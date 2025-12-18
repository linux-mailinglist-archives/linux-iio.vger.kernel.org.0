Return-Path: <linux-iio+bounces-27179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 186E0CCC4A8
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 15:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F603017640
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE092EC0A7;
	Thu, 18 Dec 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al/4MAjv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3902EBBB2
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766068348; cv=none; b=Yf3oPHn01TbjfWsQCPpHlK8xFCqelL0ga0wp97XOLEBAbiNiblHWhMz3byXiwygG8r/WLahClvXJZxnHHSmP0KFUsHMgzc7fe2nd2p2q8aBqzHoL1eMQixUGyntAm92Ah3x0842l+zvgVvpw+H+UXBmHBHEDv4P2AV4RrbbO2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766068348; c=relaxed/simple;
	bh=Cb/71YS+zrQfEMvosFYVR7Y9Zej5gzKcHCRwliPZjuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDRAAceAXfs4LMPppbJbqqUP9532BOV9pymPZdYh+5AHDR9xOjhP4a+QIa+gZA65bIo5ZymiGv9IJetaIwkoh0psQzxJUjLGnciCml/rkP+iXL0ayUwtSYtdOmANLXnxEjZY9leMCn8S2lsx241DKlLaXaYFV6Q54SMLk9Hj4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al/4MAjv; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11b6bc976d6so2683979c88.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766068346; x=1766673146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvDcrFjKqx1o4PXZRW4U7Cuz0Pc+gSxTVB1ooliuvtg=;
        b=al/4MAjveUIhL2wYsck5LhNV6y0qnvl8NsDorImq4rt5+49oMZRv4We2HG46PzMLnR
         UyI60f5QMtx02kwKJXUOefhr4HjNJyfUQ4fE51J5Gdy/Icw05scukP4hNrjqOwuhZbj0
         qUxU8rvYwGg7q0tP3+WimdHTSVzHMKF1a3I0ZJw0GuXijwzplT/5UeHlba5/n0DOqEI3
         n3N9m2gb76fYe5OHUYtBO6dCnJRXZl1zM+KeRTwwpHJuZvlBPWGoNkCAyAAEN6cgWx04
         RCqFd8K3CbgJSSXtIkM3wqHxv1ANuqaOPcR91WFEv8FfhCMT3VsI2vodJ94WwYBOAUEs
         vShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766068346; x=1766673146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvDcrFjKqx1o4PXZRW4U7Cuz0Pc+gSxTVB1ooliuvtg=;
        b=qwta50MR/vd5eVfKilAqtfiOhsxzia5Gs0Ka5iwpI4WMu4xdgECQaL4umQFJ2obN5S
         2Pmzl9ZSDFps/rje/EhfDqeqVaqYH3NBk0yhk0CZVd2wGBGW75n+bfQCoBNyc4jA4Lvj
         rXERMj2FB1Odl4dP18mv0NZ+yCCGBqH3svl2W/XGvH+RtsTnjXDqP9S5HXSBjkaUv+H8
         9cTh73p1t8FmG782jWL1x7EM9ndOhaExJW5vV5lllHCuLmouKL0nMBUcAhYBblwApxny
         dowAqzCm2iR1c4DSlamR9ZYtVXBlaIHCF1f2Embl3PGUKw3lc97U9McuRbideBUSBLUT
         9MNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9hneTsP1Bn3KVS7eAqK2bJb0pV94lnronZN5YjISn9DxgRfOHbdMSvPCb36kDSkjRxLtPY6XyLaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ab6JNbsDlevLVE65asPEAbNucyeBKK73Zdst6Q4jQXraNXTU
	4opPBqM9BpA/I2FnQwY5DXwnp/kg7GRg1jeo1fT7MjdALd9x04rHfyw6
X-Gm-Gg: AY/fxX7pJkiDmPaj/LbRJjVT6ds/heVsclihqccLppWmbDXusLvsrsEsgWgEmELvygK
	q7OjtLlXkg69LtyhJg3IzcRlRxfw7HCWJgGAq/pC/+GbNj2rOOLqyPOGLHNcSZFlt2n+Es0p/yU
	/9PGbKBaKAdx3yUORQkTGNG8/vzmIxTdeYe1t+3nh6268ajeYSEyxcar0ngtKkFaDWVAuzyKfs1
	DE/wcZUXVTE3Vbkf//CNL32jWAYCfime3/KMcdMHXypZI7AJyXQFPiA6nNluje46FMDv9uwelzI
	PqyKmePvACGx0UMVs6qH8CO3MDCQdWuggoa6cwuGwTbW7n7ZrOUn7rEQYGJFCBI66Tw1Nnszng2
	pGTW58U+BRvLgrE94Nza1Ay8rsjVivEmm0Fhjqmr3tCPOX8mN5oBwG3Y2Bdszs0i7ailfnP8G6V
	JUCTfElHROPpQwyUkxyUM=
X-Google-Smtp-Source: AGHT+IEGiOxHUxgqdOuBq8/4oIw+szluf8LA+aSM9huLM9xPzII7hyKBR3G2CZLyEFFsfc2z9Pli5g==
X-Received: by 2002:a05:7022:4091:b0:119:e569:f850 with SMTP id a92af1059eb24-12061939389mr2133231c88.7.1766068345623;
        Thu, 18 Dec 2025 06:32:25 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061fc5613sm7890150c88.11.2025.12.18.06.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:32:24 -0800 (PST)
Date: Thu, 18 Dec 2025 11:34:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/5] staging: iio: ad9832: convert to guard(mutex)
Message-ID: <aUQQ3YnaZau2RO2d@debian-BULLSEYE-live-builder-AMD64>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
 <20251215190806.11003-3-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215190806.11003-3-tomasborquez13@gmail.com>

On 12/15, Tomas Borquez wrote:
> Use guard(mutex) for cleaner lock handling and simpler error paths.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 28 +++++++++++---------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 00813dab7c..f9ef3aede4 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -9,6 +9,7 @@
>  
...
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD9832_FREQ0HM:
>  	case AD9832_FREQ1HM:
> @@ -203,22 +205,18 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
>  	case AD9832_FREQ_SYM:
> -		if (val == 1 || val == 0) {
> -			st->ctrl_fp &= ~AD9832_FREQ;
> -			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
> -		} else {
> -			ret = -EINVAL;
> -			break;
> -		}
> +		if (val != 1 && val != 0)
> +			return -EINVAL;
> +
> +		st->ctrl_fp &= ~AD9832_FREQ;
> +		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
>  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  						  st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
Since we now have the mutex unlock handled by guard, why not returning directly
from each case?
E.g.
	case AD9832_FREQ1HM:
-		ret = ad9832_write_frequency(st, this_attr->address, val);
-		break;
+		return ad9832_write_frequency(st, this_attr->address, val);
I think the last return (outside the default clause) won't be needed anymore.


And, since you are touching the lock, you may also update to use
devm_mutex_init() (that would probably be best appreciated as a separate patch).

>  	case AD9832_PHASE_SYM:
> -		if (val > 3) {
> -			ret = -EINVAL;
> -			break;
> -		}
> +		if (val > 3)
> +			return -EINVAL;

