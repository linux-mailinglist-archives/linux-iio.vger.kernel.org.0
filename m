Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC313941C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMO7V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 09:59:21 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33186 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgAMO7V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 09:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578927557; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QylB/cC3XR0W6TSZItoFx03/arcyZMHUAVM0VFmVRqM=;
        b=TduK/K81V72pl7QRPORYrRvjVH7jZNCriEnqdiEI2SIFNy1rvzz2Y/C7VBOzdjdG3FeANP
        tLRMfKAAEXe7CiXAfUBX8+inXGUXr2pEamSHLh3txsviWt4xamjT/m05aYO3aL5Hn7Hts7
        0K+LTDPqWKp3GMXZvXTwNDMGnPPwi4A=
Date:   Mon, 13 Jan 2020 11:59:00 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1578927540.3.0@crapouillou.net>
In-Reply-To: <20200111114609.1979a8ff@archlinux>
References: <20200105001639.142061-1-contact@artur-rojek.eu>
        <20200105001639.142061-3-contact@artur-rojek.eu>
        <20200111114609.1979a8ff@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,


Le sam., janv. 11, 2020 at 11:46, Jonathan Cameron=20
<jic23@jic23.retrosnub.co.uk> a =E9crit :
> On Sun,  5 Jan 2020 01:16:37 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
>=20
>>  Implement support for the touchscreen mode found in JZ47xx SoCs ADC.
> This needs more description.
>=20
> Looks like it enables a kfifo and also selects the callback buffer
> stuff to run with a generic touchscreen iio-> input driver.
>=20
> A few other bits inline, but basically fine.
>=20
> I've never really thought about whether we support a CB buffer
> without anything on the IIO side.   That should be possible,
> but I'm not sure what odd corner cases will turn up.  I'm guessing
> there are some, or you'd not have bothered exposing it here?

I'm sorry, what do you mean by "nothing on the IIO side"?


>=20
> Thanks
>=20
> Jonathan
>=20
>=20
>>=20
>>  Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  Tested-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/iio/adc/Kconfig       |   3 +
>>   drivers/iio/adc/ingenic-adc.c | 120=20
>> +++++++++++++++++++++++++++++++++-
>>   2 files changed, 121 insertions(+), 2 deletions(-)
>>=20
>>  diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>  index 5d8540b7b427..dabbf15032af 100644
>>  --- a/drivers/iio/adc/Kconfig
>>  +++ b/drivers/iio/adc/Kconfig
>>  @@ -446,6 +446,9 @@ config INA2XX_ADC
>>   config INGENIC_ADC
>>   	tristate "Ingenic JZ47xx SoCs ADC driver"
>>   	depends on MIPS || COMPILE_TEST
>>  +	select IIO_BUFFER
>>  +	select IIO_BUFFER_CB
>=20
> Feels like IIO_BUFFER_CB should be selected by the driver that
> uses that functionality rather than this one.
>=20
>>  +	select IIO_KFIFO_BUF
>>   	help
>>   	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC=20
>> unit.
>>=20
>>  diff --git a/drivers/iio/adc/ingenic-adc.c=20
>> b/drivers/iio/adc/ingenic-adc.c
>>  index 7a24bc1dabe1..4dbf15fdd95d 100644
>>  --- a/drivers/iio/adc/ingenic-adc.c
>>  +++ b/drivers/iio/adc/ingenic-adc.c
>>  @@ -8,7 +8,10 @@
>>=20
>>   #include <dt-bindings/iio/adc/ingenic,adc.h>
>>   #include <linux/clk.h>
>>  +#include <linux/iio/buffer.h>
>>   #include <linux/iio/iio.h>
>>  +#include <linux/iio/kfifo_buf.h>
>>  +#include <linux/interrupt.h>
>>   #include <linux/io.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>  @@ -20,6 +23,8 @@
>>   #define JZ_ADC_REG_CFG			0x04
>>   #define JZ_ADC_REG_CTRL			0x08
>>   #define JZ_ADC_REG_STATUS		0x0c
>>  +#define JZ_ADC_REG_ADSAME		0x10
>>  +#define JZ_ADC_REG_ADWAIT		0x14
>>   #define JZ_ADC_REG_ADTCH		0x18
>>   #define JZ_ADC_REG_ADBDAT		0x1c
>>   #define JZ_ADC_REG_ADSDAT		0x20
>>  @@ -28,6 +33,9 @@
>>   #define JZ_ADC_REG_ENABLE_PD		BIT(7)
>>   #define JZ_ADC_REG_CFG_AUX_MD		(BIT(0) | BIT(1))
>>   #define JZ_ADC_REG_CFG_BAT_MD		BIT(4)
>>  +#define JZ_ADC_REG_CFG_PULL_UP(n)	((n) << 16)
>>  +#define JZ_ADC_REG_CFG_SAMPLE_NUM(n)	((n) << 10)
>>  +#define JZ_ADC_REG_CFG_TOUCH_OPS_MASK	(BIT(31) | GENMASK(23, 10))
>>   #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
>>   #define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
>>   #define JZ4770_ADC_REG_ADCLK_CLKDIV10US_LSB	8
>>  @@ -44,6 +52,14 @@
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
>>  @@ -411,6 +427,30 @@ static const struct iio_info ingenic_adc_info=20
>> =3D {
>>   };
>>=20
>>   static const struct iio_chan_spec ingenic_channels[] =3D {
>>  +	{
>>  +		.extend_name =3D "touchscreen_xp",
>=20
> Note that adding extended names:
>=20
> 1) Needs documenting as it create ABI - so something in
> Documentation/ABI/testing/sysfs-bus-iio-*
>=20
> 2) Breaks any generic userspace application.
>=20
> Why can't we use modified and an axis to identify this?

