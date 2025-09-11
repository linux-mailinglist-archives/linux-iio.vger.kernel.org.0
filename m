Return-Path: <linux-iio+bounces-23994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0FCB53DA8
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FCB3A4060
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D72D23A9;
	Thu, 11 Sep 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PGEoNag+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A7228C9D
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625754; cv=none; b=HwW68vOxL1mcclt2O5gWtH7vBq789xAN5lwlihiA7tz1n3vI1MMA9Ur6I985pRR1+JVY5QRx3TTTI+XQTY3P1Ahq3hCPuteF2OSCqFZbQYFXhfegH8OTBjUm1F4bYDyA7bgp7xIr/RRBJb25l4NJSovvwQi1nRbDM9gBcCVQ5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625754; c=relaxed/simple;
	bh=mpF9QO78XjKHHuLN0e4o5SiMPaTbBuzm/F6ez0J1I5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGb8NPuuw044nc47feORaEkQce43kqNHVKsOXGxqwbHuO1BX3hXYI5KQz7FTyg3LqQ2vulUUEHiWRLWlmBOeIXtJnTV0hbO8v8i2MJ3JVoTUv9mR31doU7v5R20IXgxS2RACvkM53q+c9j/5i8RdnS0cJhTTnxS8pGHgp7tA5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PGEoNag+; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-31d6e39817fso1528195fac.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757625752; x=1758230552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAkTFP0wxwWUgNcsyxLjhWngpDbT6XEGsdkzHC+c2iA=;
        b=PGEoNag+OTsl5jSP+ogd9oIZvFz2LRwRw2FPa41g3CSv7yK+qrGVieRHXcYOCoWGRN
         AiZH6SjNtoHsvEGVZWcqCgrNBpEMo1B9vbhK+w9ZLR3kzgc97ZiDHG3umVQ1vgql/sPs
         mOUqjD68vub7SFoOKmRwCO0HFpRreT++mdCA2aKPFBTaD9rhlLNd7Lys9eWY8fnPDjHG
         92LHIsmlJLrf2twnrfvoPIVM/vr92m9UNKYyCaBEFaPELJxmEuH1UqJVMOL3CdYQrPxr
         8923Y71v2Py4Zagoi8BbuBtyfRqziMBus+cWVV21TFzGLxuBUFeZATDE0w8PA6dPZvTm
         yrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757625752; x=1758230552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAkTFP0wxwWUgNcsyxLjhWngpDbT6XEGsdkzHC+c2iA=;
        b=eHgobwdlQZKU503Y6PNvP4Y18e3zZtJcMOW9Kv+aAB8UNEChxCuF5Ns4kZ4sCEwNOb
         46IbtjEmvQ4qGfk7ixUeoZRs8EMTzxyUgDwAmgYR9iAp4+5o53xEqbIDNZdTFwTGxf4C
         b2FYl6Nv4aD36u8+Tjg8+C8ssmT8QdxlRYRLzxvu7ixFCOLKomE/uhdIPFWgiCSV7HpJ
         9ic288VGbJLRgwVg2q0E8XRyKkhPLudTBui35LNaCmyWaIcsFVAzpCP1Q6P+NPTknTfe
         2vESAyEGeqCILn/UoRUiLe+W181OR3+oPjSUo907OIlidfNCkoF6o+mE7vhPTY0hMJq+
         wmzw==
X-Gm-Message-State: AOJu0Yw/N/kyYLbC6Xs8LgXRQ22rarWO5TXW4RgzSIIOOLSvZxCpobd1
	Knft91SKir/7y8Vvzsvre1TZj/i4232vcPlQvnQ7l5GLSHjCquEWx/QcwD8guqfiLAg=
X-Gm-Gg: ASbGnctNof77LF3LhogRw4sQ4zsVDMNJ09CwTsCeaIVbhSMq4p6oE9pVICt7WCfpwVE
	qv+l2MSy7RgvO874I0PtbnQrrQvl3rDMSfwcv1EM8Q6ogFMihqamOKBG3/PpptjTyTUI59oAX2q
	IU3mrFXiO//nRPs8mjAsrDVBIuxwXPhFuHaVIArfzQR1tylNr79hxR99GHMEsQFbwOj4zmU1Qmg
	joldxYDLIc1Z7OWrht6QmlD158ys72Tbx2UUdpWRVpxeSP4qm4BpgqiClSvcBqmLYBTCWdYY3ZA
	+RKyVg48Y7rcvG4X64qSU+JzLgdDeZIWCmZMj7eigN6PvmEE4VI14GNjNnN3I2nZvpX/e4Ifltd
	gSzoZNeAGxeLFe60NtMe3kU2M0qMdtpRfC7eKli4m2AMTHC6PrFXoeojWUqgr6gNQY6/ROlwUD8
	8e3KU+NIGghuvO4pPDHD8J
X-Google-Smtp-Source: AGHT+IFwukD5DNSqehOYV9+RvvVGq7upnMbT0Iek6AnI933AnX9bpqbj2uYAEfMTQRiy63CyP5K42g==
X-Received: by 2002:a05:6871:29b:b0:32b:d4f1:89f1 with SMTP id 586e51a60fabf-32e567c3f9bmr301865fac.16.1757625752123;
        Thu, 11 Sep 2025 14:22:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d357d3252sm673443fac.23.2025.09.11.14.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 14:22:31 -0700 (PDT)
Message-ID: <7da87a1a-1aa0-4625-9884-e88ce48b75a2@baylibre.com>
Date: Thu, 11 Sep 2025 16:22:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Support ROHM BD79112 ADC
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
 <20250910-bd79112-v4-3-f82f43746a8c@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bd79112-v4-3-f82f43746a8c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 6:24 AM, Matti Vaittinen wrote:
> Add the ROHM BD79112 ADC in the list of the BD791xx ADC drivers
> which are maintained by undersigned.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v1 => :
>  - no changes
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af1c8d2bfb3deb870d8df44b8bae22e7cffb5aca..8e78a1168c17d8c2c7056e99e191d542ef0b95a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21864,9 +21864,10 @@ S:	Supported
>  F:	drivers/power/supply/bd99954-charger.c
>  F:	drivers/power/supply/bd99954-charger.h
>  
> -ROHM BD79124 ADC / GPO IC
> +ROHM BD791xx ADC / GPO IC
>  M:	Matti Vaittinen <mazziesaccount@gmail.com>
>  S:	Supported

Should we include the devicetree binding files here?

> +F:	drivers/iio/adc/rohm-bd79112.c
>  F:	drivers/iio/adc/rohm-bd79124.c
>  
>  ROHM BH1745 COLOUR SENSOR
> 


