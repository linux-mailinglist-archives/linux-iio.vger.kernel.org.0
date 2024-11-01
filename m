Return-Path: <linux-iio+bounces-11805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5739B9680
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 18:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEE51C2139B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6A1CB501;
	Fri,  1 Nov 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+TJYH4u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53671BD9DC;
	Fri,  1 Nov 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481937; cv=none; b=a5ALsnmu0dtbyky0Eo6wCz2m5yfe6jrM3JmhXZ0hImGAFbVqtcjKrrzueODWh2w3o24nDUunE2wi+oHEi6Iq91DwTqPCjIzwA05ukyudHA9L3R6Fa1I+tYrhhr/3qpE7QngD0tSdJkJIKlTDZ/EJRrQw1OqLNJXUDV1BYSpm0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481937; c=relaxed/simple;
	bh=F7Ly5eMnVAxBSYY9/PNU6hWxmW42sMb1TQOtApfPgqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRK7RqLnutQwsnV5EARn93QOaB+uWq916OaWbuCvC2LeR9Yas5AbochAfM+2vXjMOtFZXTdHB0jA6qRbmvrP0C+Qd3OEtZ9Z8lSet+E0vzSIACC0NojQJPJ4Lat8v+D1FA0Cp6Qj+KS7qtXQG1b2uVd0xZXE/SiMxgMT5qqV1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+TJYH4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F34C4CECD;
	Fri,  1 Nov 2024 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730481937;
	bh=F7Ly5eMnVAxBSYY9/PNU6hWxmW42sMb1TQOtApfPgqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+TJYH4uH1Ez0b5/uQT9A25EPp29fx0aNl9N2us9dQjPfkYvKvPTE3usfOzDM8fBw
	 iRfaNZZvEdHu6nESxoakkWNapBilLdS9DLpZUg86BDqgyqLn47PYtwd4LtBMFQzdNe
	 bb3FLnLX5p0EdApzskEzeQ9ZI4n1XwE46Y2w1CxTNpfAVFtjehc/oOq5pGGxULHG+z
	 pklnHukTezjrNDzgVSqiYJOjzl74Mnualvg//5fVzFaXemHCxAGHdBP/1nxwC/2jyM
	 UDIg+3UuRDhEvfc7Hx1XI0pps2P6quhUScpHjKXnAUTeaIea9hYrqSyvaSpBNqaIZ1
	 Y44ysJhOOlagg==
Date: Fri, 1 Nov 2024 17:25:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iio: adc: ad7380: add alert support
Message-ID: <20241101172529.7153dead@jic23-huawei>
In-Reply-To: <20241029-ad7380-add-alert-support-v1-1-d0359401b788@baylibre.com>
References: <20241029-ad7380-add-alert-support-v1-1-d0359401b788@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 16:02:46 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> The alert functionality is an out of range indicator and can be used as an
> early indicator of an out of bounds conversion result.
>=20
> ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common to all
> channels.
>=20
> When using 1 SDO line (only mode supported by the driver right now), i.e
> data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) is
> used as an alert pin. The alert pin is updated at the end of the
> conversion (set to low if an alert occurs) and is cleared on a falling
> edge of CS.
>=20
> The ALERT register contains information about the exact alert status:
> channel and direction. Unfortunately we can't read this register because
> in buffered read we cannot claim for direct mode.
>=20
> User can set high/low thresholds and enable event detection using the
> regular iio events:
>=20
>   events/in_thresh_falling_value
>   events/in_thresh_rising_value
>   events/thresh_either_en
>=20
> Because we cannot read ALERT register, we can't determine the exact
> channel that triggers the alert, neither the direction (hight/low
> threshold violation), so we send and IIO_EV_DIR_EITHER event for all
> channels. This is ok, because the primary use case for this chip is to
> hardwire the alert line to shutdown the device.
>=20
> When reading a channel raw data, we have to trigger 2 spi transactions: a
> first transaction that will trigger a conversion and a second
> transaction to read the conversion. By design a new conversion is
> initiated on each falling edge of CS. This will trigger a second
> interrupt. To avoid that we disable irq in the hard irq handler and
> re-enable them in thread handler.

