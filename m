Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6693017CE41
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 13:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgCGM6u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 07:58:50 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42814 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCGM6u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 07:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583585927; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmeU/kVrrVhobOq96RFhqVhi5H6TpAsu9GqwXzaqBS0=;
        b=tWtf906hTTpuAHZJCn2dFtwXrQmYVFXnowaC4au2x4a+vGGBvAvv7soU5qllgZVwQIg+iP
        kNigWpyH2jwXgrhcfPlc7IGee9tM6jn3PdLDU6TFBPRgYd0DX5UE3O2XARR0/0vbAbvauM
        dsfed7r36uXN8uPvFIxQDnxcpNii2Xo=
Date:   Sat, 07 Mar 2020 13:58:40 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1583585920.3.0@crapouillou.net>
In-Reply-To: <20200307124740.708ae2f3@archlinux>
References: <20200301150920.55993-1-contact@artur-rojek.eu>
        <20200301150920.55993-3-contact@artur-rojek.eu>
        <20200307124740.708ae2f3@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,


Le sam., mars 7, 2020 at 12:47, Jonathan Cameron=20
<jic23@jic23.retrosnub.co.uk> a =E9crit :
> On Sun,  1 Mar 2020 16:09:18 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
>=20
>>  The SADC component in JZ47xx SoCs provides support for touchscreen
>>  operations (pen position and pen down pressure) in single-ended and
>>  differential modes.
>>=20
>>  Of the known hardware to use this controller, GCW Zero and Anbernic=20
>> RG-350
>>  utilize the touchscreen mode by having their joystick(s) attached=20
>> to the
>>  X/Y positive/negative input pins.
>>  GCW Zero comes with a single joystick and is sufficiently handled=20
>> with the
>>  currently implemented single-ended mode. Support for boards with two
>>  joysticks, where one is hooked up to Xn/Yn and the other to Xp/Yp=20
>> channels
>>  will need to be provided in the future.
>>=20
>>  The touchscreen component of SADC takes a significant time to=20
>> stabilize
>>  after first receiving the clock and a delay of 50ms has been=20
>> empirically
>>  proven to be a safe value before data sampling can begin.
>>=20
>>  Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  Tested-by: Paul Cercueil <paul@crapouillou.net>
>=20
> This relies on the use of an irq that wasn't previously used.  Was=20
> that
> always hooked up?  If not we need to still work as before when it
> isn't provided.
>=20
> Otherwise this looks fine to me.

All the boards that probe the ingenic-adc driver have the interrupt=20
provided from devicetree, yes.

Cheers,
-Paul

