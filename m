Return-Path: <linux-iio+bounces-13533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C555C9F2B2F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 08:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1E9166698
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E36B1FF60C;
	Mon, 16 Dec 2024 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3gN10lS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E81FF7A1
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335549; cv=none; b=DkmMvEiPM+hq/T31DzYQXwUnnyTlg9Byc04i/EvaePhn+iVDIay0ZjvEP7Po1JuoMsDKBfniL5i8kzdxcCJzkpwKphcChVVhDR9tjkgGx327eGh+PVF8h/ZJDP+P1UHDj4/NfqAo6QRS/YB9NgwvAXSzevntXwpwHtDkK0PtvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335549; c=relaxed/simple;
	bh=TB4pKMySUmU+bo2j6i0wtu1fqIogVR+P5haCPwuRkbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2TYfV2ARHVnvIchQE9YM/JDmzV2lRNbJErG4bUSi16BUk3RqpLqRpUf1JbPoqImzd0CZiovFnSbpccV4BHzFTAsIRVvFtpncNifTy7lhOJVro7UuJUlIxCXF7yGWmWsWSyJ3Xt8grA9K43hCnuYpG2bU0t9CPQiYag/0AoJQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3gN10lS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54024ecc33dso4100681e87.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 23:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734335546; x=1734940346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbjnL6rAwA3/0HLJ9bCL9RrjkUeJqWfoDvm/GtVdU/Y=;
        b=k3gN10lSyG3ydgvx4upgozgsepP4MFmqBRPiiU+KGO0ZcZqDJFPfYsLkR2QFW1AEML
         vMt8KtIDvLlfIfdUWBqZeL/V3SKBTeUGNOH9/+TPkNBIRaQpz0q66Y/kxQbXAgsa5l6N
         uQvM6F+c+FnJ9sNAAxiTmIMxA1wQdwARMoleMGKgqYYaNNnIVie/gCV/n+oe5XVqXNVO
         n4if1fqqv0fUvaN0sT3CiQlgBJtDRCzs7k0GkRUu5hR/0/wEU/tTb36PJ5tJOO0DR7Ip
         pUzJP/VInkpRW372HHpEhAc48u5xO93UGMiPOYhP2nMuK5bdeWUVCvMZ4f+0WoVWcumS
         J07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734335546; x=1734940346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbjnL6rAwA3/0HLJ9bCL9RrjkUeJqWfoDvm/GtVdU/Y=;
        b=BkB2nhuz0x0gOVV9hzB0FmOm3R4YOglqyNphcrrToOla7XLH4oqX2D4Hy0f3crKC2L
         V7o6MsDBTR0ZlQQEXBygs7efEiHTR+MBbIztOHgkEJ1nCnLGqJ7XKnxkoKNvEhVLLxak
         +KfKcQ3hEpT/KONZLLGUiR2O4wJZAylyxAODip+ZUqEt0FDR7HjMT15+U98bchNCxUvG
         vVAqaqzxBeIYbRAm68qkRY3yrUBvmFP9RMvQTfUPjLzgoTjuBNjb8rapwmAy5SSRd9yj
         MoER9Hptki/MTuF47ddQ56hvkrrLISL6+veldOImLeRMK9dcKQLxN/CAG/1AmU77GI6i
         AjZw==
X-Forwarded-Encrypted: i=1; AJvYcCV5xbsacUe3N7qWsRQTtNhi/Pr+Ug+gNKa+b7wqisZrF05D0oTX/vJ03F7KJo09UHjBI1Euhiz7R0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/Z4ydHljG82Xp0WUbrpHQObUUv/ZlORWpRXYXxb9ihWbVXT8
	Rc6EnCcTY+p3eKwGJmzRFQfWRcXQhljgnreEGxNYNkQPtNo8micD
X-Gm-Gg: ASbGnct3oiyob+kzSnxDExIMRguyxrNkKPoCXjuUoPZA6UILnsIu5zbQbFB3Emy4zsz
	hwlMVONwG9N8fw0Ott03ePGy83lWnJTqtEpBm2ML7pU4IS/qBce/W+Rgu1CD85dDXg+4T7o3caE
	DinZMCMmYHKWflpMW10jybvl8IPQlr5/j6MzTbMQD+smHdC0F8+vW1q6d5i6wuVFdimtHHzDfBo
	dzXf396nl5LJgXuQG6fEs5uSCnvlNBs3SQ9eJCn1efuiN4X0adorRbF2eYBoL/JnDIOLw==
X-Google-Smtp-Source: AGHT+IHZ3GqmRgLI6H0BqZIjWxWdZsOrr7/Qntz0dsD8aX/6nStuEkZ+Q9YNV2ipfcLKkPuRtZHKlA==
X-Received: by 2002:a05:6512:281e:b0:540:1f7d:8bce with SMTP id 2adb3069b0e04-540916d72d9mr4114665e87.38.1734335546025;
        Sun, 15 Dec 2024 23:52:26 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f269sm753364e87.42.2024.12.15.23.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 23:52:25 -0800 (PST)
Message-ID: <39a7e191-47d7-4390-88bd-3cc347ebcf89@gmail.com>
Date: Mon, 16 Dec 2024 09:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] iio: pressure: Use aligned_s64 instead of open
 coding alignment.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241215182912.481706-1-jic23@kernel.org>
 <20241215182912.481706-7-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241215182912.481706-7-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2024 20:28, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use this new type to both slightly simplify the code and avoid
> confusing static analysis tools. Mostly this series is about consistency
> to avoid this code pattern getting copied into more drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/pressure/rohm-bm1390.c | 2 +-

For the BD1390:
Acked-By: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

