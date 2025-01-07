Return-Path: <linux-iio+bounces-14007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B21A04DC0
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD73A7A0864
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271071F4E47;
	Tue,  7 Jan 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dsj1voRk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02A1E9B0C
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293336; cv=none; b=MlTAjbBvOMGPi1ZSP5bqLgJzBH56NOHrIBCRVza6p/7wDHBqpn+5j/jl6Gf0+UQdHl7LiydAX5+A571tzUCdXgldV2Hw/crvNuSjt8xlLuNdkqsy3jjRJEablcr8cnC4UCym2+y/imTFzTYVVVLZ707mIDdLLlluttX7Zl6ri8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293336; c=relaxed/simple;
	bh=uS2s8+MyUoVyOxULB1PjXTO1JQwambQ4BiNiIW7gMpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1EfzaRiU/MkoVFtHiEOhJgoX8S88w7Rx1wh4tmNsegJlXxfcycuQg4TRhKaKWXEDxe1WW4FYWXpAJcKk7jfSvXeKr2uTe3qZT6IcFQ3XzXv2uUQvTKziYT4YbLOTPYrbt0a9NyVgNVQ+4vnHPYXE2tFGnnm3FN5w6Uakf77TxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dsj1voRk; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e2766994bso8170557a34.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293334; x=1736898134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyZY+9gyZI9ilGK7mMQlranXphPeQlaTBvl2YUeF1bA=;
        b=dsj1voRkFz5DmWetlnNnphPX4ZqfgQuKlQXzvf08aJKm9q0Joweny+ZpfzZkG83iC4
         qyQkalccRnrVzeg1Kh6ugOAnOLMJsGEli1N8ytyVXwNPEJrdLCYCWvwYPa8W8WyzSAWR
         r2RA/+NKt8n3s3VA29Cc6ggr4H3L1PFvowQpz1Dz9gPP/Jyp55A5wtk0QobgqKlqjLBY
         QaNuJxRxwUdYP9+VE5brgV3tcv1cMdRa5ocxStRgLuIPyMaurmPwcAjx/E3dXxyCmQOQ
         d2kdCKt17YQm7/FTv9P13hTgJYL00VXVTVl+9Pf7VeP5nVA9fPaF4mYLKBplJMMkRZ/G
         pP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293334; x=1736898134;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyZY+9gyZI9ilGK7mMQlranXphPeQlaTBvl2YUeF1bA=;
        b=dzy0Zyz+KowCkpC8muzr6IhN1zZgxK8wIWNYLHpQkgh2v0/N8iiK5RvQIaDBlkBATg
         MacDbW2oBQgi6ATq3lbJOYW2f+/uDf7ybuU5OMRccuJHU70OqF7zOc+20WybvqGpKNa2
         haJrddd5sJUh9oPqaHkdn2vzw0pFg5N+32yt/k5YcoM/JfozVzltfertrpmLWD9GXp1o
         gwQmbeu7XkP92JrMjg15wge8+VGtJoH/So0Piy0aLVnMGQvUAzimqjs8HwIYtKVY6L1O
         1YbjUpyJg/ZOYdhWGcEDYJogUMQvJGg1QGL8zCl9JFpk0MTvuJatRyNjaFd46+AWep5S
         HJdA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2HZz0l0+mhdLIlWIQDQbyTDPr3ppOnEluM6BPIXx1DCh+94IT6kwuhKbNQdZASTWkCVgyhxx2Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjE0nMXbuB2v9jp03zXGfXT0eRBSCS1UyUPM7GhMcWAVzWLAs
	tQw0M1CO9cMr1Brl62Ogikm7LN2MyC0IqmcEO8LWFb+6O5JINKJ0s4l2IH5M+CE=
X-Gm-Gg: ASbGncsmmuF3JvMmI6woxELvihoAxZkOh1FJrEXB5In57Ri7ydMSiG95hVTdopHlqdR
	JFpOuuYQqeRYGxAoqyEJKv4sH8F2XI0cZYUWMuZFWSsgR+mY5uFjZWA0ujRitT8vU4y46g8cljk
	jKSuKo3zEW5lAPAEmQVHFd91pCJALkltaPnwhF8DKexkJmYrwnpiN8ZvbLn01b/sSTZVMCJYBty
	Ub8/E6SbGY9crbHqeLfSqYKHXJ6681zgprTHFGC6Z44zEZnNREoz3aEPPcqvzXwz67sJ+Ws0NsB
	rvTK0+1zGkYsX5Ps9Q==
X-Google-Smtp-Source: AGHT+IHJ8n3kScfCfKz0Gfi3BXIWO2gj6Gqdvt1OvRc7KB/VzsQnuFBgqMCPR/7s3GKaPFrd+5eTXA==
X-Received: by 2002:a05:6830:470b:b0:71f:bbbd:ab49 with SMTP id 46e09a7af769-721e2e2e64fmr417986a34.9.1736293334557;
        Tue, 07 Jan 2025 15:42:14 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc998ef6asm10585525a34.50.2025.01.07.15.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:42:13 -0800 (PST)
Message-ID: <3de36de0-93ee-4ef3-a4a9-7a8f187eb4d8@baylibre.com>
Date: Tue, 7 Jan 2025 17:42:11 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/15] iio: adc: ad7768-1: use guard(mutex) to simplify
 code
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <245cce4d379d225ab6794fc3326d95f88d2abf1a.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <245cce4d379d225ab6794fc3326d95f88d2abf1a.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:25 AM, Jonathan Santos wrote:
> Use guard(mutex) from cleanup.h to remove most of the gotos and to make
> the code simpler and less likely to fail due to forgetting to unlock
> the resources.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

...

> @@ -484,7 +477,7 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	ret = spi_read(st->spi, &st->data.scan.chan, 3);
>  	if (ret < 0)
> @@ -495,7 +488,6 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
>  
>  err_unlock:

nit: also rename the label since it is no longer unlocking

>  	iio_trigger_notify_done(indio_dev->trig);
> -	mutex_unlock(&st->lock);
>  
>  	return IRQ_HANDLED;
>  }

I'm also wondering if we should just drop this lock. It is only protecting
a triggered buffer SPI xfer and debugfs register access from happening at the
same time.

Since we have to write a magic value to exit conversion mode, reading registers
during a buffered read is going to cause problems anyway. So we could just
remove the mutex lock and use iio_device_claim_direct_mode() instead in
ad7768_reg_access().


