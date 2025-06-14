Return-Path: <linux-iio+bounces-20652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E970AD9CFD
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1D77A492A
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430D2D8799;
	Sat, 14 Jun 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5MHX51h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B121ACED1;
	Sat, 14 Jun 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908537; cv=none; b=YWMTvDSkdD7IMydWUV4nSVIyPVv+HT0bfU7YSWdmQaPNlNziIBfGpEBfcFPuSI8IazhulOoHHbkLJaVoqtfbYpdCWsVMe7l5o8Q3cP5wrHL3A2lH/I/LjrDZxQwt/gMgn3tiyRI8LSBOUp0tfk8brWaRvlSHwKsaZ2/Ww4fuEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908537; c=relaxed/simple;
	bh=ECj08Ix358RPgPR1nJnTCBFkCnWnM9UmhgDu7Js3BK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+iKrgI4SNmZktSTJ3466VpqDXn7M53FxJ6267yD2/EZnEbwtM8PrSmgQaVNGyVaty94mWZCGGPV3fvlQUhy5IXeJzEHu7t+siEjaU/FX6EkLLK+TB85n3++2ZCvaHhEL7vxhtaZeDSUtOWQZ9fApvc8XjRsl7zjla/8kCudU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5MHX51h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ED9C4CEEB;
	Sat, 14 Jun 2025 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908537;
	bh=ECj08Ix358RPgPR1nJnTCBFkCnWnM9UmhgDu7Js3BK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d5MHX51hikuBWB80uq6WzgCCcCPYca9DvSECnf8TWBgluWnIs4tF0nAJYflQx+x5f
	 cbyTe1v6GnVTN/dFVva7uUrQ3boGWr2OmzYj2RtVw+7eweF8YwPBeph02adtjfR2xd
	 csiWtZA0pC+Ik/MEnh4lj3Is3Hf8vhzO0J2Wt72NQ2ITDM0l0mFYe2mUx+FARcfp1O
	 CAfQFI2NrOa1Klg3z76fJfFIhdkPR1TBPimkj/6Bsjt26azYZuDOj2q0R8tdIu3jxG
	 T1Vy41kDPO1gCqlToIdPZxdJ8xgcVbo33h54wvVRRe0THkNu9dbtm91G6ZE0zdAM7R
	 L4FdfLntIlRRg==
Date: Sat, 14 Jun 2025 14:42:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 01/11] iio: accel: adxl345: apply scale factor to tap
 threshold
Message-ID: <20250614144208.363c29cf@jic23-huawei>
In-Reply-To: <20250610215933.84795-2-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:23 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The threshold for tap detection was still not scaled. The datasheet sets
> a scale factor of 62.5mg/LSB. Remove commit about not scaled threshold
> for tap detection, and apply scaling to it.
> 

Given tap detection algorithms are not generally well defined and not a simple
threshold (generally) what scaling should we be aiming for here?
Even if it were a simple threshold, when a channel provides _raw the
expectation is that event config is vs _raw, not the base units.

So if this doesn't care about the current fullscale range (which the
comment implied was the case) it would need to rescale when the
IIO_INFO_SCALE changes.

That comment is I think indicating we decided to gloss over the
detail because it's going into a (potentially) non trivial algorithm anyway.

Jonathan


> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 7c093c0241de..d80efb68d113 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -697,17 +697,15 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
>  		switch (info) {
>  		case IIO_EV_INFO_VALUE:
>  			/*
> -			 * The scale factor would be 62.5mg/LSB (i.e. 0xFF = 16g) but
> -			 * not applied here. In context of this general purpose sensor,
> -			 * what imports is rather signal intensity than the absolute
> -			 * measured g value.
> +			 * Scale factor is 62.5mg/LSB i.e. 0xff = 16g
>  			 */
>  			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_TAP,
>  					  &tap_threshold);
>  			if (ret)
>  				return ret;
> -			*val = sign_extend32(tap_threshold, 7);
> -			return IIO_VAL_INT;
> +			*val = 62500 * sign_extend32(tap_threshold, 7);
> +			*val2 = MICRO;
> +			return IIO_VAL_FRACTIONAL;
>  		case IIO_EV_INFO_TIMEOUT:
>  			*val = st->tap_duration_us;
>  			*val2 = 1000000;
> @@ -746,6 +744,7 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
>  	case IIO_EV_TYPE_GESTURE:
>  		switch (info) {
>  		case IIO_EV_INFO_VALUE:
> +			val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
>  			ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP,
>  					   min(val, 0xFF));
>  			if (ret)


