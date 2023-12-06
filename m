Return-Path: <linux-iio+bounces-693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F30A807C01
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 00:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EBC1C20C30
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843421CF95;
	Wed,  6 Dec 2023 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="orVsswiS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880CA18D
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 15:01:28 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f9db9567so500601fa.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Dec 2023 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701903687; x=1702508487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZRSlQY1tSeKQSV6w2cmSyTvqyZhmlI/QG6P8u04SHU=;
        b=orVsswiSarhktCy2iMCM5jmGjvUKSQpw6copY+o3tEMJN1IhGdigiFDdBh0dgT1h1i
         s44jGCbVdNZkCQHFhnxP/1qE84lPHJfxggU/e/LctWcvMDg3nSmqeLEVD3psNx5rncba
         VAitymoQq0Lq+g0x828sJ48FNvLxvxAIC1uj0kiq/TfH9ZKpwZ522fYoaIXgsems52LM
         mXuopFgS52cOC/OyOJ4NtR14xeozxLyJ/oyV/xLg93QihI1dZdThKsRBabyDs3XwkYZu
         gcXzMfC+3tvAdRKCaU7TAcDgPrmHRFaGngPQRCmYzZY199IwYxTxO3uMsdtnCKSnl+vL
         eJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701903687; x=1702508487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZRSlQY1tSeKQSV6w2cmSyTvqyZhmlI/QG6P8u04SHU=;
        b=R2wn7gXyCdWl9D8f10tGxj34nIg5TA0IYKI0mhGCB7vt1aL/6D3h9KzTmuy9Vq022Q
         G+qWvIIgY1R8QvnQ3XJly8PhExLh9B4pyjWDFYrrJ4g9+NzvM8woMWBEDwPTdAqrhTWo
         LDvcf5SDB8jlpYPU5Y5w40K70HOgx5/rLwx0Me3pD/kZrWOSAA7sWwWHzdsY1+F3c9v8
         pddVcD8FslakBro8rs1NmIn1UlSlG14wH9tjaqJG16YpTa0vEgRMU0XOqSY6qqwtSuLG
         8r/chUFQ+rk1IfF8o2+h3YgSN6edGYbTqdBoZhgyq2DktKCXjq7AXvBgrczwbgreCwwZ
         Cmog==
X-Gm-Message-State: AOJu0YzvCItsW1f7aWzja+J1qAAeMsY3LHl7eD0TohgcOemfyn+/b5iH
	4i9sAylvyICfsBPYyJNG8ppxjHeFkv/IZjkzVxgmCg==
X-Google-Smtp-Source: AGHT+IHdPZTnkzskCAF5jltWi0hntGW+TYIxnzJyu9EJawZ9qGU6WhalwDBb4Um4RMiVa2iYW6RvHLCPLqoQjQU9k/g=
X-Received: by 2002:a2e:22c4:0:b0:2ca:2e14:dcef with SMTP id
 i187-20020a2e22c4000000b002ca2e14dcefmr118327lji.67.1701903686563; Wed, 06
 Dec 2023 15:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com> <20231205-iio-backend-prep-v1-4-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-4-7c9bc18d612b@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 6 Dec 2023 17:01:15 -0600
