Return-Path: <linux-iio+bounces-14643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1DA200D4
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 23:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133391658DE
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F501DACB8;
	Mon, 27 Jan 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M/IK30QO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580A1EB2A
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017982; cv=none; b=HF8ABdx5xRdTffH+DWyM7fd4L0K41cq0030ZHd6eT8BTIzQtBHGAAGB6qRKCBvPhJr1MS91UQVPLM7b5qOQeqZev5OBhZo5tExmlc58EaoC++Qm1Pa1/Aj0KvxTbjXopzhXrNPKk4AwdAKmIhJhEZjwIDEq7cF1//+6nCc9+2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017982; c=relaxed/simple;
	bh=TL6ix5Jd4YZkMFQZJvrHPcvBCtELUKRUX9Ewr+Ak6zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxpUHffKELrRkY5RFYanAvuow07l6CtceY/A7T+bIZLBY99OiNoISLxKRQyMCQ7bv9CBa2PvoakrHxQYeh+ZhRdxaPN1d0zsjrbPEPZpr87iA5GAeMR5CqT6jL78hhVaTLnVVDjhjSEa+Ws+EPh+FJ0xOwAkXJpV+5uWToC/aFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M/IK30QO; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f6b65c89c4so1097630eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 14:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738017979; x=1738622779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GN7epJb6kPL5GnwOif+YIvik/vnwU971oO3M9RsRo28=;
        b=M/IK30QOj7z88rvufHTpstDsCio2cnCI2xbOHcq4YsiJetrbZOtROCbOwefObDxCus
         EAcdXQn43omWrJafbzEyuBukbWh2w94OpRyj1PHHuBkd77mbRsQ0GDz5Ud/yQ6W7dL/+
         GkrTYFnopMtgGZI/ZPs/NnJg/BakXj0x9SJDDmI3k52vqPBTANoD3WPJzMeDn6kXxoAK
         0gWdt0eddetYyqaHlI3AamatNOU8RzvvBPv4xbXAdOlXq85adQVK/82qDCGWHAh35P/+
         0Ie9nMP38XdFylPlyqmhOkZJ5qS2pIT/1eAZAzbCNrjJj3zGNdv3QR/1raql5B3v+SlG
         7YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738017979; x=1738622779;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GN7epJb6kPL5GnwOif+YIvik/vnwU971oO3M9RsRo28=;
        b=WSHvKZeUzEzvj3YqoPm8qj26axdtJk6GM2tdC83HCijNgFjUVRzh6V3YlOZjaqw12w
         xAYLaukfHcYdyg0ua0gpwp4h7zKfmOhJ4xwUl8TkuXbFTRzLkEFBIyNBznIt6f0ToNui
         Z2429DtfgtFxyho0oqFx46wz11KRIExpNs4ZaTzcb3QaiS0tFEUN4nhXZU4x1aZarP6r
         ipD0KguDM/2UdQyr8DgiiKiFZERPahNMhtYAvyBehhaxcLdejQAhj/UOAgICbFCYtJBg
         ntvwUp+/7VMfo5+hQJ3AwpFSGa6WK6dlT53VFI/2kdmFNcGSyzXV+CmQ0Jz7gA2wmxGw
         VAHA==
X-Forwarded-Encrypted: i=1; AJvYcCUCCMgocfDdILwdF92Qsap6pKW4Ggpak/L7gljF4GceJc1ndEMI3cbuUbjCXu28+BzddCRZG3gDjQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdopCMU49MbNPZqvwgGxy3/GND7cg6kBo8iRWuW63W3Y/VUkC
	tH4G7zXNgKD7nW1Rl2a08F/wSGM1/x8jLLdAfDxpLxVeDBOGdrerMaVhmGVgzQA=
X-Gm-Gg: ASbGncvNGE0lIFUtYU03gcK7KpIbZO8URTOikOGEqE30TTvMUGJBiGstRrsxKyU5Csl
	2nxLkO2US5xcHTTHc7pZhK9cQBGcE68+d6ib2KxGb32pd2cP8aXeRRSCfOwxF+2tTtfM7qxD7GY
	NgNe7AM1aru0IMjLj/4JUDrNmQCRsWXPN8aV30FZPzzkU4/7/gjfrj9ke2CujAJFgg9kvgxzjWp
	Zoq3uZcusfKpFvGuBd1N7i5DGejuxPCgEWZ6u8rVGKpCk4Hab+jRaOC101sq4q/U/1k8UwaN7FN
	Pvv6p02iJgMvJIAJIiH8Nls2YByNIvFR2ilP0iRTuA==
X-Google-Smtp-Source: AGHT+IF8Ge5d9gQ9QysqTcZJLOBCMrr0ch/XmoPITtji0GkXQNbkP8LBAT3amNh6s/yyDouhPUb+Sw==
X-Received: by 2002:a05:6820:1e0b:b0:5fa:2e20:a371 with SMTP id 006d021491bc7-5fa3876111emr24438260eaf.1.1738017979415;
        Mon, 27 Jan 2025 14:46:19 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa8b9b8fd3sm2519790eaf.40.2025.01.27.14.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 14:46:19 -0800 (PST)
Message-ID: <b8c68fef-3427-4617-989d-20529d9293dc@baylibre.com>
Date: Mon, 27 Jan 2025 16:46:17 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] iio: adc: ad7768-1: remove unnecessary locking
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <df331cd681feb756d06df4173f67f75ec655bfb2.1737985435.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <df331cd681feb756d06df4173f67f75ec655bfb2.1737985435.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 9:13 AM, Jonathan Santos wrote:
> The current locking is only preventing a triggered buffer Transfer and a
> debugfs register access from happening at the same time. If a register
> access happens during a buffered read, the action is doomed to fail anyway,
> since we need to write a magic value to exit continuous read mode.
> 
> Remove locking from the trigger handler and use
> iio_device_claim_direct_mode() instead in the register access function.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * New patch in v2. It replaces the guard(mutex) patch. 
> ---
>  drivers/iio/adc/ad7768-1.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 17a49bf74637..5e2093be9b92 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -271,16 +271,16 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> -	if (readval) {
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (readval)
>  		ret = regmap_read(st->regmap, reg, readval);
> -		if (ret)
> -			goto err_unlock;
> -	} else {
> +	else
>  		ret = regmap_write(st->regmap, reg, writeval);
> -	}
> -err_unlock:
> -	mutex_unlock(&st->lock);
> +
> +	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
>  }
> @@ -495,18 +495,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> -
>  	ret = spi_read(st->spi, &st->data.scan.chan, 3);
>  	if (ret < 0)
> -		goto err_unlock;
> +		goto out;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
>  					   iio_get_time_ns(indio_dev));
>  
> -err_unlock:
> +out:
>  	iio_trigger_notify_done(indio_dev->trig);
> -	mutex_unlock(&st->lock);
>  
>  	return IRQ_HANDLED;
>  }

I think the lock can be fully removed from struct ad7768_state  if it isn't
being used anymore (and remove mutex_init() in probe()).

