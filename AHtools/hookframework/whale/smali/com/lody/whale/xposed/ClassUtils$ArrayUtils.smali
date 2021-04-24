.class final Lcom/lody/whale/xposed/ClassUtils$ArrayUtils;
.super Ljava/lang/Object;
.source "ClassUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lody/whale/xposed/ClassUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "ArrayUtils"
.end annotation


# static fields
.field static final EMPTY_CLASS_ARRAY:[Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 85
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Class;

    sput-object v0, Lcom/lody/whale/xposed/ClassUtils$ArrayUtils;->EMPTY_CLASS_ARRAY:[Ljava/lang/Class;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 81
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isSameLength([Ljava/lang/Object;[Ljava/lang/Object;)Z
    .locals 2
    .param p0, "array1"    # [Ljava/lang/Object;
    .param p1, "array2"    # [Ljava/lang/Object;

    .line 102
    if-nez p0, :cond_0

    if-eqz p1, :cond_0

    array-length v0, p1

    if-gtz v0, :cond_2

    :cond_0
    if-nez p1, :cond_1

    if-eqz p0, :cond_1

    array-length v0, p0

    if-gtz v0, :cond_2

    :cond_1
    if-eqz p0, :cond_3

    if-eqz p1, :cond_3

    array-length v0, p0

    array-length v1, p1

    if-eq v0, v1, :cond_3

    .line 105
    :cond_2
    const/4 v0, 0x0

    return v0

    .line 107
    :cond_3
    const/4 v0, 0x1

    return v0
.end method
