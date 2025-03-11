Return-Path: <linux-iio+bounces-16741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D510EA5CF1A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 20:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2177C17BAD3
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BF1E7C0E;
	Tue, 11 Mar 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X3St/9vI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD4262809
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720574; cv=none; b=sJjW78opDNkdxbir0xNhaZdGud9WPd4LRGcPt/tfDOOtc0Y/XhYWIhDsA76OdPvIPIOPJCOqUzAR2ij06BGFII8+4SQw/14YywSeqmKafyW+5ti7B/nwp6NRM/uFQnq62PkakZqF/BVUNL+ndpWFnB8cvMFU/fTy6fyIo43E5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720574; c=relaxed/simple;
	bh=wiP/wrqIsDjmStBKGQIyo+Y332398UmcUWXEcyK0TNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/6kD3g/sh0hVeOLikwuMXsLh1txbzuX02AtDZZ3gfbir0iOibVHylHd6cBkX9n9qBXs7SFUJp4sDWfoMM5fFXXQCQaSRzE51miRcP1V1URI9o/4Y8qx2TRm1i1rJPCohP5s7EU0xCiRFHEQxDzolwP9kEY4icMffkt3A35UlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X3St/9vI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72736498817so3012176a34.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741720571; x=1742325371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9egr+Lg+UBJMz2VXuWB7AelAQ7ytnDgCpHTXLqPTJU=;
        b=X3St/9vISjLLd1FIdk3ZdQ1zVHehjzbIoncCo6lavXt8SSsD7eWlIfhztN5ZjeSVTq
         fFJzzFW2u0JaGQaspoC+B1NxqUfUBL1k1wiHEImlZ45XRRxirALU2wxPYZDiZowcgPXC
         kNoqc/C8uGk63qpBy0kAEywefoVG3594g6wr6zBz27VCzyVwuwibotqDiDqCJWwIZTTk
         H70RjmysizDCBmGrf3LVo2RynffikQZGE44EzctEiTD2Q4hLp2iRWVmn8aNqDVH/Unw9
         QLqdWS4XRuzPtaknlMgZyyuTwYz2GZM8BOYC4bQlLov1yp2e9hzODfNdMCDoSQPlYni3
         7e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741720571; x=1742325371;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9egr+Lg+UBJMz2VXuWB7AelAQ7ytnDgCpHTXLqPTJU=;
        b=c2MibI332XrFBm6DXW9+RKDCo9jCb8gQqMploYghDz7XecOE/qjBMPlQ76nOaatnej
         xP9I8SpexkxBDfrtFkZ2b3CkyAVeIHfhGZOs53C7eiujf4TgKlpMg89xnI5tGU6i4dsO
         Eid6cu0P+KFofVIQdMAN3h5mXIm73u4v1m5lpBuYfRJJzqIc8K0y58flp+OfyuHYQZej
         cwqjSQ9SZFnKKIZhxVQ9zD3dqwg28Avx/SgZYZLSX0Sbx9WkeB9Li2HApHQag/bVHPCQ
         aeHuatu8Ezoy4yZCTJ9dlFNiGVR/hcHXBCwFFuaQn2T1peBXdS3CHu+LwfgpClOEaqdV
         MCvw==
X-Forwarded-Encrypted: i=1; AJvYcCWZiRiHuaeJtVZQmks6QsNUeULVPlPcPbFb2aPqeZR0CBb0PmaxVlLnhNEQH303yupi3tYyAIBZzFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqm3hYreMNB46wTd5J0gRDvtOsR09KHxDLT7IeHPz44qZSoCpa
	l7iHYWf/y47Srsarxx0Y80NSu3ytlkWq2omCRfQPjnPrZtzIF8qbqY3dAhNqwzg=
X-Gm-Gg: ASbGncuWocii0e5KcFwlAQDSDU9LJM6GCLm342CEn/RFQrx42rzi8MzxWMDsDqD55lR
	ZQySo2WYg9KOtxNcNWjY4a2ZmnZl4loSuJYHPUZUTecVEYZ/PETb0sVbgIgRJgv3qeakNt0PqMN
	FjN4gC/UmDo82NK1IS8lgYQznJtdTnANIYRq97DiWHRavgKScTeHbQy6qA9vBclUGasKLoSAa5+
	HJk7a/1Xqptew3bNDQ3uWIMHHAUIkRAmO9xw5QKz9CyLaWVYB+UWlR/eByfoWcByeJ41Wwwaegd
	/O9EuG7aEMAkH9mxkFM/HHWzmTbwWtJ0i/1CmoVdKgtmPgs6hCOhvRfATvX2ZngOA+KwV95FYzD
	ie+Xw4g==
X-Google-Smtp-Source: AGHT+IHQOkg2cCmyGIghbViSSX3+PQ6vojua5L9Ak7LIMFsS/nKWiUSvRzhQwLxA85imhObE9Oq6WA==
X-Received: by 2002:a05:6830:3e93:b0:72a:48e0:445e with SMTP id 46e09a7af769-72a48e04505mr4985093a34.11.1741720571217;
        Tue, 11 Mar 2025 12:16:11 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72b8000321fsm1282934a34.22.2025.03.11.12.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:16:10 -0700 (PDT)
Message-ID: <18325a18-d047-40c0-a3f1-dc0f8bdaf2d3@baylibre.com>
Date: Tue, 11 Mar 2025 14:16:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] iio: light: Sparse friendly claim of direct mode
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 12:06 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note that a number of the drivers touched in this series have no
> obvious active maintainer, so it would be much appreciated if anyone
> has time to take a look! It is a large series so feel free to review
> any you have time to look at rather than feeling you need to look
> at the whole thing!
> 
> This is effectively part 4 of what will probably be around 7 series
> focused on moving from iio_device_claim/release_direct_mode() to
> iio_device_claim/release_direct(). The new form is more consistent
> with conditional locking semantics and sparse markings have been
> added that let us detect miss-balance between claim and release.
> 
> More details can be found in the cover letter of the first series:
> https://lore.kernel.org/all/20250209180624.701140-1-jic23@kernel.org/
> 
> This series focuses on the light sensor drivers.
> 
Made a couple of minor comments, but overall looks OK.

Reviewed-by: David Lechner <dlechner@baylibre.com>


