Return-Path: <linux-iio+bounces-16238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED58A4B16E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1CB87A19A9
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CEC1E2007;
	Sun,  2 Mar 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKX+zFzF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC811CAA80;
	Sun,  2 Mar 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917689; cv=none; b=Dtiq7DFWgdQKjbVG/feQIrFTqFMjBCSMavoB+YDzqMkAw6XWQMjSn/8RDmJbzBi6tL4NDlBlyueIBqppLfEQxwI6R/7UWAxefy6MBdaIjKGs9AhoBzCm8rrSLn4gqTlQpmoV4FAqTzNO4+929kSDJZzDNnEZPKNS4WqT8M2M2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917689; c=relaxed/simple;
	bh=8+SMDoEPSEiEU9txDd71EQ/uKI5rnbmytRvECcrWBRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtAoJdg4reSHCKpXcZaVCbqLZM6VmBUe/BvONrM9dNax/EgZf0BeIl/KdxlfTXfStR/TDVPTTNbC3hVXcoexbyQgBFo9sGbQ3DbivZhjOpgqeviAMCjWAUBydrkt70Fa74t+ThLRbbSNC+cTZU+ia6SQDFuhZDlwJGSzcI0IOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKX+zFzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAA7C4CED6;
	Sun,  2 Mar 2025 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740917688;
	bh=8+SMDoEPSEiEU9txDd71EQ/uKI5rnbmytRvECcrWBRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SKX+zFzFhKj+BpjiTNE8zbt5HrSArf0jCwh0CbiWShnVPE5DJazUlwR5xF+G53BkF
	 ma/3xoO//flEnos6d37RWQU3lQrmuqVMQws0gk1XNr/0sAmxmBSLnq4LNLK2sOzMqK
	 FUYSkAvRoWdzkJx5fdp9S8FghRtsB7t3X1m04bQtUpc8aTmKMg1KeJaVQonZAaO2V6
	 MAxgpzemZvsgVbNgyqQsKYEQSkp9U+4rfDhdhsjta1BxR41PKVFyyfWJsoFE1o7yzR
	 lhFb1v0z5cQXZXWhbD22HCHeqP+pQ3UKP/Y9QmQ9HeSz+9G88y1IsOBuTpVkh9gYlV
	 BVZiOEi54itmg==
Date: Sun, 2 Mar 2025 12:14:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 06/15] iio: accel: adxl345: add single tap feature
Message-ID: <20250302121436.32f96b35@jic23-huawei>
In-Reply-To: <20250220104234.40958-7-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:25 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the single tap feature with a threshold in 62.5mg/LSB points and a
> scaled duration in us. Keep singletap threshold in regmap cache but
> the scaled value of duration in us as member variable.
> 
> Both use IIO channels for individual enable of the x/y/z axis. Initializes
> threshold and duration with reasonable content. When an interrupt is
> caught it will be pushed to the according IIO channel.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 364 ++++++++++++++++++++++++++++++-
>  1 file changed, 362 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 0cee81bc1877..d05593c0d513 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> @@ -17,6 +18,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/kfifo_buf.h>
>  
>  #include "adxl345.h"
> @@ -31,6 +33,33 @@
>  #define ADXL345_INT1			0
>  #define ADXL345_INT2			1
>  
> +#define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
This is a bit confusing.  Here we have a mask for axis that
has 3 bits.
> +
> +enum adxl345_axis {
> +	ADXL345_Z_EN = BIT(0),
> +	ADXL345_Y_EN = BIT(1),
> +	ADXL345_X_EN = BIT(2),
> +	/* Suppress double tap detection if value > tap threshold */
> +	ADXL345_TAP_SUPPRESS = BIT(3),
and here an enum that is closely related with 4.

> +};
...

