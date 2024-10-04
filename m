Return-Path: <linux-iio+bounces-10107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26798FCF6
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 07:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57465B216EE
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 05:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F23D7711F;
	Fri,  4 Oct 2024 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiqeHqnQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958E50A63;
	Fri,  4 Oct 2024 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019171; cv=none; b=nI2Q7mEKRoCgX5cV5SvkpH3E8AtzItMDTpyXR5J+CZ1BemfzMPyH+3GMjP7XcSBl0H40gxdXaldGC7/u4HV8xXguUjP47cyxdGAM142NRSVKzCsJzAKUtGpq220pgIcnxslNT2uziMCeVx221Y0ppBo5k76cvcvbGKi3gFqRrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019171; c=relaxed/simple;
	bh=rifb5Qs0EZI3qg/Cy8nr0+lrG+rmlYI8cfdQ8Y5cK/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7wl+Qv1UZWl2P0KkWtBucaDAgDQYwcJ0yjPw8sOChZYnP4kk3oZMrRo3AFQAmE58/8iqiq8gPwnublMgPkb36pHFezijFpvqmdWvrQl5rjzhk5ccLqBiABPsmotG2CCTHFzShlFRkJzCM/0xU305hcKdSbJpOhuQqHMws95ZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiqeHqnQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2447534e87.0;
        Thu, 03 Oct 2024 22:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728019168; x=1728623968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWE8BSvHH3boOtqmg7g/otc17CB0Bh5sA87dRFnlFHk=;
        b=OiqeHqnQ6EpY261YIsdGT3TxLXZ7agyN85hhKCxzl5Gf0HEY7tgzNhb4BA/dF4DOi1
         toT3YVh0pZsb8BPlQ6Png54gY/ueXf5tpAQtBiZJ6mz+Ao/R/AEq8bi5ZJQIkB0RNQpo
         sMFJb/Ez0VcA2AwXHGB22uWFKl3PkrBxPEI0/i9Rp0XENcmevWDSbtR+r6Vigr+dJx3T
         OL8gv+5IUCda7k5LHZcB3wyby+PcsqehmCuPtZW7vCLbz3KIQd+dBBqWmxMQot6iWy84
         nQhUXMTFdIQaiYODmVHiB79srUpSsL9kHW63C8abRgYTXkb6l39ajAKvuH5qt+RVkpWY
         89+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728019168; x=1728623968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWE8BSvHH3boOtqmg7g/otc17CB0Bh5sA87dRFnlFHk=;
        b=A/QJ/QuI22ui4MQgIIlS4YHD3BrOkhWvVH5iQhF7lcVSmnosHMCC0plMHj/RF5MNV5
         PNCLpLbvQjlmvdbJ9gyCfVczrzX2adQrB/1qZgpOihDQ5yUq3cTF7oGcSTAVjixjwYVI
         98xx/qpPL1UCzyKTCZo+j/8gKJsIP2guCnFFJ9X3dj8CWXlJ38pB4aKb7ZUqdaJYkWUS
         effSqz823Xv+cvjYx9a9n7h5OmNiKFwnoCub+cv0Br69NzLJpDo0wiHGlakXMYYg4AOp
         pZ60aIoTPavkYG0Husrbhi3LPh21ulf8Dv56yOlgboHO5W0e5VbuTwXHmvnH0Pj3jqed
         0CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0/kXRoAQ1PmvVOGG1SHKaYGXr5vsreCOZ0q+gntvED6/QiKv9KPQ530KXQuDaexG/mfDJSEW09VQ=@vger.kernel.org, AJvYcCXf0LbsEOdA9JxxC5Cnay2vLG2E2t8vwvBDtT7z7pVHnlCOS4r8Eu6CUk+rc5JPV0pxpVsCFFiUfGqHBPYL@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlMxtp2tpxiS2lttJ9XTwQbHM4h/voaEX1Pi0Gb0t90dfVORO
	YqB4kob8Eh3cUgXrKk7IO89G0rYLyqRUmkhovrxbOORuIBV9gOm1eclbYg==
X-Google-Smtp-Source: AGHT+IFJWM/gKcMRRcl5VcdSUpU45n5nBYPypcFSDXfwBz8+cdQFtlYvEopAh+TlHKBYiGXiTcyjag==
X-Received: by 2002:a05:6512:4019:b0:533:7ce:20e0 with SMTP id 2adb3069b0e04-539ab84a2c9mr890802e87.8.1728019167327;
        Thu, 03 Oct 2024 22:19:27 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a8251499sm326129e87.11.2024.10.03.22.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 22:19:25 -0700 (PDT)
Message-ID: <15e6b791-379d-42c0-afb4-b08790d1b4da@gmail.com>
Date: Fri, 4 Oct 2024 11:17:34 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] iio: accel: kx022a: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mihail Chindris <mihail.chindris@analog.com>,
 Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>,
 Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ondrej Jirman <megi@xff.cz>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-1-67c0385197cd@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241003-iio-select-v1-1-67c0385197cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2024 00:04, Javier Carrasco wrote:
> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>


