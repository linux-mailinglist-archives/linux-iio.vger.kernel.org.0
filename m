Return-Path: <linux-iio+bounces-23595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5133BB3ECA6
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5893B4047
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7E1306489;
	Mon,  1 Sep 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MFN+p/pf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26452DF156
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745391; cv=none; b=V5xwLxn1xf9Jj7jqClzgo1v0h4BT3ufHLfrKFX+z+NhzGh/eJk1bwvDusA5+o3xthdOWw1UJ8E2tpgCdGXvV/2qhJ6Dz67fCEsnVlZ/nn5aW2X/0MosfBWLOdq849MTVi4jI6SUyVk61sO34CnYYCccb2Dsi90hn8BE0/zJFEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745391; c=relaxed/simple;
	bh=iCDOwe2JDN7D20tz+UUXodURXbkHJQguPAdWUx1aBKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdl62U9M5c7LjhfL3g7T0C0vTy1f2RKqytJFXu8Ty/tncsNpgpsimGQrsSuigJY0CeBf5jGQQdFQ1QWbkW5y+hTzXGZpdgejDC/FCDCsszk/z5CRyZ1nhISNauKJhMhlVrt+vaHuf9GfgJMZP1tmaesrtgK5gDY+wgla0RbUMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MFN+p/pf; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61bc52fd7a4so3463950eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2025 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756745389; x=1757350189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDXivowS1hfDO+0A526hQxq99iIj0yuPAX5zet9fq1k=;
        b=MFN+p/pf7Rdr4sVwhW2c7JAp11ap6C5/B9nowJv6rdqWCoKGLIh5GAtveEtIN4UcFL
         xHOOG4ArbWO/qlg6CNUBzjrudmR1gmc+i6qGqWF3UIw4cTi3EbM2Iu3qj1xGiZKgThQ0
         Ls/6/Vcx0bJfc2dGvNvuIBK5Cz8QXGRByKq/YAFFbUwDP4CSTho4JqvwR1LrPp1zJ9Q0
         JDhHCKqAXhsKtJvGyu1wGa2UaB4pGoMKYaOCylGsqNeoHO/hWinohaVCopDkZkiRDAMs
         gGeCb8KDq9Pzqxd0KwU/kWbAY/+k/2X03KUOLTt1Pz6fm910y+LZywhD8+gSaKojGpd1
         93MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756745389; x=1757350189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDXivowS1hfDO+0A526hQxq99iIj0yuPAX5zet9fq1k=;
        b=XO1H70tkJbKLUlT9J62E+Iw4twEJEnYkN6uQBjkBkoe8lVeTd4XCWV8+W8Yz9SOltf
         xT8Ho6438QzYhHb/Lv0hymS4T2aXLUjxW6irPgbmHv1LVvmqbNSwfQDAa+G7hcTWqy1g
         RelImFCj3cILaPoSTZVGpLuymaUXb5k5Pacgi6F/PLVDfbNcNrSzB9ID404KNDBVaCb8
         8JbGq+xVhplbvGckR9EAu0w3D0Nml6NiC8DCrxmlWFaPm3sqkWYkk822Pe5Df10JPjke
         gIbBtZsZrf6BAp2+2AFZxEE0ssdXX8iq99Ck1x3taygwcuaJZJ9AShFSmr7eVDlpYhJg
         haRA==
X-Gm-Message-State: AOJu0YzqVsACcCCwgSEQV5awfr/vucsAF5rFlsY//n3k+G86Yis2BVzH
	jOnJloQsPOOib3qazlVZv7FUQUlLYGZ1WUGDXFRamigBb+eNs8ijrV4zmi+XE0g8KmU=
X-Gm-Gg: ASbGncutzSDlIzeL6CyEI2fAczu46WRHqAq+CVBEMnZe+AHG0vpd+FGK7QWAnmx8Zbo
	1bRDzPUYWER54CLWbF+P0FJNAt6D5y8ko/tRpb9uvxaOvZJyhVBF1+Fq9fw71kHogUDLA4vwxG+
	NG2rVh0gVsYCXyZnssf/r1emyEgytxECcQxNRgL9BfTvtEeL+tlJSmCKlTS9uXICsaG3ltseQnR
	MORpgGjSIVIPVgMdPG7+X02265J/VQUFBGWA2id+vd+6EICYxSTyGwvse7UEjynS38MoJ/xHS22
	pNT64xqsVQ2Tt817yMYx61oGL22KfQ5VQZm8qpLvF/O7/CN0yyUDEAWnal0WPJonffwmTrtfM2f
	U2GA8I+Q6hPLssdpGFHJ8WGugwDoYbuoAB/tC67BgwDWKERpSX2cc8FHSANTK3G54/uj2sZmFUD
	5rK7arFn2jo27IL9ZpSw==
X-Google-Smtp-Source: AGHT+IE0HZ+iWpQczC5BrtTUNwIlahZdv82jHW37K5IFPYvYtCOZVlDUlO7zJReBZU+9WammgJgrxg==
X-Received: by 2002:a05:6870:1582:b0:315:60a6:c28f with SMTP id 586e51a60fabf-31963098d63mr4606617fac.3.1756745389022;
        Mon, 01 Sep 2025 09:49:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e? ([2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3196d2a7f3csm1797037fac.8.2025.09.01.09.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 09:49:47 -0700 (PDT)
Message-ID: <e610c63d-7db0-427e-953f-b49b2b5ad2d0@baylibre.com>
Date: Mon, 1 Sep 2025 11:49:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: Fix a null pointer dereference in
 pac1934_acpi_parse_channel_config
To: Charles Han <hanchunchao@inspur.com>, marius.cristea@microchip.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250901064512.1554-1-hanchunchao@inspur.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250901064512.1554-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 1:45 AM, Charles Han wrote:
> Add check for the return value of devm_kmemdup()
> to prevent potential null pointer dereference.
> 
> Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


