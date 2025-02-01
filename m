Return-Path: <linux-iio+bounces-14828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4CA24A20
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C447A224D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20241C5D5D;
	Sat,  1 Feb 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcgn+w5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04361C5D4F;
	Sat,  1 Feb 2025 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738425868; cv=none; b=hNw8MLdCxkv0LFa1Zzprr6NEASAimPO73B18hCKPds7SMl2s2R5zQKy86d0y1wt03iMBQnTH5xj+BUz8peSGqjXvROSDVpwioy3ydfpCt9lwz/wuVND1WUigNfKpHaONJuQzUylVUep3dPVODHfLVtxbEsKLMvDPizxso0DNKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738425868; c=relaxed/simple;
	bh=I4MzQGJ/XOlvmg1qM+M5R17X2i7Dg0JfSmlnBulmUM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bhhg6OSB1frEVEgkr1uTdTHxZ11IF4DFY0pk0Xe/IP+RdzggfeTNiX7NsvdFg9L+dNOetg03eYzp2VrMGPcUW8Jl1ddHSNZtHiTsv6aabJFqY6iLLwvZLovoBeJ5QmFHG08GQb5MIfb+QQ81MacLimRiIASzgYKMaLr8Xe+KG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcgn+w5P; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401be44b58so3219848e87.0;
        Sat, 01 Feb 2025 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738425865; x=1739030665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/FHkEyEgm2mZD4oKyZRqvHHFUf2hu9d5AgxmkFkN0E=;
        b=Lcgn+w5P1N8gSVgcRLSRL7UCBs5WcecymLjPn/phHf0WUlxKy6LCxo3kueBREC4Ao/
         NYhqzRIXykrQBW5XjqaFVgjTdkaGyIlUbFAas2QViAfYTULJnzasUm2Utm2UAR0UNVlV
         Tw0Ce46l+DT4flPX4y6uQ0j2zgOWlBMSOC3DzHi6tUHadJQ2Like0HpNLO038hJBfPla
         BYrDfbxdvECXx/0eVF/qISccgD3HFkQzDLu8DicxogE34KUnlOeepX1VhKlfbSYupr7k
         Pjj8kZpt4fLzBDoqJ6Exse4kloEcNajFyuWR1rkrJv7JfvK+WOabpc7AruqdYB/yYWV6
         zFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738425865; x=1739030665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/FHkEyEgm2mZD4oKyZRqvHHFUf2hu9d5AgxmkFkN0E=;
        b=C99FJ2vHztFBVX1LmFRl34yIZF2/WKwMRdL+yeede7gNyeti34c1UzefGCEQKb1B3a
         PztcDmSU2mBM3gdCi4FdbnCGaBVx8LGM/XbWhjD+F0DWh31lH9ucnic/Pm9kUjeKlmBv
         /FdwnUT04pzXobTeL0wjXUiAcGtHWLUCTDScpu3q+v071/elaH04B7XPoNkoZAWB+rvT
         fiOmergYZLx81ee9JTP7/uB7OsUkLLwrpYHCayErXS5nGIGv/QEXrlK3aghVgi9hOfwU
         m+ZdIe0JtuZmzrLTLL+FrPDk+7+3fyD8kLciW1CjJoj3ls0surGrOuPri774+jY1cdde
         0YMA==
X-Forwarded-Encrypted: i=1; AJvYcCV7tX2k3e+jbSo7j3BLEF0ARAup9RtKLSCHTjsYRbzysJC1QD5VWM0b5OYo9VOq36TszKxdKKZ060cs@vger.kernel.org, AJvYcCVwUy58uppuvcrUQ8K03QD94aV1US6i2ZGUmmi2N6ktBsIpa13qCFAfSNHAKlp5M18YvTIrt3rvs6qVhYZf@vger.kernel.org, AJvYcCXtGPSkESdObLci74sIHIQDbXKXzPmU11szYzQ4e8g9sf9xvUakPxiuQKjHuFXjAEkB5l7H5RBSEpdZ3g==@vger.kernel.org, AJvYcCXvp6SYcihgewexTSneuZMhztMEsBZYRfxKHsta8LLdD8BvagXl3HKcSlxH2P8SzybdPRgDFvzTCXbR@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQMsXkfxFRFx8A1INxs2Z9S7Rbx6bTJjewuoarxXTPRuO9X2n
	0BBGxYtAZ27i4TEAqbSfovVJ5W4Cm7TG/l7+nHcGXUdGtvwSa/tN
X-Gm-Gg: ASbGnct2FRfP5oDWw4fqb5n9fNCpyWkdQwRe5lBXSdqrmEmb92V6wGulLS5SBOoKqmK
	A1K/TK4qWNOVyxeXpl9TedEbMG1YaC9mRPYrJz8eJgRcPRJJHwPR+Cg9sZxxiIfhxJyXVzO4ck5
	XUo6Gu5DESI32WH1/HlktIKVM6seS6gi1PQryQqgGKuoNKjCFetWni16jt7Hf5UPZTj5CQNxWff
	0+zMh80nEKflb+0p08nQrEgxLgTp7TBtvw2YgDrNNj4tj7rmEaCEynjbp+Cg9gjsIVorMAv6Uf2
	Jb7LSsZgkZ7KvIZApCCfPonbdXyvAwbvq9n15ORueigxICH+GEcdgDb7
X-Google-Smtp-Source: AGHT+IEHgoBRAFDpT9ajz7rHokftbme9Oe99VBKzXpPXpyz0eK0jMQNt2qgRHPVoygEZHpYt4EeRLw==
X-Received: by 2002:a05:6512:3501:b0:540:1e5e:3876 with SMTP id 2adb3069b0e04-543e4c3fcc9mr4511664e87.52.1738425864690;
        Sat, 01 Feb 2025 08:04:24 -0800 (PST)
Received: from [192.168.1.110] (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebebec13sm777072e87.229.2025.02.01.08.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 08:04:22 -0800 (PST)
Message-ID: <d3c2d681-4f92-4e09-8c81-c050723c25e8@gmail.com>
Date: Sat, 1 Feb 2025 18:04:20 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] mfd: Add ROHM BD79124 ADC/GPO
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Linus Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <cc30cf6859b5e5a7320282709f428cd42717ac6b.1738328714.git.mazziesaccount@gmail.com>
 <20250131171436.00002583@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250131171436.00002583@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2025 19:14, Jonathan Cameron wrote:
> On Fri, 31 Jan 2025 15:37:06 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Add core driver for the ROHM BD79124 ADC / GPO.
>>
>> The core driver launches the sub-drivers for the pinmux/GPO and for the
>> IIO ADC. It also provides the regmap, and forwards the IRQ resource to
>> the ADC.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> As per response in cover letter. This is a common device combination and so
> far I don't think we ever bothered with an MFD. Lots of ADCs provide
> GPIO chips as well so I'd just squash it into the ADC driver.

You may be right with this. I still need to digest this a bit as I 
explaned in the cover letter discussion :)

All of your inline comments were valid and I agree with them. Noticing 
the single IC limitation was great!

I'll address all the findings if I keep the MFD approach.

Yours,
	-- Matti


