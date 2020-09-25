Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32B2278736
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgIYM2s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 08:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYM2s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:28:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33ED721D7A;
        Fri, 25 Sep 2020 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601036927;
        bh=oAGOSMRMsQU8yJoQm1DZP2F8qfoZz3uwgR4UJ81S1UI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y1oS3uluNIPh0wJdYOGx7Y2K/UPH/uoFuFKGe9MzXO0oOJ/i2Kx9Ko5cku91pKDbT
         Zaz5EvHR+ewNrOL9+W9vUGQToQW8taKgUu88IXiEwoblGlD6d2KfLsI4rXa26V2oVH
         uP2GCoWcyutLPqTVKGay1AyuOdqZkB98Fu7SgK78=
Date:   Fri, 25 Sep 2020 13:28:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v5 3/3] iio: adc: mt6360: Add ADC driver for MT6360
Message-ID: <20200925132840.513bf214@archlinux>
In-Reply-To: <1600687442-23658-4-git-send-email-gene.chen.richtek@gmail.com>
References: <1600687442-23658-1-git-send-email-gene.chen.richtek@gmail.com>
        <1600687442-23658-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 19:24:02 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> From: Gene Chen <gene_chen@richtek.com>
>=20
> Add MT6360 ADC driver include Charger Current, Voltage, and
> Temperature.
>=20
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

Hi Gene,

A few things inline that need fixing or tidying up.

Looking good otherwise.

Jonathan
> ---
>  drivers/iio/adc/Kconfig      |  11 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/mt6360-adc.c | 363 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 375 insertions(+)
>  create mode 100644 drivers/iio/adc/mt6360-adc.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d94dc80..a135ada 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -703,6 +703,17 @@ config MCP3911
>  	  This driver can also be built as a module. If so, the module will be
>  	  called mcp3911.
> =20
> +config MEDIATEK_MT6360_ADC
> +	tristate "Mediatek MT6360 ADC driver"
> +	depends on MFD_MT6360
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to enable MT6360 ADC support.
> +	  Integrated for System Monitoring includes
> +	  is used in smartphones and tablets and supports a 11 channel
> +	  general purpose ADC.
> +
>  config MEDIATEK_MT6577_AUXADC
>  	tristate "MediaTek AUXADC driver"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 90f94ad..5fca90a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_MAX9611) +=3D max9611.o
>  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
>  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
>  obj-$(CONFIG_MCP3911) +=3D mcp3911.o
> +obj-$(CONFIG_MEDIATEK_MT6360_ADC) +=3D mt6360-adc.o
>  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) +=3D mt6577_auxadc.o
>  obj-$(CONFIG_MEN_Z188_ADC) +=3D men_z188_adc.o
>  obj-$(CONFIG_MESON_SARADC) +=3D meson_saradc.o
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> new file mode 100644
> index 0000000..a1a01e5
> --- /dev/null
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define MT6360_REG_PMUCHGCTRL3	0x313
> +#define MT6360_REG_PMUADCCFG	0x356
> +#define MT6360_REG_PMUADCIDLET	0x358
> +#define MT6360_REG_PMUADCRPT1	0x35A
> +
> +/* PMUCHGCTRL3 0x313 */
> +#define MT6360_AICR_MASK	GENMASK(7, 2)
> +#define MT6360_AICR_SHFT	2
> +#define MT6360_AICR_400MA	0x6
> +/* PMUADCCFG 0x356 */
> +#define MT6360_ADCEN_MASK	0x8000
> +/* PMUADCRPT1 0x35A */
> +#define MT6360_PREFERCH_MASK	GENMASK(7, 4)
> +#define MT6360_PREFERCH_SHFT	4
> +#define MT6360_RPTCH_MASK	GENMASK(3, 0)
> +#define MT6360_NO_PREFER	15
> +
> +/* Time in ms */
> +#define ADC_WAIT_TIME_MS	25
> +
> +enum {
> +	MT6360_CHAN_USBID =3D 0,
> +	MT6360_CHAN_VBUSDIV5,
> +	MT6360_CHAN_VBUSDIV2,
> +	MT6360_CHAN_VSYS,
> +	MT6360_CHAN_VBAT,
> +	MT6360_CHAN_IBUS,
> +	MT6360_CHAN_IBAT,
> +	MT6360_CHAN_CHG_VDDP,
> +	MT6360_CHAN_TEMP_JC,
> +	MT6360_CHAN_VREF_TS,
> +	MT6360_CHAN_TS,
> +	MT6360_CHAN_MAX
> +};
> +
> +struct mt6360_adc_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	/* Due to only one set of ADC control, this lock is used to prevent the=
 race condition */
