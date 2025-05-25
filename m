Return-Path: <linux-iio+bounces-19885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E37AC34CA
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0D9175A48
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB231F2C34;
	Sun, 25 May 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW/nSUKW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362A26AF3;
	Sun, 25 May 2025 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748178682; cv=none; b=q+W0KY/nk71uBC7b90N1775dq2fK8LiqyYNbFb3XlYqkLbZZoI2+EO24rj8FwgMfhkOrRQiqZ+GbWfZNhRaYUB8fHWHM9Gwd5G0XVNLV6aodRV1VXk7D+Pr3yEeyhSNHWJr5WVOIx56MUjaJH/kbPtu6E9ZOyAIBdpZOL8KTRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748178682; c=relaxed/simple;
	bh=6Mtb3b27NiBhNSscS2yTiu9ewI8biBsKNzBjI6Exyh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tk/puQFeE4idHAG+fDlhYdqBXjpHzEwId5GT2OTbFj1wH3yjyk/vpanRHbTuIejby/cMmxzj4f5MzLVMBi5Oi076/KTZ+RnrP0sTaxW//TbjURmPWLvELp6CiNbUeXxt3aylfqoa1ReiSUgiulrmQrW9qGJ8PXE4Bge62SjI0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW/nSUKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB66EC4CEEA;
	Sun, 25 May 2025 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748178681;
	bh=6Mtb3b27NiBhNSscS2yTiu9ewI8biBsKNzBjI6Exyh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hW/nSUKWQ3tk+SuAJ4BvGm651ra1yKO8BbRsYdHrjXCha6HjZKsa3VzbwLu2d8xOF
	 mOxhgGhfM7bD+NuVNVRcYa9hK5yW+4y6T6qk+eDadFTOCcPtHQyAHDcRM7WEMM/ER3
	 +45+fhjPtE+KLGW2975R/fxSp41Lz0ZdURwyXv4HFOKZNfrvVLsifaOlrmATlRn3X5
	 dmVrxFlrcE02hAKXq++wovjpYl8DtvcM0FRs84NndrB+foFp1w+DV6BmNVkx5HZRjy
	 In8cPRtb/IuXPLJ9U0BvgZIHR7xMx24oOFqM6E0+hjAUjMFG22zmKsslboBCXh9gzf
	 SNTBHHlDnoOSA==
Date: Sun, 25 May 2025 14:11:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/12] iio: accel: adxl313: add inactivity sensing
Message-ID: <20250525141112.35bee00a@jic23-huawei>
In-Reply-To: <20250523223523.35218-11-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:21 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Extend the interrupt handler to process interrupts as inactivity events.
> Add functions to set threshold and period registers for inactivity. Add
> functions to enable / disable inactivity. Extend the fake iio channel to
> deal with inactivity events on x, y and z combined with AND.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Hi Lothar,  Comments inline.
>  static const struct regmap_range adxl312_readable_reg_range[] = {
> @@ -254,6 +258,14 @@ static const struct iio_event_spec adxl313_fake_chan_events[] = {
>  		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>  		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
>  	},
> +	{
> +		/* inactivity */

Ah. I only noticed this here, but the axis for these two types of
detection should be different so awe shouldn't see them in a single
array of events.


> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_PERIOD),
> +	},
>  };

> @@ -550,16 +606,30 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
>  	if (type != IIO_EV_TYPE_MAG)
>  		return -EINVAL;
>  
> -	if (info != IIO_EV_INFO_VALUE)
> -		return -EINVAL;
> -
> -	/* Scale factor 15.625 mg/LSB */
> -	regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> -	switch (dir) {
> -	case IIO_EV_DIR_RISING:
> -		ret = regmap_write(data->regmap,
> -				   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
> -				   regval);
> +	switch (info) {

I got lost in earlier discussion you were having with Andy on this, but
personally, if a series is going to introduce a simple test then flip
it to a switch statement later, I'd rather see the switch statement from
the start and reduce the churn a little.

> +	case IIO_EV_INFO_VALUE:
> +		/* The scale factor is 15.625 mg/LSB */
> +		regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = regmap_write(data->regmap,
> +					   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
> +					   regval);
> +			if (ret)
> +				return ret;
> +			return adxl313_set_measure_en(data, true);
> +		case IIO_EV_DIR_FALLING:
> +			ret = regmap_write(data->regmap,
> +					   adxl313_act_thresh_reg[ADXL313_INACTIVITY],
> +					   regval);
> +			if (ret)
> +				return ret;
> +			return adxl313_set_measure_en(data, true);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_INFO_PERIOD:
> +		ret = adxl313_set_inact_time_s(data, val);
>  		if (ret)

