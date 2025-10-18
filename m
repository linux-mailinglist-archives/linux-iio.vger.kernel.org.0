Return-Path: <linux-iio+bounces-25240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A86BED480
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4CA19A082E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DF251791;
	Sat, 18 Oct 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0LLDqyx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23424293C;
	Sat, 18 Oct 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807799; cv=none; b=qsHxZhCNb9U8VA2pVlT7Zx6FWZO1we5PJUA0Js9/CfajhmUQbc7fm5YXpUFQT+BQZjc/8XzeeCDiMjT5itzWNHVt/BNVOO/c3/GbIQYfPc5HAwbtMsZjBJ/7JMh5qHso9kbanPNPVIYHBTgKDKL6QFV5CR7+dc4fwbxOhIEqJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807799; c=relaxed/simple;
	bh=VhSFwjpMORyOUTgLov6/+Fi/Da3vOEW3aHGRvlbY+fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXfRuqeXdXprEKxhrdtF6Uef5+bn0kV2pnu142eQVQVeS/jIDkFFn1KVOF+4Lxz1aukRl4MzxIMv//3QF8PrEHyhMhLo/O979+i8uX/9ZPSrDUoEvZ8edXO1SHQznBZD7fxQzn4bZNMDfyzfKKdw73fF+KUGnlDHsAMQEPfhKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0LLDqyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDB5C4CEF8;
	Sat, 18 Oct 2025 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760807798;
	bh=VhSFwjpMORyOUTgLov6/+Fi/Da3vOEW3aHGRvlbY+fg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e0LLDqyxtAwh/3HZWZ+LZx4IW6M1HkEbTw9Hi+XNtaaZCyhTu2asp+THQxlMo1Qd8
	 XRzgxM+GA+wj5enB/lFGRSxVDT4o/YmGZpHGmjVlDnZDMUQE8TlobMX+6pPmy/8lZU
	 GSMJo+0OK7ubXT8/5KtLUyXG7uqu/eocM12rqJXZNSNl9b38UdFjbvnnMZanwm6h6h
	 wsFBdambpUDVfPT7zY2CNTzW9H4o311KurLnnqw9AYFfRffl0+QG28UZVsuJD6vnB9
	 DlbFlaLPDiwSg9GNx6+KGRYJIXarRdJSRmLjPhZ2kszlOqeHno9glvroY0dXk/1Hyy
	 dqI8v+XO6xF3A==
Date: Sat, 18 Oct 2025 18:16:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jagath Jog J
 <jagathjog1996@gmail.com>
Subject: Re: [PATCH 3/6] iio: accel: bma220: add tap detection
Message-ID: <20251018181632.76851d4e@jic23-huawei>
In-Reply-To: <20251014-bma220_events-v1-3-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
	<20251014-bma220_events-v1-3-153424d7ea08@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 19:42:59 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add support for tap events.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> Please advise on where should I should be using the mutex guard()
> (single regmap reads vs single writes vs more complex read/write combo)

It usually depends not so much on what is being accessed directly under the lock
but more whether we need to prevent interruption of sequences that might
be running from other paths.  That or protecting a buffer that might be
hit from another path.

The regmap calls themselves are effectively atomic due to internal locking
so we shouldn't need to add to that if there are no issues with more complex
sequences that need protecting.

In general tap detection is one of my least favourite things to enable because
every device seems to have a different set of control parameters.
I've +CC Jagath who looked at this a lot a while back and defined much of
the existing ABI.


> ---
>  drivers/iio/accel/bma220_core.c | 296 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 295 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 871342d21456..c4bebf3e5548 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -21,6 +21,7 @@

> @@ -231,6 +254,13 @@ static const struct iio_trigger_ops bma220_trigger_ops = {
>  	.validate_device = &iio_trigger_validate_own_device,
>  };
>  
> +static int bma220_reset_int(struct bma220_data *data)
> +{
> +	return regmap_update_bits(data->regmap, BMA220_REG_IE1,
> +				  BMA220_INT_RST_MSK,
> +				  FIELD_PREP(BMA220_INT_RST_MSK, 1));

regmap_set_bits()

> +}

