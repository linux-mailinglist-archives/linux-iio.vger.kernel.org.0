Return-Path: <linux-iio+bounces-18497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E36A96576
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637D316AF4A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAB420CCF5;
	Tue, 22 Apr 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0mVFHb+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28C20B801
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316513; cv=none; b=Plo7LUXWQVffxz2Lqxgc0EzrMdORyE+6bXZuN5SB+ocP4xGvzpk+BnuhQsaFaazrI+Xh7oSAfN6Z2Hfo7oJVupYR1wmejWCSDrcYC+0sbW3Or/Z7KOUUNAiYDBFzEIBb91fjRL1f5pQTkWjgAARFr9fvlRNPuplwP0MeFf9p5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316513; c=relaxed/simple;
	bh=anLjr1tReamUydhT8BOyd5WAfBLORHEW1TH2GPX2hgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ4jtXD4ScuUt32DT8Pax1TaV1tv0LStTNiLdulVluDjhccVEuVToRewFCF+5wOYsGU+6OI/+6BjQ3GAUhJUgbFDmk6RFI7OohSKkTV7Q72oiulyA0+Yk0mqpAJYcya8+mRF3q1ASn4AT7Y7f8g7ZF36PsqNsYSbwVdd4UiWZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0mVFHb+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so45554275e9.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745316509; x=1745921309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6B0Yh7dOpmfhINAPeCPvt7WU205S796TEUCdlISV0U=;
        b=B0mVFHb+/5jqS94/znqPq3C2MAjiHd4kCjrdRDFYQ+hzcQ/jLVJ7R3NeBIxywW11sh
         AFg02oOW8w1IKuxQAzVcyb/heCpjaIfwukJhsXnCPuiMqYYwYSrmvQUHDyX18FZNDRUc
         kkt99djSCAfQXwJwitodsg8ssGUo3uT33qLCWqwGmpEdwjOtPnBUUuGxDGFX3ya+xhVe
         vTPORT6FIRj2hyI3C4NOcXfgXsPLGPPYlzUoaipSShBBj3s90X9Q2OkIRXzN3MBdsLGN
         qFYOxtt53VmimipWlDhthAaOibzp+qm8ESw6p5cbAsbXyvin4iO/uAD2jDKpqWgrKqxt
         1NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316509; x=1745921309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6B0Yh7dOpmfhINAPeCPvt7WU205S796TEUCdlISV0U=;
        b=eBJwEbpQRI1pLPORNX0I7DCdUSFS0ZKLttacRJjl2AQeuYrymD5UK3wkYoZabbWkvZ
         DUtIFwTgTophGvWM8PnBV6MiO/BhTY0WO9z8Oj5Lv8YEVZKZgtUVG55thV17IR1soWtD
         iwsktFRL1EGqYLmoVdGUaTgElQghoDPMIMkKaSYcRlCemjIAXCyqEEuh8UEAYz2+jghg
         AOXckmHvroLFKoC0znlSfo131sqAR/D1KffesiW+bOoesm7AAXflUs05EaABmGKG6zyP
         M2XGDmnJObjidFveaYDTTAlbTvnBuoUE8aeoByW9B+UTVKPKWE5DjpylLIGqzlyBee2m
         MjEw==
X-Forwarded-Encrypted: i=1; AJvYcCW/xxxhwmnlCIuKVpBYEsblnt0kj/908UC7BwDF+PFBu1mjnF4ITfIsyL5fJV+KNtuRPkSNa/uSkco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3B/OerlugA9uI3FXZ8MlLW3ZXIs8rEC0PdH0NRzzLSzf+g3T
	/8PPwwNXn9VB0hS4LOcwB6hv4HbR29h1xwLwaf+IH63XkQ0MblepTGqNU/SePsc=
X-Gm-Gg: ASbGncsXGoJVKQy1igYgYVJWstbs9U0xoPs7JB1CaWXBaexXHpBu1n6f4QnJgJGUH8z
	oeVClaLgZEhVHPoO7PUSP6xyLOHszKXf0TRDVmvqDzJu1gO/rzIeQB4qc5u1SbLhi2R0FufRiVm
	U02qt1gIF2AoaBDABTguMNJXREA+hVwhy5p4/wqlktC0A3SI6ZEWrs0FQ40K100X6k0NbpgqMTQ
	HuKpzkRczGXXt0ApOGoenkpNreNV3+rovpxEtZTL2v5b/4UnQSf5n2lMj9Dk9zObfEbTok0Jw2O
	IMofgZ5/EywbChIG9hFYD6mAocaKMGEZDGmdWkhVbGIQpWWFbriD2OeQ
X-Google-Smtp-Source: AGHT+IHzVpPPPr7Q08HSTDXKukGfeX85sPIQ5U7vWA+NG5QegCS1HXNyMGxJ3cf6h3kIB4C5AubgEw==
X-Received: by 2002:a05:600c:c0f:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-4406ab93badmr129900855e9.12.1745316509263;
        Tue, 22 Apr 2025 03:08:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4406d5a9e50sm169732175e9.6.2025.04.22.03.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:08:28 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:08:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 3/3] staging: iio: ad9832: Add minor improvements to
 ad9832_write_powerdown
Message-ID: <e712ec88-d925-4a73-8df4-ca3387a903fd@stanley.mountain>
References: <20250420174725.887242-1-gshahrouzi@gmail.com>
 <20250420174725.887242-4-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420174725.887242-4-gshahrouzi@gmail.com>

On Sun, Apr 20, 2025 at 01:47:25PM -0400, Gabriel Shahrouzi wrote:
> Minimize size of type that needs to be used by replacing unsigned long
> with bool. Avoid redundancy by checking if cached power state is the
> same as the one requested.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index a8fc20379efed..2ab6026d56b5c 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -173,13 +173,19 @@ static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribut
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad9832_state *st = iio_priv(indio_dev);
>  	int ret;
> -	unsigned long val;
> +	bool val;
> +	bool cur;
>  
> -	ret = kstrtoul(buf, 10, &val);
> +	ret = kstrtobool(buf, &val);
>  	if (ret)
> -		goto error_ret;
> +		return ret;

Fold this whole thing into patch 2.  Don't write something and then fix
it in the next patch.

>  
>  	mutex_lock(&st->lock);
> +
> +	cur = !!(st->ctrl_src & AD9832_SLEEP);
> +	if (val == cur)
> +		goto unlock;
> +
>  	if (val)
>  		st->ctrl_src |= AD9832_SLEEP;
>  	else
> @@ -189,10 +195,10 @@ static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribut
>  	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
>  				st->ctrl_src);
>  	ret = spi_sync(st->spi, &st->msg);
> -	mutex_unlock(&st->lock);
>  
> -error_ret:
> -	return ret ? ret : len;
> +unlock:
> +	mutex_unlock(&st->lock);
> +	return len;

This should still be:

	return ret ? ret : len;

regards,
dan carpenter


