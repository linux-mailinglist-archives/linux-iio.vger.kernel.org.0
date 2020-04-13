Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D880D1A6ABE
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgDMRAG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732122AbgDMRAF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 13:00:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F95F2063A;
        Mon, 13 Apr 2020 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586797204;
        bh=ocGzwyhvt/PYPOB6+zxPTBWiQ899GAZEAY8iTUvNIUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bkW+EpneMfX+D9Fq74tsKvBc78hHopXaLraz2OzLalkawmS5DI/6HD6SbW2OYPnDh
         FIuAI9QbsUfix589HVlHAulQ1glRXMUbG3bqg+pZMNZ661s5+e+B/g4c4k42pcOdNc
         uERlxUqGbIItvHB+RblBOmESFU8ajXH0dMXm5q/8=
Date:   Mon, 13 Apr 2020 17:59:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, xxm@rock-chips.com,
        kever.yang@rock-chips.com
Subject: Re: [PATCH v3] iio: adc: rockchip_saradc: Add support iio buffers
Message-ID: <20200413175959.7766b9c8@archlinux>
In-Reply-To: <4304017.Osc3njyXrW@diego>
References: <20200412224251.2919182-1-heiko@sntech.de>
        <20200413174434.55b2941a@archlinux>
        <4304017.Osc3njyXrW@diego>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 18:55:12 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Hi Jonathan,
>=20

Hi Heiko,

> > > +/* buffer elements are u16, timestamp needs to be 8-byte aligned */
> > > +#define SARADC_BUFFER_NUM_U16	ALIGN(SARADC_MAX_CHANNELS, 4) =20
> > I may be going crazy but I think that will get you the 'start' of the
> > timestamp, not the length including it.
> >=20
> > We should be seeing 24 bytes here =3D 12 u16s.  Sanity check the value.
> >=20
> > Running through the stack of defines.
> > #define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
> > #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> > #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
> >=20
> > ALIGN(6, 4) =3D=3D __ALIGN_KERNEL(6, 4)
> >             =3D=3D __ALIGN_KERNEL_MASK(6, 3)
> >             =3D=3D (((6 + 3) & ~3)=20
> > which is 9 with the bottom two bits masked or b1001 & b1100 =3D 8 not 12
> >=20
> > So I think you are looking for
> > ALIGN(SARADC_MAX_CHANNELS + sizeof(u64) / sizeof(u16), 4)
> > which will be ((10 + 3) & ~3) b1101 & b1100 =3D 12 =20
>=20
> hmm, getting the start of the timestamp was actually what I intended ;-)
> The dln2-adc driver did that fancy struct definition for its data. which
> I stole, see the part from blow:

Crossed emails. I realised I was being an idiot but had already clicked sen=
d :)

