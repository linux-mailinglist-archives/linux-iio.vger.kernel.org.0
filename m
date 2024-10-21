Return-Path: <linux-iio+bounces-10839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E49A5D53
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635102818E2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC51E0B94;
	Mon, 21 Oct 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoCzF62f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271C1E04A5
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496497; cv=none; b=c0OguEKxM+vj886/S1K9Tb3TsqcDARUjjLPiszSNtumyPlzuFLjWc4x/8VPpYvy4yjBzn2IMXRCExYE1so0tcPivyRC3D+IZtUlywa/YbRQQFVet0KGJIj1it9zxkjeuNrtRklqwU5Wqs1GI73N1NhQA305o4L7V6M/WFCU+xi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496497; c=relaxed/simple;
	bh=mr/NuUq5pOZPEb4fngG7dDCx50cGdqdbNMekoV28qWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5hT7aasHz+Dn8iy2P9s6T+0ydjWalwjGYEx/rYeZiR7qEJSZQQe6do57dhcIO/PexYEssJ58ItaEfvyUK1XM17yXEJshuPO6mwWep7uKWZvFjRkEHM3t05BjDyIlh6e4m3hnmd0UcSj7qFQd4bmzkqWHQTkDaUw/f1U4GI6DXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoCzF62f; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so4257142e87.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729496493; x=1730101293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dF00K0xbGDMz2mGiY4CBaTeGVlNkDdRSl6pBHSSwBoI=;
        b=BoCzF62fTcatjPoHyLZQks4E7Kbt54LfMnydbpnFzB0E5JMeGfVRfKSJRyo8X8j9Aq
         OiR2HgxHax4JVmIT2zNYN9pdYmztsrE94RogaOeK3mYCMSh8oF/k3B29+Z6OFtNGAYkQ
         +78hkYtnkYGLqlN1s82jye6uhxtaWXxTnGr7n3MzgvO96qplQRi5U6QxFyTS6s3LvEp1
         CrdpBAD1d2Diy0r5P0KlG2KfVHwsAbQEGfnlhzBFIGrX0PPo0mv9BUfRUK+wPu5C4Cil
         HDsGIYvZqGOAGg1b2U33fapYQTi9ogs05WxpLOMhhxPoyuB5cqrr/1XdloWOhVSp/H6B
         EpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729496493; x=1730101293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dF00K0xbGDMz2mGiY4CBaTeGVlNkDdRSl6pBHSSwBoI=;
        b=hW2Ky2grikIOugz1XYRHdEiwiDj63m/nGNzZ3Uq1rknSfBYNnOVT0yW7jA1bEPfLWH
         A6KqFgYdFD4uKLxkG+KH+yqyOuQYJuMxwkwsA7NmaL/v7iUpTzqsMy7Ja2QyT0k4SROR
         6ayz9MOdmHU/6gcKQnvw0p3OQmy4Etk7VYEH54V1T88OCQ5TLnskKr0qXYQ1imgX4j6J
         J0fs/E4V8ypyitOW1x2EH6ZlKjVn1FiGV3/zyoZrsm5dx9NsbqNQvckJFzKRtS1TDtQk
         NCfpsrcyijakwAacpIAihpjbukpZon3u+wDV2V8/yogHWt83oAhBbwmdrgV9AMYgy/fY
         0iwg==
X-Forwarded-Encrypted: i=1; AJvYcCVm2ZFSHGeUbbCZTVC+s+ASS8IfYQ8ONlrjXVwkblklLmfYB4pTHBRQuG3t19C9Ye4mQAulCq1t+FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1C3CIadAQig3n+FzOaufhSMZurFWy8lOtstT/8TLgOBHCJwb
	ATKSO2OzwerImWOJN0Bhx5UlarNwpzWuthS6sUqEbQJKAd8zYFWz
X-Google-Smtp-Source: AGHT+IGXvFymgMLJVztxZ6kBLxTQH7nrNZnjiIyYTmWsZ18c2TT9JI4RlaFcqmd2G5ThXcba9hcKSQ==
X-Received: by 2002:a05:6512:350e:b0:539:f1ad:b7a6 with SMTP id 2adb3069b0e04-53a154b2c7emr3462741e87.37.1729496493261;
        Mon, 21 Oct 2024 00:41:33 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e55dasm415900e87.1.2024.10.21.00.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 00:41:32 -0700 (PDT)
Message-ID: <e52c9571-098f-46d5-95de-fbcfabb617a3@gmail.com>
Date: Mon, 21 Oct 2024 10:41:31 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: replace s64 __aligned(8) with aligned_s64
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20241020180720.496327-1-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241020180720.496327-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2024 21:07, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> e4ca0e59c394 ("types: Complement the aligned types with signed 64-bit one")
> introduced aligned_s64. Use it for all IIO accelerometer drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> I debated whether to split this up by driver by the time we've done all IIO
> drivers that will be a very large number of trivial patches.
> 
> The changes are minor enough that they shouldn't present much of a
> backporting challenge if needed for future fixes etc.
> 
> I'm find splitting them up if people prefer.
> Next on my list is to look at adding runtime checks that the buffers
> containing these timestamps are big enough but I want this out of the
> way first.

Makes sense to me.

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iio/accel/kionix-kx022a.c   | 3 ++-
>   drivers/iio/accel/kxcjk-1013.c      | 3 ++-
>   drivers/iio/accel/kxsd9.c           | 3 ++-

For the Kionix/ROHM seensors,
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


Yours,
	-- Matti

