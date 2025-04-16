Return-Path: <linux-iio+bounces-18176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45043A90B8B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 20:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CB13A803A
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A922423F;
	Wed, 16 Apr 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hl6cYHC/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFE224231
	for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829043; cv=none; b=WfCFxk+a15IOY4IeaPtx+wUvDXXgrLtAFi+wRS5s2YYh9P6PAt1v5K1ccAWZwdcwQc1/RR9QZ57wflvJ8inR0AZs71EZRnK1zPHnbjCYPW8KotsNw8jFkG6ArRJ/k7+jinMM7gdwHBOq9NflbXE/ErH6jr5Mkcpo3XnuMUZxATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829043; c=relaxed/simple;
	bh=C8cKwh7uzGJstEM3SOQj91jM6awnax2SblmAOFtgeBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wopmcx7t8nA2qypJ09F24cmCm+K8EJEy0S4U8VDL7Y4S8ClHRFZ7ch9G6CL1MkEfULLWcmASxPPOcHDOXCgyLHo0kyV7o3lZ52t+PHt8cW7aSuiIgqruL6dMD1WU8pkg4PrGQiRO3Hu61d5njKVVxqvUnU1w+8MwFBZeKJb8zJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hl6cYHC/; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c173211feso2131353a34.1
        for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744829040; x=1745433840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFNyZFztrG1dOuqdMRUTe/Wty6L/zEKrXsP9PzAiPXk=;
        b=Hl6cYHC/5kkMExMREYI2xBpVr/oL8qeVMwsW6PfCYnCTYEEl4zHlGjZylUakZy0SOI
         OeJCrutnVTDCrPRh2P5p/fGY8u+VT5gNXLRS11TKNfBBHao+Qj2xneBeAEhwpycaU86z
         ABakAivxoVjW2Y9ZHzzc+M2rRyDX2ja3o9WJzn/uOXUij6HZEESW5jV6ptdg3e9OAX+i
         13xG8T0+9cNC2OTrILU7q76t/gpM5wWOdFFT4h1gMcswhwEmKsYzq+Ya0cFz66X5InW8
         nm1B0UWgGYaKF07aU7/x6c16BAiLfr41VPYGd7dSSHrGrEViSp+3bfRayi6xjIVMa/o5
         X5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744829040; x=1745433840;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFNyZFztrG1dOuqdMRUTe/Wty6L/zEKrXsP9PzAiPXk=;
        b=GHmnZEn9983XKtdccotgBrJDV645o6z8YNN1rZxb2W1LipAEewHm2rp/ZndXm3CsPY
         NV47rJ8LccN98xLb6cL40UNBDSzIHAfxtwNb+ESwI3rBDfd+Qvl2LRSvdTJh7YMeRl51
         Vprpk6dALGZmTPcZP6EBaG+kjoudFl6XHP5eRBAIkJ9kCw3OJ4nVNATVmmuprswvWffD
         JahH0pVJ5rmRFOa3qL/5AXoioAKwDL7wSj0+WIsxM7IXx+1+T4k5YSLdC8+Ei+L77RGB
         ygPO+Iz37rzWMBbfCUkEmQD6YCe3T8AzbIJ3GTIXe5k7GPKAY+pZYG8EwwXIzM+7kj/r
         VVFA==
X-Forwarded-Encrypted: i=1; AJvYcCWR8AVHc+7e1uoLl1BXcgIHt3aQq/WyixmCxaO6iv8T0Nxn2MoY2XbQMkI8HoQ1eIywFso7T9JU76c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDw1oRKCDxplVqBzREdKSzs0o2Uvzr5WxSST6ugP4MMEaqwfd2
	oaiCqdltET9jROGgMszUULG5k1bB3Qem4K01wdl0ARt4c4vvGf+u8Z4kVFCSvXc=
X-Gm-Gg: ASbGncsTfRIKRCMGLBdIJ2f5mp3Nu1q8SlDTLQu39Akuty0Sg3X3K2AVH1RhusCo+wi
	LQrtiMXYN76JjSapFmPU9Zs7CLf30cdMf++e7mMGp90tqug2KHvnfTrsYRgKsMtEN69LlfeFBpx
	HEGFqGr91DUUeQGvU0rtsgCZntcP9RwZjPzQuhfFTp7YN5a8PF/0MA58s7A1EVBgjLyc/MfCOd/
	KCtleSbb1ETLRDgCHUWvvVVNKyAN9/rtu4K4cRu9vAUDdxz+sPjIPBywKS9cLpsRM2cWhuz9iAb
	YaF3CCxVjWE6ZdOyh3HBD72K/nVwIEedv+QwEXmRsOCgJMYMCV5LuJN6ZYXCfLaA77WWDsyFEU/
	IUejxQYgAiWFMZ0Us5g==
X-Google-Smtp-Source: AGHT+IFNy7Si480QA8MeOF7SjrhfcYCIh4tBh20HJCj/dT3m88fwp7Q5GoiwZjRbLJPiJQ65PvSFwA==
X-Received: by 2002:a05:6830:2113:b0:727:4356:9f07 with SMTP id 46e09a7af769-72ec6bf6163mr2046480a34.14.1744829039908;
        Wed, 16 Apr 2025 11:43:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3? ([2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-604a5c4bfafsm467955eaf.25.2025.04.16.11.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 11:43:59 -0700 (PDT)
Message-ID: <a6023ccd-76b2-487e-ae22-6bfbbc47ff85@baylibre.com>
Date: Wed, 16 Apr 2025 13:43:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad4000: Avoid potential double data word read
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 7:21 AM, Marcelo Schmitt wrote:
> Currently, SPI-Engine offload module always sends 32-bit data elements to
> DMA engine. Appropriately, when set for SPI offloading, the IIO driver uses
> 32 storagebits for IIO ADC channel buffer elements. However, setting SPI
> transfer length according to storagebits (32-bits in case of offload) can
> lead to unnecessarily long transfers for ADCs that are 16-bit or less
> precision. Adjust AD4000 single-shot read to run transfers of 2 bytes when
> that is enough to get all ADC data bits.
> 
> Fixes: d0dba3df842f ("iio: adc: ad4000: Add support for SPI offload")
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