> +	struct mutex adc_lock;
> +	ktime_t last_off_timestamps[MT6360_CHAN_MAX];
> +};
> +
> +static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int chan=
nel, int *val)
> +{
> +	__be16 adc_enable;
> +	u8 rpt[3];
> +	ktime_t start_t, predict_end_t;
> +	unsigned int pre_wait_time;
> +	int ret;
> +
> +	mutex_lock(&mad->adc_lock);
> +
> +	/* Select the preferred ADC channel */
> +	ret =3D regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_P=
REFERCH_MASK,
> +				 channel << MT6360_PREFERCH_SHFT);
> +	if (ret)
> +		goto out_adc_lock;
> +
> +	adc_enable =3D cpu_to_be16(MT6360_ADCEN_MASK | BIT(channel));
> +	ret =3D regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, &adc_enable=
, sizeof(adc_enable));
> +	if (ret)
> +		goto out_adc_lock;
> +
> +	start_t =3D ktime_get();
> +	predict_end_t =3D ktime_add_ms(mad->last_off_timestamps[channel], 2 * A=
DC_WAIT_TIME_MS);
> +
> +	if (ktime_after(start_t, predict_end_t))
> +		pre_wait_time =3D ADC_WAIT_TIME_MS;
> +	else
> +		pre_wait_time =3D 3 * ADC_WAIT_TIME_MS;
> +
> +	msleep(pre_wait_time);
> +
> +	while (true) {
> +		ret =3D regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT1, rpt, sizeo=
f(rpt));
> +		if (ret)
> +			goto out_adc_conv;
> +
> +		/*
> +		 * There are two functions, ZCV and TypeC OTP, running ADC VBAT and TS=
 in
> +		 * background, and ADC samples are taken on a fixed frequency no matte=
r read the
> +		 * previous one or not.
> +		 * To avoid conflict, We set minimum time threshold after enable ADC a=
nd
> +		 * check report channel is the same.
> +		 * The worst case is run the same ADC twice and background function is=
 also running,
> +		 * ADC conversion sequence is desire channel before start ADC, backgro=
und ADC,
> +		 * desire channel after start ADC.
> +		 * So the minimum correct data is three times of typical conversion ti=
me.
> +		 */
> +		if ((rpt[0] & MT6360_RPTCH_MASK) =3D=3D channel)
> +			break;
> +
> +		msleep(ADC_WAIT_TIME_MS);
> +	}
> +
> +	/* rpt[1]: ADC_HI_BYTE, rpt[2]: ADC_LOW_BYTE */
> +	*val =3D rpt[1] << 8 | rpt[2];
> +	ret =3D IIO_VAL_INT;
> +
> +out_adc_conv:
> +	/* Only keep ADC enable */
> +	adc_enable =3D cpu_to_be16(MT6360_ADCEN_MASK);
> +	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, &adc_enable, sizeof=
(adc_enable));
> +	mad->last_off_timestamps[channel] =3D ktime_get();
> +	/* Config prefer channel to NO_PREFER */
> +	regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_=
MASK,
> +			   MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
> +out_adc_lock:
> +	mutex_unlock(&mad->adc_lock);
> +
> +	return ret;
> +}
> +
> +static int mt6360_adc_read_scale(struct mt6360_adc_data *mad, int channe=
l, int *val, int *val2)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	switch (channel) {
> +	case MT6360_CHAN_USBID:
> +	case MT6360_CHAN_VSYS:
> +	case MT6360_CHAN_VBAT:
> +	case MT6360_CHAN_CHG_VDDP:
> +	case MT6360_CHAN_VREF_TS:
> +	case MT6360_CHAN_TS:
> +		*val =3D 1250;
> +		return IIO_VAL_INT;
> +	case MT6360_CHAN_VBUSDIV5:
> +		*val =3D 6250;
> +		return IIO_VAL_INT;
> +	case MT6360_CHAN_VBUSDIV2:
> +	case MT6360_CHAN_IBUS:
> +	case MT6360_CHAN_IBAT:
> +		*val =3D 2500;
> +
> +		if (channel =3D=3D MT6360_CHAN_IBUS) {
> +			/* IBUS will be affected by input current limit for the different Ron=
 */
> +			/* Check whether the config is <400mA or not */
> +			ret =3D regmap_read(mad->regmap, MT6360_REG_PMUCHGCTRL3, &regval);
> +			if (ret)
> +				return ret;
> +
> +			regval =3D (regval & MT6360_AICR_MASK) >> MT6360_AICR_SHFT;
> +			if (regval < MT6360_AICR_400MA)
> +				*val =3D 1900;
> +		}
> +
> +		return IIO_VAL_INT;
> +	case MT6360_CHAN_TEMP_JC:
> +		*val =3D 105;
> +		*val2 =3D 100;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mt6360_adc_read_offset(struct mt6360_adc_data *mad, int chann=
el, int *val)
> +{
> +	*val =3D (channel =3D=3D MT6360_CHAN_TEMP_JC) ? -80 : 0;
> +	return IIO_VAL_INT;
> +
> +}
> +
> +static int mt6360_adc_read_raw(struct iio_dev *iio_dev, const struct iio=
_chan_spec *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct mt6360_adc_data *mad =3D iio_priv(iio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return mt6360_adc_read_channel(mad, chan->channel, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		return mt6360_adc_read_scale(mad, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_OFFSET:
> +		return mt6360_adc_read_offset(mad, chan->channel, val);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const char *mt6360_channel_labels[MT6360_CHAN_MAX] =3D {
> +	"usbid", "vbusdiv5", "vbusdiv2", "vsys", "vbat", "ibus", "ibat", "chg_v=
ddp", "temp_jc",
> +	"vref_ts", "ts"
> +};
> +
> +static int mt6360_adc_read_label(struct iio_dev *iio_dev, const struct i=
io_chan_spec *chan,
> +				 char *label)
> +{
> +	return snprintf(label, PAGE_SIZE, "%s\n", mt6360_channel_labels[chan->c=
hannel]);
> +}

Very nice.  The patch series adding this callback will hopefully be finaliz=
ed
shortly.

> +
> +static const struct iio_info mt6360_adc_iio_info =3D {
> +	.read_raw =3D mt6360_adc_read_raw,
> +	.read_label =3D mt6360_adc_read_label,
> +};
> +
> +#define MT6360_ADC_CHAN(_idx, _type) {				\
> +	.type =3D _type,						\
> +	.channel =3D MT6360_CHAN_##_idx,				\
> +	.scan_index =3D MT6360_CHAN_##_idx,			\
> +	.datasheet_name =3D #_idx,				\
> +	.scan_type =3D  {						\
> +		.sign =3D 'u',					\
> +		.realbits =3D 16,					\
> +		.storagebits =3D 16,				\
> +		.endianness =3D IIO_CPU,				\
> +	},							\
> +	.indexed =3D 1,						\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_OFFSET),	\
> +}
> +
> +static const struct iio_chan_spec mt6360_adc_channels[] =3D {
> +	MT6360_ADC_CHAN(USBID, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(VSYS, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(VBAT, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(IBUS, IIO_CURRENT),
> +	MT6360_ADC_CHAN(IBAT, IIO_CURRENT),
> +	MT6360_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(TEMP_JC, IIO_TEMP),
> +	MT6360_ADC_CHAN(VREF_TS, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(TS, IIO_VOLTAGE),
> +	IIO_CHAN_SOFT_TIMESTAMP(MT6360_CHAN_MAX),
> +};
> +
> +static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct mt6360_adc_data *mad =3D iio_priv(indio_dev);
> +	struct {
> +		u16 values[MT6360_CHAN_MAX];
> +		int64_t timestamp;
> +	} data __aligned(8) =3D {0};

I don't think that is sufficient to force the gap to be set to 0.
The c99 spec says in 6.7.8.21
"If there are fewer initializers in a brace-enclosed list than there are el=
ements or members
of an aggregate, or fewer characters in a string literal used to initialize=
 an array of known
size than there are elements in the array, the remainder of the aggregate s=
hall be
initialized implicitly the same as objects that have static storage duratio=
n."

The static case is covered by 6.7.8.10
"If an object that has automatic storage duration is not initialized explic=
itly, its value is
indeterminate. If an object that has static storage duration is not initial=
ized explicitly,
then:
=E2=80=94 if it has pointer type, it is initialized to a null pointer;
=E2=80=94 if it has arithmetic type, it is initialized to (positive or unsi=
gned) zero;
=E2=80=94 if it is an aggregate, every member is initialized (recursively) =
according to these rules;
=E2=80=94 if it isaunion, the first named member is initialized (recursivel=
y) according to these
  rules
"
Structure is an aggregate,s every member is initialized.  Unfortunately tha=
t doesn't
have any impact on gaps.  So it 'might' zero it, but there are no guarantee=
s.

As such, I think you need to use memset which will just fill the memory wit=
h zeros
without caring about the structure.
Or cheeky route is to add elements to fill the gap and just call them pad[]=
 or similar.


> +	int i =3D 0, bit, val, ret;
> +
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklengt=
h) {
> +		ret =3D mt6360_adc_read_channel(mad, bit, &val);
> +		if (ret < 0) {
> +			dev_warn(&indio_dev->dev, "Failed to get channel %d conversion val\n"=
, bit);
> +			goto out;
> +		}
> +
> +		data.values[i++] =3D val;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(in=
dio_dev));
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static inline int mt6360_adc_reset(struct mt6360_adc_data *info)
> +{
> +	__be16 adc_enable;
> +	ktime_t all_off_time;
> +	int i, ret;
> +
> +	/* Clear ADC idle wait time to 0 */
> +	ret =3D regmap_write(info->regmap, MT6360_REG_PMUADCIDLET, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Only keep ADC enable, but keep all channels off */
> +	adc_enable =3D cpu_to_be16(MT6360_ADCEN_MASK);
> +	ret =3D regmap_raw_write(info->regmap, MT6360_REG_PMUADCCFG, (void *)&a=
dc_enable,
Why are we casting to a void *? That shouldn't be necessary. Am I missing s=
omething?

> +			       sizeof(__be16));

Slight preference for sizeof(adc_enable) as then I don't have to sanity che=
ckit
is the right type whilst reviewing.

> +	if (ret)
> +		return ret;
> +
> +	/* Reset all channel off time to the current one */
> +	all_off_time =3D ktime_get();
> +	for (i =3D 0; i < MT6360_CHAN_MAX; i++)
> +		info->last_off_timestamps[i] =3D all_off_time;
> +
> +	return 0;
> +}
> +
> +static int mt6360_adc_probe(struct platform_device *pdev)
> +{
> +	struct mt6360_adc_data *mad;
> +	struct regmap *regmap;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap) {
> +		dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*mad));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	mad =3D iio_priv(indio_dev);
> +	mad->dev =3D &pdev->dev;
> +	mad->regmap =3D regmap;
> +	mutex_init(&mad->adc_lock);
> +
> +	ret =3D mt6360_adc_reset(mad);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to reset adc\n");
> +		return ret;
> +	}
> +
> +	indio_dev->name =3D dev_name(&pdev->dev);
> +	indio_dev->dev.parent =3D &pdev->dev;
> +	indio_dev->info =3D &mt6360_adc_iio_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D mt6360_adc_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(mt6360_adc_channels);
> +
> +	ret =3D devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, NULL,
> +					      mt6360_adc_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to allocate iio trigger buffer\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static const struct of_device_id __maybe_unused mt6360_adc_of_id[] =3D {
> +	{ .compatible =3D "mediatek,mt6360-adc", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mt6360_adc_of_id);
> +
> +static struct platform_driver mt6360_adc_driver =3D {
> +	.driver =3D {
> +		.name =3D "mt6360-adc",
> +		.of_match_table =3D mt6360_adc_of_id,
> +	},
> +	.probe =3D mt6360_adc_probe,
> +};
> +module_platform_driver(mt6360_adc_driver);
> +
> +MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
> +MODULE_DESCRIPTION("MT6360 ADC Driver");
> +MODULE_LICENSE("GPL v2");

