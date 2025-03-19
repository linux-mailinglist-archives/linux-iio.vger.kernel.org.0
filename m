Return-Path: <linux-iio+bounces-17096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765DFA68E9F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4583BEB07
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BA316D32A;
	Wed, 19 Mar 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dfb4aP0f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22610487BE
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393431; cv=none; b=pDmRu5wr6/1rwS7P3eGhMSkXLADM0Oh+GiIgETRk6Kr1DHgGBzkByujNCmSh0TTsnEGAzZ4GAlKxEFLJHrBjkgUiQJAaMdSKHSs7YnsPy90UPzN1R6nWSqhk1r/dUbZGN/aAKMWJdV1sym74LQCCLwqG5WYAGDlU68R2i4lrAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393431; c=relaxed/simple;
	bh=RZxZQKNwj3Tru3dXf7Tqfg2p9oWqsYaFjAKfL7Wgx5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TThzCVFd9Geah0vocdLWKd+BqLaVX4zAGBg3LD+j7NU3HOlNfvB5rXB2AYS4a3/nXFyLSG3GxZhGS9KtFMgs1vIXovLSziUtdC5ziqZXx4JCEWgM308PSoV+gO68oZyCu2zkts3YIpyYqn4cRX6DInYnKQiBRIszcFUc0g/2ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dfb4aP0f; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c12b7af278so585733fac.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742393428; x=1742998228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCQ7mg9qx8im0TmEXVjeKUfTXL7p1nZHg6BtajIV6Qo=;
        b=Dfb4aP0fDZ2r26shPW+7AebkU4S1Srdo9EeDxDLauEGHN7FG+HL1/kvbnBA6K40vjn
         i0hNO48b6cgUJt8j8uu+Xs92jateavsW+YJ/pbt6Mnd0SUgIXApeAiA0OzBknzZuhPhC
         yueS07yzGmNUol+D0j5PGH6EScEVfNWkFWRQLtTIGdlpRevcjvP8Fn++clW76KuTdyso
         B0cdleCNwUWyXISZCLxp8eryuC14a5Wz2tG7NJn5AIpsF8jts0BfBKrkSBQ7HsePlgPS
         WXsJ8mFbD2f0jU6FtV/+CFEMVVPwHC39LTdFzA6iCTdmpbyfDcrE7vr8DBQfJmelVKDN
         ccSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393428; x=1742998228;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCQ7mg9qx8im0TmEXVjeKUfTXL7p1nZHg6BtajIV6Qo=;
        b=AlwPwJ4FzrToZ+C0kpP/sJXTYSGsGlX2bXJGxTX/BgLS0ZpNgKXZztCwBWY/11jO5t
         1TRLxwTcLlTOORIw+gj4evNJLxvPOt37umA0IgWj7I3Nigd7xtfyyDASgOu6N/kF2uGJ
         lg4KX+VzlhWsZO79TIrJjd2KrQdm2G8h3BBKvrNsxn02sRyXSVv9Mm2oAwOhWYeCEjAD
         gPvxiYINFi2Hrf5e/Q7YoiAQYnCthv5VOKiVKKzYuulGhMxU8VFBTjlyUDfyYebxRmzh
         BEsxec2JmFbeSi+Zqkk3PrwHZqRbDCol932YxaH4Uv/YzR+JKR0iUpvbXcXZVwJhUy+T
         tFMw==
X-Gm-Message-State: AOJu0Ywss5M3oA4u+suVNG+hTe+vBOo9Vsu4bBSj2+lsaHRHJdh466Sx
	x3OiiRqMBQyUIvDKID3EprXwLNT5lUo1ATRqI5xV0F5tapXUV4qrDcDEO6dJ/mg=
