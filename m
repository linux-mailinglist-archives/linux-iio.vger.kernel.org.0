Return-Path: <linux-iio+bounces-10101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992998FA28
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 01:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E323B22D7A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B699E1CC8AC;
	Thu,  3 Oct 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ac8N5ecs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D861AB52D
	for <linux-iio@vger.kernel.org>; Thu,  3 Oct 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996452; cv=none; b=TTbTna7cU9EHIbA+kOK9MYw6/pUsQ+ZwZx/8M4R+pE3eV/FBl7LKMeVNFz+OYPYqBS6mqcBcq/YLNLUGMw/mxngtyM2x9fQ6kLDkHpeFiC0ZDX5z7lse3PbG2bT0A462XSmsDgkLPjsxs8v1cbLa2p1QS3CAQCGYX989OqgExj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996452; c=relaxed/simple;
	bh=xXL8HI2Q5MuYpV8UpkIO5E5251rjRrAeA8uaI1xF7e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eh/5geYhPwtGBGoBYuR/ydYO6heXYn9Tkg2DdOZUX59xvHzJgYzLUtbxA2vlyawc/UdwhWVfDNGd1T/7PtRjyzqowJh+wa19gY9FwP1qeaV2U3eCTObAM/OVQknt8ZjORp8insvJZ3UwdrUnJPGxXVcktAgHn+nVusbJ23fFCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ac8N5ecs; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e034fac53bso830073b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 03 Oct 2024 16:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727996449; x=1728601249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHx8yKcSzaq3ypj4Ne3xb34NUKWh4BVjPBHswoexNlw=;
        b=Ac8N5ecsdFSgjYnWqeTedrfp+Sv0h25sWeL/pyjO/6CFiePJ+WKzn717Fmx/v5Ro7C
         ME1g3N8MThb6BS40HI38MY8IMTeUghVng6Pkasp2ToQ+TgxTIlDQtU5fTd9GWr9Gyivh
         7xluWMoX/xccZg6Fb6IPZ+29N1KnvS/VaYqdJS38B1SZ/r2jvfwHX5nIWq418VEZtqiU
         4CiwNklOAXI9T2HSDG/baOeFvYXMd66EXO8vLtWLgb1sYqtyiQXYWczAX9QQaf3wlQ5Z
         vwenxSzC7dBIraVGfIFYb2DEhyUcuHM2HnC9MNhNYszMbvnj0VjsDJHfN73UxbMZsjyT
         z26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727996449; x=1728601249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHx8yKcSzaq3ypj4Ne3xb34NUKWh4BVjPBHswoexNlw=;
        b=LCrrsy5lziVF2+1RuTqniZtHrLhVz4vvNC/mJhW3mx/VCxDq23bQRBB904AjxEgk6p
         +hhYYKqj4EEwcOJgrzJJwwKKg6uk7yCxfqUIfv+te/GdkGY1bU134Ak603eZYod4Vgxk
         CCRJb1N7vq5wCIxLKHlBtyROlvArBHJYwmEMOMdm1jAk7sQ6zZdADxMDtl1o9KS1cQRy
         9LJltSja14gwjqM7jjharHvNNACjAr/124lYjxYpzHvRYnp2ZsQZ0wSfMaz10bXAuHx3
         j8yvnYSiEJFJSSk9xURqyx0RCqhOSoBYa1o5HDpkS0+444dcIfisM3m+YUG35DoK6Los
         TAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg0v5uF6GS53bCQQhlnBIv43IZF/BzjXmRuLNPARKQ0woct0Q8fI9e7r0mRajvk+q3nlnRrpOp1Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIA7Jg15EeGUo6CPsGqs/edCgeV1DJNR9ERbLW8TpGGWkG3r1
	T5VFCnpKD+KSKA0u59ekvAKCJu25SAzAeY9xr8jT0pb7+tTj5p1zP2D1eLp54WM=
X-Google-Smtp-Source: AGHT+IG3vF6tZP6pEKV1o83yOgbiM9LdwC8enpJ9UIwDsPcjOLqX0feW9TsHnjDTMhU6IyqcSNGWbA==
X-Received: by 2002:a05:6808:118b:b0:3e0:6809:ab27 with SMTP id 5614622812f47-3e3c17764e2mr807116b6e.41.1727996449243;
        Thu, 03 Oct 2024 16:00:49 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e3bc36ed89sm625386b6e.28.2024.10.03.16.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 16:00:47 -0700 (PDT)
Message-ID: <28972c88-e5ee-4cc9-8d66-b69897d45b79@baylibre.com>
Date: Thu, 3 Oct 2024 18:00:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] iio: adc: ad7944: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Nuno Sa <nuno.sa@analog.com>, Dan Murphy <dmurphy@ti.com>,
 Sean Nyekjaer <sean@geanix.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?=
 <l.goehrs@pengutronix.de>, Mihail Chindris <mihail.chindris@analog.com>,
 Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>,
 Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ondrej Jirman <megi@xff.cz>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-2-67c0385197cd@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241003-iio-select-v1-2-67c0385197cd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 4:04 PM, Javier Carrasco wrote:
> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: d1efcf8871db ("iio: adc: ad7944: add driver for AD7944/AD7985/AD7986")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


