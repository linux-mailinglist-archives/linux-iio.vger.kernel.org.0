Return-Path: <linux-iio+bounces-15755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7857A3AEA2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C8D1647C5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F91EEAA;
	Wed, 19 Feb 2025 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EVnl/hN5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521B1E4AB
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927390; cv=none; b=um6zNj0EQZFTuE63ZYAk5Wx9iEOaROeLTve7hUAeqmf6fi3r4OiM9ka8EI4Qe6xQGUFdHOrsAWpfNL/eLwZ95+AyL1M/NBMJgXnGPYQD6DtYwIsgi3l1IQ0oa575/Hnox2+fPGRLk3zjZXCr0GwSTC8sZAIlq8KZEQATj256Mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927390; c=relaxed/simple;
	bh=N9HYiKAzIYICHkevEmGii0QS0aosYLi2lJDrliQrdjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVvRyVXtbcGMFWGAveqcjSfwQ23sMMOvZKdtchqjGAVy2iZVBqePGwTLx30/q8OEU5y9Epc2c8KQEL0VQGRRAB4ISa0Dm0q9TmCl/2BCm3TWoy6ICX0OIYw2lnz9GqVxCz1lr9L3rTpEFxhFHZZGSoL1Pb+DubX7F/+LI2sxn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EVnl/hN5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471dc19a6acso36939301cf.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 17:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739927386; x=1740532186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhFcj8FNnOMQY209sd3DQ8BUWimeVSt0pBldsBEl40Q=;
        b=EVnl/hN5WpV0RNCklh8OUnR6IjJMMgXdf11CR+grCtWbi1BcYAHZfs/PkID76Vw0gy
         kb6eoU4fNGpQPghFuEO8Jxs/t6fEgBW7eIWQ+y/5t8sOFgPua6qMbFdrxQKqvbqiFmS7
         FgrVEPRqxoewlsaqCqu9xh1sb1OtKnWRoz7M3T0uGUCZzolksKVjFIcoYm0kk4ifIVnj
         0WEdkHkjnaL4o/x8hzHCDy5bkIrUEhizhsh3OBseVxQ54MuUSX3ybTjV/waMgaTZOwWf
         shoaBlph/Nm/iHZAW1DUEVhuDG3msOLc7Uhr45cBsdXhDETHFeHp21ndYk/Mxk4EbcIk
         CWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739927386; x=1740532186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhFcj8FNnOMQY209sd3DQ8BUWimeVSt0pBldsBEl40Q=;
        b=dRSkLSBNwrmyAV0UC7yCPrhOlgqwtcxuTFin1iSPyohKtvW/R4bekeUkDexxPMC2fe
         DlMUahax1ZOQAia83c83vMkNGZRcImREbTb5lNixnqE5SnonIJ9LF5Tcfe2fgrzb+UQ6
         7K9MefKePbKyRkmb7S7JZnhFRym4tQhhJOQGF4MlEQPONCcJzPi3dxNqQqioyuWTsrzo
         E3PlAG3nKuK1YWR9JfsmfEDKs/pzZJcdaBI0NQ7jNF6iL86WysSo3MAjXr1NGZDZjOT2
         ZBMdwdiD2zx8Iv6/K+VrhD98krt8BTdrGsphOzmlez6bXcOsrhh0eYEkQeTERywbqxrP
         AF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO6uVbYwt7pcrB5yD/gqLy5RqqwxtxNKez5YFMqqvanc6v16Eeupr+m+Z5y7nxDHaqHCNk/gT4yw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69p3/pxDZJvF/BdyMxwh2KumLtygvUi/8MmKxD7li+gj1MFtn
	4Xe4+4/Nd4YJgqYh4ehq1zGjEZWV7i5ovCdojjaDdyqWXI7/lM3OH3M7CoKOtYo=
X-Gm-Gg: ASbGncvDjELdX9IDcyxaWbdKKFhwfvlyRnF8uKwnR1v5cQuBX9U1h2KtFe5Ecm1La43
	dY9OXSM79SmC+tV0iqYV7KxAEa4gYECCYu38bEUK2H1mSMgQQptUVRahW6zD2tpmG1m1VXHJZVM
	kXyeL8p3rzYKbpxkn/OOoZhRbHzpMP5Yo8ST/YrbIyoxLd9Vaj5ZO3pGVGiALj+o2pTm8hj6nUB
	gEacEE880N1h1Gce3pTqN+ct2uXpLC4Fq5IMVmbGKyd+hHZb2j/nlazS5n3/HVsqR5Ygkwtbxbg
	TUPGi+FrFl35TjOPfSRt0lYkFGIrTRzCsjkts+QKfonZ6YD8d6mj0gfQ2xs=
X-Google-Smtp-Source: AGHT+IGIImyr8vXM8aoEAFX4jw+veWvhRzvUOjQ6ykQZGmD9QHL01qCTPEVDTI2/NSadsnBmXDnhew==
X-Received: by 2002:ac8:5d8c:0:b0:472:447:ad6a with SMTP id d75a77b69052e-4720447b020mr53202851cf.36.1739927386536;
        Tue, 18 Feb 2025 17:09:46 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47201c9eecesm12727831cf.37.2025.02.18.17.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 17:09:45 -0800 (PST)
Message-ID: <3f5fe015-20f8-4a88-bf28-86b224bc1349@baylibre.com>
Date: Tue, 18 Feb 2025 20:09:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: adc: ad4695: fix out of bounds array access
To: David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-02-18 18:17, David Lechner wrote:
> I was doing some more testing and found a bug with the
> in_temp_sampling_frequency attribute being corrupted. This is a patch
> to fix that, plus a bonus patch that cleans up some related code (it
> wasn't strictly part of the fix, hence the separate patch).
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> David Lechner (2):
>        iio: adc: ad4695: fix out of bounds array access
>        iio: adc: ad4695: simplify getting oversampling_ratio
>
>   drivers/iio/adc/ad4695.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> ---
> base-commit: ac856912f210bcff6a1cf8cf9cb2f6a1dfe85798
> change-id: 20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-7f16ebc3be14
>
> Best regards,

