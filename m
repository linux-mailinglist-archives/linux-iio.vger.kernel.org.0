Return-Path: <linux-iio+bounces-15940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F313A40894
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B6A172758
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748720010B;
	Sat, 22 Feb 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1YEEbnS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1135956
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740229471; cv=none; b=EXuQ0SZCeFTXYxuArPMWnJYBfjy3//FO7oqGm9sxrvVIzzK9KVA19ZJ5l/vt33STXRf6IY4jK09xChiV/M/6CVF3RE/5LmltM/L0rG42kDBclrxXhXOOMhuw1yvhz48YgE9cT/dXRZLt97M7BKMbPEfy6HatLSwHtW/Y+SYn+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740229471; c=relaxed/simple;
	bh=FKO9wMPvozIQFF3Z3w4S53i1TPcDOMCq6le1+c92/YM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsaB5x0djR1TNamriXe5I1JlbiEtOPfeGdkT1UP7w9BY5d4Tx/UznPVdM8d8MgpXyFIRvCPzFL1k7yOVTA/nIvjRtLyW9NFF6NL36dKY5jZ9bi+f/lXmFpXaf+Rhj3aNMrT6JUl+ojltoc09vjyoxVDuTFcNkALV0z0tYjp6ISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1YEEbnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC08C4CED1;
	Sat, 22 Feb 2025 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740229470;
	bh=FKO9wMPvozIQFF3Z3w4S53i1TPcDOMCq6le1+c92/YM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T1YEEbnSwKoS/pE6qJ3M/c+zm4xWhuBZWQvUqz6qwy7GaDUP0W4+5/48F1HEo263f
	 OUOrtQ+RXMvl75/FzAatLnfpNPjhSDymBaZwSY29mGdwpNACFHu+Yicm7iMTtDcU5d
	 PTdb2j0TMjwxf3N63RgZMJ15kVafne0tuhAotyzZsRlsXEc+AVPHDaFjsDjRF7HnOz
	 r1T0+G8tkXDcrGpeKBS94pyFaJQ8bGZ0O8fURtQKbM1DSk8CHx2HjaD4HLAwyEammd
	 PQ2/uJWxWb0khd2Jt6FsgJJTYL55kg+py66GtHL57mh2DQqQCIa58h965OPerg8NsF
	 OYxRsO4WRrKNw==
Date: Sat, 22 Feb 2025 13:04:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Mike
 Looijmans <mike.looijmans@topic.nl>, Phil Reid <preid@electromag.com.au>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 23/29] iio: adc: max1027: Move claim of direct mode up
 one level and use guard()
Message-ID: <20250222130419.2f6dfd90@jic23-huawei>
In-Reply-To: <20250217141630.897334-24-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	<20250217141630.897334-24-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>  
> @@ -382,37 +374,33 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
>  	int ret = 0;
>  	struct max1027_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret
Naughty me. I clearly didn't build test between this patch and next one.

Fixed up to maintain bisectability.

> +
>  		ret = max1027_read_single_value(indio_dev, chan, val);
> -		break;
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_TEMP:
>  			*val = 1;
>  			*val2 = 8;
> -			ret = IIO_VAL_FRACTIONAL;
> -			break;
> +			return IIO_VAL_FRACTIONAL;
>  		case IIO_VOLTAGE:
>  			*val = 2500;
>  			*val2 = chan->scan_type.realbits;
> -			ret = IIO_VAL_FRACTIONAL_LOG2;
> -			break;
> +			return IIO_VAL_FRACTIONAL_LOG2;
>  		default:
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	default:
> -		ret = -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
> -
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
>  }
>  
>  static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,