I'm in a good place to know that extended names are bad. The problem=20
here is that Xn/Yn channels will be added later (we have a board that=20
has one joystick connected to Xp/Yp, and a second joystick connected to=20
Xn/Yn). I assume that it is not possible to have two channels with the=20
same type and modifier?

Alternatively I believe we could also have the first two channels as=20
X/Y single-ended, and then two channels as X/Y differential, and do=20
some easy math in the joystick driver, but that would make it pretty=20
hardware-specific.

Cheers,
-Paul

>=20
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
>>  +		.extend_name =3D "touchscreen_yp",
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
>>  @@ -418,6 +458,7 @@ static const struct iio_chan_spec=20
>> ingenic_channels[] =3D {
>>   				      BIT(IIO_CHAN_INFO_SCALE),
>>   		.indexed =3D 1,
>>   		.channel =3D INGENIC_ADC_AUX,
>>  +		.scan_index =3D -1
>>   	},
>>   	{
>>   		.extend_name =3D "battery",
>>  @@ -428,6 +469,7 @@ static const struct iio_chan_spec=20
>> ingenic_channels[] =3D {
>>   						BIT(IIO_CHAN_INFO_SCALE),
>>   		.indexed =3D 1,
>>   		.channel =3D INGENIC_ADC_BATTERY,
>>  +		.scan_index =3D -1
>>   	},
>>   	{ /* Must always be last in the array. */
>>   		.extend_name =3D "aux2",
>>  @@ -436,16 +478,70 @@ static const struct iio_chan_spec=20
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
>>  +	struct iio_buffer *buffer;
>>  +	int irq, ret;
>>=20
>>   	soc_data =3D device_get_match_data(dev);
>>   	if (!soc_data)
>>  @@ -460,6 +556,18 @@ static int ingenic_adc_probe(struct=20
>> platform_device *pdev)
>>   	mutex_init(&adc->aux_lock);
>>   	adc->soc_data =3D soc_data;
>>=20
>>  +	irq =3D platform_get_irq(pdev, 0);
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
>>  @@ -499,7 +607,8 @@ static int ingenic_adc_probe(struct=20
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
>>  @@ -507,6 +616,13 @@ static int ingenic_adc_probe(struct=20
>> platform_device *pdev)
>>   		iio_dev->num_channels -=3D 1;
>>   	iio_dev->info =3D &ingenic_adc_info;
>>=20
>>  +	buffer =3D devm_iio_kfifo_allocate(dev);
>>  +	if (!buffer) {
>>  +		dev_err(dev, "Unable to add IIO buffer\n");
>>  +		return -ENOMEM;
>>  +	}
>>  +	iio_device_attach_buffer(iio_dev, buffer);
>>  +
>>   	ret =3D devm_iio_device_register(dev, iio_dev);
>>   	if (ret)
>>   		dev_err(dev, "Unable to register IIO device\n");
>=20

=

