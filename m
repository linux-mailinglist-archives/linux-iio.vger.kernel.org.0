Return-Path: <linux-iio+bounces-12469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9288A9D4E26
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 14:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6801B230D9
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D251D86CB;
	Thu, 21 Nov 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpePayAR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD881B0F0C;
	Thu, 21 Nov 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197256; cv=none; b=LCQHL3GAnK4tIIUkASlgevbBBpeQpwgryukxebqFAQtN4ES9VN41AnPgz7mxmKNsTz6QzqVUgcMuZWdNGYu/VBgDEQjeiDjRXes1DQP1SkPQvL2khNhtoKh09m6BVPw0elDq+RFNK+4osDVRE9PrRVdxHvWRJM3ZR4C2Ix/MkO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197256; c=relaxed/simple;
	bh=4F2uPZDhl79s/b3GeeUWm0C4ymSo6yl2Vh00rx1jd0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYrFhz2AfWAHCATEPaloKYfKI4nfM700hKodksQ2WaS/F5yFp80Lnc+nqMgkEOPyK6Xc4UbK/yl0BZEJy6FzqXZ/XNnG8pSvWQxjFe/U/IeK2dn35uEYKyFEpOwN8oleFGZfGXWxbDUpQjzhNa+JpR6a1mBZrT/2CmQHYBW4mVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpePayAR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e8607c2aso989156e87.3;
        Thu, 21 Nov 2024 05:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732197252; x=1732802052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwmcWq/IQwazom5lTDenZTbI3rb/SZ+QRK2h1hXK7aw=;
        b=LpePayARxIyf5WK62Gg7p+agNjzokxOI+ucQ/YUhMSEVG9W+Ro81TO3ikS3q2y8Pj7
         Bp3VSsdfPIuZ0jRRGqH3Nfdw/lqxXoiQRb8ubLsX9VRtr4ZcmxuEYY9Qm+OvGxfLvWSA
         coY0ZL5LB2Cj3G4zLFLmvIxONMKlqMVf9N+yq8knS9+lFehX0CiMGflnV7rA9FIOgdEr
         a/c7ApXI3zoazQLvpfYlQ9J09kHdtDhpXGamPId+srdgVUjg+3DWrV1iIe7gWF2R5+2d
         NiKpNW9LC8BgofFEbiIvF4CwZsnZi8g+h0WLzKbGQoRMuirvELiz5uQ6uRi724GIZ2VX
         SDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197252; x=1732802052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwmcWq/IQwazom5lTDenZTbI3rb/SZ+QRK2h1hXK7aw=;
        b=PfcHzDfbgjWbwZF2qCwR7Ox0nN/HXzmISGd3+2bhR3k6LFLEOC3INRYaM7afJegESJ
         n0UR5RxhFUmkp2wcWfkEe2OoBQMfsYd6ny2RJO+/m9R4baBntdyX6V7EDUuNfqIIe/uH
         xVmNSZcOIOTGdX5t5fscc8qFyCj5FdGJArZnffPyFxpC5PtsnT2K8uxiXRJq0stdRQ07
         H2dfOe2YsvWAdHU+rDwX5w9Ljl69ig+DUmmzfxZkKCWwS0PqqLC/SShXXXvImE/pbXGq
         Ot1znzhVicnhYWGcHZQ28b9Jkub1RZciDTdNw2tly+cSpP4OxSAFZmh2u03VOJTcSA7c
         2kBg==
X-Forwarded-Encrypted: i=1; AJvYcCXGWnKNztFxcaf6Nv/o5vMTd+Z3i/hEsP4+PbrlxoqGcYmdpZe5M5K1LKLig5mXjVR0FqthCBa7iFy4OQcL@vger.kernel.org, AJvYcCXbnprjX6/KvbRwDJxPQhNxFLwRLD/0j/M1M5GybKaMmV6nTbWHnNDmOgnGDVywSpE9C6vJDPEXXm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0fQxFVkB6p7I7q5S/PQ2DY0BMh54kWYWSOYIGf/Ja6UrEyHK
	Lm0apU20EZ2PyBRdCnhE4r6zNLjcHVY6y1iLtziR0ZxfCubyHNHsdCAMgQ==
X-Gm-Gg: ASbGncspNVlZ2xapTpLrhspPcb4flJ+jJkm5dTnel71Ibk9Z++f4C8WKr1thrp5TILm
	52jPtY2fIfJ6Qs52O34oHmbtIJav+FMrMdUf7B7VmG0PIWIxeIiEHQIPoao1P01ilS2Y38E+S9Y
	a31CHUA/WmI7jxbxRJ+6R7uTU3H2T2hXf9VBDvu9PxOyM7/LN1OqLfE3T+hXBgbJWM1W25AbGHR
	hH2PQC8PdvuxbGv6H2Z6VQlRp4zIBD1uLztBP4oC5RZrwyWe538HFwhTCd91CbCb+MLCUQOk0Fv
	LzF8cTLm4+E22IJzMZtTsK6X9FSq
X-Google-Smtp-Source: AGHT+IFnvckvHnQVhH3o7rsxtGMkea8ghpFCZHEKE9KCGQ72vQv0aiXs+A4cfd8QImS86LgLcn+6bA==
X-Received: by 2002:a05:6512:32a5:b0:53d:bf13:49de with SMTP id 2adb3069b0e04-53dc1346858mr2699914e87.34.1732197251996;
        Thu, 21 Nov 2024 05:54:11 -0800 (PST)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44efaf8sm1888225a12.33.2024.11.21.05.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 05:54:11 -0800 (PST)
Message-ID: <2f321215-2ca3-4249-a9f0-427004c95d70@gmail.com>
Date: Thu, 21 Nov 2024 14:54:10 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: Use __cleanup for a few ROHM sensors
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732193263.git.mazziesaccount@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <cover.1732193263.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2024 14:04, Matti Vaittinen wrote:
> Use __cleanup.
> 
> The series converts the rest of the ROHM sensors (maintained by me) to
> use guard(mutex). This simplifies the error paths.
> 
> As a note, kx022a accelerometer driver is handled in another series,
> which also adds support for two new accelerometers. I did also patch the
> driver for the BU27008 and BU27010 - but when I was testing the changes
> I found that the BU27008 status is set to "obsolete". I'll try to dig
> some information about the BU27010 and decide if having the driver
> in-tree is still worth the effort, or if I should just send out patches
> to drop it all. Hence patch to rohm-bu27008.c is not included in the
> series. If someone is actually using the BU27008 or BU27010 and wants
> to patch it - feel free to pick
> 131315de97ff ("iio: bu27008: simplify using guard(mutex)")
> from
> https://github.com/M-Vaittinen/linux/tree/bu27008-cleanup
> 
> ---
> 
> Matti Vaittinen (2):
>   iio: bu27034: simplify using guard(mutex)
>   iio: bm1390: simplify using guard(mutex)
> 
>  drivers/iio/light/rohm-bu27034.c   | 73 ++++++++++------------------
>  drivers/iio/pressure/rohm-bm1390.c | 78 ++++++++++++------------------
>  2 files changed, 55 insertions(+), 96 deletions(-)
> 
> 
> base-commit: adc218676eef25575469234709c2d87185ca223a

Hi Matti,

Both patches look good to me, but I noticed that you kept a few
mutex_lock() + mutex_unlock() in both drivers, in particular in the
cases where a scoped_guard() could simplify the code. Did you leave
those cases untouched on purpose?

Best regards,
Javier Carrasco

