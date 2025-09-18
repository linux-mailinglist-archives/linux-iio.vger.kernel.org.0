Return-Path: <linux-iio+bounces-24274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C1DB86AEA
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 21:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002D7466020
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE012D8383;
	Thu, 18 Sep 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ih3qsp01"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540C2D47EF
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223948; cv=none; b=Zb0kpj8W4lC0bBu406B/n+NVHtboOX29TwslNKydskUEC2ERnq/y1rYnxCna2Nlu6TYngiL07l441svGIW9qyo4bNu1hNsZVuL7WVXPeMW148GDOh8Q/Sb8ZVTP5AUbWCQCjJiDsPNuJguUeKr7aPe86ZVLOHczStiva4DFnaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223948; c=relaxed/simple;
	bh=qivYkST2C7b7yAkJHzipE9NJQefbbXWWzWHSNDOD73w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QK959b1vKvzjnslFQncB7mN7pDyAfobQIsMnKR+AwB8F5wEel9sihX+xaNC2/j/kUPlWLpqzqVAAagUx3JXc6PBFyNggS5bOKTr3+/dp3OofGSm7MsSj2RseB/ZCQBqJgGAexFcBg5Di9F5OVV5TyDHHDyXA7dD8cAjMvIMGPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ih3qsp01; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cceb3be82so1074927fac.2
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758223945; x=1758828745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uC46HYcJYoz9+sBv/kVNcz3yRxRfTKz6LdiKNeN6Wo=;
        b=Ih3qsp01kdSLJ2q/2QwIxMJN0GL/kcgzGrUyckPu227ZjWJJL6W5yap9lRy34m11MB
         vGh3SJARh2b92Ugt2v4SFw9IZmd+529d+jyiTZpZeRJdPCTrBy88Meg9O0cOaww1R6Qh
         chRmJ9UYbcR/ZXARIo7Jk9E27jp4RBVgBWQz6Cmz9V/bJmYHlffS7Q2xZsMdoY/5ub0+
         kvPCv7ecBYr5MId493prXKdRR7MtW70zR3yfDi5WP+6JiVNJE1g/+8kM7BZzsfB4vSyZ
         V+OYmP/VIUhL9oznThYpmBe5OHyFZ6Ryd4pRfqhZm21ILSWP54hW++EyF0Nv5dZcAeic
         ERrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223945; x=1758828745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uC46HYcJYoz9+sBv/kVNcz3yRxRfTKz6LdiKNeN6Wo=;
        b=n+gvrJ6iZWQvK4DzP2EqxXtoIRDIT0gSksG/zBt4CFl5nrG24Zh7ipvWNPxq/EWguh
         GSoA5Lri/52pE8R0uha9EEah+tFlQn00ezI5ypQZVehHds8IL/MQqutjbDeL63M86qFb
         xyDCReR5YZd9LmcgCehMspvmC96wG8BBcOKGUEpdCQd0TDDB02Mlfd8GQYa1PBPx7jxz
         CNpjEGJe3w5enQGgteICGVOpX4zHMoXcJ66U0GfkGpBJMBh/mwU01iX6ONRF33xyVXyF
         m5GnDZob9Qw31mCoJrZrFL19dS42G9lYK3g5ywBI1ZfqZd5BGnObjWEqdV3tsC1u2I20
         R8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWQpeXWOr7mlhbaaTDiCNuE9q7QRoeUgKDyES+qHRJkvMXB3Rupexub0c9febmREIzouWONnnSjABY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRo4+9ArSh2M17LQkQ7o1EvBKTw02ibTuCn9JYhBMjODUj3Kf
	lokd2QzDTA/sOVJnf6qYJgLdZLZjJB3Uziv3wMKSNIY8uhsfUbZ5inT/rIZJtL7X6L4=
X-Gm-Gg: ASbGnctei4EsncLmnCKEx0kUKdN2tHzGCeaC7Hu6A67SK4CyYu42gOzCRnkPP/ilKm5
	D8POepvPrapjxs58onsJwlTFMTUjlK/lNDB3jRnDt7PXPAJPJ/4FQnC5xu1zBeATwoYbU59pdgu
	yBCZOB0LgW0XKKNrMD4gzTguoMCZvF/KljNy/hFj75GNi/Jy3ZUV/HvOU/CwOreZf3VJhmPG/R8
	DX6uiR70iRo/YJ/p3U+/DKrMDKnj49izGsRIpUs2AUDiQ29kYNqNe1nzcv0btfoDU49jSqO4b6k
	G8J/h3Dmk+PSZRL6Ir+cS52spFF/IjwxfCCdKoaCF2sFakNPBSGDTdTo6oJZW3wr3kHqUvgbXMy
	7k/s4Ou2ohKHP+EMS9VC2/siAs1ct4y7dCWXs92PZatl3jwmrUfPCzyhfru50lYHdmwH/Ug6ZiF
	Q7IpvKoxikFn3fB0Xc7g==
X-Google-Smtp-Source: AGHT+IERFs5Dq//LaVtzyCCdTNAhiZ4f4o05CjfcgmjDwNiiOFdseuqJHqY+PhbFovbfmMpCoV8JxQ==
X-Received: by 2002:a05:6808:f94:b0:437:e3ab:fa02 with SMTP id 5614622812f47-43d6c24f008mr346527b6e.26.1758223944929;
        Thu, 18 Sep 2025 12:32:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c6bcb8asm1132156b6e.8.2025.09.18.12.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:32:24 -0700 (PDT)
Message-ID: <280f7145-8800-4f50-b316-3a604150a980@baylibre.com>
Date: Thu, 18 Sep 2025 14:32:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] iio: adc: ad4030: Fix _scale value for common-mode
 channels
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <b05f763506fdecf0d21a53dde82355418d6fb915.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b05f763506fdecf0d21a53dde82355418d6fb915.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:37 PM, Marcelo Schmitt wrote:
> Previously, the driver always used the amount of precision bits of
> differential input channels to provide the scale to mV. Though,
> differential and common-mode voltage channels have different amount of
> precision bits and the correct number of precision bits must be considered
> to get to a proper mV scale factor for each one. Use channel specific
> number of precision bits to provide the correct scale value for each
> channel.
> 
> Fixes: de67f28abe58 ("iio: adc: ad4030: check scan_type for error")
> Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


