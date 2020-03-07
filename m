Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7820E17CDE4
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCGLmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 06:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGLmh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 06:42:37 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704742073C;
        Sat,  7 Mar 2020 11:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583581356;
        bh=E6m+Cvd7VXvkzjdxK/ZRTKYIia3elhGZMFemu9cqZAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LnVGFXGjdTw7aIWPzFER0BcndfhxhvApovXwFU6kSj2/DD2FaeZxDf59Bwcukw59H
         4smXbCFho8X1D5Nlqx0hNSRu4Yg0diFDP7+Fvx0PzLED0IZmt7Iw529e56kKyvoMnb
         39bcROttKtRubReUzkXlMQOcteNstnlo52bGQ7Z8=
Date:   Sat, 7 Mar 2020 11:42:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     xxm <xxm@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, lars@metafoo.de,
        linux-iio@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, kever.yang@rock-chips.com,
        linux-rockchip@lists.infradead.org, pmeerw@pmeerw.net,
        knaack.h@gmx.de
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Add support iio
 =?UTF-8?B?YnVmZmVyc+OAkOivt+azqOaEj++8jOmCruS7tueUsWxpbnV4LXJvY2tjaGlw?=
 =?UTF-8?B?LWJvdW5jZXMreHhtPXJvY2stY2hpcHMuY29tQGxpc3RzLmluZnJhZGVhZC5v?=
 =?UTF-8?B?cmfku6Plj5HjgJE=?=
Message-ID: <20200307114231.41832f07@archlinux>
In-Reply-To: <9036a57e-be5e-49e1-6f0e-77b3a5e9fa12@rock-chips.com>
References: <20200301112353.887028-1-heiko@sntech.de>
        <67e46e36-ebac-ebe3-b4f4-9edb88fb0dcf@rock-chips.com>
        <20200303203236.2cbcfeee@archlinux>
        <9036a57e-be5e-49e1-6f0e-77b3a5e9fa12@rock-chips.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Mar 2020 09:39:10 +0800
xxm <xxm@rock-chips.com> wrote:

