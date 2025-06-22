Return-Path: <linux-iio+bounces-20856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381CEAE302D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7176D3B31A4
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395BF1E1A3F;
	Sun, 22 Jun 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAabTcoh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C741DE3D9;
	Sun, 22 Jun 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750599768; cv=none; b=KjXrCJUY9v0HoL5Y4GfETO6c/7ptP/o8YkHQQoRj6ikLnA7YVD7KmVlxKBMUtTetXcSUItl8jXtkKws0lfsPJt1GnxZykFDM9OHW0CT25uWx5akwi/4yHHQQHTDOL8j6+NlWzNP6woPPIO94PCb8OiDGmND3asWzJgwirDUcERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750599768; c=relaxed/simple;
	bh=Tv9mUPVVn7wQLIbUJ6oRa4Si03XNjcQob/mp6dyG+Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrtM4+yS8E/e1jLoqIgtsCoZrx+RhCAUbs2weSXsd0AZoujuXJ846QRtEMcvhOwDPQj+I/UdTpXXwUR4rTRVngB2PVWa5cPN0Jg8FU5fqszBFZFMHE9JDPpJpRqsq13iORWT7X8PVBebpaw1GguH5IbmOFDQ29UqplH7ntrEjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAabTcoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9508BC4CEE3;
	Sun, 22 Jun 2025 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750599767;
	bh=Tv9mUPVVn7wQLIbUJ6oRa4Si03XNjcQob/mp6dyG+Ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XAabTcoh1vT1auSju+Pvv9KuHnnwaONSYzlckp5tnYftYZWUc3gOVZ6kg3vTu5t41
	 jRP53C+9A+mz9B6V64IsPVxDkZ2tEj4D99VmiU6bLPPGKmrpleLGVaXWd6IJz7cUuY
	 +/REKvMW0WFWg07AVzCT29VnoTQFVeVoaq0yDSzm+v/5eJ5rFeg/+dF2eTGDTuef6p
	 P/X4jIAnyxDiaDtbL4eF4kn6Ap0obN4qMrw7jwqh7t8I+er+EclyW/2l95FJXWMtb/
	 O+i7EdZzFzAFsnC8ZtMwdMwlRRjdF68zZlHuj99wthAQUsVjdPKqMpdqXCsf14/8tX
	 cl7CKj5Cw8WLQ==
Date: Sun, 22 Jun 2025 14:42:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v3 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <20250622144240.02845c0a@jic23-huawei>
In-Reply-To: <20250616-bmi270-events-v3-3-16e37588604f@gmail.com>
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
	<20250616-bmi270-events-v3-3-16e37588604f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 20:53:11 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Any-motion event can be enabled on a per-axis basis and triggers a
> combined event when motion is detected on any axis.
> 
> No-motion event is triggered if the rate of change on all axes falls
> below a specified threshold for a configurable duration. A fake channel
> is used to report this event.
> 
> Threshold and duration can be configured from userspace.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Hi Gustavo,

Main question in here is about the scaling of the motion threshold.
It seems to be based on units of g.  We use m/s^2 for IIO acceleration channels
and also the expectation is that threshold events match scaling of the main channels
(_scale applies to them).  Hence here we will need to do something a little
fiddly to maintain the threshold scale if the main channel scaling changes.

I'd missed this on earlier reviews but came to see that we have rubbish documentation
on this aspect when looking at some other changes recently.

I need to find time to both fix up the ABI docs and write a lot more explanatory
text around events. Sadly neither is appropriate activity for a sleepy Sunday afternoon!

Jonathan


> @@ -114,6 +134,10 @@
>  #define BMI270_STEP_COUNTER_FACTOR			20
>  #define BMI270_STEP_COUNTER_MAX				20460
>  
> +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) ((val) * (scale) + \
> +						  ((val2) * (scale)) / MEGA)
> +#define BMI270_RAW_TO_MICRO(raw, scale) ((((raw) % (scale)) * MEGA) / scale)

I'm struggling a bit with what this is doing.  Perhaps a comment?




> @@ -827,6 +977,20 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static IIO_CONST_ATTR(in_accel_value_available, "[0.0 0.00049 1.0]");
This aligns with below.  Scaling definitely shouldn't be in g and is likely more
complex because of the relationship expected with the overall channels scaling
controls.

> @@ -848,21 +1016,58 @@ static int bmi270_read_event_config(struct iio_dev *indio_dev,
>  				    enum iio_event_direction dir)
>  {


> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		ret = bmi270_read_feature_reg(data, reg, &regval);
> +		if (ret)
> +			return ret;
> +
> +		raw = FIELD_GET(BMI270_FEAT_MOTION_THRESHOLD_MSK, regval);
> +		*val = raw / BMI270_MOTION_THRES_SCALE;
> +		*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_THRES_SCALE);

Why this particular scaling? Is effectively just dividing 1g / number of
values and hence providing a scaling to g?

Full scale is described as being 1G.
As this device is providing _RAW data for the relevant channels I'd
expect this to be scaled to match that. That will be a little fiddly here as
this is apparently always 0-1g whereas the scaling of the channel varies.
Thus irritatingly we'd need to adjust the scaling of this so it remains
consistent as the full scale changes.

The events ABI documentation is rather weak / wrong on this as it refers to
both _input_ and _raw_ thresholds whereas the true ABI just has one with
the scaling always being to match _raw if that is present. So _threshold * _scale
should be in the standards base units of m/s^2.


> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_EV_INFO_PERIOD:
> +		ret = bmi270_read_feature_reg(data, reg, &regval);
> +		if (ret)
> +			return ret;
> +
> +		raw = FIELD_GET(BMI270_FEAT_MOTION_DURATION_MSK, regval);
> +		*val = raw / BMI270_MOTION_DURAT_SCALE;
> +		*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_DURAT_SCALE);
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}


