Return-Path: <linux-iio+bounces-26910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D52CAB8FC
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 19:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C1030189AA
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1702E4266;
	Sun,  7 Dec 2025 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKa1uriU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3E8F4A;
	Sun,  7 Dec 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765131875; cv=none; b=HpwMnn8JZPHN5tUBuMZlXH+xubTxPc4QM0n9Ep1nJHBpugWCl3HEE1OSlMailUjlOi7AJyTPLGYBGoDBcTVxUMKr71XnKSkCO0NaK7+M+cmR+SvB0bovVprfCnT7ea/eMvIsYJCC1yKh5joHlb2ouzIXp0Na9aOcvUoRTv6VaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765131875; c=relaxed/simple;
	bh=F5b9CSFIVL7dkvtH38DlsENOwFOCMpKZ+Bnc43sUjL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBJjOfPbSr5BSmGont+2+R2DDr6N8nDMIm0h1DljbKWlTy6d8DBqRnGqjh+20HSMN/o3zAEJAWOAYlNgka9FjFIs6ZGGVpLWTFMAHvBUTWhqAl99C5f+VLYzkGFoapGBmrWtUmUTjsJQKFJS8IK1/y8PqXzsE0qDViRUWMZK/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKa1uriU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA958C4CEFB;
	Sun,  7 Dec 2025 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765131874;
	bh=F5b9CSFIVL7dkvtH38DlsENOwFOCMpKZ+Bnc43sUjL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NKa1uriUaz6yXULpOz0+3rKGfrW5c/++1vuhelVInfif4X70kVC4uRhmoz8cZwMi6
	 lPmusMkhlIK0XXW5HgTILX1EQDSvfTIy6oZmx9WLCyV42QYo7zjwhIQgvUGRd2v1Dn
	 qjXuiP0kcU0Ox04/01p34diVnQQrv1lO8M4nomKehPU9XirGVFwoIG7B9pvpd70mZR
	 6sFknSkVK8IXp9VCESA3Lm+t9kcwwZaXA47IhVaXOz20g/ZTl37HV+kPtdSm06Ir8t
	 hFL66pnr4vjvj2WCIAtSkefgt2n4B3f1QhCkUTr4B1eLjVWPPXgMlAVp6oMHfS+kbe
	 vvB20Pne8Tauw==
Date: Sun, 7 Dec 2025 18:24:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt@analog.com>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v4 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <20251207182423.54e4b33d@jic23-huawei>
In-Reply-To: <c3b79acfd171b3625b0e6ed8af4c95cc8409af18.1764101647.git.Jonathan.Santos@analog.com>
References: <cover.1764101647.git.Jonathan.Santos@analog.com>
	<c3b79acfd171b3625b0e6ed8af4c95cc8409af18.1764101647.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 18:56:35 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> provide a VCM regulator interface.
> 
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. PGA is controlled by GPIOs provided in
> the device tree.
> 
> The AAF gain is defined by hardware connections and should be specified
> in the device tree.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v4 Changes:
> * replaced shift_right() with '>>' operator in the ad7768_fill_scale_tbl()
>   function.
> * Refactored ad7768_parse_aaf_gain () as requested.
> * renamed ad7768_register_regulators() to ad7768_register_vcm_regulator()
>   to better reflect its purpose (not sure if this is ok to do).
> * Replaced u64_fract with u32_fract -> after reviewing the numbers again, I
>   realized that u32_fract is sufficient for these calculations.
> * addressed minor suggestions.
> * Adopted a new approach to manage the PGA GPIOs, using pga-gpios property.
>   This avoids possible conflicts when the internal gpio controller is used
>   externally (and also allows hardwiring, as soon as the gpio interface 
>   supports it). However, using GPIOs from the device's own controller causes
>   a deadlock when claiming direct mode in the ad7768_gpio_get() function.
>   This happens because the direct mode remains locked by the ad7768_write_raw()
>   function. I have kept this approach for now to discuss a way around this
>   problem. It would be good to have the flexibility provided by pga-gpios 
>   property.

See below. I 'think' this is easy enough to resolve by relaxing the need
to claim direct mode for scale changes - if it were an external gpio that
should be safe anyway and if it is internal, then the inner direct mode
claim should do the job.

Other than that, to me this code looks nice and clean so hopefully we can
merge it once that fix is in place.

Thanks,

Jonathan




> @@ -464,6 +531,42 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
>  	return ret;
>  }

>  
> +/*
> + * FIXME: Using GPIOs from the device's own controller causes the device
> + * to get stuck when claiming direct mode in the ad7768_gpio_get() function.
> + * This happens because the direct mode remains locked by the
> + * ad7768_write_raw() function.

Ouch. I'm not spotting why we need to claim direct mode for this particular
use of write_raw().  Seems safe enough to modify the gain whilst in buffered
mode.  Bit confusing perhaps if a user does this, but not a functional problem.
Sometimes we over protect in that path because userspace rarely uses write_raw
with the buffer mode enabled as it doesn't work on many devices.

So I'd squash the __ad7768_write_raw() back into ad7768_write_raw()
and claim and release direct mode only in the switch legs that need it
(oversampling and sampling frequency probably).  That should resolve
the deadlock.


> + */
> +static int ad7768_setup_pga(struct device *dev, struct ad7768_state *st)
> +{
> +	st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->pga_gpios))
> +		return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +				     "Failed to get PGA gpios.\n");
> +
> +	if (st->pga_gpios->ndescs != ADAQ7768_PGA_PINS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Expected %d GPIOs for PGA control.\n",
> +				     ADAQ7768_PGA_PINS);
> +	return 0;
> +}