>  enum adxl345_chans {
> @@ -83,6 +128,7 @@ bool adxl345_is_volatile_reg(struct device *dev, unsigned int reg)
>  	case ADXL345_REG_DATA_AXIS(3):
>  	case ADXL345_REG_DATA_AXIS(4):
>  	case ADXL345_REG_DATA_AXIS(5):
> +	case ADXL345_REG_ACT_TAP_STATUS:

ah.   I thought this had a full list from earlier patches.
Move this and any later additions back to patch 4.

>  	case ADXL345_REG_FIFO_STATUS:
>  	case ADXL345_REG_INT_SOURCE:
>  		return true;
> @@ -112,6 +158,117 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
>  }
>  
> +/* tap */
> +
> +static int adxl345_write_tap_axis(struct adxl345_state *st,
> +				  enum adxl345_axis axis, bool en)
> +{
> +	st->tap_axis_ctrl = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK,
> +				      en ? st->tap_axis_ctrl | axis
> +				      : st->tap_axis_ctrl & ~axis);
> +
> +	return regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
> +				  ADXL345_REG_TAP_AXIS_MSK,
> +				  FIELD_PREP(ADXL345_REG_TAP_AXIS_MSK,
> +					     st->tap_axis_ctrl));
Given that mask is bottom few bits anyway and you can just define the
tap axis as separate fields. 

See below, but I would push the IIO_MOD values down into here. Put the switch
per axis in at this level and then use a simple if statement to
call regmap_clear_bits() / regmap_set_bits() based on enable.

> +}

...

> +static int adxl345_is_tap_en(struct adxl345_state *st,
> +			     enum adxl345_tap_type type, bool *en)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*en = (adxl345_tap_int_reg[type] & regval) > 0;

Could use 0/1 return rather than passing a paramter for the output.
I don't mind much either way.


> +
> +	return 0;
> +}
> +
> +static int adxl345_set_singletap_en(struct adxl345_state *st,
I'd push the IIO modifier in here instead of axis. 
> +				    enum adxl345_axis axis, bool en)
> +{
> +	int ret;
> +
> +	ret = adxl345_write_tap_axis(st, axis, en);
And push it into here as well.

> +	if (ret)
> +		return ret;
> +
> +	return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
> +}
> +

...

> @@ -197,6 +354,160 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int adxl345_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	bool int_en;
> +	bool axis_en;
> +	int ret = -EFAULT;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +			axis_en = FIELD_GET(ADXL345_X_EN, st->tap_axis_ctrl);
> +			break;
> +		case IIO_MOD_Y:
> +			axis_en = FIELD_GET(ADXL345_Y_EN, st->tap_axis_ctrl);
> +			break;
> +		case IIO_MOD_Z:
> +			axis_en = FIELD_GET(ADXL345_Z_EN, st->tap_axis_ctrl);
> +			break;
> +		default:
> +			axis_en = ADXL345_TAP_SUPPRESS;
> +			break;
> +		}
I'd check axis_en here.
		if (!axis_en)
			return false;
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_SINGLETAP:
> +			ret = adxl345_is_tap_en(st, ADXL345_SINGLE_TAP, &int_en);
> +			if (ret)
> +				return ret;
> +			return int_en && axis_en;

Then this just becomes return int_en;

> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl345_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	enum adxl345_axis axis;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +			axis = ADXL345_X_EN;
> +			break;
> +		case IIO_MOD_Y:
> +			axis = ADXL345_Y_EN;
> +			break;
> +		case IIO_MOD_Z:
> +			axis = ADXL345_Z_EN;
> +			break;
> +		default:
> +			axis = ADXL345_TAP_SUPPRESS;

How are we getting another axis here?

> +			break;
> +		}
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_SINGLETAP:
> +			return adxl345_set_singletap_en(st, axis, state);

As above, pass chan->channel2 into here so we can simplify the eventual
setting of the the register values.

> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl345_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	unsigned int tap_threshold;
> +	int ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			/*
> +			 * The scale factor is 62.5mg/LSB (i.e. 0xFF = 16g) but
> +			 * not applied here.

Maybe say why.

> +			 */
> +			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_TAP, &tap_threshold);

Bit of a long line. Aim for sub 80 chars unless readability is greatly
hurt.

> +			if (ret)
> +				return ret;
> +			*val = sign_extend32(tap_threshold, 7);
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_TIMEOUT:
> +			*val = st->tap_duration_us;
> +			*val2 = 1000000;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
...


