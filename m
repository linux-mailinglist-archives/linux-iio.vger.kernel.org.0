Return-Path: <linux-iio+bounces-19009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5C7AA7990
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 20:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FFE7A689B
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412A1E32D5;
	Fri,  2 May 2025 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YzMBEKTq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94551E04AC
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212082; cv=none; b=iqHeiak4Usu9PEGel/dfWOLzq6dAT0K4UVZJZeM3BUk614w8PxDapyH3ZZ6/bRAK245X46l042OyZyj0FXJT9Kh5+C8EZsdl9ayGRRoWOIhLMuYIIo6hqJFfU4zbAPelUIs1dQaqIIeZFuh3CgT6wcgIewRBjr/5hNU9nERAI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212082; c=relaxed/simple;
	bh=etET4InrPZFfLVNbBfsGBvrQq/2AsRr7XUB0q5olziI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baNTYRC7fPysuboCtNA59p2frUjebt5J4DEPPF5VKsGMPrWGc1IuoG/XhhxMInyeThwjSzwpp/IsZxdPSmfn8YDyJUP6N52YqZUep4hhh4Jpa6mcgZyKPSAsixWio1vaTVqVvKB0Miep75XVFHz5wM9z08Sz2ZMHEewgU3YDRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YzMBEKTq; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f6a92f234dso1790116b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2025 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746212080; x=1746816880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0v5QJaDLKj7eiDa88mbshkSyU/5sC59jCX11a9PYWo=;
        b=YzMBEKTqsD+BZdkWxkpGJMWWMKyilOR4Zmp3PXghZcy3XnI1GKivB83PUGRJ7JJfcP
         WBizkXiGkNBXB7WekDSMLfDGYiIqramxd+gveNRfYU8lIt+9wfqHtri86ltsaH3h2bRt
         32xNhvkfGaGekAGuvbxA6mQFwa95xYDKoUv6FxiwcLRMmqlLq4crT3diNsOQ8gfZ2NEa
         Ha2y12XNj1bnuinvNCLjEIvR/CEpA1GVlLjXPvk4qFzk1ugTo6Z23C3eaEfsMXxFig7u
         Sv7ADOTvUbSSOiMMIwQpRGRuCBVOX55zVE0RFuZLwVaZ6BbvU0sgECkOMYkcjGMlHt2z
         ZyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746212080; x=1746816880;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0v5QJaDLKj7eiDa88mbshkSyU/5sC59jCX11a9PYWo=;
        b=NTgupXrQzA+Vo9N7VfDUv5qiz7LVEfO/H+j4mJQoss9Iod52qfDoPd1aZW+9kGhtag
         8FSRAMYI4zU2CkRrAbuwHn5XihHJgtuA3FLXZBOlUNHcDxpzzyUi2Iu61+coT4M029Jv
         CcYIVEikfXRYTJQRJEtG0QiYtZIijo08S/sO1tJ40AJjJzrbiRWWjan79TtlIsDgkVgB
         kxW5abng1t5+yVWe0MHEQcodWomOtJrSQTILKRIHwbDPSwYLv/1H/dGkpMZd3ptvl1LS
         iDgXM3tQFvictfjgrsQDZAhcsWOxiegJo9mI3mSyKlkqg0DNppJJlZfXrs/pLLNqhYQc
         JVqQ==
X-Gm-Message-State: AOJu0YzGamY6HZD/9Wd1YVMBlTR9/RF7ToSFaIoOpK01vUh4uE1ATN+t
	JLpXiCkMioF+7D2zHdAeGKsRSw0NB1TgWLjknAVdvGI6khJpjY8nz2Rexup4D9I=
X-Gm-Gg: ASbGnctBu9VNDff0qRdyWoMuM2Gez/9d2CLAhytKvnMDrhuKlONXut7eiMWOzbH6wzR
	LGzsjC46c/m6+tpeOyv0ILV737VcSuDwlkvP8NeQNWSwi7AEqabehaeaLcu5Lha0ylpJWRRuG30
	HKZJC8hqs9I1ZkGWGswv/WdGfvB/akTYiyQ+D1ykNi6hHPlXbjVQPR1eCXYF0juqzRD8l27Qlnc
	SnVBUkDzEGkJPDSM2fGEoeyCocXpUFZjX2k9RZhj3IFrHV/3A2zX4UGBGmyYnEABwnX290w7m6e
	alb0MrO2aYyXEyKR0Nnmc3SM0Fv9//OdJkGGVZIQBtX5H09+96lWWGR3zIPXN5aX7tbpkYu5zze
	QmtxrDeLExH9+ETOwTQVAHe6PChVo
X-Google-Smtp-Source: AGHT+IGg3NfrHCT9rWDG9WuCsQU3jADp64M+/PiypBGRCbX4Dd8LSeFbkh4aztyl1pAXJ+UtiOQbLg==
X-Received: by 2002:a05:6808:2e4c:b0:3fc:1f7b:c3b3 with SMTP id 5614622812f47-4034148814dmr2250631b6e.33.1746212079887;
        Fri, 02 May 2025 11:54:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4489:d382:ca90:f531? ([2600:8803:e7e4:1d00:4489:d382:ca90:f531])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dae382fsm685964b6e.21.2025.05.02.11.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 11:54:38 -0700 (PDT)
Message-ID: <8ff3f1da-f868-4c7e-9123-00a3c54904d5@baylibre.com>
Date: Fri, 2 May 2025 13:54:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-4-174bd0af081b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-4-174bd0af081b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/25 8:27 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support by a per-channel resistor value.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 29f12d650442b8ff2eb455306ce59a0e87867ddd..d4b8ea51f60be367e79a4db18d932cbca9c7dc91 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -204,6 +204,15 @@ patternProperties:
>            considered a bipolar differential channel. Otherwise it is bipolar
>            single-ended.
>  
> +      adi,rfilter-ohms:
> +        description:
> +          For ADCs that supports gain calibration, this property must be set to
> +          the value of the external RFilter resistor. Proper gain error
> +          correction is applied based on this value.
> +        default: 0
> +        minimum: 0
> +        maximum: 65536
> +
Max should be 64512.

