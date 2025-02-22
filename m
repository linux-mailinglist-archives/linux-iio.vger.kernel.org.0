Return-Path: <linux-iio+bounces-15980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B223A40AB3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF52D3AE21A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1881D86E8;
	Sat, 22 Feb 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AgbDvlRB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F310E4
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245467; cv=none; b=bjYA33efsWB7Xyg7UACfUtjNDYOUc4/PZIirr+BKqbbCwFgZ5G4KzhtmsHHXqvn+zFBGsrjaeOWWPcCLOrMkvKhu83f8eV9J1+62UAfI2ccQv3npc/1NUk5fRdkonl/xgkNVJN7eUMrxoGSVHq/XvxIBwnCvzk7ziGo0TWn4Dcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245467; c=relaxed/simple;
	bh=CyF+qU2Ab2T49/DgCHzI2UA3DrsirXHrRpfI2A6oP00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfglRqr6nHmfPkrDowxSZeSOdnkv3k3AdXf+FLnLTDGduuQNsxpb363yuyPJMSBIMmOJKmmM22HxIlqLZqYYCzqA2vVmcx1iraW/Xgl6dW6IRoddk7tFw5AW/eZxQX4+0GMVaZV6edQ6kxyv/qHYlLrNfXM7GFEr9s8PYBm2TZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AgbDvlRB; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7272f9d216dso1797645a34.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740245464; x=1740850264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umSaZpJsRTxAjHVQyIPwWd7ZmuYXXC82qLwu4g3KMsU=;
        b=AgbDvlRBajIX5SiHOqJCHGFuoPR5TR+tQmfwTOKEESsbZ8famzV/PrxYQ98MOCoOD/
         YShs9jbYOGEFVwhz8ms3IGlhr6tIHThxkuiWyE0ERtK1eJURMeTnD2m822C730mdQNwa
         pRQuSLnagu98jg7V9/jCIoe3YhF0Y6mHwSNcGLNDWHBUdd5zhdBfiy/RVzW5mWZdUdZR
         CWqvUgIsrF8A799Ryw5ib56hA0xRZmT7vAa5kry8wNzkvyw/nvD2wlwdn1t+GPo4xfXj
         4ahQW8u/etR6xLmHp1DHH2dHS6a/IvT//GLfQJEfgDKwpRNo0ZxhZjwBA1jNlJix5Mcw
         R6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740245464; x=1740850264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umSaZpJsRTxAjHVQyIPwWd7ZmuYXXC82qLwu4g3KMsU=;
        b=dbLka3VzG1G9A+c4Mu+vxOQClaJZNRVSn9o1omZ41bLJycR/+P6I03UyiOJMwjp4Vl
         i1jccV/vEgWJxZrDfEqohkgKAB77vMfIB4EIPYTRScI1PxnApIaRn3PdhSJ22u5p99eY
         r+P6lhbyKypOiQqq/ZF6+yeN4aRkbvO6i/0EWuWW6o9TNruocgESVzvQJQ59FSYslqYt
         pHLuMCJFDvZLzzBPCeIl0zp5FQw9v7EqE88Fk1wwXNAYGBdWJzSkDNMKUNGQ2b5tdGaT
         HdJfZn3W66akJq3GQkQVhNsG3VTFw15QtAdbqJbQm1z6JiOdywJkM/SIAprSI00+AOen
         yPLA==
X-Gm-Message-State: AOJu0YwZiCeLeBIRx0rspbZQNv7tav+0sYxSTePjvyKM7m/800iIfmL2
	NoyUZW+aShOFoxZwgkmGC7oN9qAVJgr3V4ul+Ny0fHvyVwAhHKJdXcTVVNYu4rI=
X-Gm-Gg: ASbGncuz6X9Uhz37XfEFAlrX5pQ0MRw2v0msc1PmdII0i6ryw4gOWgKlE0DaJhJBShD
	PzLMuYt2h0YgiWmacTzWDHTK4/XoEHqspnrF1yVSM5IVs7XcS74JMZBp0vY1yWS6QqnBRqvuyTp
	0Ka+gZGZEgKhdpnxc02Uplf3YvUDyOAwk83B9bg6Cf1xeMPcomcNRJKnOkOMRc6jRwgg8cTTKXE
	aSoWxyODCRf0SLCgnZ/O/2MxKkULDoeuVMjVlpOpLsBs6yJW0ZfD1vKugcC/ckNSUPmh2GYesl0
	0K0SUebOeQm0FewK0IbcV6w24vRuLC3ZR74nDAmeiqERQBbsNcUQ13veMKjBDlY=
X-Google-Smtp-Source: AGHT+IGXxbWfYhLXPZeHIIm78NNGLMBPXt1gslBwTaTXB0Iczgx0Wa/lUTSQPX5RcLE9fGYxwUKe7w==
X-Received: by 2002:a05:6830:3909:b0:727:2c98:4b15 with SMTP id 46e09a7af769-7274c216ab3mr5979117a34.18.1740245464024;
        Sat, 22 Feb 2025 09:31:04 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72737f96190sm1913719a34.11.2025.02.22.09.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 09:31:03 -0800 (PST)
Message-ID: <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
Date: Sat, 22 Feb 2025 11:31:01 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ad7380: add support for SPI offload
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 12:03 PM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add support for SPI offload to the ad7380 driver. SPI offload allows
> sampling data at the max sample rate (2MSPS with one SDO line).
> 
> This is developed and tested against the ADI example FPGA design for
> this family of ADCs [1].
> 
> [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

We forgot to also update Documentation/iio/ad7380.rst. We can follow up
with a separate patch later though.

>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad7380.c | 509 +++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 475 insertions(+), 36 deletions(-)
> 

...

>  #define _AD7380_CHANNEL(index, bits, diff, sign, gain) {			\
>  	.type = IIO_VOLTAGE,							\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> @@ -237,48 +335,123 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
>  	.num_event_specs = ARRAY_SIZE(ad7380_events),				\
>  }
>  
> +#define _AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, gain) {		\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                          \
> +		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
> +		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
> +	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |   \
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\

Not sure if this is worth troubling with, but it might make more sense to make
IIO_CHAN_INFO_SAMP_FREQ info_mask_separate instead of info_mask_shared_by_type,
at least in the case of the single-ended chips.

This family of chips does simultaneous conversions so shared_by_type (or shared_by_all)
would typically be the right thing to do here. However, the single-ended versions
of these chips also have a multiplexer, so there are 2 banks of simultaneously
sampled inputs. So the effective sample rate as far as IIO is concerned would
actually be 1/2 of the sampling_frequency attribute value.

Since we have a channel mask restriction where we force all channels in a bank
to be enabled at once, I think it would work to make IIO_CHAN_INFO_SAMP_FREQ
info_mask_separate where the reported sampling frequency is the conversion rate
divided by the number of channels in a bank.

> +	.info_mask_shared_by_type_available =					\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> +	.indexed = 1,                                                           \
> +	.differential = (diff),                                                 \
> +	.channel = (diff) ? (2 * (index)) : (index),                            \
> +	.channel2 = (diff) ? (2 * (index) + 1) : 0,                             \
> +	.scan_index = (index),                                                  \
> +	.has_ext_scan_type = 1,                                                 \
> +	.ext_scan_type = ad7380_scan_type_##bits##_##sign##_offload,            \
> +	.num_ext_scan_type =                                                    \
> +		ARRAY_SIZE(ad7380_scan_type_##bits##_##sign##_offload),		\
> +	.event_spec = ad7380_events,                                            \
> +	.num_event_specs = ARRAY_SIZE(ad7380_events),                           \
> +}
> +