> Hi,
>=20
> =E5=9C=A8 2020/3/4 4:32, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Mon, 2 Mar 2020 10:11:02 +0800
> > xxm <xxm@rock-chips.com> wrote:
> >  =20
> >> Hi, Heiko
> >>
> >> =E5=9C=A8 2020/3/1 19:23, Heiko Stuebner =E5=86=99=E9=81=93: =20
> >>> From: Simon Xue <xxm@rock-chips.com>
> >>>
> >>> Add the ability to also support access via (triggered) buffers
> >>> next to the existing direct mode.
> >>>
> >>> Device in question is the Odroid Go Advance that connects a joystick
> >>> to two of the saradc channels for X and Y axis and the new (and still
> >>> pending) adc joystick driver of course wants to use triggered buffers
> >>> from the iio subsystem.
> >>>
> >>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> >>> [some simplifications and added commit description]
> >>> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> >>> ---
> >>>    drivers/iio/adc/Kconfig           |   2 +
> >>>    drivers/iio/adc/rockchip_saradc.c | 137 ++++++++++++++++++++++----=
----
> >>>    2 files changed, 102 insertions(+), 37 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >>> index 82e33082958c..55d2499ff757 100644
> >>> --- a/drivers/iio/adc/Kconfig
> >>> +++ b/drivers/iio/adc/Kconfig
> >>> @@ -787,6 +787,8 @@ config ROCKCHIP_SARADC
> >>>    	tristate "Rockchip SARADC driver"
> >>>    	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
> >>>    	depends on RESET_CONTROLLER
> >>> +	select IIO_BUFFER
> >>> +	select IIO_TRIGGERED_BUFFER
> >>>    	help
> >>>    	  Say yes here to build support for the SARADC found in SoCs from
> >>>    	  Rockchip.
> >>> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rock=
chip_saradc.c
> >>> index 582ba047c4a6..402b2210a682 100644
> >>> --- a/drivers/iio/adc/rockchip_saradc.c
> >>> +++ b/drivers/iio/adc/rockchip_saradc.c
> >>> @@ -15,7 +15,11 @@
> >>>    #include <linux/delay.h>
> >>>    #include <linux/reset.h>
> >>>    #include <linux/regulator/consumer.h>
> >>> +#include <linux/iio/buffer.h>
> >>>    #include <linux/iio/iio.h>
> >>> +#include <linux/iio/trigger.h>
> >>> +#include <linux/iio/trigger_consumer.h>
> >>> +#include <linux/iio/triggered_buffer.h>
> >>>   =20
> >>>    #define SARADC_DATA			0x00
> >>>   =20
> >>> @@ -34,7 +38,6 @@
> >>>    #define SARADC_TIMEOUT			msecs_to_jiffies(100)
> >>>   =20
> >>>    struct rockchip_saradc_data {
> >>> -	int				num_bits;
> >>>    	const struct iio_chan_spec	*channels;
> >>>    	int				num_channels;
> >>>    	unsigned long			clk_rate;
> >>> @@ -49,8 +52,37 @@ struct rockchip_saradc {
> >>>    	struct reset_control	*reset;
> >>>    	const struct rockchip_saradc_data *data;
> >>>    	u16			last_val;
> >>> +	const struct iio_chan_spec *last_chan;
> >>>    };
> >>>   =20
> >>> +static void rockchip_saradc_power_down(struct rockchip_saradc *info)
> >>> +{
> >>> +	/* Clear irq & power down adc */
> >>> +	writel_relaxed(0, info->regs + SARADC_CTRL);
> >>> +}
> >>> +
> >>> +static int rockchip_saradc_conversion(struct rockchip_saradc *info,
> >>> +				   struct iio_chan_spec const *chan)
> >>> +{
> >>> +	reinit_completion(&info->completion);
> >>> +
> >>> +	/* 8 clock periods as delay between power up and start cmd */
> >>> +	writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
> >>> +
> >>> +	info->last_chan =3D chan;
> >>> +
> >>> +	/* Select the channel to be used and trigger conversion */
> >>> +	writel(SARADC_CTRL_POWER_CTRL
> >>> +			| (chan->channel & SARADC_CTRL_CHN_MASK)
> >>> +			| SARADC_CTRL_IRQ_ENABLE,
> >>> +		   info->regs + SARADC_CTRL);
> >>> +
> >>> +	if (!wait_for_completion_timeout(&info->completion, SARADC_TIMEOUT))
> >>> +		return -ETIMEDOUT;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>    static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
> >>>    				    struct iio_chan_spec const *chan,
> >>>    				    int *val, int *val2, long mask)
> >>> @@ -62,24 +94,12 @@ static int rockchip_saradc_read_raw(struct iio_de=
v *indio_dev,
> >>>    	case IIO_CHAN_INFO_RAW:
> >>>    		mutex_lock(&indio_dev->mlock);
> >>>   =20
> >>> -		reinit_completion(&info->completion);
> >>> -
> >>> -		/* 8 clock periods as delay between power up and start cmd */
> >>> -		writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
> >>> -
> >>> -		/* Select the channel to be used and trigger conversion */
> >>> -		writel(SARADC_CTRL_POWER_CTRL
> >>> -				| (chan->channel & SARADC_CTRL_CHN_MASK)
> >>> -				| SARADC_CTRL_IRQ_ENABLE,
> >>> -		       info->regs + SARADC_CTRL);
> >>> -
> >>> -		if (!wait_for_completion_timeout(&info->completion,
> >>> -						 SARADC_TIMEOUT)) {
> >>> -			writel_relaxed(0, info->regs + SARADC_CTRL);
> >>> +		ret =3D rockchip_saradc_conversion(info, chan);
> >>> +		if (ret) {
> >>> +			rockchip_saradc_power_down(info);
> >>>    			mutex_unlock(&indio_dev->mlock);
> >>> -			return -ETIMEDOUT;
> >>> +			return ret;
> >>>    		}
> >>> -
> >>>    		*val =3D info->last_val;
> >>>    		mutex_unlock(&indio_dev->mlock);
> >>>    		return IIO_VAL_INT;
> >>> @@ -91,7 +111,7 @@ static int rockchip_saradc_read_raw(struct iio_dev=
 *indio_dev,
> >>>    		}
> >>>   =20
> >>>    		*val =3D ret / 1000;
> >>> -		*val2 =3D info->data->num_bits;
> >>> +		*val2 =3D chan->scan_type.realbits;
> >>>    		return IIO_VAL_FRACTIONAL_LOG2;
> >>>    	default:
> >>>    		return -EINVAL;
> >>> @@ -104,10 +124,9 @@ static irqreturn_t rockchip_saradc_isr(int irq, =
void *dev_id)
> >>>   =20
> >>>    	/* Read value */
> >>>    	info->last_val =3D readl_relaxed(info->regs + SARADC_DATA);
> >>> -	info->last_val &=3D GENMASK(info->data->num_bits - 1, 0);
> >>> +	info->last_val &=3D GENMASK(info->last_chan->scan_type.realbits - 1=
, 0);
> >>>   =20
> >>> -	/* Clear irq & power down adc */
> >>> -	writel_relaxed(0, info->regs + SARADC_CTRL);
> >>> +	rockchip_saradc_power_down(info);
> >>>   =20
> >>>    	complete(&info->completion);
> >>>   =20
> >>> @@ -118,51 +137,55 @@ static const struct iio_info rockchip_saradc_ii=
o_info =3D {
> >>>    	.read_raw =3D rockchip_saradc_read_raw,
> >>>    };
> >>>   =20
> >>> -#define ADC_CHANNEL(_index, _id) {				\
> >>> +#define ADC_CHANNEL(_index, _id, _res) {			\
> >>>    	.type =3D IIO_VOLTAGE,					\
> >>>    	.indexed =3D 1,						\
> >>>    	.channel =3D _index,					\
> >>>    	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> >>>    	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
> >>>    	.datasheet_name =3D _id,					\
> >>> +	.scan_index =3D _index,					\
> >>> +	.scan_type =3D {						\
> >>> +		.sign =3D 'u',					\
> >>> +		.realbits =3D _res,				\
> >>> +		.storagebits =3D 16,				\
> >>> +		.endianness =3D IIO_LE,				\
> >>> +	},							\
> >>>    }
> >>>   =20
> >>>    static const struct iio_chan_spec rockchip_saradc_iio_channels[] =
=3D {
> >>> -	ADC_CHANNEL(0, "adc0"),
> >>> -	ADC_CHANNEL(1, "adc1"),
> >>> -	ADC_CHANNEL(2, "adc2"),
> >>> +	ADC_CHANNEL(0, "adc0", 10),
> >>> +	ADC_CHANNEL(1, "adc1", 10),
> >>> +	ADC_CHANNEL(2, "adc2", 10),
> >>>    };
> >>>   =20
> >>>    static const struct rockchip_saradc_data saradc_data =3D {
> >>> -	.num_bits =3D 10,
> >>>    	.channels =3D rockchip_saradc_iio_channels,
> >>>    	.num_channels =3D ARRAY_SIZE(rockchip_saradc_iio_channels),
> >>>    	.clk_rate =3D 1000000,
> >>>    };
> >>>   =20
> >>>    static const struct iio_chan_spec rockchip_rk3066_tsadc_iio_channe=
ls[] =3D {
> >>> -	ADC_CHANNEL(0, "adc0"),
> >>> -	ADC_CHANNEL(1, "adc1"),
> >>> +	ADC_CHANNEL(0, "adc0", 12),
> >>> +	ADC_CHANNEL(1, "adc1", 12),
> >>>    };
> >>>   =20
> >>>    static const struct rockchip_saradc_data rk3066_tsadc_data =3D {
> >>> -	.num_bits =3D 12,
> >>>    	.channels =3D rockchip_rk3066_tsadc_iio_channels,
> >>>    	.num_channels =3D ARRAY_SIZE(rockchip_rk3066_tsadc_iio_channels),
> >>>    	.clk_rate =3D 50000,
> >>>    };
> >>>   =20
> >>>    static const struct iio_chan_spec rockchip_rk3399_saradc_iio_chann=
els[] =3D {
> >>> -	ADC_CHANNEL(0, "adc0"),
> >>> -	ADC_CHANNEL(1, "adc1"),
> >>> -	ADC_CHANNEL(2, "adc2"),
> >>> -	ADC_CHANNEL(3, "adc3"),
> >>> -	ADC_CHANNEL(4, "adc4"),
> >>> -	ADC_CHANNEL(5, "adc5"),
> >>> +	ADC_CHANNEL(0, "adc0", 10),
> >>> +	ADC_CHANNEL(1, "adc1", 10),
> >>> +	ADC_CHANNEL(2, "adc2", 10),
> >>> +	ADC_CHANNEL(3, "adc3", 10),
> >>> +	ADC_CHANNEL(4, "adc4", 10),
> >>> +	ADC_CHANNEL(5, "adc5", 10),
> >>>    };
> >>>   =20
> >>>    static const struct rockchip_saradc_data rk3399_saradc_data =3D {
> >>> -	.num_bits =3D 10,
> >>>    	.channels =3D rockchip_rk3399_saradc_iio_channels,
> >>>    	.num_channels =3D ARRAY_SIZE(rockchip_rk3399_saradc_iio_channels),
> >>>    	.clk_rate =3D 1000000,
> >>> @@ -193,6 +216,39 @@ static void rockchip_saradc_reset_controller(str=
uct reset_control *reset)
> >>>    	reset_control_deassert(reset);
> >>>    }
> >>>   =20
> >>> +static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
> >>> +{
> >>> +	struct iio_poll_func *pf =3D p;
> >>> +	struct iio_dev *i_dev =3D pf->indio_dev;
> >>> +	struct rockchip_saradc *info =3D iio_priv(i_dev);
> >>> +	u16 data[20]; =20
> >> How about this:
> >> #define MAX_CHANNEL_NUM 16 =20
> >=20
> > Unfortunately this is a bit more complex than it seems.
> > The buffer needs to be big enough for all the channels
> > + a 8 byte aligned space to put the timestamp in.
> >=20
> > You can construct that in a fashion suitable to use in a
> > macro but it's a bit more fiddly than simply being the
> > maximum number of channels.
> >  =20
> Make use of iio_dev->scan_bytes to alloc a buffer in=20
> iio_info->update_scan_mode callback for storing the
> "data + timestamp" is another way

Please don't do that. scan_bytes is marked as [INTERN] in
the docs in iio.h.   The reason for this is it is an internal
implementation detail.  Drivers should not be touching it.
We never provided any sort of utility function because it's normally
really easy for a driver to establish an upper bound for itself.

Jonathan


> >> u16 data[MAX_CHANNEL_NUM]; =20
> >>> +	int ret;
> >>> +	int i, j =3D 0;
> >>> +
> >>> +	mutex_lock(&i_dev->mlock);
> >>> +
> >>> +	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
> >>> +		const struct iio_chan_spec *chan =3D &i_dev->channels[i];
> >>> +
> >>> +		ret =3D rockchip_saradc_conversion(info, chan);
> >>> +		if (ret) {
> >>> +			rockchip_saradc_power_down(info);
> >>> +			goto out;
> >>> +		}
> >>> +
> >>> +		data[j] =3D info->last_val;
> >>> +		j++;
> >>> +	}
> >>> +
> >>> +	iio_push_to_buffers_with_timestamp(i_dev, data, iio_get_time_ns(i_d=
ev));
> >>> +out:
> >>> +	mutex_unlock(&i_dev->mlock);
> >>> +
> >>> +	iio_trigger_notify_done(i_dev->trig);
> >>> +
> >>> +	return IRQ_HANDLED;
> >>> +}
> >>> +
> >>>    static int rockchip_saradc_probe(struct platform_device *pdev)
> >>>    {
> >>>    	struct rockchip_saradc *info =3D NULL;
> >>> @@ -315,12 +371,19 @@ static int rockchip_saradc_probe(struct platfor=
m_device *pdev)
> >>>    	indio_dev->channels =3D info->data->channels;
> >>>    	indio_dev->num_channels =3D info->data->num_channels;
> >>>   =20
> >>> -	ret =3D iio_device_register(indio_dev);
> >>> +	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
> >>> +					 rockchip_saradc_trigger_handler, NULL); =20
> >> devm_iio_triggered_buffer_setup seems better =20
> >>>    	if (ret)
> >>>    		goto err_clk;
> >>>   =20
> >>> +	ret =3D iio_device_register(indio_dev);
> >>> +	if (ret)
> >>> +		goto err_buffer_cleanup;
> >>> +
> >>>    	return 0;
> >>>   =20
> >>> +err_buffer_cleanup:
> >>> +	iio_triggered_buffer_cleanup(indio_dev);
> >>>    err_clk:
> >>>    	clk_disable_unprepare(info->clk);
> >>>    err_pclk:
> >>>     =20
> >> xxm@rock-chips.com
> >>
> >> =20
> >=20
> >=20
> >=20
> >  =20
>=20
>=20

