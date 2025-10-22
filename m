Return-Path: <linux-iio+bounces-25355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382CABFD710
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 19:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD619A1AE0
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8E2749C4;
	Wed, 22 Oct 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r04J1A8a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9F35B123
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152612; cv=none; b=l/IpXjoENIOARV8bntTkQjJSops4u7BgYqsaLRmmbVdmLxsECmyHYL/HUbFQAbgynRp1jz6pQEVz0QxZUmjQSSESFHbfpMb7gj6q/9m8xowkAz89lTDbnYqZ/kT7wnV0LZJE6Pvclt+ltftpoQcapJJGpQz6xuidsJ6iszJPy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152612; c=relaxed/simple;
	bh=R3kdlrw77LED+wsVg0L5dNH5LTE4fMRX/9gH9I9W4H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQCfUilsF5xuuNnStiQ1p/UXyiHjhH417yiXmj8801Ra557KiejTI0Od/EdE6J54RDZKrO8L2BQLuAi9ruGhNN4cm8BbwCmkK1pFfNCQoeo2O34/KvxV4MDiVA51fpyrLvwIvE889DOo/ivJnWsu/GFBIgm4X7CvyyD+FD4hxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r04J1A8a; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-650304a822aso1567224eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761152609; x=1761757409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwfGThHvmVcSe5ARp0+SHwJ01qbi5m3iOi3dL9nhqHg=;
        b=r04J1A8a59Xj7rlpvS+L3pPlkxMNFUB/C4Y0Xc1vO/7KO1Nc2T8PvX06A8nw/iCSCN
         7Be32PV3OQF7BuiY+/fyQ1OgJbnULv2jxiwwGXMrs42V7w81PoQRv09Kwf52OfMpY4WR
         OD2Sl3ymaVWRVdaweDUZlS5Jf0iGlzY/c8Y8+zqkErGM1B7BmExHxU05ksBxSpoxAtYO
         0p5/nMtWw+KZlESuj7iEuB237O85aYPRTL7LvPIMgasXsGhQKTCtvzpFtrzb1oS3SARQ
         +tsuTFlZvRAPgCblis60Obgn93Bt2quDdUqqF56r+okZhfLVfktmb77yYhrMPKKp3Tu1
         uswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152609; x=1761757409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwfGThHvmVcSe5ARp0+SHwJ01qbi5m3iOi3dL9nhqHg=;
        b=s/l7YhM+QRAoeM2Jkf84ximdYgY+d9js3P2htHpICm7QBmdbnOqXczjUnrk2kK5a9O
         o5cRrdlbEcFmOdHVfncRrdvkt60vLu23SxnIwz6UWrrSy89ntanQWfBlMm0uXs/u3PFm
         jb9nc+h7grpwHrvln5y4voKODJpqBJLchGjhVU9pXX0QKbLs2k70rDADKQXPKpMOxuRl
         osPjT8zfRAB6H196x/pTqv9pRkchJPJcn5kQEBmLxiawNc8Wm7cFhuElFzC1kEke/B+O
         sSVTk5QJZ91MDAMZw7v9+FZMs68PuNxE2Ph9jAZD3U9afs1dYSUvFLLwHdLG5rS5Fblx
         Crmg==
X-Forwarded-Encrypted: i=1; AJvYcCXVuJgQD2lD1FunEgZJntqAP2Ow59JeVkYTBPUg6V/b/c3xZfbiOqjkULTwk4C/vSOsNFJlHOxl34s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2p7I+o65d+88Ono11k83TWG883hs8D1BpSZ3HpA7beZ7Ppsj
	XahyO8mVI4J7vc1NWAjaE+NynknihFoPd05jOm6/pfYYm5T4Z/HcKnDPYvdAh3OvvW4=
X-Gm-Gg: ASbGnctqQ3mmOok0hgryCYzbkIvBz0X/Doyr4hBYO2RRLxYZvN3hEBoSwsJ50zuMAv9
	klos31BC5RQERC5rkmhQ3qIGMEry0XNws1D6nIdelPcQNQ2GZK+ckJ1bGA4a9bVJ0CgAbezOZGq
	tAfaRzpFHaGGcrL8hJ1IP3sG3WX7FjrUZh5TF87L06g0Mbtwt6mJ7l34Gq4Bqp5ZB+xBeEF2Vro
	cNMOgNP/7J5EfajzpAqFj15rsA+JRFn0vLqTSjDhgCcAJ2byJRV98KzkmgRu4qbg5cQ0gR66+UC
	wiWRYS0Q8rMHVDokb4haTTXphM48imAGa91kaDoq9I3JjF1DJuVEgCDFaIVy2KT1mqPt9lYnn13
	ynPHl/yO2T1ZO2Mu85Ur1htIyhXgy1Qn+zV+PMSHDqgZnVkBinhqslVAKRMYW5pNOx7aB7bnH73
	dSIGTuDVsDC/GKUX6h15vcQ55rp7yGcNcHlfe+hy3+0q62wu4ZZ7YmuVPRaOkN
X-Google-Smtp-Source: AGHT+IGYMQZ96Ni70MOY6AUaspj+zxS7uLkggZkCTrutX3cSI3hydzShXPRmiBmHi5D+RoDJHRlsOg==
X-Received: by 2002:a05:6808:189c:b0:43f:5634:29ba with SMTP id 5614622812f47-443a2fb2c78mr9828633b6e.35.1761152609165;
        Wed, 22 Oct 2025 10:03:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4176:6994:bd72:1296? ([2600:8803:e7e4:500:4176:6994:bd72:1296])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65368f34be1sm318640eaf.17.2025.10.22.10.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:03:28 -0700 (PDT)
Message-ID: <0e00bb14-19c7-493a-9629-354bac3a273e@baylibre.com>
Date: Wed, 22 Oct 2025 12:03:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: iio: pressure: Remove vdd-supply and
 vddio-supply from required list
To: Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Antoni Pokusinski <apokusinski01@gmail.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Justin Weiss <justin@justinweiss.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20251022164154.2994517-1-Frank.Li@nxp.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251022164154.2994517-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 11:41 AM, Frank Li wrote:
> Some board designs connect vdd and vddio to the system power supply. Remove
> these properties from the required list and make them optional, since
> drivers/iio/pressure/mpl3115.c does not use them.
> 
> Fix below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/iio/pressure/fsl,mpl3115.yaml#
> 

Why not just add the required properties to the .dts file?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> index 2933c2e10695e..04703a01cf7af 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> @@ -47,8 +47,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - vdd-supply
> -  - vddio-supply
>  
>  additionalProperties: false
>  


