Return-Path: <linux-iio+bounces-17415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117DCA76449
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756913A4919
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DE61DF974;
	Mon, 31 Mar 2025 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDyviKtn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1921DF244;
	Mon, 31 Mar 2025 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417188; cv=none; b=iULRLMEyMKpna4+k6757g/MMFH/4cL5VTNIJ6y3ulkIUbq1To7GFyBFu8ijAJHLXQwFDbT4/0DlLTOEBUnlGJqefU9vICnM4Vz4ZQFyKL/p7DsIt8+P/QaWlTjZWrGc+v5+G0Mu1p6Eg1dBdU9WZxaQ37C8ZTv0ZFUGfyGpulzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417188; c=relaxed/simple;
	bh=nxvcNJQRIxPnlvks/aAjXspWOqO56Apa++g9yiGvNiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfbDN4jugbxZOJ/XF5vRdA0KZ51DHl78RIkZmfMcpMf0OWiRJeENFC4o0iwALB8wE6wM6eFM3BpmsLcDAoXyiPFq2NCy5QgBmEeF9vf2+GpACdd3V6Rf7yt3CvU/+annTbTHVxDW5D8kNR6ujwLoOJEZRUroM6HAeHZZX4zY9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDyviKtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320BC4CEE5;
	Mon, 31 Mar 2025 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743417187;
	bh=nxvcNJQRIxPnlvks/aAjXspWOqO56Apa++g9yiGvNiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDyviKtnPUEibTBbLVNPamChV1rWb8LnvRuWA94N4bSMrQP70xKeP4YVwEPtYomkD
	 Ck2aU/cgeoCDwKelM9Kg7NkxawVUVfuU64xxn0UMRHFVQpKiIxSH/2NRnNWrOy8ERB
	 I3CQmTi1E6df5YZyNkNvzraAT0O8LhGo8qZE53tElYtI5KEuFPGomY2eLekPbiRIhD
	 S4fTy30XX/KZWlTBWRu5JJwsqlfaFx4NYD6nhTSAThQw57IBiwLq8yFaUgCSOkMd7Q
	 gTR/4whoahH/27yJBGw77SEjiCqP5FORC5WSxjULLfxDN0OKV5znXZf7ta/I55Ejcb
	 Zn5VjCUL8+1DQ==
Date: Mon, 31 Mar 2025 11:33:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 06/11] iio: accel: adxl345: extend sample frequency
 adjustments
Message-ID: <20250331113300.08379a5a@jic23-huawei>
In-Reply-To: <20250318230843.76068-7-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 23:08:38 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce enums and functions to work with the sample frequency
> adjustments. Let the sample frequency adjust via IIO and configure
> a reasonable default.
> 
> Replace the old static sample frequency handling. During adjustment of
> bw registers, measuring is disabled and afterwards enabled again.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
One minor thing inline.


>  	return -EINVAL;
> @@ -504,7 +581,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
> -	s64 n;
> +	enum adxl345_odr odr;
> +	int ret;
> +
> +	ret = adxl345_set_measure_en(st, false);

Why is this necessary but wasn't before?
If it should always have been done for existing calibbias etc,
perhaps a separate precursor patch is appropriate?


> +	if (ret)
> +		return ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> @@ -512,20 +594,26 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
>  		 * factor
>  		 */
> -		return regmap_write(st->regmap,
> -				    ADXL345_REG_OFS_AXIS(chan->address),
> -				    val / 4);
> +		ret = regmap_write(st->regmap,
> +				   ADXL345_REG_OFS_AXIS(chan->address),
> +				   val / 4);
> +		if (ret)
> +			return ret;
> +		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		n = div_s64(val * NANOHZ_PER_HZ + val2,
> -			    ADXL345_BASE_RATE_NANO_HZ);
> +		ret = adxl345_find_odr(st, val, val2, &odr);
> +		if (ret)
> +			return ret;
>  
> -		return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> -					  ADXL345_BW_RATE,
> -					  clamp_val(ilog2(n), 0,
> -						    ADXL345_BW_RATE));
> +		ret = adxl345_set_odr(st, odr);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> -	return -EINVAL;
> +	return adxl345_set_measure_en(st, true);
>  }

