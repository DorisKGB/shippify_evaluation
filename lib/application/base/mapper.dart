/*
Mapeador genérico para convertir las entidades a modelos
@param I => objeto de entrada
@param O => objeto de salida
*/

abstract class Mapeador<I, O> {
  O transform(I item);
  List<O> transformList(List<I> array);
}

abstract class MapedorService<I, O> implements Mapeador<I, O> {
  O map(I item);

  @override
  O transform(I item) => map(item);

  @override
  List<O> transformList(List<I> list) =>
      list.map((I item) => map(item)).toList();
}
