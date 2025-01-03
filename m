Return-Path: <linux-iio+bounces-13883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025CDA00A3F
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB2B7A20A1
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B3B1FA24A;
	Fri,  3 Jan 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mHad7xRc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236701F9EC1
	for <linux-iio@vger.kernel.org>; Fri,  3 Jan 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913047; cv=none; b=rlDoJNgc6xPnCBDGGMQZw44ANHCBNxqjqN/l56R3JoVdXvxc1RhzHi/5teYlKlCODENcHsxYuI3Od4cGoTuGBJ/evDAgerpN+n8rfAhZZ4GikakxuC4EXA6qgb5Fev73Hu5knMEjfNcp+wiGxTyENLlQivAkERxi59dIN1g8ZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913047; c=relaxed/simple;
	bh=IRJHciWqqdgGQOEUniGMHthK9iLB/AW7DgOoZrn/pVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Po1lpKnS1aE/vnRPuOOwbsqzfQSBv1zHvR/sItS7uPs+KQSEWufh1Ast74uiF9uf3Z6kTG154+QenWDb4NsFfbD5Jdu3jYrLSnWiOIEm2sxcvSKJ9fnLpHb3LYFRZiIuqUY/OTAQfcP8B1nghWKEyLcdj2Qj0kGgNAPAgfRYJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mHad7xRc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso23607890a12.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Jan 2025 06:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735913044; x=1736517844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nadMbH+ZbVOHrjS+G35Vf+1M5GTdHk8b7CxTha8a/M=;
        b=mHad7xRcUfXVSAcCXwhobjuFSqorBvZVnpA4ejp1GfNtxJCYtLeAl40tgdQ83JNNQC
         7PHTXTfR4a0Phd5vMzEHWVrU+5YjLEJZCnDVKakX7whQpnkIOJroPucNCYK5gksixgOO
         XwawSD0crp4L92hOMxdcGGAlmJwpRfYfjul7FJIaTUkeJjghv9wk+4PnDsCgcbmbpWAA
         USnWWuQCwVGgiCxyuK5HCVe8dShQWkfygFs1xn/giLVdhawP3pdMfxWD3jwfl8RfmjNz
         Ph3eJyyiuDhUppmwXvIPC1VfWiwXQkVbB6Iz1EVGxlKTAC+Ih6NS5Rt94jwnyif/1gtL
         kjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735913044; x=1736517844;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nadMbH+ZbVOHrjS+G35Vf+1M5GTdHk8b7CxTha8a/M=;
        b=JyVjZYhkK/8Yt+ujx/15ge/xB6DjkS39wHZtbnO3XrSUA8vF7aWeWJMglIttVRkcS+
         NX4pQlqoZ8/F+UuZxwL14yYp62jCkufc0jiACUDOULv7lxnxSMpVbSZ9TAIkBnA6DIWs
         R2Hmglp8TqJ8jiVEwBqaamI82sjvQl8cHGiCPwQmXb8Kx4zE1u2wT+AL13F6xSjKvx03
         E1hh7lYg7Rb/7gC/kQ2ejhMrjOS6fIObrR0i/v2EG1vHdVQaEQNA1ItsQOXueqCQWf8x
         2qDxX8CTnpqhLSNH8K1qJDctK3FXvhN3UHpLVMpodkLHPXMZkvnFu/K+uVIpYKcfxhkt
         TAkw==
X-Gm-Message-State: AOJu0YyLw6sP1k9kqIRn4V9u6cUR2Ys2HMttDf9EAyMNL4aUZpABjj8o
	N94zPcaLoF8jb2eCDIlCFLEYKkz9jOXw+3K9oBQVBUn9AlNA0/pmRZwQd0Twd+c=
X-Gm-Gg: ASbGnctuF1wjlkPhFiPSyEx5chaeolCjKOa23kBET9Ye9lzBnBCt5oXkRz12fJKRuVn
	VCGY0ph5QjJMnLYV37UBWQAfc9w2IAs0aIAqlnHx6rEE1YC0zRppD0odMTIf5y005Gh9sngysl9
	ADG82Gavsyn6hTaHMSuL96HKBwPs8I/RVdxHvaQzeTm/we4zZrmNBcM5GhqMKRoDM/ikqVktRwz
	88HDLAjdk6e50mtF8YmcoIzNavue+j2q6jEeqIoI5EcLfqkClLXHto6XcZCwF4QZA==
X-Google-Smtp-Source: AGHT+IHXizRGATHHIB9x/d9Ka0idAbL9vxxT/I6jeN6KVRqP+AQrKS6HS0dZiWSTzEdkl6gN+V82Og==
X-Received: by 2002:a05:6402:2691:b0:5d0:7282:6f22 with SMTP id 4fb4d7f45d1cf-5d80245b76fmr42721534a12.14.1735913044130;
        Fri, 03 Jan 2025 06:04:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a3ebsm19489852a12.7.2025.01.03.06.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 06:04:02 -0800 (PST)
Message-ID: <be7c786b-e786-480b-8ce9-917a0836b7ce@tuxon.dev>
Date: Fri, 3 Jan 2025 16:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
To: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org,
 lars@metafoo.de, ulf.hansson@linaro.org
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.01.2025 16:00, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds some cleanups for the RZ/G2L ADC driver after the support
> for the RZ/G3S SoC.
> 
> Ulf, all,
> 
> Please, do you think there might be something wrong on the power domains
> implementation 

I was referring to the driver part (drivers/clk/renesas/rzg2l-cpg.c).

> that led to the conclusion from patch
> "iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()"?
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (2):
>   iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
>   iio: adc: rzg2l: Cleanup suspend/resume path
> 
>  drivers/iio/adc/rzg2l_adc.c | 62 +++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 30 deletions(-)
> 


