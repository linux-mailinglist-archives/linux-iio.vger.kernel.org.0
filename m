Return-Path: <linux-iio+bounces-19011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7EAA79F8
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88B63B2D0B
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB441EF38E;
	Fri,  2 May 2025 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NQIbCYgs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D91EE031
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212679; cv=none; b=GfLwtzqTPg/sHopLsUkAya2Wk2qtK1suB109aQqXPE39Gpyiphxk0ZbU7eCbav39ucp1PDAVppWGm9BhUiJCMkOCv5gk8WrEwwhH3sgEr+U+l20SBpfAmuefU1V7SslZGtYLVufU5e66IpW+gnIoE5cf/CdDh2Y4HzQ+0aS1L+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212679; c=relaxed/simple;
	bh=BqtqTKdD0wfSLUZ1EG3RdjGoNfqcNF11h+vSIZQ1Ymc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHXjR/wSY95Eht98ryqU/toHKTHUa3ndxszducSKlaDOpWf2OHUndPmzy+ZQJnIFH7zlA820NJ3kOAMNksiesx+vyk4QWqZRaoFMaFgGvczHaJ5oq9FJ6r2yIp/qwxnLh0Ffx2+oPuaimPtgEiUUj5nyRP9FZlwoGl/ZqGg2pcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NQIbCYgs; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c3b863b8eso1629438a34.2
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2025 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746212676; x=1746817476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3PKLFA2VVV9aMJem6QKMjsF94f7Td0gw1o00ZukAD8=;
        b=NQIbCYgshIHLPb5s/7S2PaxLgdrPqgQz9QxSaL4FZyRUaWiVRsTHZ5Dzx9kXM/C6BS
         eeXRv2kuocbQG+gGzsrThpARB4mhp44abhCoZj3/IgFlX5v+i08F8ckS4wn5HHY+HjZZ
         Y3Z+oE3R587IfrZH0E38b5E0ecGDIyyNpllIOyPYRzTIA+xhgm50joqpRVN6tBjiu4EM
         N5LHs8o3nzDay2CnFGmVDzsnQe9S8s1iJ0CeW9ZM1Fx5eAc6Qr7QTbK6xtFeUCF75id/
         ZsvmNw+e64YbybAGWbEgjZlrTkPQOYHe6YHVeh15dWKzGNch6VgG357dbZZlU+oFmYs+
         A1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746212676; x=1746817476;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3PKLFA2VVV9aMJem6QKMjsF94f7Td0gw1o00ZukAD8=;
        b=i4es/JFbCHXFXy8pu76B/x46PAmZFnN79mKAGzUwXTmGxhz+lIVwgJAjVO9Cg6PeCq
         MMv4SQiIsKbrOxYM6IEbJgAUHcI1K/kLQ/nGzrZvNLm02FiLop9rsUu0bqJO0PR4Wtz4
         0Ygg7ao399nb8d9/GiyasmBHN81NjjX00oYUjdNoDT1R0qLfDuuTn7SnzNedVZmfvb/8
         jx++HIRKiWvUlQ17LHJVlpJZIKPPStYQNN4CVLcfS3QyAznLWrUPoEOmabX0B0mL/304
         WdbpHGI1CxCIdCpmPKDakBFsq2Ealj6Y1l99jO0LBuTrjGzUieC3reyjNn3SVDM1XqLG
         CVXA==
X-Gm-Message-State: AOJu0Yw5nq8jWBN7VR+TLDgkHrFvbV3g4RV4yKzKQyIRFPOl7ERa33t6
	SzYxlTaeTsdnXBNt/sHpiHoRGF+ZXmPnjH76bHvqCT3DmdetmvOrFAGDZ1Y/Qdg=
X-Gm-Gg: ASbGncthjjnYt90Adb40/DT38f50VtNBhQEOTfybj45oRn7O5svK0Eat7+D+1y9U+Fh
	PShpI/q2OLbWudAe1wGjoogvAQCmAfRRoUL+26WUyI27jrk1xLIdo7foehNzocL2t14GO9B3j/e
	CGjw/spoWGY+PpqU+b0h82lNXZM4W1kHhMlxclhzp3CpYJ9yKaQGDHCQytBsYA32tilO+tAB2tD
	0u1CpZQ7kishJElrsbPNJNosVYj62CDsG2Mrl0bFNVwnn4KrGx+FLVMI5zBIqVKc8CwLCyW+dDp
	uNm1Gd8gZqDyP4jDhcYvslbZTWbka00QBWuWV56zioRlk4AqHmOfiz8kB0Tb9V4YiFfibzb2KaB
	sPSzJ1MBcr+sX3NHttw==
X-Google-Smtp-Source: AGHT+IFvwfGrNvE39uQ48bU7A3GY6kQiwC6kAAl9UGMdUVUY3hdyDs8bTqBwhUAODN9l0novkb6Y7A==
X-Received: by 2002:a05:6830:610d:b0:72c:3235:557d with SMTP id 46e09a7af769-731da159bd8mr2434917a34.13.1746212676619;
        Fri, 02 May 2025 12:04:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4489:d382:ca90:f531? ([2600:8803:e7e4:1d00:4489:d382:ca90:f531])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d31a1f04sm590393a34.14.2025.05.02.12.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 12:04:36 -0700 (PDT)
Message-ID: <2349fa18-efbb-44f9-bfab-323ab3ec2453@baylibre.com>
Date: Fri, 2 May 2025 14:04:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: adc: ad7606: add gain calibration support
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
 <20250502-wip-bl-ad7606-calibration-v2-5-174bd0af081b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-5-174bd0af081b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/25 8:27 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
> 
> Usage example in the fdt yaml documentation.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Tested-by: David Lechner <dlechner@baylibre.com>

