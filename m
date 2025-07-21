Return-Path: <linux-iio+bounces-21846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B8B0CC34
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1481B7AC5A8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260E220F4B;
	Mon, 21 Jul 2025 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M1Ro/V2u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29971EF1D
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131684; cv=none; b=YXpUfStGf2rk7uqvZNSgfrwTuj2qbOzYqpt9uPLTLT5GvXexYVT2Bs3RZLIgCB8KehruCQoS5RKUs+zGm2IPwlXHUkYTiF817/VqE8tIqjQilHzeoDlUrsg8GLo0ZHNHjywccErCtwTjdfWLf32vmiR7kwOoPmXCdQC3/X9PArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131684; c=relaxed/simple;
	bh=CMKwmcoyYWnuqYTxRDyFEXVj/77a1Rs4755k1CQKGi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDgnwksF9HuYVTSzNNfDtU1pVVNpMc7toRKjckm63dxxGXXsH9oKHFy+bvaQ/bFKx1gZep35GDsxPPrIhZzLFIegubh4lwQUeynJ5vCyRWwHHKn6FG9wEXtF/Dv2Um3L6uy/FQ4QV2HCQmLFC5391pmAB/IG8kuxFACRiZkpkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M1Ro/V2u; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41b4ebb15e2so2313540b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753131682; x=1753736482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXWBks1EUAciZOD3ioE8/iGRBfqG2hakCkxED7hvB1Y=;
        b=M1Ro/V2uwKxv6dVzBOR1jZZV9E1W6+EfXzG0Zz+kjen9gwjQdCbcNsiDjawHrw54it
         jmFWXN86sZk9+Mdxt1v+mHsSsv6vwc2hgqmgB7DCvp67M2QRyEow6DzI1kR58KlSy4X9
         8P0XiB723gHrJxR81eAAPYj8KJX/ydz/EiXyWOqxXEeNB3ZQdO5QxIIMjvvpCZpBQwtV
         ZjCunRU+Ay1xCCmEihOgNw4mPGsjrwvDxA4RrhczHnZepZb5Irnu32fHUYe13/jlFeaA
         B19VasqxPi7YdXI9NgzMPGyyKXiE2mO4XEq5JsphrnfekhjfEpnFJN0cwZpg4Gu64eTV
         il0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753131682; x=1753736482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXWBks1EUAciZOD3ioE8/iGRBfqG2hakCkxED7hvB1Y=;
        b=fh/q6MD8QeoORNBz3oHpyl4/pGBkszGccsbKC4wxud28gR87YGNQzg6OoFTRJ/IXUN
         bpVH3bcGoOX6tm4LprfyHXza19ZyRL7Y86n0xDqKn0j4ancwuu1NYAU7cYug+hl6UOtF
         Cr/5MtSHAGc+bKh5qOicmTa7o7A/qAjZDJEurjrlPfF5ytqqXsu9YlqmVRG4Fou27T3J
         DxX/QI1X4rzyKjRzHz7loJRRZdziPF9lwyVF9dPGktK9dMg5p4W/ykWDuL5o8yQwXpO0
         x13K1OMHi6hQX7NvX6GDongxY4I/vm2evk1HU6SwoPOqhTYLCC66R5U1oBlM8G4TlWMe
         YUGA==
X-Forwarded-Encrypted: i=1; AJvYcCXgPiEXaM343aAYBD+JkYU/V94HhH1MyDltKEWwzn3qKE5/PTh6w4VEHIC7gBav/fU7xM2sOnHyGig=@vger.kernel.org
X-Gm-Message-State: AOJu0YywOPIyC2t0DrIvBiR2aznW9fhHs9W9k6aEUuAY+zEDJ1sA/YN9
	A6TJ3HNaRRh7us8PuhroLJbMhRkjT9A5Pjt/cQ9QRjZa/J2Op3szELZxXqakuSEeeZ0=
X-Gm-Gg: ASbGncuke7aItKhaKdDsWc5iUyh53C5YTldo/hf+urRpC0wMSP3NZuPbKbOcNd+nJFe
	XLaIZQhAdpIzlJ2Z4cTf0S1n8b83mu5CKgEPrSryIyBme9hEuzgkZKBHkdOXIH83gJB2yH//gwP
	osOq+dRI7e6O2e0JATPyqNbW8e+hCeuvaixtAH47YisfOzEb25teHaPfROrInxb2ZKnHxnyWXrz
	lRnZ7SI9uWvYyKlt5HiR7r1fPTQE5nWG3kqzX+Y+7vnKbxqKgaC8ESMtUj9Z+MkKzdK2ShAGSSd
	5TXbXWOTX6LNJIOk+W93cUTZs3U2ID2UwXQpPAzoNAZFyJqSAJmGFZZJ0qOWj3/KZ+Nmy4ON69R
	wtC1ijFWea+ovg6VvxYLQbvsN1SYODAW9vp31NixB0ggVFfCc5FDfjd6lqqkNs18z2x6d9xLtuH
	MN+K9EvX6UsA==
X-Google-Smtp-Source: AGHT+IEPt2O2BlG+TVDknWLjyVyFRxHH6uNruZppfA/oxvYn8tf3hlEwc1xHZLSg37PVYVenHK/2vA==
X-Received: by 2002:a05:6808:30a9:b0:40b:2b2e:89f4 with SMTP id 5614622812f47-41e4500b356mr12724226b6e.10.1753131681608;
        Mon, 21 Jul 2025 14:01:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd10c0ea6sm2827533b6e.1.2025.07.21.14.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 14:01:21 -0700 (PDT)
Message-ID: <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
Date: Mon, 21 Jul 2025 16:01:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, lorenzo@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, radhey.shyam.pandey@amd.com,
 srinivas.goud@amd.com, manion05gk@gmail.com
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aH4mwkh80TUTNXtS@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 6:38 AM, Andy Shevchenko wrote:
> On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wrote:
>> Add a shutdown handler for the ST LSM6DSx I3C driver to perform a hardware
>> reset during system shutdown. This ensures the sensor is placed in a
>> well-defined reset state, preventing issues during subsequent reboots,
>> such as kexec, where the device may fail to respond correctly during
>> enumeration.
> 
> Do you imply that tons of device drivers missing this? I don't think we have
> even 5% of the drivers implementing the feature.
> 
In the IIO drivers I've worked on, we always do reset in the probe()
function. The shutdown() function might not run, e.g. if the board
loses power, so it doesn't fix 100% of the cases.

