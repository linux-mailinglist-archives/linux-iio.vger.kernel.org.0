Return-Path: <linux-iio+bounces-23466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 551F6B3CD45
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF9C5623F3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73125FA2C;
	Sat, 30 Aug 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rApEJ9er"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A522AE7A
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756572091; cv=none; b=LibZdNHWznuFFt+BBbrUJzddS3KLV9lW/MQvwO6aeT7sMv2/vLD1+LjMmUVl1v7dsI84GnZWTxFcv58Tgy3Co/qnLCOyAU6xhtjYxeq1T20PLtUCxPOTzNgwmXF1ZU0IH2sELauW8WVlPw74JWJy5Vib4ExxsqhmBw/qe8PNBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756572091; c=relaxed/simple;
	bh=9pLVtHagF9RfuVvLL5VmokTfRtBhGQ67ZkM9NHr6/xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTh4mneciizprCvoeT/M3/Dn2/xtqIamm/7KwghNypbTflmtBdCobQIBgdt4r8Dmp5byQEZG1Dl3CuemOLqU9mJ/hQC6Ft9wVl23UbSJV3IdLzrAYyXRPb5V+nmRdy9oMu6uXvV29O2lO9Wr/HjNx2EG/tftY7ZkJEWE8Q/mHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rApEJ9er; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74381ee9bc9so2886096a34.1
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756572088; x=1757176888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbfBohOE3aUAe+8ggIJdFs3Ub7xyIyjcAlkbS5chGaw=;
        b=rApEJ9erCEAhloV58ULbDH5EvvpeMmIdIkDlBfA9xitGgEExwtWbmQkz1RUdCcMAa+
         MtiyC3tIRRdc6vXoHUu2B2b3v1Uel8VaZhy9UZX/Uah6P0EyiCU15AmxTH4j9D02KAR3
         uCbIyFS0BGua5quv3PSXGEZmnnhJq4+rV4xkGO4lwLZV1x+4Nttni7NvjpCSyqUeoUMW
         ZtCG+WSiQzT4Az4QFJAA+stUYBZvp9m+roqig8mLZZgHi8WGydgHAq8NCj/DE3EEmy14
         dlMiiSme7XxvU31PHkPQcRjmmOtH3Od5NAjxz4q5/Fiw3Sg7ezmKN2AuxWgiEFwOPbGs
         nJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756572088; x=1757176888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbfBohOE3aUAe+8ggIJdFs3Ub7xyIyjcAlkbS5chGaw=;
        b=OU+CNDXnf8vwSk2IOzE1N2OFQW7MKoQeCECXmjyUX7SiQ0YvN5G6MeMyg87Om+8GeH
         e3Q37c32Ho4BfcMdqet6cZQzY/pxfdDCgAEzfi3W66tkMKXEo+Kux9QonCsE1M7ukPnK
         Hd9EEzsrEr/KGJVExqO0kSmPXkUhpg6INTRffP7P1ggfxpFbH+gfWIkixI5yyFkfmO94
         AiONsJkwWDMm1XaUKDdrPis7IVPWoVql/QEmR2HPaQRxUsE7FSWGtCXZGXIv/ZRei4FD
         eSdsQP8Go388d2zGEdYZxAuuCkGxFxoPiMi96G1kB16xDspilPbUEvFB0fArrmyZjyF/
         4CSA==
X-Forwarded-Encrypted: i=1; AJvYcCUZH+bBujLjtLRgX+iVlieBbtbfu5GfHKx/gFUdWaXsz7BXI0Y9Mf+FiI89rN0cBgTUxarUuHebdfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNYlg7BGEo+2AZJs9oYMqMWmsZ0MpTeFxrEIlTx73nPg2KjNK
	5wXWlxnlInfUDeDA4v/Kzj+hORM3uI0f3iKNZXXEKbofdMByBCzaGzjRbCchz0RFRx4=
X-Gm-Gg: ASbGncvLVAlcLNYAjINUNrUaxYBfIWwOD3M1hLm4KbODzL3JOBeE8seGNTfuriSfVDn
	NGKQicuXesPEtCts8lhll9qJsqnmmP4laPnclr0hwjLDvaka6vFjB0ccwb1kRPteiHcRZWu4sqE
	LuQ3so1DGsT4/vFmTmPHbXG0W+znzW6yV2mzALFUbjINlH7tTSjLzof2F1OFCc6BHq90lU6cxl7
	DEQDhjMyGHl7JJbnikGLsV2BtYai0kklmTGgxtAPzsJ6ddcKDjOFZDaEdOo1ee6n+JFtzg9RwQ6
	KyypUu6a0LjWXDcSlYJ7wgRGvf4RDhUzVLimJCWVcC+RlKNQ4B6PtwRyxhF12/vZLYs7auruWBV
	713ZP/1EVuuIzBc79oc1ZcSC0kIIG2ThBFFN4iAX4hSGdtDOjE8FE5u+QQDEMHGH4BvS9oKUSBg
	M=
X-Google-Smtp-Source: AGHT+IEr7AQnCq5wkF/dg8M61n6r+AfW5NR3ZpEgSAUCmyBrqg6y3i+f1Si6RhVd/teU1v3mrKvqvQ==
X-Received: by 2002:a05:6830:398b:b0:744:f08e:4d30 with SMTP id 46e09a7af769-74569f18c36mr1644826a34.35.1756572088242;
        Sat, 30 Aug 2025 09:41:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3196d46d8a6sm345913fac.18.2025.08.30.09.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 09:41:26 -0700 (PDT)
Message-ID: <a94fe92c-ec2e-42d9-9a88-f40f243560ca@baylibre.com>
Date: Sat, 30 Aug 2025 11:41:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] spi: spi-offload-trigger-pwm: Use duty offset
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@baylibre.com>
Cc: Axel Haslam <ahaslam@baylibre.com>, jic23@kernel.org,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com,
 andy@kernel.org, corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, broonie@kernel.org, Jonathan.Cameron@huawei.com,
 andriy.shevchenko@linux.intel.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <2410525339f56466fa566dda367678ec92f9fb98.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2410525339f56466fa566dda367678ec92f9fb98.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:42 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Pass the duty offset to the waveform pwm.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-offload-trigger-pwm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
> index 805ed41560df..8413aeb3689d 100644
> --- a/drivers/spi/spi-offload-trigger-pwm.c
> +++ b/drivers/spi/spi-offload-trigger-pwm.c
> @@ -51,13 +51,13 @@ static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
>  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
>  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
>  	wf.duty_length_ns = wf.period_length_ns / 2;
> -
> +	wf.duty_offset_ns = periodic->offset_ns;

I would be tempted to put the loop check here:

	offload_offset_ns = periodic->offset_ns;

	do {
		wf.offset_ns = offload_offset_ns;
		ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
		if (ret)
			return ret;
		offload_offset_ns += 10;

	} while (wf.offset_ns < periodic->offset_ns);

	wf.duty_offset_ns = periodic->offset_ns;

instead of in the ADC driver so that all future callers don't have to
repeat this.

Also cc: Uwe in case he has any better suggestions on how to avoid
repeating such verbose validations by all uses of the PWM waveform
APIs.


>  	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
>  	if (ret < 0)
>  		return ret;
>  
>  	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
> -
> +	periodic->offset_ns = wf.duty_offset_ns;
>  	return 0;
>  }
>  
> @@ -77,6 +77,7 @@ static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
>  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
>  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
>  	wf.duty_length_ns = wf.period_length_ns / 2;
> +	wf.duty_offset_ns = periodic->offset_ns;
>  
>  	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
>  }