> +static int bma220_set_tap_en(struct bma220_data *data,
> +			     enum iio_modifier axis,
> +			     int type,
> +			     bool en)
> +{
> +	unsigned int flags = BMA220_TAP_TYPE_DOUBLE;
> +	int ret;
> +
> +	switch (axis) {
> +	case IIO_MOD_X:
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
> +					 BMA220_INT_EN_TAP_X_MSK,
> +					 FIELD_PREP(BMA220_INT_EN_TAP_X_MSK, en));

regmap_assign_bits() comes in handy when you are setting just one bit.

> +		break;
> +	case IIO_MOD_Y:
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
> +					 BMA220_INT_EN_TAP_Y_MSK,
> +					 FIELD_PREP(BMA220_INT_EN_TAP_Y_MSK, en));
> +		break;
> +	case IIO_MOD_Z:
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
> +					 BMA220_INT_EN_TAP_Z_MSK,
> +					 FIELD_PREP(BMA220_INT_EN_TAP_Z_MSK, en));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (ret)
> +		return ret;
> +
> +	/* tip_en must be 1 to select singletap detection */
> +	if (type == IIO_EV_DIR_SINGLETAP)
> +		flags = BMA220_TAP_TYPE_SINGLE;
> +
> +	ret = regmap_update_bits(data->regmap, BMA220_REG_CONF5,
> +				 BMA220_TIP_EN_MSK,
> +				 FIELD_PREP(BMA220_TIP_EN_MSK, flags));
> +	if (ret)
> +		return ret;
> +
> +	data->tap_type = flags;
> +
> +	return 0;
> +}

> +
> +static int bma220_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
> +			if (ret)
> +				return ret;
> +			*val = FIELD_GET(BMA220_TT_TH_MSK, reg_val);
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_PERIOD:
Period for a tap detector, particularly one that can do double tap is unusual.
Period is normally a case of how long a condition must be true before it causes
an interrupt.

I haven't figured out if this maps to one of the rather rich set of double tap
attributes in the ABI. See Documentation/ABI/testing/sysfs-bus-iio *doubletap*

Related stuff are
in_accel_gesture_doubletap_tap2_min_delay - I think that is tt_quiet in this case.
in_accel_gesture_doubletap_reset_timeout - I think this is at least approximately
tt_quiet + tt_dur.  It gives the time at which we give up on this being a potential
double tap. It's not quite right though as the actual reset is a bit after that.

+CC Jagath who defined most of the tap ABI and might be able to remember how this
all works better than me.

We may have a gap here that needs yet more ABI.


> +			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
> +			if (ret)
> +				return ret;
> +			*val = FIELD_GET(BMA220_TT_DUR_MSK, reg_val);

This needs to be in second if you are using duration. Is the register really in seconds?

> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}


>  
> @@ -506,13 +777,36 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
>  	struct bma220_data *data = iio_priv(indio_dev);
>  	int ret;
>  	unsigned int bma220_reg_if1;
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +
> +	guard(mutex)(&data->lock);
>  
>  	ret = regmap_read(data->regmap, BMA220_REG_IF1, &bma220_reg_if1);
>  	if (ret)
>  		return IRQ_NONE;
>  
> -	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1))
> +	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {

Is it an either / or case? I.e. we can only have buffered reads with
the data ready interrupt or events?   That does happen in some devices
but is fairly unusual.

>  		iio_trigger_poll_nested(data->trig);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if1)) {
> +
> +		if (data->tap_type == BMA220_TAP_TYPE_SINGLE)
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							  IIO_MOD_X_OR_Y_OR_Z,
> +							  IIO_EV_TYPE_GESTURE,
> +							  IIO_EV_DIR_SINGLETAP),
> +				       timestamp);
> +		else
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							  IIO_MOD_X_OR_Y_OR_Z,
> +							  IIO_EV_TYPE_GESTURE,
> +							  IIO_EV_DIR_DOUBLETAP),
> +				       timestamp);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> 


