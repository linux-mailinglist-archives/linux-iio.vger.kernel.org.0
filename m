Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA821CB48
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgGLUQS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 16:16:18 -0400
Received: from crapouillou.net ([89.234.176.41]:54636 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgGLUQS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 16:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594584974; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKxKe+OHWSliKAjEw9lsWdj2LNHN97IDSrIYWRHi+AU=;
        b=s86+3IcTTMhBNto3LPvATTNUzxtb1YXJrUTKMtKnRe6NOtZ50DWLh9RyY9WWBzXo7jPjL9
        SIJ/Ijq+CWR6PjT25YKUw1RT3UR1yVUaWszzB17mjyFoAtf5c/gTi6PcGvjkykq4DdbRPc
        Cu0yvn/2euDVHb+X52GkpoWKorvo/1E=
Date:   Sun, 12 Jul 2020 22:16:04 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 6/6] IIO: Ingenic JZ47xx: Add touchscreen mode.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <SMHDDQ.A6DG0J6PD8U92@crapouillou.net>
In-Reply-To: <20200712141946.7d8f802f@archlinux>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
        <20200709152200.10039-7-contact@artur-rojek.eu>
        <20200712141946.7d8f802f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le dim. 12 juil. 2020 =E0 14:19, Jonathan Cameron <jic23@kernel.org> a=20
