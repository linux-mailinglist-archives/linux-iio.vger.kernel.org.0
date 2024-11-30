Return-Path: <linux-iio+bounces-12884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF58D9DF2AD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D8628133B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E419E7D1;
	Sat, 30 Nov 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l4USdOr0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD78130E4A
	for <linux-iio@vger.kernel.org>; Sat, 30 Nov 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732992644; cv=none; b=qyG9un+C0EatUcfSyCRq35Ojgo6IVrf++VJENmyGTCt55mezx/SSt/XKoRt2bpLACRTNJprNe2a5zJn5HzjtlRuOknXpSa9B4o14Bf6ocBqSDkWdLaJ985aLqGiNsrtZKhPCkxavqUDOk8XnK+oDN3gCplCdmv+VBwssZhtmgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732992644; c=relaxed/simple;
	bh=QEwOBohegim/6DNi0o5P9p435b9KwpkcXOXYxL1//f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoRRzCi1zDKuE1TLPZkMVfP7Bx1htF8CDGSp8RgpEhVYaPJQkyDvD0uSLl0YWneHWSXieu3xk87cg+zPRUHCL9ZL42s7vsOkvVEmGtY19Fum1AzvpOv3eKzDsjML7ytjzvoI54yZOYDP34MRYToaal7Y5rm6xbnjFBywtc4vqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l4USdOr0; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29687cd1924so1451699fac.2
        for <linux-iio@vger.kernel.org>; Sat, 30 Nov 2024 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732992642; x=1733597442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I25x18j8ZN6wv+m57NL159iqLWMt9+yWlrxyycszO84=;
        b=l4USdOr0/aWzNAy8FTgxXhc+oxrb2nTALkKkAfRrUUG50RuwkMoEBsTWiKWshpuCUK
         YuC9oTdHLQ3EIOx+DbTmK5fEeOFi9nYnyTvtMCy6eBG942S89aU5KGVtchC+MQntYufe
         mb22FKZYi8Gts9ufmf/zv5slR/CgSLyxtD3i7izpxYAMf0Arf2Q7sM0pMHTtyZU3H0a2
         tiPRzBc+aZIHnRdPaOtiRzcoiyBRX9qwlKhCXECF4+hXPa9jY8iB7mJ3nKEH+DygqksM
         DWDwF8VNo9FYEAGhdj0tTK3cQIWpTKAGomZiKcD5/uab3BvdWAdPD4Kah8AZt3N22b1Q
         n7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732992642; x=1733597442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I25x18j8ZN6wv+m57NL159iqLWMt9+yWlrxyycszO84=;
        b=cfUPOg6QhUbNm3ca/gF2m5qByko36x8tLIx9QPtLSCp2CSsY4oqhl2IXXBAqPNmM9h
         wv90bNcv3xileK6jJf7hCZQHHCRrojGhPfuC8CG0R2A8J983F/0DG3GJlfqrIrw4IyAR
         R+7A1htFImPJx0DPeBcq9BrCLCQqgO+ywFr9ROcO5NEW/zSStd1cLU8XOnZsyIs2hFHc
         GYURvoXmzjGrg91TQg6AXx4FEAJ3qPfvBlu/PrcyOFp09Vju9ch7sJpdiBahsEa03Xyt
         i+XYMVTCVYGuH+xPfh9v2/8QGbzUIjwqifWGb/ba+VPJYv+fjPjzxbdlXyIrPFt0a/vQ
         h8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWtpFqn89zjsoRpVDXwekxhK4lZwx8gW86MsGsLaKDQGZF1sL3AJ61nEs9Jai3xzlEjWR2HvCsIHOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSegFBRF/1ZuQzqfUdxo5rMRp+bOleSbJbWaMhx7L1gDjik4g
	f4Ku4/eu5LJPrN2BNSK4lWCVyPokExRHPAn/I0pzcxTnJaMwk4RTXN6AN0Jnn6M=
X-Gm-Gg: ASbGncu1a7kS4CY+0iB9QIB1uXLclJI+Zb/utzeUahsWX8EyVT4EzH8JH4hrtwMgxXg
	8+V/AeR+Ga8gLuXeHPvFxK0VKTBXGyZVdGbbOZmgO6J+L/bvLXwB+gGraH0zxDI+NNyeFKfa+8r
	PBMcoQrRdfAh3yG3OCV1E9PKkeu4a5S6spvHOp5LaoNMkzUs1rsCaC2PeeQtvqoLo+9Sl/BH1+M
	wC/4Niwi60Qvq1B10HfcJMWSEzsPYFtImXy8xCANNRyr23Tcsz+/ISS+ZFp+P2jKx0teNHXN5fB
	0mWX/Hokd/I=
X-Google-Smtp-Source: AGHT+IHMQHi+XSb10ft1yQND1yWWDCFYjk610SkV9fX/M2s2WKAmpH/Fd9zfkJK5BDgIWnYP03FRKw==
X-Received: by 2002:a05:6871:5e06:b0:277:d8ee:6dda with SMTP id 586e51a60fabf-29dc4198fb1mr14233141fac.23.1732992641928;
        Sat, 30 Nov 2024 10:50:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de9945eb6sm1893519fac.34.2024.11.30.10.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 10:50:41 -0800 (PST)
Message-ID: <2c6a435e-23aa-446c-bec6-6fc4d24e2d66@baylibre.com>
Date: Sat, 30 Nov 2024 12:50:39 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: adc: ad7173: fix non-const info struct
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Guillaume Ranquet <granquet@baylibre.com>
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
 <20241130184306.51e5bb8c@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241130184306.51e5bb8c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/24 12:43 PM, Jonathan Cameron wrote:
> On Wed, 27 Nov 2024 14:01:52 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> While working ad7124, Uwe pointed out a bug in the ad7173 driver.
>> static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
>> and was being modified during driver probe, which could lead to race
>> conditions if two instances of the driver were probed at the same time.
>>
>> The actual fix part is fairly trivial but I have only compile tested it.
>> Guillaume has access to ad4111 hardware, so it would be good to get a
>> Tested-by from him to make sure this doesn't break anything.
>>
> This is very big for a backport.  So I replied to previous version to suggest
> instead duplicating the data before modifying.  That has much less code
> movement and maybe a cleaner fix.  Perhaps we then cycle back to avoiding
> that copy later.
> 
That is exactly what I did in v2. "iio: adc: ad7173: fix using shared
static info struct" copies the struct before modifying it and is the
only patch with a Fixes: tag.