>=20
> > > +	struct {
> > > +		u16 values[SARADC_BUFFER_NUM_U16];
> > > +		int64_t timestamp;
> > > +	} data; =20
>=20
> So SARADC_BUFFER_NUM really is meant to only contain the
> number of actual buffer data - I guess I should explain that out better
> in the comment. Because defining this separate makes this so much
> more readable when we're not trying to implicitly add the timestamp
> space.
>=20
> And a size_of(data) for that struct then returned nicely these 24 bytes
> in my tests.
>=20
>=20
> > > =20
> > >  struct rockchip_saradc_data {
> > > -	int				num_bits;
> > >  	const struct iio_chan_spec	*channels;
> > >  	int				num_channels;
> > >  	unsigned long			clk_rate;
> > > @@ -49,8 +56,37 @@ struct rockchip_saradc {
> > >  	struct reset_control	*reset;
> > >  	const struct rockchip_saradc_data *data;
> > >  	u16			last_val;
> > > +	const struct iio_chan_spec *last_chan;
> > >  };
> > > =20
> > > +static void rockchip_saradc_power_down(struct rockchip_saradc *info)
> > > +{
> > > +	/* Clear irq & power down adc */
> > > +	writel_relaxed(0, info->regs + SARADC_CTRL);
> > > +}
> > > +
> > > +static int rockchip_saradc_conversion(struct rockchip_saradc *info,
> > > +				   struct iio_chan_spec const *chan)
> > > +{
> > > +	reinit_completion(&info->completion);
> > > +
> > > +	/* 8 clock periods as delay between power up and start cmd */
> > > +	writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
> > > +
> > > +	info->last_chan =3D chan;
> > > +
> > > +	/* Select the channel to be used and trigger conversion */
> > > +	writel(SARADC_CTRL_POWER_CTRL
> > > +			| (chan->channel & SARADC_CTRL_CHN_MASK)
> > > +			| SARADC_CTRL_IRQ_ENABLE,
> > > +		   info->regs + SARADC_CTRL);
> > > +
> > > +	if (!wait_for_completion_timeout(&info->completion, SARADC_TIMEOUT))
> > > +		return -ETIMEDOUT;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
> > >  				    struct iio_chan_spec const *chan,
> > >  				    int *val, int *val2, long mask)
> > > @@ -62,24 +98,12 @@ static int rockchip_saradc_read_raw(struct iio_de=
v *indio_dev,
> > >  	case IIO_CHAN_INFO_RAW:
> > >  		mutex_lock(&indio_dev->mlock);
> > > =20
> > > -		reinit_completion(&info->completion);
> > > -
> > > -		/* 8 clock periods as delay between power up and start cmd */
> > > -		writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
> > > -
> > > -		/* Select the channel to be used and trigger conversion */
> > > -		writel(SARADC_CTRL_POWER_CTRL
> > > -				| (chan->channel & SARADC_CTRL_CHN_MASK)
> > > -				| SARADC_CTRL_IRQ_ENABLE,
> > > -		       info->regs + SARADC_CTRL);
> > > -
> > > -		if (!wait_for_completion_timeout(&info->completion,
> > > -						 SARADC_TIMEOUT)) {
> > > -			writel_relaxed(0, info->regs + SARADC_CTRL);
> > > +		ret =3D rockchip_saradc_conversion(info, chan);
> > > +		if (ret) {
> > > +			rockchip_saradc_power_down(info);
> > >  			mutex_unlock(&indio_dev->mlock);
> > > -			return -ETIMEDOUT;
> > > +			return ret;
> > >  		}
> > > -
> > >  		*val =3D info->last_val;
> > >  		mutex_unlock(&indio_dev->mlock);
> > >  		return IIO_VAL_INT;
> > > @@ -91,7 +115,7 @@ static int rockchip_saradc_read_raw(struct iio_dev=
 *indio_dev,
> > >  		}
> > > =20
> > >  		*val =3D ret / 1000;
> > > -		*val2 =3D info->data->num_bits;
> > > +		*val2 =3D chan->scan_type.realbits;
> > >  		return IIO_VAL_FRACTIONAL_LOG2;
> > >  	default:
> > >  		return -EINVAL;
> > > @@ -104,10 +128,9 @@ static irqreturn_t rockchip_saradc_isr(int irq, =
void *dev_id)
> > > =20
> > >  	/* Read value */
> > >  	info->last_val =3D readl_relaxed(info->regs + SARADC_DATA);
> > > -	info->last_val &=3D GENMASK(info->data->num_bits - 1, 0);
> > > +	info->last_val &=3D GENMASK(info->last_chan->scan_type.realbits - 1=
, 0);
> > > =20
> > > -	/* Clear irq & power down adc */
> > > -	writel_relaxed(0, info->regs + SARADC_CTRL);
> > > +	rockchip_saradc_power_down(info);
> > > =20
> > >  	complete(&info->completion);
> > > =20
> > > @@ -118,51 +141,55 @@ static const struct iio_info rockchip_saradc_ii=
o_info =3D {
> > >  	.read_raw =3D rockchip_saradc_read_raw,
> > >  };
> > > =20
> > > -#define ADC_CHANNEL(_index, _id) {				\
> > > +#define ADC_CHANNEL(_index, _id, _res) {			\
> > >  	.type =3D IIO_VOLTAGE,					\
> > >  	.indexed =3D 1,						\
> > >  	.channel =3D _index,					\
> > >  	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> > >  	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
> > >  	.datasheet_name =3D _id,					\
> > > +	.scan_index =3D _index,					\
> > > +	.scan_type =3D {						\
> > > +		.sign =3D 'u',					\
> > > +		.realbits =3D _res,				\
> > > +		.storagebits =3D 16,				\
> > > +		.endianness =3D IIO_LE,				\
> > > +	},							\
> > >  }
> > > =20
> > >  static const struct iio_chan_spec rockchip_saradc_iio_channels[] =3D=
 {
> > > -	ADC_CHANNEL(0, "adc0"),
> > > -	ADC_CHANNEL(1, "adc1"),
> > > -	ADC_CHANNEL(2, "adc2"),
> > > +	ADC_CHANNEL(0, "adc0", 10),
> > > +	ADC_CHANNEL(1, "adc1", 10),
> > > +	ADC_CHANNEL(2, "adc2", 10),
> > >  };
> > > =20
> > >  static const struct rockchip_saradc_data saradc_data =3D {
> > > -	.num_bits =3D 10,
> > >  	.channels =3D rockchip_saradc_iio_channels,
> > >  	.num_channels =3D ARRAY_SIZE(rockchip_saradc_iio_channels),
> > >  	.clk_rate =3D 1000000,
> > >  };
> > > =20
> > >  static const struct iio_chan_spec rockchip_rk3066_tsadc_iio_channels=
[] =3D {
> > > -	ADC_CHANNEL(0, "adc0"),
> > > -	ADC_CHANNEL(1, "adc1"),
> > > +	ADC_CHANNEL(0, "adc0", 12),
> > > +	ADC_CHANNEL(1, "adc1", 12),
> > >  };
> > > =20
> > >  static const struct rockchip_saradc_data rk3066_tsadc_data =3D {
> > > -	.num_bits =3D 12,
> > >  	.channels =3D rockchip_rk3066_tsadc_iio_channels,
> > >  	.num_channels =3D ARRAY_SIZE(rockchip_rk3066_tsadc_iio_channels),
> > >  	.clk_rate =3D 50000,
> > >  };
> > > =20
> > >  static const struct iio_chan_spec rockchip_rk3399_saradc_iio_channel=
s[] =3D {
> > > -	ADC_CHANNEL(0, "adc0"),
> > > -	ADC_CHANNEL(1, "adc1"),
> > > -	ADC_CHANNEL(2, "adc2"),
> > > -	ADC_CHANNEL(3, "adc3"),
> > > -	ADC_CHANNEL(4, "adc4"),
> > > -	ADC_CHANNEL(5, "adc5"),
> > > +	ADC_CHANNEL(0, "adc0", 10),
> > > +	ADC_CHANNEL(1, "adc1", 10),
> > > +	ADC_CHANNEL(2, "adc2", 10),
> > > +	ADC_CHANNEL(3, "adc3", 10),
> > > +	ADC_CHANNEL(4, "adc4", 10),
> > > +	ADC_CHANNEL(5, "adc5", 10),
> > >  };
> > > =20
> > >  static const struct rockchip_saradc_data rk3399_saradc_data =3D {
> > > -	.num_bits =3D 10,
> > >  	.channels =3D rockchip_rk3399_saradc_iio_channels,
> > >  	.num_channels =3D ARRAY_SIZE(rockchip_rk3399_saradc_iio_channels),
> > >  	.clk_rate =3D 1000000,
> > > @@ -193,6 +220,42 @@ static void rockchip_saradc_reset_controller(str=
uct reset_control *reset)
> > >  	reset_control_deassert(reset);
> > >  }
> > > =20
> > > +static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf =3D p;
> > > +	struct iio_dev *i_dev =3D pf->indio_dev;
> > > +	struct rockchip_saradc *info =3D iio_priv(i_dev);
> > > +	struct {
> > > +		u16 values[SARADC_BUFFER_NUM_U16];
> > > +		int64_t timestamp;
> > > +	} data;
> > > +	int ret;
> > > +	int i, j =3D 0;
> > > +
> > > +	mutex_lock(&i_dev->mlock);
> > > +
> > > +	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
> > > +		const struct iio_chan_spec *chan =3D &i_dev->channels[i];
> > > +
> > > +		ret =3D rockchip_saradc_conversion(info, chan);
> > > +		if (ret) {
> > > +			rockchip_saradc_power_down(info);
> > > +			goto out;
> > > +		}
> > > +
> > > +		data.values[j] =3D info->last_val;
> > > +		j++;
> > > +	}
> > > +
> > > +	iio_push_to_buffers_with_timestamp(i_dev, &data, iio_get_time_ns(i_=
dev));
> > > +out:
> > > +	mutex_unlock(&i_dev->mlock);
> > > +
> > > +	iio_trigger_notify_done(i_dev->trig);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > >  static int rockchip_saradc_probe(struct platform_device *pdev)
> > >  {
> > >  	struct rockchip_saradc *info =3D NULL;
> > > @@ -221,6 +284,11 @@ static int rockchip_saradc_probe(struct platform=
_device *pdev)
> > > =20
> > >  	info->data =3D match->data;
> > > =20
> > > +	if (info->data->num_channels > SARADC_MAX_CHANNELS) {
> > > +		dev_err(&pdev->dev, "max channels exceeded");
> > > +		return -EINVAL; =20
> >=20
> > How can that happen?  Bug in the addition of a new device type?
> > If it's just paranoia against future code, perhaps add a comment to
> > say that. =20
>=20
> yep that is "paranoia" for the case someone adds a fancy new 20 channel
> saradc variant and forgets to adapt the constant.
>=20
> I'll add a comment.
>=20
> >  =20
> > > +	}
> > > +
> > >  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	info->regs =3D devm_ioremap_resource(&pdev->dev, mem);
> > >  	if (IS_ERR(info->regs))
> > > @@ -315,6 +383,12 @@ static int rockchip_saradc_probe(struct platform=
_device *pdev)
> > >  	indio_dev->channels =3D info->data->channels;
> > >  	indio_dev->num_channels =3D info->data->num_channels;
> > > =20
> > > +	ret =3D devm_iio_triggered_buffer_setup(&indio_dev->dev, indio_dev,=
 NULL,
> > > +					      rockchip_saradc_trigger_handler,
> > > +					      NULL);
> > > +	if (ret)
> > > +		goto err_clk;
> > > + =20
> >=20
> > Please avoid mixing an matching between device managed an unmanaged int=
erfaces.
> > It means the driver is not 'obviously correct' and hence harder to revi=
ew.
> >=20
> > Two choices here.  Either use devm_add_action_or_reset to automatically
> > disable each clock + regulator in the managed release path, drop all th=
e error
> > handling and remove (note this should be a precursor patch), or use
> > iio_triggered_buffer_setup and manually call iio_triggered_buffer_clean=
up
> > in the right place in the remove function. =20
>=20
> I'll go with the devm_* approach, less complexity is better than adding m=
ore ;-)
>=20
>=20
> Heiko
>=20
> > >  	ret =3D iio_device_register(indio_dev);
> > >  	if (ret)
> > >  		goto err_clk; =20
> >=20
> >  =20
>=20
>=20
>=20
>=20

