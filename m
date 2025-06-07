Return-Path: <linux-iio+bounces-20298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12753AD0E5E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61515164716
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3D35957;
	Sat,  7 Jun 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiKeD4+c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCE202F8F;
	Sat,  7 Jun 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312165; cv=none; b=fmC6ZhtTckQKRiyFsX+fFref4cOweTeVeM4t5lc1VzFxl2CRFrPDCLMq6jRuLzD+G6IfA43K+4PDIDO7uV5WoFtRJb+YfBo94bw0x2Pgqh3VxFynR0xy6SjpzHer4ZyBW1L6UoKUOyu6CEaJFbdsbDSuXPRzvmddb1tYETDuuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312165; c=relaxed/simple;
	bh=OIs4yv+URHEOWO1meZP7I71WqUgcXFUai9rr8syXNkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhaSe4BDhkhyKjKrD/Yv04mkAcNfJ1vWoAHsCaszoVHbpCpDAJGFZM4z18K6CKvXTODa72NUba8gzI6/A/PxWR1u5n1yS3j6XQMlhaAWWpEkGNkWHtT0FXX0q4fHGRyzwWKgN4FKZ2Ko2GVlUmJYoOtGrx7b9HnJ3xNhdWLY45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiKeD4+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59A4C4CEE4;
	Sat,  7 Jun 2025 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749312165;
	bh=OIs4yv+URHEOWO1meZP7I71WqUgcXFUai9rr8syXNkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GiKeD4+c4JLCQSHu4mq91nPonMRk6gDQI0lhbjQwXtPnRdOZ88Fp5Oi0cGdw6bnAV
	 /gPSTgs3qqEmhbfAIiySate0ZQNIYX9dM11tbkmxwHTqPE7py6QpWMzcYu/W6jXh8v
	 nhPK89qyDkpQD6RTmEf7gup+CGP6v+M8RMOBpcW/KJ9yJPLgzVHTmJIujeMahTBiyn
	 lQsMgGh6TSsc5JkTdLe8jAWlTOBfhCi6jEDYBIbZq+0N17d/Pl6lEihKDcHMntJe+u
	 nRrE1i5H/LC16CGKIi+Hh60wtvnXhxa649g+UHGzMXAXgrYmseaW3t+FdbzkpMnuF3
	 AmJOSVbxCcfug==
Date: Sat, 7 Jun 2025 17:02:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <20250607170237.77601f20@jic23-huawei>
In-Reply-To: <20250605-bmi270-events-v2-3-8b2c07d0c213@gmail.com>
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
	<20250605-bmi270-events-v2-3-8b2c07d0c213@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Jun 2025 19:05:03 -0300
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

A few minor comments inline.  +CC Lothar given they have been doing a lot of
work with similar events recently and might have time to take a look at this
and see if I'm missing anything wrt to consistency with our recent discussions.

> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 318 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 309 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 0798eb1da3ecc3cecaf7d7d47214bb07f4ec294f..eb0cada50087ccecfd5624a531692873e396deb6 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c

...


> @@ -881,10 +1086,17 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
>  {
>  	struct bmi270_data *data = iio_priv(indio_dev);
>  	unsigned int raw;
> +	int reg;
>  
>  	guard(mutex)(&data->mutex);
>  
>  	switch (type) {
> +	case IIO_EV_TYPE_MAG_ADAPTIVE:
> +		reg = BMI270_ANYMO1_REG;
> +		break;
> +	case IIO_EV_TYPE_ROC:
> +		reg = BMI270_NOMO1_REG;
> +		break;
>  	case IIO_EV_TYPE_CHANGE:
>  		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))
>  			return -EINVAL;
> @@ -897,6 +1109,31 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (!in_range(val, 0, 1))
> +			return -EINVAL;
> +
> +		raw = BMI270_INT_MICRO_TO_RAW(val, val2,
> +					      BMI270_MOTION_THRES_SCALE);
> +		return bmi270_update_feature_reg(data, reg,
> +					 BMI270_FEAT_MOTION_THRESHOLD_MSK,
> +				FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK,
> +					raw));

This is some usual indenting.   Use a local variable for the value and
maybe the mask as well just to keep it readable.


> +	case IIO_EV_INFO_PERIOD:
> +		if (!in_range(val, 0, BMI270_MOTION_DURAT_MAX + 1))
> +			return -EINVAL;
> +
> +		raw = BMI270_INT_MICRO_TO_RAW(val, val2,
> +					BMI270_MOTION_DURAT_SCALE);
Align after (

> +		return bmi270_update_feature_reg(data, reg,
> +						BMI270_FEAT_MOTION_DURATION_MSK,
> +				FIELD_PREP(BMI270_FEAT_MOTION_DURATION_MSK,
> +					raw));
As above.

> +	default:
> +		return -EINVAL;
> +	}
>  }

>  
>  static const struct iio_event_spec bmi270_step_wtrmrk_event = {
> @@ -934,6 +1200,22 @@ static const struct iio_event_spec bmi270_step_wtrmrk_event = {
>  			       BIT(IIO_EV_INFO_VALUE),
>  };
>  
> +static const struct iio_event_spec bmi270_anymotion_event = {
> +	.type = IIO_EV_TYPE_MAG_ADAPTIVE,
> +	.dir = IIO_EV_DIR_RISING,
> +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +			       BIT(IIO_EV_INFO_PERIOD),
As below.
> +};
> +
> +static const struct iio_event_spec bmi270_nomotion_event = {
> +	.type = IIO_EV_TYPE_ROC,
> +	.dir = IIO_EV_DIR_RISING,
> +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +			       BIT(IIO_EV_INFO_PERIOD),
Could make that one line as I think it's 80 chars exactly.
I don't mind that much though.




