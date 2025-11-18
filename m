Return-Path: <linux-iio+bounces-26294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20486C6A48C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 142414F26F9
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5736135C194;
	Tue, 18 Nov 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h10hpQzZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30593570B6
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478847; cv=none; b=Mu2GoyqgXGZKzSEfl3pwOBau7Fm4fq8wquEMMUJXyjE7bFKBiL4+khc1E8tQnf1XWPJ5XO5vkxEWJy+5AQaqqoS4SFpUMZ42LylAqJz1MdmeKgzVt70U8EWy8UzrZZEYVWxKe2XltXUeauBhT3ybRsRXHK56uG5ISRqE1KqCtoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478847; c=relaxed/simple;
	bh=RQEpkMOuZrkK2YOaBS1E2tkJQCzquhBcELMN4PmdBYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTU08W/jSXmFYZZo18WViBH44y8/fZI7Yn5x7LQ4DMKV1TbUQ2oicjOtaqMUKvzFRk1XOuTXwK+KXAcbAPlaDbzBoHuHhBlJEDzQnu108bORod1QK6Sm9HRlNB1yPq+eJivZJxU6GA62EyalG1X/QeCCG1ez1LkQmcwnXjyGMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h10hpQzZ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74526ca79beso4293012a34.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763478844; x=1764083644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7r+XsMefqJ/y0he7o52hSgDRc1AgbWU6XIMPumfhemE=;
        b=h10hpQzZhiRDc8VKxFw5gOSYNAEYiA8bADvMUjzqXFTNVCt2AWqByzNsxjZKGTYFtV
         38opdvK9g16QKAw/i4bb6YOxN7YU/chaCRTZEQpF/gnHvJ01GnoPmqrmSr9d/NzIKjFZ
         epvipRbrlbxUrGi5UyUqWINMKfLNKSlwM1OeN+deQXggqKM4OBpArycCKZISr5dORbsE
         p6T3iJT9FDW4vARYwsS5YK9QQ+nJW9kAmSoGHXCPbo1qlAuL9xgnmKXgFYGFsngDYjm6
         08jnaYjI3FeqT10XeXC5CUVUfOUz5DMgaOcL4mNAcKKvHnWe67xCUBfzYnjsWoepoIJe
         SErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763478844; x=1764083644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7r+XsMefqJ/y0he7o52hSgDRc1AgbWU6XIMPumfhemE=;
        b=Moj4ogYvDDynpNTSsq7dTRB94KwIuRlVLukBNtbQCFT6oJ7XPMrKhgZXi8gIthTQJu
         TqLF4gUP67+g3poLhvLwQESMkmfZUxlHINX/tldYuVIz593NjEG9x0Vo86SZ2w5BhmuG
         avbb6fXqPKE/QdREL4ck4K6jBWVfFsJazUTUrT4JgvKKisEYekBLs2Pi04WZs8+x3EpF
         ZJLLafgKOA+QqwnTOcjb5ca/DupdScVpMmgAh7MUAJzJg2bqZRA/AsGWC9wFgBWOvDXo
         LWnstqIfpfVace3JsqDiXQwbNbZfRycfLSWr3Rc7FRfN1imS4VeNZP/9bcLpUpSMiHbD
         wPww==
X-Forwarded-Encrypted: i=1; AJvYcCWBAgArbgABPI6a7hmYNwPhZM/HBiodXFEb/p7YDHR7rkfDEJrgAmwukLZRg9eZUl5cs4Zo5z+LGAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKwyoY9aXWxxmGrfkFKeZUWCernWKjt+lHC5RUIHw9fxZpG/A
	ECcwH5krKNup1Pkg47tziLa929LA/c/t5+XkwIymOa4DUPGPWq7kl7uShPDxEbO0fazXou3QPU1
	5GOcJ
X-Gm-Gg: ASbGncvQ87HMSz0EWtxGBI0Yjj3v+6xTSU7ZzgHvMQwarsw5qGB2WBDUcOYED922lV7
	Ajyk5wW7Q4ksW5Yt8MrmSEnmr3w360zFvYz/q49BGk0u6i+4pHxOrXl85kE00m//CQ/A09tYNg0
	8saPRIZfkCMzgrta0J2wzi//kYppNK7Y+hulwr5qF7RnrfIosN6Bka1sqSZjVbDobSCUOjpEVjH
	ZXFWYkQBKyfWOYBvPm/xlAPfs7gM0cc1QKGTHgLwZn82kMripzCyH2kkxEpchvhgaUXDEGdRNMe
	H2S8o/jN75bXWRCRELzdZYYneNqjce+H6wiJgzd47Qapr2WPHWjeqyf9DzDyzZQ/n3OSBcKukVS
	832TazmgMXp3l9wzpY93VQDz8tTwWRvZk7hb6fh3+CwkPCNlTtW+2g0646J/vMZYIMkT8Uzmbnq
	8dYkciTduMaXFbmojtJHw77cowsjUMUMQeIynhFED+fG0IAysImg==
X-Google-Smtp-Source: AGHT+IEA9iyMjnN+s/VcQjXsmQfU+gFhguO8C7imemBqcQRzFsisigJn/msgaF6YLKJjnXyFesnCbA==
X-Received: by 2002:a05:6830:449f:b0:7c7:c71:849b with SMTP id 46e09a7af769-7c7444659aamr12422176a34.14.1763478843932;
        Tue, 18 Nov 2025 07:14:03 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e86:179b:44b8:cc2b? ([2600:8803:e7e4:500:8e86:179b:44b8:cc2b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a3bd060sm6627007a34.24.2025.11.18.07.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 07:14:03 -0800 (PST)
Message-ID: <39c9971e-a825-4d43-b28d-3a7750c6415a@baylibre.com>
Date: Tue, 18 Nov 2025 09:14:02 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] iio: adc: Add support for TI ADS131M0x ADCs
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
References: <20251118141821.907364-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251118141821.907364-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 8:18 AM, Oleksij Rempel wrote:
> This series adds support for the Texas Instruments ADS131M0x family of
> 24-bit, simultaneous-sampling ADCs. The first patch introduces the
> DeviceTree binding, and the second adds the driver itself.
> 
> These devices are not compatible with the ADS131E0x series despite the
> similar naming.
> 
> David Jander (1):
>   iio: adc: Add TI ADS131M0x ADC driver
> 
> Oleksij Rempel (1):
>   bindings: iio: adc: Add bindings for TI ADS131M0x ADCs
> 
>  .../bindings/iio/adc/ti,ads131m02.yaml        | 208 ++++
>  drivers/iio/adc/Kconfig                       |  11 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ti-ads131m02.c                | 968 ++++++++++++++++++
>  4 files changed, 1188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml
>  create mode 100644 drivers/iio/adc/ti-ads131m02.c
> 
> --
> 2.47.3
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>