X-Gm-Gg: ASbGncufRDyzhroeLuryNO8t8XwuFRs0aVH7OvsvfEug/gP2P9dHSKtqviYtUByYUWa
	5RV5GWCZod5V5Q9o9VLNFbvSOv6S4M/5BtFzrIHiYp6Se6dnZ5CHe0enQhyEGeRdqeUz6ALHkn3
	AtiS0IlN2u31L0XgFL5SSPgNrQGYhvqSZhWgQfRhQxJsk7Iu2Duaqd6Wa/ybYdd86n2FNGLpIZK
	za+Tp1eQzP6diTsR45Q0S0PYy50ATA/4DDsGp9gPaMopCJKsECVSoPhPrhoxPjEMd/ra2t42SAw
	VDANNHD+nggdWwVGL23FLBQBvxGq33LhpW0n81UM9ep+DNQ2P/PX0fgAs9IqHA+vOwAIVkAxwnE
	Vcux+dsbUL68DYyQA
X-Google-Smtp-Source: AGHT+IGLAuT9bruCmg6JLGuhMlyOX5HQi279BRJMsB+YAibz/H/yD22BULxRcvK1dKErXhzR7pgh0A==
X-Received: by 2002:a05:6871:200e:b0:2c3:13f7:2b3d with SMTP id 586e51a60fabf-2c71a1b6563mr4086867fac.13.1742393428113;
        Wed, 19 Mar 2025 07:10:28 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2442600a34.52.2025.03.19.07.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 07:10:27 -0700 (PDT)
Message-ID: <a6246dea-738b-48fc-80fc-6676967157eb@baylibre.com>
Date: Wed, 19 Mar 2025 09:10:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: dac: ad3552r-hs: add debugfs reg access
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250319-wip-bl-ad3552r-fixes-v2-1-2656bdd6778e@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250319-wip-bl-ad3552r-fixes-v2-1-2656bdd6778e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 8:30 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add debugfs register access.
> 

Forgot to pick up Nuno's review tag or explain why not.

> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> Changes in v2:
> - set reg size setup as inline.
> - Link to v1: https://lore.kernel.org/r/20250319-wip-bl-ad3552r-fixes-v1-1-cf10d6fae52a@baylibre.com
> ---
>  drivers/iio/dac/ad3552r-hs.c | 26 ++++++++++++++++++++++++++
>  drivers/iio/dac/ad3552r.h    |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index cd8dabb60c5548780f0fce5d1b68c494cd71321d..fdea9984547ae338a51c4671024133be82ed854f 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/debugfs.h>

Is this header actually needed?

>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/iio/backend.h>
> @@ -464,6 +465,30 @@ static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
>  				      gain, 1);
>  }
>  
> +static int ad3552r_hs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				 unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> +	int size_xfer, max_reg_addr;
> +
> +	max_reg_addr = (st->model_data->num_hw_channels == 2) ?
> +			AD3552R_REG_ADDR_MAX : AD3551R_REG_ADDR_MAX;

Might as well add max reg to the model_data struct and read it directly instead
of inferring it from other info.

> +
> +	if (reg > max_reg_addr)
> +		return -EINVAL;
> +
> +	/*
> +	 * There is no 3 or 4 bytes r/w len possible in HDL, so keeping 2
> +	 * also for the 24bit area.
> +	 */
> +	size_xfer = (reg > AD3552R_SECONDARY_REGION_START) ? 2 : 1;

If we are reading both bytes of a 16-bit register at the same time, we should
only allow reading the lower of the two addresses, otherwise reading the high
register address could return 1 byte from one register and 1 byte from another
register.

And if we can't read the 24-bit and 32-bit registers all at once, I think we
should read them as 8-bit instead of 16-bit because the 24-bit registers are
not 16-bit aligned.

Or to keep it consistent, just allow accessing everything as 8-bit registers.

> +
> +	if (readval)
> +		return ad3552r_hs_reg_read(st, reg, readval, size_xfer);
> +
> +	return st->data->bus_reg_write(st->back, reg, writeval, size_xfer);
> +}


