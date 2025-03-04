Return-Path: <linux-iio+bounces-16340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487AA4DF72
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F41178838
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526752040BA;
	Tue,  4 Mar 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBCjxfOX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70426ACD;
	Tue,  4 Mar 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095645; cv=none; b=Vc17GWZWlEl210FioWwPBp09VMzt3pobaOWiaPJImS6B5T8SRe6QUvJZYYB5N7VKu1LxfJl9VaJavGJNorSst1er5V9JR5GSfg94mWwSA/Q41WqDShG2sfc6OIwAD/FPDJsMoC8MaPnM2PO+prv6uV0swrGjJ/p+52reWepBWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095645; c=relaxed/simple;
	bh=pVYyIl+Em1VOzg0o3IBtnAjWx3tLPRO85bYqrADD6zA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAVomNxQRew2co6qLV6A50sq4u0Ymu8Nn1aH4jFjEqZwvALEuHLD7JXYarE0VkK7/aaZnyhWc07uHwd6oSnZz8FQhuIrOss0KyBoXSpCCtOA7rrXmK0ryPXM2v94Gadvyx5BuoGCcxn8xnT2knmDlJiIwZiKg+a8ouk9Eby/8Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBCjxfOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E507C4CEE5;
	Tue,  4 Mar 2025 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095644;
	bh=pVYyIl+Em1VOzg0o3IBtnAjWx3tLPRO85bYqrADD6zA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBCjxfOX9sFkfFCkReuO76NXo1mEZV4M/qu4bTWUi20ZcJfVQJibbqqC1Rx6vk879
	 i4rmBvIZns4sQUX1RuXDWzzS0N7Gi+3u5/HO6sN5A9JlIBS8IJrinykKB1z26C0Tqu
	 aOFVejDDDdEX8z2pI1lM7mwPPtVlAzLjivG4y35bKHkRB/A7m74CObzHpObwDJy+OR
	 oSPkkCpSnranu7lwEvomjVasifIERkFJDPJK5kD/L4ySNd5k+D6Te9LFlq5I6uOZ9b
	 LxARyP5f579Ut6NUYXmJG1W4nffdoELv5huE2vm5bjPkwODQ7HkI9vtcD5Nr1RLbwt
	 1DrMJJ52vC1iw==
Date: Tue, 4 Mar 2025 13:40:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 11/15] iio: accel: adxl345: add g-range configuration
Message-ID: <20250304134033.656e4a6a@jic23-huawei>
In-Reply-To: <20250220104234.40958-12-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-12-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:30 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce means to configure and work with the available g-ranges
> keeping the precision of 13 digits.
> 
> This is in preparation for the activity/inactivity feature.

I'm not really following why adding range control is anything
much to do with that. Mostly we do this to improve accuracy for
low accelerations.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>


> @@ -483,12 +518,48 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
>  	return 0;
>  }
>  
> +static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
> +			      enum adxl345_range *range)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(adxl345_fullres_range_tbl); i++)
> +		if (val == adxl345_fullres_range_tbl[i][0] &&
> +		    val2 == adxl345_fullres_range_tbl[i][1])
> +			break;
Similar to case in earlier patch, maybe set *range and return in here
so that any finish of the loop is an error.
> +
> +	if (i == ARRAY_SIZE(adxl345_fullres_range_tbl))
> +		return -EINVAL;
> +
> +	*range = i;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> +				 ADXL345_DATA_FORMAT_RANGE,
> +				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
> +	if (ret)
> +		return ret;
> +

return regmap_update_bits() unless this gets more complex in later patch.

> +	return 0;
> +}
> +

> @@ -558,6 +634,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
> +	enum adxl345_range range;
>  	enum adxl345_odr odr;
>  	int ret;
>  
> @@ -581,6 +658,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		ret = adxl345_set_odr(st, odr);
>  		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = adxl345_find_range(st, val, val2,	&range);
> +		if (ret)
> +			return ret;
> +		ret = adxl345_set_range(st, range);
as in previous I'd have the 	
		if (ret)
			return ret;
here for consistency with the other one immediately above this.
> +		break;
>  	default:
>  		return -EINVAL;
>  	}


