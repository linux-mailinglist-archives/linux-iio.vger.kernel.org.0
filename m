Return-Path: <linux-iio+bounces-12477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256409D5974
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 07:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D391F21D6F
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 06:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1916BE14;
	Fri, 22 Nov 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS3EArA5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF861632D5;
	Fri, 22 Nov 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257677; cv=none; b=mAXEjxl6bIwIVywL/N/bCVXp2xr1RPjUYtsbzC38tBM8rhN9hux2BlPfzn8hc1qYn7WT8G/rmTKww6d5URjQ5syQuMSDMH3p5LinV0zF4ZTFIDG4KWXB5wrm4jYvy9bA3Rhhpds4AHT/Pd24vz58zjPBxO8je4bSvkWhXMCORlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257677; c=relaxed/simple;
	bh=qT67HFU+pJWSoX2UoORQ/o4FlFr0iWQDHlUBdbxNq4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkcavWvJBj3T3pgd3Fp04ZZX7AIw/lSTOG66hxrDSaumE/Rf16nYsfuVR8/E3MFdtScv6h6FwxJFfSRscuqVYLObmgdGoJn/3/HrJ9rRjksKBytwhduWJlXGm8fd1+se4GWpcEwhOUvG+UIe3paS1xsi3KfCe1dBjIaa/sXVq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS3EArA5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso15584865e9.0;
        Thu, 21 Nov 2024 22:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732257674; x=1732862474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcddFwAK1YNeu0WgzYzncUvMDhmlBQjxzfSz1BY/lRs=;
        b=RS3EArA5TGNWHR9r5GZ1z+rWweLT2TuUR8Rkgj9lDwIUmHKn6H8kkeyeEyGkgabkbV
         F34JTZUIntgwgCKyzmMCtRQ2TGvlJqQ7fxqVS2m9H3VLCUoHLpABCF8H3qr83yEhu/4j
         B4CXrVTvn6woadLEUuB/8OgmuXKQ/tzyVE/3e4TslcGceseN2qwa/wm/7Yzb+8b+ux5T
         DvvGU8Wekn4AFJDhKPvQ3Pa7gBvZLAaHoNydzq1aZGsh9tJbtCoESDPgatKMS67lJE48
         eTdgBVD0ZLj/0svVziOVtxZAXe2ms91vkYXBpTuGuHGN58NPy9IsnXYsIhmsG89LqFg0
         DKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732257674; x=1732862474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcddFwAK1YNeu0WgzYzncUvMDhmlBQjxzfSz1BY/lRs=;
        b=lEo87qyAzlZ3qgIUvwAoPU9HlKP4vD83VpjvVGmgn1NeYTYlVtMHOwjrIB2KdrzIpL
         ZN4Auinc/CE5y2K8/dwqdKpDZTmUnOHnwOhU2OaUpVVjGU5x5YLZfMlESH0fhKgHPwS6
         4MYMUseSpiJ1OCl7wBNrPRWwA06Voq38cw9mHgtRa1fvuvy/bG574+kFhu9pMHZV0Yhu
         E+3o1cY0un3b+YrWHWBZSDaPdQKDj8W+yO9rmy2Pu14PKTPdgRPyyJ03NaUIz2M6enRK
         xKfDXvFEOAaVw08aHf4hCoInqNfP5w9L7JH1ZuVO65YwJmhHF684JezRvYsFiTnBEEmu
         WSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVhZbbmR3pz6H/X2czV4moYWz3xog+PQBL/fUC0a2RhIj7RwCgIYwDJAk+2qjthiurflG5Bq6myYJVPxQQ3@vger.kernel.org, AJvYcCWohdSFwo2wqYDbSHpk8XdwAs2msDgxVmZXe0iWnSVWdTUjST37spOj612Yv0jduRh0k0tHJr5rPpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOX/HHoS5xUNcXUPyXQxHKb8QqhByoPxIUHCbaGtt4Lrt9C/5/
	O3xbyOoAV+QETDyznUXXZqzy7IrnsqoTrEvnvrpc2na31IW737j8a0TFtA==
X-Gm-Gg: ASbGnctbehaVMgh7c2A7Rl8rE2Utw4GyG9jzQFgKVFafax6CSGq53Z9uO0uMxkPYV2/
	vVZ2ujHwuFBKf/Csz3NoJJCS4idJQNHiEeRSRqU1DM42Hw4LC8p11/JB6q2/IBHmuPMcHKBIiYg
	C2CT5vdC21Aw5JGcYRvYB97CjCerkpvDbha8DVwfZW7nCboKQiNTYyiIWyqX4S0G0pWMb0Ua3zH
	HOY7MjzvxCsdVsL+I5KDoV2XlYhewck4uVKRzubtd7VIDQ8h0FQwDvTBf0qyc51IUlfRKpUMWcg
	A4WXk1UNRPbexxgv+Av058Hu9MsTfOdVqQd+Kx0ZBVREbW5/lIIVpP6yLSUKqO21d1mgf1hksdN
	g0r5h5yTCDfQ9YqRtHZjSxU/ygyDslLjYHW/54aurS+o=
X-Google-Smtp-Source: AGHT+IEm1gNUblkdNOHfWlt9CjFBKocgwoXIVt1MTuEfZKG6whS1fDcjjyLGJ2ZGAyifUFzufrZ1bQ==
X-Received: by 2002:a5d:47a3:0:b0:382:48ef:b41e with SMTP id ffacd0b85a97d-38260b6b168mr1349644f8f.24.1732257673717;
        Thu, 21 Nov 2024 22:41:13 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:182b:b217:1455:c275? (2a02-8389-41cf-e200-182b-b217-1455-c275.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:182b:b217:1455:c275])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm1516126f8f.59.2024.11.21.22.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 22:41:13 -0800 (PST)
Message-ID: <60096b9b-37ce-4b08-a519-3c607de71c0d@gmail.com>
Date: Fri, 22 Nov 2024 07:41:12 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: bm1390: simplify using guard(mutex)
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732193263.git.mazziesaccount@gmail.com>
 <a4c2f21189964132d245531b77fb0865562443a1.1732193263.git.mazziesaccount@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <a4c2f21189964132d245531b77fb0865562443a1.1732193263.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2024 14:05, Matti Vaittinen wrote:
> The BM1390 uses mutex for protecting the fifo read sequence. The clean-up
> for a few of the functions can be slightly simplified by removing the
> goto-based error handling/unlocking and by utilizing the guard(mutex)
> scoped mutex handling instead.
> 
> Simplify driver by using the scoped mutexes.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/iio/pressure/rohm-bm1390.c | 78 ++++++++++++------------------
>  1 file changed, 30 insertions(+), 48 deletions(-)
> 

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

