Return-Path: <linux-iio+bounces-21557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B90B00EFD
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 00:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F8E5C3600
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E828FABA;
	Thu, 10 Jul 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1rHlFXeZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547E2441AA
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187637; cv=none; b=VBPAkUZaj93GBVEMXcdffi3d85FVfN3G8053J0ivNzP0HdE2twF4MAtMrUStzpw895RgogKES9v4IAzrJie0/DFV+82cT6pO1GHRrXzW4uIN6+FQFI0Eon+Bmsq12p6SvngY1Z1ml1/xgBKOIqFc48MLm/XQpNGpj6ePIttMYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187637; c=relaxed/simple;
	bh=bJbmwm472ijV9x/+fG+outQOQFj7aFSyXilYJxBvE14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMk4mgGK435pOPMHVFXxNahQS+w06c4T91Z49ina2q6FXQHpWcz0c3kIZqZJTG3UQmNIVZbjvgx4kPNO0eW3STpHaE8oOdjjeycBmoR4FSPlTNx+LghWDNxHkQu8utbqHklAnCZ0FaFwvkAyfiu+9lU8+p6LJpab/Ljl6200hcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1rHlFXeZ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73afbe149afso762223a34.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187635; x=1752792435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t072feumeTAfzGxa4JHP1lKw3xCbLX0wu0pHv8qW0gM=;
        b=1rHlFXeZU32fftVXkX73ZU8Z/AZo94y978Jlx8T3OS7Z7KrlluzcbF6R/mUjV56wmj
         1bEnnfHGclD2YIzbOh9y5rMk+aig53tdINkaOrO3w40gHQFGM2BiQ+ii3O1zgwGKf1In
         K8LaCKm3KOYmv8Oe3Ecmn7GFj2z4oLjrrxnbPdK/QkytLfJFAVfUvpKgaKVOaa4rzp0N
         8xytDdEMG2alY/kh+pxIL9mwiVZ5CGDrbqOBtoIAG9BnOaqTl48UoiMWQ/eSClgttPoK
         oJddRIc7ycpauHKWDNu4dulOKT8RNZPdYvTvbwsTDBQ6sAFB9y4eob3YcBPv2OnA4aPJ
         lQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187635; x=1752792435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t072feumeTAfzGxa4JHP1lKw3xCbLX0wu0pHv8qW0gM=;
        b=uJspOt0NqolrGd1eClDWn1wd5GOK7gafT6sOS7RpKY80viOnGvRUL0jf88817xli4L
         eR97ujXmPmopvJVtnhy5t5QPDhcaJ81UI0vMmEdpLkr3QOHH/02IJlC0YEyRHz4XjdTq
         mtYBIoXB36I65MuGs3JoJR6dXfr+WHTISchabE6JBDehMpFCwonpeuLt1wHm0i1pCtnN
         /0O9RTz6md7svnq7QFj/5/vqGGuNOHk4q2YfQcrIIDpAlM/9jsaCMghGJUUudKXR3aK4
         HFBhH17BUl5XG2cp/eK9aO62qMWvX1fYuOIZA2eG+djxjsO+ehRaCCGaJn15OqzG/4du
         5G+A==
X-Gm-Message-State: AOJu0YzFDZ74uu9wl+OfqeW79i1cJXC9oz46wZOC2JMdh9CzCKFAP0yf
	BWWxQB3e9zuSl9PGvUKreKtSVa3sHXr8fY9D9rCjDPS1eWZ/JjxeLIbiZCJK/Uz74eM=
X-Gm-Gg: ASbGncv/zwZVOaPZA+aXqaeb078h5QVKZ8/63dpbs4f4XqOyZbj7tNNOR/+X3gPLTQk
	ZV32BXxasBFLb4eMb2tsvuHJ5AkorNhiUimZU0wGg+QozAvsagRJL/VHfNqHrPvBdmvFCDLgAKA
	8l/18n9N+M5U0OjxMR4IMxXaWxWjkJVoH+bUKeR3cAUVRvH+WBi45AL7SEPYfOj7Y6pxyLkTHik
	32OxnamEM05dE0LMEdpxJ+JbeNrQ7j3QU3/jyFzlnSmrqUrNOEDT6TizapL0IjfTpRMOsKH2HjZ
	EZBRqLZGm9pK9DdA3A/6gToeiO2hX4CI+NgxUyf9c9vzFtBfFLOrA9E98USjgSRCpdemJinzY5y
	Uiy8Wk9Qe/mdgtJKnTagPggZ+h1NWPwsJ1evpctKYMzpxnm0Ked2R8dgCsGASXN3OCVev0w==
X-Google-Smtp-Source: AGHT+IEGL+6L6D979qiJ/G3hRFcvYVKsdeiWqqnUrXSYXPj+VhboftqS28q+/PT6Xw7dLqAGih6RFA==
X-Received: by 2002:a05:6830:418e:b0:72b:782a:56d7 with SMTP id 46e09a7af769-73cfb21025bmr326254a34.23.1752187635014;
        Thu, 10 Jul 2025 15:47:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:891b:7836:c92:869? ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf1065401sm355453a34.10.2025.07.10.15.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 15:47:14 -0700 (PDT)
Message-ID: <29786806-6495-4423-9172-e924c60b93d6@baylibre.com>
Date: Thu, 10 Jul 2025 17:47:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] iio: adc: ad7137: add filter support
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 5:39 PM, David Lechner wrote:
> Adding yet another feature to the ad7173 driver, this time,
> filter support.
> 
> There are a couple of leading patches to rename some stuff to minimize
> the diff in the main patch where filter support is actually added. And
> there is a bonus patch to clean up the ABI docs for filter_type first
> before adding the new filter types introduced in this series.
> 
> This was tested on the EVAL-AD7173-8ARDZ evaluation board.
> 
> This series depends on a bunch of fixes, so we'll have to wait for
> those to make it back into iio/testing before we can merge this
> series. There is also an outstanding patch to add SPI offload support
> to this driver, but that doesn't actually have any merge conflicts
> with this series, so they can be applied in any order.
> 
> ---
> David Lechner (5):
>       iio: adc: ad7173: rename ad7173_chan_spec_ext_info
>       iio: adc: ad7173: rename odr field
>       iio: adc: ad7173: support changing filter type
>       iio: ABI: alphabetize filter types
>       iio: ABI: add filter types for ad7173
> 
I don't know why, but I really struggle to write this part number
correctly. The subject of this cover letter is wrong, but at least
I got it right in all of the patch subject lines.

