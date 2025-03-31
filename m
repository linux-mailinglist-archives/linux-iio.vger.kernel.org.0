Return-Path: <linux-iio+bounces-17418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EA8A7648C
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBB93A64EC
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5E1DF977;
	Mon, 31 Mar 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxcum8VA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480462AE8D;
	Mon, 31 Mar 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418331; cv=none; b=aD0Sv+RVTZ4berLwl970B0UPjcHrrz+w7RjLXiFX7aP/HQ/2ghjwnaNBDq1hNVqnBv7P2mV1+eeidPaX85wLkrO3qnJyxi2ovW4lFavbvfCa8dF6xyRsklP60nONdoPo26kiWaJ3X8XiplG+xrbVWdw+9qFFQz0fx5zdhqDpiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418331; c=relaxed/simple;
	bh=ybGEwyvbDY+OFGgpRswWwTvumhQ8Sdx9Rxl7GJAJoM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POUzF0exHS3f5bm11bJd61PHFTpzG6FzGXhvpb6Zu7XXNvpy3eWoLwcbrAePYZ3lQmazOKIHyGNVHDLHFEm58blX5RZvMplbnseNUDc3cDxA7zHqtLGDkN096FzlN/+YWsGJhzpLwc5g/+ZJ7Ty5SJ5Cr909HgdqLPbPzqqmdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxcum8VA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D55BC4CEE3;
	Mon, 31 Mar 2025 10:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743418330;
	bh=ybGEwyvbDY+OFGgpRswWwTvumhQ8Sdx9Rxl7GJAJoM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rxcum8VAXm2raNF0VdLu6koj9w6TmeXtDgiV7gPPfd/1AjpvK+UDqflM5Ex4VSaKg
	 PImTJrjo+v+18bi1UVJcUEfu9qE57Xor+26zXlF/R4GF+kur3soJJUFL3jVGpm+JSL
	 vkXbd8TNyU34IzRocFm+fRNqshVozGBnpF/PWUuzoF4BN55S/M+2FcuxH6cHAYg71a
	 mlHe/1jrWF6VXE0DFB+wDVimTTaBnxitwOuvCT5h4HVMdzpOAFYsbZ8rrUaFvF60n2
	 oOCJhaUi0CSdm6Fb/QFmUockPHJwFsT809otjPv4X/rpms0nOpDn4GBQSE7Fca5/wf
	 62ZTM2dXII3Nw==
Date: Mon, 31 Mar 2025 11:52:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 10/11] iio: accel: adxl345: add coupling detection
 for activity/inactivity
Message-ID: <20250331115203.578c69eb@jic23-huawei>
In-Reply-To: <20250318230843.76068-11-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 23:08:42 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add coupling activity/inactivity detection by the AC/DC bit. This is an
> addititional enhancement for the detection of activity states and
> completes the activity / inactivity feature of the ADXL345.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---

> @@ -300,6 +319,69 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  
>  /* act/inact */
>  
> +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> +				   enum adxl345_activity_type type, bool *ac)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (type == ADXL345_ACTIVITY)
> +		*ac = (FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval) > 0);
> +	else
> +		*ac = (FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval) > 0);

The > 0 doesn't add anything so I'd drop those.
Get used to non 0 integer == true for booleans takes some time but
is commonly assumed in kernel code (it is true in C in general but
some coding styles don't assume it!)

> +
> +	return 0;
> +}


>  static int adxl345_read_avail(struct iio_dev *indio_dev,
> @@ -919,6 +1050,8 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
>  	bool int_en;
> +	bool act_ac;
> +	bool inact_ac;
Could stick those 3 bools on one line without loosing readability I think.
Save a tiny bit of scrolling ;)
or push them down to context where they are used.


>  	int ret;
>  
>  	switch (type) {
> @@ -963,6 +1096,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return int_en;
> +	case IIO_EV_TYPE_MAG_REFERENCED:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = adxl345_is_act_inact_ac(st, ADXL345_ACTIVITY, &act_ac);
> +			if (ret)
> +				return ret;
> +			return act_ac;
> +		case IIO_EV_DIR_FALLING:
> +			ret = adxl345_is_act_inact_ac(st, ADXL345_INACTIVITY, &inact_ac);
> +			if (ret)
> +				return ret;
> +			return inact_ac;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -999,6 +1147,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
>  		}
>  	case IIO_EV_TYPE_MAG:
>  		return adxl345_set_ff_en(st, state);
> +	case IIO_EV_TYPE_MAG_REFERENCED:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return adxl345_set_act_inact_ac(st, ADXL345_ACTIVITY, state);
> +		case IIO_EV_DIR_FALLING:
> +			return adxl345_set_act_inact_ac(st, ADXL345_INACTIVITY, state);
> +		default:
> +			return -EINVAL;
> +		}
> +
>  	default:
>  		return -EINVAL;
>  	}