=E9crit :
> On Thu,  9 Jul 2020 17:22:00 +0200
> Artur Rojek <contact@artur-rojek.eu> wrote:
>=20
>>  The SADC component in JZ47xx SoCs provides support for touchscreen
>>  operations (pen position and pen down pressure) in single-ended and
>>  differential modes.
>>=20
>>  The touchscreen component of SADC takes a significant time to=20
>> stabilize
>>  after first receiving the clock and a delay of 50ms has been=20
>> empirically
>>  proven to be a safe value before data sampling can begin.
>>=20
>>  Of the known hardware to use this controller, GCW Zero and Anbernic=20
>> RG-350
>>  utilize the touchscreen mode by having their joystick(s) attached=20
>> to the
>>  X/Y positive/negative input pins.
>>=20
>>  JZ4770 and later SoCs introduce a low-level command feature. With=20
>> it, up
>>  to 32 commands can be programmed, each one corresponding to a=20
>> sampling
>>  job. It allows to change the low-voltage reference, the high-voltage
>>  reference, have them connected to VCC, GND, or one of the X-/X+ or=20
>> Y-/Y+
>>  pins.
>>=20
>>  This patch introduces support for 6 stream-capable channels:
>>  - channel #0 samples X+/GND
>>  - channel #1 samples Y+/GND
>>  - channel #2 samples X-/GND
>>  - channel #3 samples Y-/GND
>>  - channel #4 samples X+/X-
>>  - channel #5 samples Y+/Y-
>=20
> The one thing I noticed on this read was that we are slightly=20
> stretching
> the normal IIO channel definitions.  The claim is that each of these=20
> channels
> is a POSITIONREALTIVE channel, whereas that isn't really true.  They=20
> are
> related to the position, but as I understand it not directly=20
> measuring it
> (particularly X+ - X-) which is pretty much a reference voltage (I=20
> think!)
>=20
> We might be better off just describing these as voltage channels, with
> 4 and 5 described as differential voltage channels.  The problem there
> being that it doesn't describe the fact that the measurements are with
> particular voltages also being applied to the touch screen.
>=20
> Perhaps we are best off just leaving it as you have it and being a bit
> 'odd'.  What do you think?  Having written this down I think perhaps=20
> leaving
> it alone is the best plan :(

That's up to you really. These ADC channels will measure voltage, but=20
they are supposed to be used with a touchscreen, that's why we went=20
with POSITIONRELATIVE. However, with the kind of devices we're working=20
with, they are never used as such, so using VOLTAGE would work too.

> Otherwise this all looks fine to me.
>=20
> Thanks,
>=20
> Jonathan
>=20
>>=20
>>  Being able to sample X-/GND and Y-/GND is useful on some devices,=20
>> where
>>  one joystick is connected to the X+/Y+ pins, and a second joystick=20
>> is
>>  connected to the X-/Y- pins.
>>=20
>>  All the boards which probe this driver have the interrupt provided=20
>> from
>>  Device Tree, with no need to handle a case where the IRQ was not=20
>> provided.
>>=20
>>  Co-developed-by: Paul Cercueil <paul@crapouillou.net>
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
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
>>   v4: clarify irq provider source in the patch description
>>=20
>>   v5: no change
>>=20
>>   v6: - correct the spelling of Device Tree and IRQ in commit message
>>       - don't omit trailing commas from initializer lists
>>       - error check `clk_enable`
>>       - remove redundant `dev_err` from `platform_get_irq` error=20
>> check
>>=20
>>   v7: no change
>>=20
>>   v8: add support for ADCMD low-level command feature
>>=20
>>   drivers/iio/adc/Kconfig       |   1 +
>>   drivers/iio/adc/ingenic-adc.c | 250=20
>> +++++++++++++++++++++++++++++++++-
>>   2 files changed, 249 insertions(+), 2 deletions(-)
>>=20
>>  diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>  index ff3569635ce0..5b57437cef75 100644
>>  --- a/drivers/iio/adc/Kconfig
>>  +++ b/drivers/iio/adc/Kconfig
>>  @@ -500,6 +500,7 @@ config INA2XX_ADC
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
>>  index 0233a9055c86..976aea46fede 100644
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
>>  @@ -20,19 +22,46 @@
>>   #define JZ_ADC_REG_CFG			0x04
>>   #define JZ_ADC_REG_CTRL			0x08
>>   #define JZ_ADC_REG_STATUS		0x0c
>>  +#define JZ_ADC_REG_ADSAME		0x10
>>  +#define JZ_ADC_REG_ADWAIT		0x14
>>   #define JZ_ADC_REG_ADTCH		0x18
>>   #define JZ_ADC_REG_ADBDAT		0x1c
>>   #define JZ_ADC_REG_ADSDAT		0x20
>>  +#define JZ_ADC_REG_ADCMD		0x24
>>   #define JZ_ADC_REG_ADCLK		0x28
>>=20
>>   #define JZ_ADC_REG_ENABLE_PD		BIT(7)
>>   #define JZ_ADC_REG_CFG_AUX_MD		(BIT(0) | BIT(1))
>>   #define JZ_ADC_REG_CFG_BAT_MD		BIT(4)
>>  +#define JZ_ADC_REG_CFG_SAMPLE_NUM(n)	((n) << 10)
>>  +#define JZ_ADC_REG_CFG_PULL_UP(n)	((n) << 16)
>>  +#define JZ_ADC_REG_CFG_CMD_SEL		BIT(22)
>>  +#define JZ_ADC_REG_CFG_TOUCH_OPS_MASK	(BIT(31) | GENMASK(23, 10))
>>   #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
>>   #define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
>>   #define JZ4770_ADC_REG_ADCLK_CLKDIV10US_LSB	8
>>   #define JZ4770_ADC_REG_ADCLK_CLKDIVMS_LSB	16
>>=20
>>  +#define JZ_ADC_REG_ADCMD_YNADC		BIT(7)
>>  +#define JZ_ADC_REG_ADCMD_YPADC		BIT(8)
>>  +#define JZ_ADC_REG_ADCMD_XNADC		BIT(9)
>>  +#define JZ_ADC_REG_ADCMD_XPADC		BIT(10)
>>  +#define JZ_ADC_REG_ADCMD_VREFPYP	BIT(11)
>>  +#define JZ_ADC_REG_ADCMD_VREFPXP	BIT(12)
>>  +#define JZ_ADC_REG_ADCMD_VREFPXN	BIT(13)
>>  +#define JZ_ADC_REG_ADCMD_VREFPAUX	BIT(14)
>>  +#define JZ_ADC_REG_ADCMD_VREFPVDD33	BIT(15)
>>  +#define JZ_ADC_REG_ADCMD_VREFNYN	BIT(16)
>>  +#define JZ_ADC_REG_ADCMD_VREFNXP	BIT(17)
>>  +#define JZ_ADC_REG_ADCMD_VREFNXN	BIT(18)
>>  +#define JZ_ADC_REG_ADCMD_VREFAUX	BIT(19)
>>  +#define JZ_ADC_REG_ADCMD_YNGRU		BIT(20)
>>  +#define JZ_ADC_REG_ADCMD_XNGRU		BIT(21)
>>  +#define JZ_ADC_REG_ADCMD_XPGRU		BIT(22)
>>  +#define JZ_ADC_REG_ADCMD_YPSUP		BIT(23)
>>  +#define JZ_ADC_REG_ADCMD_XNSUP		BIT(24)
>>  +#define JZ_ADC_REG_ADCMD_XPSUP		BIT(25)
>>  +
>>   #define JZ_ADC_AUX_VREF				3300
>>   #define JZ_ADC_AUX_VREF_BITS			12
>>   #define JZ_ADC_BATTERY_LOW_VREF			2500
>>  @@ -44,6 +73,14 @@
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
>>  @@ -69,6 +106,61 @@ struct ingenic_adc {
>>   	bool low_vref_mode;
>>   };
>>=20
>>  +static void ingenic_adc_set_adcmd(struct iio_dev *iio_dev,=20
>> unsigned long mask)
>>  +{
>>  +	struct ingenic_adc *adc =3D iio_priv(iio_dev);
>>  +
>>  +	mutex_lock(&adc->lock);
>>  +
>>  +	/* Init ADCMD */
>>  +	readl(adc->base + JZ_ADC_REG_ADCMD);
>>  +
>>  +	if (mask & 0x3) {
>>  +		/* Second channel (INGENIC_ADC_TOUCH_YP): sample YP vs. GND */
>>  +		writel(JZ_ADC_REG_ADCMD_XNGRU
>>  +		       | JZ_ADC_REG_ADCMD_VREFNXN | JZ_ADC_REG_ADCMD_VREFPVDD33
>>  +		       | JZ_ADC_REG_ADCMD_YPADC,
>>  +		       adc->base + JZ_ADC_REG_ADCMD);
>>  +
>>  +		/* First channel (INGENIC_ADC_TOUCH_XP): sample XP vs. GND */
>>  +		writel(JZ_ADC_REG_ADCMD_YNGRU
>>  +		       | JZ_ADC_REG_ADCMD_VREFNYN | JZ_ADC_REG_ADCMD_VREFPVDD33
>>  +		       | JZ_ADC_REG_ADCMD_XPADC,
>>  +		       adc->base + JZ_ADC_REG_ADCMD);
>>  +	}
>>  +
>>  +	if (mask & 0xc) {
>>  +		/* Fourth channel (INGENIC_ADC_TOUCH_YN): sample YN vs. GND */
>>  +		writel(JZ_ADC_REG_ADCMD_XNGRU
>>  +		       | JZ_ADC_REG_ADCMD_VREFNXN | JZ_ADC_REG_ADCMD_VREFPVDD33
>>  +		       | JZ_ADC_REG_ADCMD_YNADC,
>>  +		       adc->base + JZ_ADC_REG_ADCMD);
>>  +
>>  +		/* Third channel (INGENIC_ADC_TOUCH_XN): sample XN vs. GND */
>>  +		writel(JZ_ADC_REG_ADCMD_YNGRU
>>  +		       | JZ_ADC_REG_ADCMD_VREFNYN | JZ_ADC_REG_ADCMD_VREFPVDD33
>>  +		       | JZ_ADC_REG_ADCMD_XNADC,
>>  +		       adc->base + JZ_ADC_REG_ADCMD);
>>  +	}
>>  +
>>  +	if (mask & 0x30) {
>>  +		/* Sixth channel (INGENIC_ADC_TOUCH_YD): sample YP vs. YN */
>>  +		writel(JZ_ADC_REG_ADCMD_VREFNYN | JZ_ADC_REG_ADCMD_VREFPVDD33
>>  +		       | JZ_ADC_REG_ADCMD_YPADC,
>>  +		       adc->base + JZ_ADC_REG_ADCMD);
>>  +
>>  +		/* Fifth channel (INGENIC_ADC_TOUCH_XD): sample XP vs. XN */
>>  +		writel(JZ_ADC_REG_ADCMD_VREFNXN | JZ_ADC_REG_ADCMD_VREFPVDD33
>>  +		       | JZ_ADC_REG_ADCMD_XPADC,
>>  +		       adc->base + JZ_ADC_REG_ADCMD);
>>  +	}
>>  +
>>  +	/* We're done */
>>  +	writel(0, adc->base + JZ_ADC_REG_ADCMD);
>>  +
>>  +	mutex_unlock(&adc->lock);
>>  +}
>>  +
>>   static void ingenic_adc_set_config(struct ingenic_adc *adc,
>>   				   uint32_t mask,
>>   				   uint32_t val)
>>  @@ -288,6 +380,72 @@ static const struct iio_chan_spec=20
>> jz4740_channels[] =3D {
>>   };
>>=20
>>   static const struct iio_chan_spec jz4770_channels[] =3D {
>>  +	{
>>  +		.type =3D IIO_POSITIONRELATIVE,
>>  +		.indexed =3D 1,
>>  +		.channel =3D INGENIC_ADC_TOUCH_XP,
>=20
> Ah. sorry. I should have noticed this much earlier.
>=20
> These aren't position channels as such.  They are channels
> that are then processed into position in combination.
>=20
> Problem is I'm not sure how we 'should' describe then.
>=20
> Perhaps this is the best we can do.

We could have the two differencial channels as IIO_POSITIONRELATIVE,=20
and the four single-ended ones as IIO_VOLTAGE.

Cheers,
-Paul

>>  +		.scan_index =3D 0,
>>  +		.scan_type =3D {
>>  +			.sign =3D 'u',
>>  +			.realbits =3D 12,
>>  +			.storagebits =3D 16,
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
>>  +			.storagebits =3D 16,
>>  +		},
>>  +	},
>>  +	{
>>  +		.type =3D IIO_POSITIONRELATIVE,
>>  +		.indexed =3D 1,
>>  +		.channel =3D INGENIC_ADC_TOUCH_XN,
>>  +		.scan_index =3D 2,
>>  +		.scan_type =3D {
>>  +			.sign =3D 'u',
>>  +			.realbits =3D 12,
>>  +			.storagebits =3D 16,
>>  +		},
>>  +	},
>>  +	{
>>  +		.type =3D IIO_POSITIONRELATIVE,
>>  +		.indexed =3D 1,
>>  +		.channel =3D INGENIC_ADC_TOUCH_YN,
>>  +		.scan_index =3D 3,
>>  +		.scan_type =3D {
>>  +			.sign =3D 'u',
>>  +			.realbits =3D 12,
>>  +			.storagebits =3D 16,
>>  +		},
>>  +	},
>>  +	{
>>  +		.type =3D IIO_POSITIONRELATIVE,
>>  +		.indexed =3D 1,
>>  +		.channel =3D INGENIC_ADC_TOUCH_XD,
>>  +		.scan_index =3D 4,
>>  +		.scan_type =3D {
>>  +			.sign =3D 'u',
>>  +			.realbits =3D 12,
>>  +			.storagebits =3D 16,
>>  +		},
>>  +	},
>>  +	{
>>  +		.type =3D IIO_POSITIONRELATIVE,
>>  +		.indexed =3D 1,
>>  +		.channel =3D INGENIC_ADC_TOUCH_YD,
>>  +		.scan_index =3D 5,
>>  +		.scan_type =3D {
>>  +			.sign =3D 'u',
>>  +			.realbits =3D 12,
>>  +			.storagebits =3D 16,
>>  +		},
>>  +	},
>>   	{
>>   		.extend_name =3D "aux",
>>   		.type =3D IIO_VOLTAGE,
>>  @@ -490,13 +648,89 @@ static const struct iio_info ingenic_adc_info=20
>> =3D {
>>   	.of_xlate =3D ingenic_adc_of_xlate,
>>   };
>>=20
>>  +static int ingenic_adc_buffer_enable(struct iio_dev *iio_dev)
>>  +{
>>  +	struct ingenic_adc *adc =3D iio_priv(iio_dev);
>>  +	int ret;
>>  +
>>  +	ret =3D clk_enable(adc->clk);
>>  +	if (ret) {
>>  +		dev_err(iio_dev->dev.parent, "Failed to enable clock: %d\n",
>>  +			ret);
>>  +		return ret;
>>  +	}
>>  +
>>  +	/* It takes significant time for the touchscreen hw to stabilize.=20
>> */
>>  +	msleep(50);
>>  +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK,
>>  +			       JZ_ADC_REG_CFG_SAMPLE_NUM(4) |
>>  +			       JZ_ADC_REG_CFG_PULL_UP(4));
>>  +
>>  +	writew(80, adc->base + JZ_ADC_REG_ADWAIT);
>>  +	writew(2, adc->base + JZ_ADC_REG_ADSAME);
>>  +	writeb((u8)~JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_CTRL);
>>  +	writel(0, adc->base + JZ_ADC_REG_ADTCH);
>>  +
>>  +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_CMD_SEL,
>>  +			       JZ_ADC_REG_CFG_CMD_SEL);
>>  +	ingenic_adc_set_adcmd(iio_dev, iio_dev->active_scan_mask[0]);
>>  +
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
>>  +
>>  +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_CMD_SEL, 0);
>>  +
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
>>  +	unsigned long mask =3D iio_dev->active_scan_mask[0];
>>  +	unsigned int i;
>>  +	u32 tdat[3];
>>  +
>>  +	for (i =3D 0; i < ARRAY_SIZE(tdat); mask >>=3D 2, i++) {
>>  +		if (mask & 0x3)
>>  +			tdat[i] =3D readl(adc->base + JZ_ADC_REG_ADTCH);
>>  +		else
>>  +			tdat[i] =3D 0;
>>  +	}
>>  +
>>  +	iio_push_to_buffers(iio_dev, tdat);
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
>>  @@ -511,6 +745,17 @@ static int ingenic_adc_probe(struct=20
>> platform_device *pdev)
>>   	mutex_init(&adc->aux_lock);
>>   	adc->soc_data =3D soc_data;
>>=20
>>  +	irq =3D platform_get_irq(pdev, 0);
>>  +	if (irq < 0)
>>  +		return irq;
>>  +
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
>>  @@ -550,7 +795,8 @@ static int ingenic_adc_probe(struct=20
>> platform_device *pdev)
>>=20
>>   	iio_dev->dev.parent =3D dev;
>>   	iio_dev->name =3D "jz-adc";
>>  -	iio_dev->modes =3D INDIO_DIRECT_MODE;
>>  +	iio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>>  +	iio_dev->setup_ops =3D &ingenic_buffer_setup_ops;
>>   	iio_dev->channels =3D soc_data->channels;
>>   	iio_dev->num_channels =3D soc_data->num_channels;
>>   	iio_dev->info =3D &ingenic_adc_info;
>=20