IRQF_ONESHOT not enough?=20

>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> Hello,
>=20
> The ad738x family includes a built-in alert mechanism for early
> detection of out-of-bounds conversion results. This series introduces
> this functionality to the ad7380 family, with several open questions.
>=20
> About High/Low Threshold sysfs entries:
> The internal high/low threshold registers are 16 bits and thresholds must
> be computed on a 16 bits scale, regardless of the actual ADC resolution,
>  meaning SCALE and OFFSET attributes or realbits can't be used to compute
> the raw value.
>=20
> For example, with a 3.3V reference and a 16-bit scale, the calculation for
> a 1.3V high threshold is 1300/0.100708 =E2=89=88 13000 >> 4 =3D 812. User=
 has to
> write 812 in sysfs entry. This value is valid for all chips, regardless
> of the actual ADC resolution.
> Is it okay to have a raw threshold value that is not on the same scale
> as the channel raw value? What about when reading back the threshold
> values?

That's pretty unintuitive and ABI has always assumed equivalent scale.
Can we fiddle the scale so the driver is responsible
for rescaling form something that matches _raw scaling to what is needed
here?  There are drivers that do this because there threshold registers
are lower precision than the data ones.  I'm not sure we have a case
in a driver supporting multiple resolutions of ADC though.  Principle
is the same, just different maths to do.

>=20
> About event Handling:
> There is an alert register containing two status
> bits per ADC, one corresponding to the high limit, and the other to the
> low limit. A logical OR of alert signals for all ADCs creates a common
> alert value which drives out the alert pin.
> Unfortunately we cannot read the alert register to determine the exact
> channel and direction, because in buffered read, we cannot claim for
> direct mode. So:
> * we send an alert event on ALL channels

