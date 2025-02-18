Return-Path: <linux-iio+bounces-15720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD9A393CB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 08:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C8716F144
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A48D1B4121;
	Tue, 18 Feb 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AODXw9Wg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD627482
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863973; cv=none; b=dBSbU0vkSq9MsfyEKOrnuMeDTkWSVtHDs1wH67aLg+/2YOdQltv0byQ4NessVSrUer/rIq88q8kSJnMVZzyFRcXFfV1OR3K8D3iU1MlYjqpJ35kitmTyhSzLdv9yNXedsC15hzpPrBAc1j3qJrg97haxsblmRHrlw7clcx0QtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863973; c=relaxed/simple;
	bh=M8Q4iOZOBOBDjRuaUK/eyPWTDoDrmq8pxvoSnYtauQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABoa+D3TrRlralRvTW9mmuXsAiJv+j3WpLLOGaApetrJPs0xmJuDRzZKU0GJ0uQHcY6duC9WaEzWPqFbIczgG4bygP8ZhhS5r1N24WJBwy10v/dl1c3OXPz2xd3zBnYWRHE2uJT3bcNkeAE5Rigd5OcWbkcArNck4FS2E41+Kk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AODXw9Wg; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a317e4c27so16276451fa.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 23:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739863969; x=1740468769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0i5hulwMhxWFO5U3tr/p5yxbEdy5uN9qkARKoRgE4mk=;
        b=AODXw9Wg7ePmSfcMCOnD2vQH0p+e0UCl/e9/MQGi0Yd8ZyVx1zxAeJIy2VM/1IAeqy
         PLhMW/I+ipU4KTEbgaGmSyaMqdS0ZxtBCux85Rw0odTR4L3gfxfWTsh4Il4+IpPXv3X1
         YlXX97T8QBqmfpQ+YWrOacPZkc2BRaBdAL+j7+UUpkcJO/1RKi//mqM3KJ7Xfgte4aIE
         IrCb+fSDYPYm2RYdYh0nN1oE2ATZadlMZbBq1dnnFPQLPXZ2tT1qJDYwVY5+kAirevcl
         iKJTZpDIIIRm53YMpqpYM9oUOgUjAWgsoKacMiuEc9rLJX2pO3hlt8dXWDu/hvsGxrbg
         RtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739863969; x=1740468769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0i5hulwMhxWFO5U3tr/p5yxbEdy5uN9qkARKoRgE4mk=;
        b=Ht67Pq8yCqO2ftmvo95s3zCR3G2ZLs228fieErMVD2CyxRodv2I3tGTOyLkWBEccG9
         fNGMzpUH442SD/CdO4Cu1ENvRXcjEvA/HcObaPCaB/3F2MeCpMYTnSwsayDhCt6/XtYf
         h1iq4R6ysI2ieoZKKxkIvPn8YcMGZuyuVPSgRZVIrXTqzTPl8P2mr07W1Nn4/+B7+A2q
         Gg30wFmfuG5pyjXzOEp2GctEnpo8ODkl0KCDAHGxT0WId0BNPkQjaam/AMuu8VNRwEas
         gtsE5R94AUUYbNXhXXUnftxpbTjQjVslRgSDD0B4MruJAhc8FMQaJ/o7kyHT5yEy/pBG
         nFow==
X-Forwarded-Encrypted: i=1; AJvYcCW4soZxHRgrL3Yr9H6q8j39fdUrUXxqjJ55PhD7oM+zm7SLIG6EZah5VB4rds4WdLuCwx4vTxiGKSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79qe1clygnq/Om32f6gscKUByZp5Zn1hbvKLvoKstdBx9jiVt
	rb0/iLhpyYHblZ4hYt4vxTsQ6c/jBGg5YsBBf2FaC/kbumN3HOg8
X-Gm-Gg: ASbGncvtKMED2xL4/kmufg3I4uzM9AYo8ZPTmx6uKewYFLUxNu5ovf4FICbPWSduTqs
	y/i1ZObjg2g2PJc0ibcPeqyo024XziBJ7TQlkTOGxhVWx4lMnTq/0ZTxiQkahuc20RAxDtdcEZF
	nbRsgsdzKXZBLJOAvR29YdPKTxjVS6W0tKbuIg15J/ouA7qve+RzwEytNa4vYTRBV6eFfcEwFiJ
	1y6Gb+PjJjYqTII/Fj5I22nb2EevSohzSqmEQ2x6GVZqshmBtnjGUl2a9T1viX3hitvj7dJAibf
	KuCPpIEGRdN5Owcq5q4lUSkSEMU2JGww6TNB16Lcul1krJAuL9RpSCn8EzHWOm90Rk8KPyPA
X-Google-Smtp-Source: AGHT+IGJq7RDcuKyCabObuQS44f8inxHTaK1td8K5zcQnYq9lcDraXPFTSlZ9bjuipWm+JaTZqfvVQ==
X-Received: by 2002:a05:6512:3ba9:b0:545:2271:3108 with SMTP id 2adb3069b0e04-5452fe6b190mr3522800e87.38.1739863969208;
        Mon, 17 Feb 2025 23:32:49 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5460ce138a9sm966134e87.128.2025.02.17.23.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 23:32:48 -0800 (PST)
Message-ID: <2374dcae-594f-4818-99fb-fc77349b24f2@gmail.com>
Date: Tue, 18 Feb 2025 09:32:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] iio: accel: kx022a: Factor out guts of write_raw() to
 allow direct returns
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
 <20250217140135.896574-5-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250217140135.896574-5-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2025 16:01, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Create a new utility function for the actions taken when direct mode
> is held. This allows for direct returns, simplifying the code flow.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks Jonathan!
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