>=20
>>  ---
>>=20
>>   Changes:
>>=20
>>   v2: - improve description of the touchscreen mode,
>>       - get rid of the unneeded kfifo,
>>       - drop IIO_BUFFER_CB from Kconfig,
>>       - remove extended names from the touchscreen channels
>>=20
>>   v3: remove unneeded `linux/iio/kfifo_buf.h` include
>>=20
>>   drivers/iio/adc/Kconfig       |   1 +
>>   drivers/iio/adc/ingenic-adc.c | 109=20
>> +++++++++++++++++++++++++++++++++-
>>   2 files changed, 108 insertions(+), 2 deletions(-)
>>=20
>>  diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>  index 82e33082958c..d3fd4b6e2d47 100644
>>  --- a/drivers/iio/adc/Kconfig
>>  +++ b/drivers/iio/adc/Kconfig
>>  @@ -453,6 +453,7 @@ config INA2XX_ADC
>>   config INGENIC_ADC
>>   	tristate "Ingenic JZ47xx SoCs ADC driver"
>>   	depends on MIPS || COMPILE_TEST
>>  +	select IIO_BUFFER
>>   	help
>>   	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC=20
>> unit.
>>=20
>>  diff --git a/drivers/iio/adc/ingenic-adc.c=20
>> b/drivers/iio/adc/ingenic-adc.c
>>  index 7a24bc1dabe1..0dafc8d5d0d8 100644
>>  --- a/drivers/iio/adc/ingenic-adc.c
>>  +++ b/drivers/iio/adc/ingenic-adc.c
>>  @@ -8,7 +8,9 @@
>>=20
>>   #include <dt-bindings/iio/adc/ingenic,adc.h>
>>   #include <linux/clk.h>
>>  +#include <linux/iio/buffer.h>
>>   #include <linux/iio/iio.h>
>>  +#include <linux/interrupt.h>
>>   #include <linux/io.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>  @@ -20,6 +22,8 @@
>>   #define JZ_ADC_REG_CFG			0x04
>>   #define JZ_ADC_REG_CTRL			0x08
>>   #define JZ_ADC_REG_STATUS		0x0c
>>  +#define JZ_ADC_REG_ADSAME		0x10
>>  +#define JZ_ADC_REG_ADWAIT		0x14
>>   #define JZ_ADC_REG_ADTCH		0x18
>>   #define JZ_ADC_REG_ADBDAT		0x1c
>>   #define JZ_ADC_REG_ADSDAT		0x20
>>  @@ -28,6 +32,9 @@
>>   #define JZ_ADC_REG_ENABLE_PD		BIT(7)
>>   #define JZ_ADC_REG_CFG_AUX_MD		(BIT(0) | BIT(1))
>>   #define JZ_ADC_REG_CFG_BAT_MD		BIT(4)
>>  +#define JZ_ADC_REG_CFG_PULL_UP(n)	((n) << 16)
>>  +#define JZ_ADC_REG_CFG_SAMPLE_NUM(n)	((n) << 10)
>>  +#define JZ_ADC_REG_CFG_TOUCH_OPS_MASK	(BIT(31) | GENMASK(23, 10))
>>   #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
>>   #define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
>>   #define JZ4770_ADC_REG_ADCLK_CLKDIV10US_LSB	8
>>  @@ -44,6 +51,14 @@
>>   #define JZ4770_ADC_BATTERY_VREF			6600
>>   #define JZ4770_ADC_BATTERY_VREF_BITS		12
>>=20
>>  +#define JZ_ADC_IRQ_AUX			BIT(0)
>>  +#define JZ_ADC_IRQ_BATTERY		BIT(1)
>>  +#define JZ_ADC_IRQ_TOUCH		BIT(2)
>>  +#define JZ_ADC_IRQ_PEN_DOWN		BIT(3)
>>  +#define JZ_ADC_IRQ_PEN_UP		BIT(4)
>>  +#define JZ_ADC_IRQ_PEN_DOWN_SLEEP	BIT(5)
>>  +#define JZ_ADC_IRQ_SLEEP		BIT(7)
>>  +
>>   struct ingenic_adc;
>>=20
>>   struct ingenic_adc_soc_data {
>>  @@ -411,6 +426,28 @@ static const struct iio_info ingenic_adc_info=20
>> =3D {
>>   };
>>=20
>>   static const struct iio_chan_spec ingenic_channels[] =3D {
>>  +	{
>>  +		.type =3D IIO_POSITIONRELATIVE,
>>  +		.indexed =3D 1,
>>  +		.channel =3D INGENIC_ADC_TOUCH_XP,
>>  +		.scan_index =3D 0,
>>  +		.scan_type =3D {
>>  +			.sign =3D 'u',
>>  +			.realbits =3D 12,
>>  +			.storagebits =3D 16
>>  +		},
>>  +	},
>>  +	{
>>  +		.type =3D IIO_POSITIONRELATIVE,
>>  +		.indexed =3D 1,
>>  +		.channel =3D INGENIC_ADC_TOUCH_YP,
>>  +		.scan_index =3D 1,
>>  +		.scan_type =3D {
>>  +			.sign =3D 'u',
>>  +			.realbits =3D 12,
>>  +			.storagebits =3D 16
>>  +		},
>>  +	},
>>   	{
>>   		.extend_name =3D "aux",
>>   		.type =3D IIO_VOLTAGE,
>>  @@ -418,6 +455,7 @@ static const struct iio_chan_spec=20
>> ingenic_channels[] =3D {
>>   				      BIT(IIO_CHAN_INFO_SCALE),
>>   		.indexed =3D 1,
>>   		.channel =3D INGENIC_ADC_AUX,
>>  +		.scan_index =3D -1
>>   	},
>>   	{
>>   		.extend_name =3D "battery",
>>  @@ -428,6 +466,7 @@ static const struct iio_chan_spec=20
>> ingenic_channels[] =3D {
>>   						BIT(IIO_CHAN_INFO_SCALE),
>>   		.indexed =3D 1,
>>   		.channel =3D INGENIC_ADC_BATTERY,
>>  +		.scan_index =3D -1
>>   	},
>>   	{ /* Must always be last in the array. */
>>   		.extend_name =3D "aux2",
>>  @@ -436,16 +475,69 @@ static const struct iio_chan_spec=20
>> ingenic_channels[] =3D {
>>   				      BIT(IIO_CHAN_INFO_SCALE),
>>   		.indexed =3D 1,
>>   		.channel =3D INGENIC_ADC_AUX2,
>>  +		.scan_index =3D -1
>>   	},
>>   };
>>=20
>>  +static int ingenic_adc_buffer_enable(struct iio_dev *iio_dev)
>>  +{
>>  +	struct ingenic_adc *adc =3D iio_priv(iio_dev);
>>  +
>>  +	clk_enable(adc->clk);
>>  +	/* It takes significant time for the touchscreen hw to stabilize.=20
>> */
>>  +	msleep(50);
>>  +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK,
>>  +			       JZ_ADC_REG_CFG_SAMPLE_NUM(4) |
>>  +			       JZ_ADC_REG_CFG_PULL_UP(4));
>>  +	writew(80, adc->base + JZ_ADC_REG_ADWAIT);
>>  +	writew(2, adc->base + JZ_ADC_REG_ADSAME);
>>  +	writeb((u8)~JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_CTRL);
>>  +	writel(0, adc->base + JZ_ADC_REG_ADTCH);
>>  +	ingenic_adc_enable(adc, 2, true);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int ingenic_adc_buffer_disable(struct iio_dev *iio_dev)
>>  +{
>>  +	struct ingenic_adc *adc =3D iio_priv(iio_dev);
>>  +
>>  +	ingenic_adc_enable(adc, 2, false);
>>  +	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
>>  +	writeb(0xff, adc->base + JZ_ADC_REG_STATUS);
>>  +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK, 0);
>>  +	writew(0, adc->base + JZ_ADC_REG_ADSAME);
>>  +	writew(0, adc->base + JZ_ADC_REG_ADWAIT);
>>  +	clk_disable(adc->clk);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static const struct iio_buffer_setup_ops ingenic_buffer_setup_ops=20
>> =3D {
>>  +	.postenable =3D &ingenic_adc_buffer_enable,
>>  +	.predisable =3D &ingenic_adc_buffer_disable
>>  +};
>>  +
>>  +static irqreturn_t ingenic_adc_irq(int irq, void *data)
>>  +{
>>  +	struct iio_dev *iio_dev =3D data;
>>  +	struct ingenic_adc *adc =3D iio_priv(iio_dev);
>>  +	u32 tdat;
>>  +
>>  +	tdat =3D readl(adc->base + JZ_ADC_REG_ADTCH);
>>  +	iio_push_to_buffers(iio_dev, &tdat);
>>  +	writeb(JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_STATUS);
>>  +
>>  +	return IRQ_HANDLED;
>>  +}
>>  +
>>   static int ingenic_adc_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev =3D &pdev->dev;
>>   	struct iio_dev *iio_dev;
>>   	struct ingenic_adc *adc;
>>   	const struct ingenic_adc_soc_data *soc_data;
>>  -	int ret;
>>  +	int irq, ret;
>>=20
>>   	soc_data =3D device_get_match_data(dev);
>>   	if (!soc_data)
>>  @@ -460,6 +552,18 @@ static int ingenic_adc_probe(struct=20
>> platform_device *pdev)
>>   	mutex_init(&adc->aux_lock);
>>   	adc->soc_data =3D soc_data;
>>=20
>>  +	irq =3D platform_get_irq(pdev, 0);
>=20
> Do we need a fallback path if there is no irq provided?  We can't=20
> break existing
> supported devices that don't specify one.
>=20
>>  +	if (irq < 0) {
>>  +		dev_err(dev, "Failed to get irq: %d\n", irq);
>>  +		return irq;
>>  +	}
>>  +	ret =3D devm_request_irq(dev, irq, ingenic_adc_irq, 0,
>>  +			       dev_name(dev), iio_dev);
>>  +	if (ret < 0) {
>>  +		dev_err(dev, "Failed to request irq: %d\n", ret);
>>  +		return ret;
>>  +	}
>>  +
>>   	adc->base =3D devm_platform_ioremap_resource(pdev, 0);
>>   	if (IS_ERR(adc->base))
>>   		return PTR_ERR(adc->base);
>>  @@ -499,7 +603,8 @@ static int ingenic_adc_probe(struct=20
>> platform_device *pdev)
>>=20
>>   	iio_dev->dev.parent =3D dev;
>>   	iio_dev->name =3D "jz-adc";
>>  -	iio_dev->modes =3D INDIO_DIRECT_MODE;
>>  +	iio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>>  +	iio_dev->setup_ops =3D &ingenic_buffer_setup_ops;
>>   	iio_dev->channels =3D ingenic_channels;
>>   	iio_dev->num_channels =3D ARRAY_SIZE(ingenic_channels);
>>   	/* Remove AUX2 from the list of supported channels. */
>=20

=