Message-ID: <CAMknhBF84oWxgGpyj=6S013qCrqHXRFk6Apub94FN6SUcWSmsA@mail.gmail.com>
Subject: Re: [PATCH 4/8] iio: adc: ad9467: fix scale setting
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:06=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> When reading in_voltage_scale we can get something like:
>
> root@analog:/sys/bus/iio/devices/iio:device2# cat in_voltage_scale
> 0.038146
>
> However, when reading the available options:
>
> root@analog:/sys/bus/iio/devices/iio:device2# cat
> in_voltage_scale_available
> 2000.000000 2100.000006 2200.000007 2300.000008 2400.000009 2500.000010
>
> which does not make sense. Moreover, when trying to set a new scale we
> get an error because there's no call to __ad9467_get_scale() to give us
> values as given when reading in_voltage_scale. Fix it by computing the
> available scales during probe and properly pass the list when
> .read_available() is called.
>
> While at it, change to use .read_available() from iio_info. Also note
> that to properly fix this, adi-axi-adc.c has to be changed accordingly.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c            | 47 +++++++++++++++++++++++
>  drivers/iio/adc/adi-axi-adc.c       | 74 ++++++++-----------------------=
------
>  include/linux/iio/adc/adi-axi-adc.h |  4 ++
>  3 files changed, 66 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index badbef2ce9f8..3c8bd6c821a4 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -120,6 +120,7 @@ struct ad9467_state {
>         struct spi_device               *spi;
>         struct clk                      *clk;
>         unsigned int                    output_mode;
> +       unsigned int                    (*scales)[2];
>
>         struct gpio_desc                *pwrdown_gpio;
>         /* ensure consistent state obtained on multiple related accesses =
*/
> @@ -216,6 +217,7 @@ static void __ad9467_get_scale(struct adi_axi_adc_con=
v *conv, int index,
>         .channel =3D _chan,                                              =
 \
>         .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |         =
 \
>                 BIT(IIO_CHAN_INFO_SAMP_FREQ),                           \
> +       .info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE),=
 \
>         .scan_index =3D _si,                                             =
 \
>         .scan_type =3D {                                                 =
 \
>                 .sign =3D _sign,                                         =
 \
> @@ -370,6 +372,26 @@ static int ad9467_write_raw(struct adi_axi_adc_conv =
*conv,
>         }
>  }
>
> +static int ad9467_read_avail(struct adi_axi_adc_conv *conv,
> +                            struct iio_chan_spec const *chan,
> +                            const int **vals, int *type, int *length,
> +                            long mask)
> +{
> +       const struct adi_axi_adc_chip_info *info =3D conv->chip_info;
> +       struct ad9467_state *st =3D adi_axi_adc_conv_priv(conv);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               *vals =3D (const int *)st->scales;
> +               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               /* Values are stored in a 2D matrix */
> +               *length =3D info->num_scales * 2;

Maybe use ARRAY_SIZE(*info->scales) here instead of hard-coding 2?

> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mo=
de)
>  {
>         int ret;
> @@ -382,6 +404,26 @@ static int ad9467_outputmode_set(struct spi_device *=
spi, unsigned int mode)
>                                 AN877_ADC_TRANSFER_SYNC);
>  }
>
> +static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
> +{
> +       const struct adi_axi_adc_chip_info *info =3D conv->chip_info;
> +       struct ad9467_state *st =3D adi_axi_adc_conv_priv(conv);
> +       unsigned int i, val1, val2;
> +
> +       st->scales =3D devm_kcalloc(&st->spi->dev, ARRAY_SIZE(*st->scales=
),
> +                                 info->num_scales, GFP_KERNEL);

If I'm reading this correctly, it says to allocate an array with n=3D2
elements (ARRAY_SIZE(*st->scales) =3D=3D 2) and the elements have
size=3Dinfo->num_scales bytes.

It seems like this should be:

        st->scales =3D devm_kmalloc_array(&st->spi->dev, info->num_scales,
                                        sizeof(*st->scales), GFP_KERNEL);

Which allocates n=3Dinfo->num_scales elements and the elements have
size=3D8 bytes (sizeof(*st->scales) =3D=3D 8).

(also changed to devm_kmalloc_array() since it doesn't look like it
needs to be zeroed since all values are assigned below)

> +       if (!st->scales)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < info->num_scales * 2; i++) {

Is `* 2` correct here? Assuming only info->num_scales elements were allocat=
ed.

> +               __ad9467_get_scale(conv, i, &val1, &val2);
> +               st->scales[i][0] =3D val1;
> +               st->scales[i][1] =3D val2;
> +       }
> +
> +       return 0;
> +}
> +
>  static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
>  {
>         struct ad9467_state *st =3D adi_axi_adc_conv_priv(conv);
> @@ -442,6 +484,10 @@ static int ad9467_probe(struct spi_device *spi)
>
>         conv->chip_info =3D &info->axi_adc_info;
>
> +       ret =3D ad9467_scale_fill(conv);
> +       if (ret)
> +               return ret;
> +
>         id =3D ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
>         if (id !=3D conv->chip_info->id) {
>                 dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected =
0x%X\n",
> @@ -452,6 +498,7 @@ static int ad9467_probe(struct spi_device *spi)
>         conv->reg_access =3D ad9467_reg_access;
>         conv->write_raw =3D ad9467_write_raw;
>         conv->read_raw =3D ad9467_read_raw;
> +       conv->read_avail =3D ad9467_read_avail;
>         conv->preenable_setup =3D ad9467_preenable_setup;
>
>         st->output_mode =3D info->default_output_mode |
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index aff0532a974a..ae83ada7f9f2 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -144,6 +144,20 @@ static int adi_axi_adc_write_raw(struct iio_dev *ind=
io_dev,
>         return conv->write_raw(conv, chan, val, val2, mask);
>  }
>
> +static int adi_axi_adc_read_avail(struct iio_dev *indio_dev,
> +                                 struct iio_chan_spec const *chan,
> +                                 const int **vals, int *type, int *lengt=
h,
> +                                 long mask)
> +{
> +       struct adi_axi_adc_state *st =3D iio_priv(indio_dev);
> +       struct adi_axi_adc_conv *conv =3D &st->client->conv;
> +
> +       if (!conv->read_avail)
> +               return -EOPNOTSUPP;
> +
> +       return conv->read_avail(conv, chan, vals, type, length, mask);
> +}
> +
>  static int adi_axi_adc_update_scan_mode(struct iio_dev *indio_dev,
>                                         const unsigned long *scan_mask)
>  {
> @@ -228,69 +242,11 @@ struct adi_axi_adc_conv *devm_adi_axi_adc_conv_regi=
ster(struct device *dev,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_adi_axi_adc_conv_register, IIO_ADI_AXI);
>
> -static ssize_t in_voltage_scale_available_show(struct device *dev,
> -                                              struct device_attribute *a=
ttr,
> -                                              char *buf)
> -{
> -       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -       struct adi_axi_adc_state *st =3D iio_priv(indio_dev);
> -       struct adi_axi_adc_conv *conv =3D &st->client->conv;
> -       size_t len =3D 0;
> -       int i;
> -
> -       for (i =3D 0; i < conv->chip_info->num_scales; i++) {
> -               const unsigned int *s =3D conv->chip_info->scale_table[i]=
;
> -
> -               len +=3D scnprintf(buf + len, PAGE_SIZE - len,
> -                                "%u.%06u ", s[0], s[1]);
> -       }
> -       buf[len - 1] =3D '\n';
> -
> -       return len;
> -}
> -
> -static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
> -
> -enum {
> -       ADI_AXI_ATTR_SCALE_AVAIL,
> -};
> -
> -#define ADI_AXI_ATTR(_en_, _file_)                     \
> -       [ADI_AXI_ATTR_##_en_] =3D &iio_dev_attr_##_file_.dev_attr.attr
> -
> -static struct attribute *adi_axi_adc_attributes[] =3D {
> -       ADI_AXI_ATTR(SCALE_AVAIL, in_voltage_scale_available),
> -       NULL
> -};
> -
> -static umode_t axi_adc_attr_is_visible(struct kobject *kobj,
> -                                      struct attribute *attr, int n)
> -{
> -       struct device *dev =3D kobj_to_dev(kobj);
> -       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -       struct adi_axi_adc_state *st =3D iio_priv(indio_dev);
> -       struct adi_axi_adc_conv *conv =3D &st->client->conv;
> -
> -       switch (n) {
> -       case ADI_AXI_ATTR_SCALE_AVAIL:
> -               if (!conv->chip_info->num_scales)
> -                       return 0;
> -               return attr->mode;
> -       default:
> -               return attr->mode;
> -       }
> -}
> -
> -static const struct attribute_group adi_axi_adc_attribute_group =3D {
> -       .attrs =3D adi_axi_adc_attributes,
> -       .is_visible =3D axi_adc_attr_is_visible,
> -};
> -
>  static const struct iio_info adi_axi_adc_info =3D {
>         .read_raw =3D &adi_axi_adc_read_raw,
>         .write_raw =3D &adi_axi_adc_write_raw,
> -       .attrs =3D &adi_axi_adc_attribute_group,
>         .update_scan_mode =3D &adi_axi_adc_update_scan_mode,
> +       .read_avail =3D &adi_axi_adc_read_avail,
>  };
>
>  static const struct adi_axi_adc_core_info adi_axi_adc_10_0_a_info =3D {
> diff --git a/include/linux/iio/adc/adi-axi-adc.h b/include/linux/iio/adc/=
adi-axi-adc.h
> index 52620e5b8052..b7904992d561 100644
> --- a/include/linux/iio/adc/adi-axi-adc.h
> +++ b/include/linux/iio/adc/adi-axi-adc.h
> @@ -41,6 +41,7 @@ struct adi_axi_adc_chip_info {
>   * @reg_access         IIO debugfs_reg_access hook for the client ADC
>   * @read_raw           IIO read_raw hook for the client ADC
>   * @write_raw          IIO write_raw hook for the client ADC
> + * @read_avail         IIO read_avail hook for the client ADC
>   */
>  struct adi_axi_adc_conv {
>         const struct adi_axi_adc_chip_info              *chip_info;
> @@ -54,6 +55,9 @@ struct adi_axi_adc_conv {
>         int (*write_raw)(struct adi_axi_adc_conv *conv,
>                          struct iio_chan_spec const *chan,
>                          int val, int val2, long mask);
> +       int (*read_avail)(struct adi_axi_adc_conv *conv,
> +                         struct iio_chan_spec const *chan,
> +                         const int **val, int *type, int *length, long m=
ask);
>  };
>
>  struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *d=
ev,
>
> --
> 2.43.0
>
>