That's ugly but I can't think of much else you can do :(

> * we set the direction to IIO_EV_DIR_EITHER (xilinx-xadc is doing that)
> Does that work?
Yes. It's not unheard of to just have 'out of range' signals on ADCs.
Hence we have the either direction.

With hindsight maybe we should just have sent two events but that either
thing goes back a long way so userspace has to understand it and it
fits your usecase here.


>=20
> Moreover, the user can not reliably read alert register manually because
> when reading a channel, we have to do 2 transactions: 1 to trigger
> conversion and 1 to read data (this one  will also trigger a new
> conversion). When reading alert register, the register will not reflect t=
he
>  alert of the first conversion.
> Does it make sens to send generic event if user can't read register?

Sure.  Some devices don't have status registers at all so you just need
to know how the line is configured. =20

>=20
> Interrupt Handling:
> Should we consider enabling interrupt only once per buffered read? If
> thresholds are continuously exceeded a lot of interrupts are generated.

We do have a concept of *reset_timeout though so far that's always been
for accelerometer tap events. You could set up something similar for this
and reenable the interrupt only after X seconds.=20


>=20
> ADI engineers suggest the primary use of this alert pin is as a hardware
> shutdown signal for the ADC. Therefore, is it better to skip event
> handling and provide threshold configuration only? Would custom
> attributes be more appropriate than events in this case?

It it's shutdown signaling should we just push this to a DT binding?
Seems likely to vary by board design, but not by usecase.


Ignoring these questions here is a review of the code.


Thanks,

Jonathan

> =20
>  #define DEFINE_AD7380_2_CHANNEL(name, bits, diff, sign)	\
> @@ -481,6 +502,9 @@ struct ad7380_state {
>  	bool resolution_boost_enabled;
>  	unsigned int ch;
>  	bool seq;
> +	int high_th;
> +	int low_th;
u16?  Though there is a confusing shift so I'm not quite sure what it's sca=
le is!
> +	bool alert_en;
>  	unsigned int vref_mv;
>  	unsigned int vcm_mv[MAX_NUM_CHANNELS];
>  	/* xfers, message an buffer for reading sample data */
> @@ -948,12 +972,133 @@ static int ad7380_get_current_scan_type(const stru=
ct iio_dev *indio_dev,
>  					    : AD7380_SCAN_TYPE_NORMAL;
>  }
> =20
> +static int ad7380_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +
> +	return st->alert_en ? 1 : 0;
> +}
> +
> +static int ad7380_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     int state)
Obviously this will need updating to bool.=20
> +{
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		struct ad7380_state *st =3D iio_priv(indio_dev);
> +		int ret;
> +
> +		if (state =3D=3D st->alert_en)
> +			return 0;
> +
> +		/*
> +		 * According to the datasheet, high threshold must always be
> +		 * greater than low threshold
> +		 */
> +		if (state && st->high_th < st->low_th)
> +			return -EINVAL;
> +
> +		ret =3D regmap_update_bits(st->regmap,
> +					 AD7380_REG_ADDR_CONFIG1,
> +					 AD7380_CONFIG1_ALERTEN,
> +					 FIELD_PREP(AD7380_CONFIG1_ALERTEN, state));
> +
> +		if (ret)
> +			return ret;
> +
> +		st->alert_en =3D state;
> +
> +		return 0;
> +	}
> +	unreachable();
> +}
> +
> +static int ad7380_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		*val =3D st->high_th;
return IIO_VAL_INT here.
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		*val =3D st->low_th;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad7380_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {

If David's if guard stuff is in place before this gets merged, definitely=20
prefer that here (and probably everywhere else we have this call!)


> +		struct ad7380_state *st =3D iio_priv(indio_dev);
> +		int ret;
> +
> +		/*
> +		 * According to the datasheet,
> +		 * AD7380_REG_ADDR_ALERT_HIGH_TH[11:0] are the MSB of the 16-bit
> +		 * internal alert high register. LSB are set to 0x0.
> +		 * AD7380_REG_ADDR_ALERT_LOW_TH[11:0] are the MSB of the 16 bit
> +		 * internal alert low register. LSB are set to 0xf.
> +		 *
> +		 * When alert is enabled the conversion from the adc is compared
> +		 * immediately to the alert high/low thresholds, before any
> +		 * oversampling. This means that the thresholds are the same for
> +		 * normal mode and oversampling mode.
> +		 * For 12 and 14 bits, the thresholds are still on 16 bits.
> +		 */
> +		if (val < 0 || val > 2047)
> +			return -EINVAL;
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret =3D regmap_write(st->regmap,
> +					   AD7380_REG_ADDR_ALERT_HIGH_TH,
> +					   val);
> +			if (!ret)
			if (ret)
				return ret;

			st-high_th =3D ...
			return 0;

So keep the error path as the out of line one.

> +				st->high_th =3D val << 4 | 0xf;
read and write should be the same value.  Here it seem it will read back 16=
 * the written value
which leaves me confused.

> +			return ret;
> +		case IIO_EV_DIR_FALLING:
> +			ret =3D regmap_write(st->regmap,
> +					   AD7380_REG_ADDR_ALERT_LOW_TH,
> +					   val);
> +			if (!ret)
> +				st->low_th =3D val << 4;
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	unreachable();
> +}

> +
> +static irqreturn_t ad7380_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	s64 timestamp =3D iio_get_time_ns(indio_dev);
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan =3D &indio_dev->channels[0];
> +	int i =3D 0, j =3D 0;
No need to init i. can also init j in the for loop preamble.
however, i * 2 and i * 2 + 1 seem to have the same value so no
need for j.


> +
> +	for (i =3D 0; i < st->chip_info->num_channels - 1; i++) {
> +		iio_push_event(indio_dev,
> +			       chan->differential ?
> +			       IIO_DIFF_EVENT_CODE(IIO_VOLTAGE,
> +						   j,
> +						   j + 1,
> +						   IIO_EV_TYPE_THRESH,
> +						   IIO_EV_DIR_EITHER) :
> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +						    i,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       timestamp);
> +		j +=3D 2;
> +	}
> +
> +	enable_irq(irq);

As I ask above, I'm confused on why oneshot doesn't effectively do this
for you already.

> +
> +	return IRQ_HANDLED;
> +}

