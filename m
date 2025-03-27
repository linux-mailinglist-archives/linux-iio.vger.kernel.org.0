Return-Path: <linux-iio+bounces-17287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854ACA7367B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB09316AEA5
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E491A2658;
	Thu, 27 Mar 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nxF/g/+u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320B19D882
	for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092069; cv=none; b=NNY/rfQn25z82IGWF1ZnD6JlYJDfhtkxGfhtSWBLSAlmCcDO+UDXORXrCvayGmX1YEZuu6oc+U6s2tegNC3ch2P/9M5IGob3hFqODzuJ7GXZK5lM1OXvO9lMBEnhjvGCJ7PXK2Ok3AAXH+kTRy0drni03ixswL0cyt7Uc6ZMx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092069; c=relaxed/simple;
	bh=GNhVFB92K5K7JKIG4jp0Cs6nn7gAJCe0a7Uemu1nmnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmVbr4WhbqYukt20NhIekMeWTThzE6yjHV2vFgDjlvflJMnbLKvO0aIou6wYf6OM+2hQa8/3aiToiKYjGIMVZk3swI9vz4VZgpDQu31oufyeKLzfOvBbnDC+5awk6tIhakzYqe9glj0WenFi3p1y+dVrEVl7pBD8BatUiwwYhos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nxF/g/+u; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72c40235c34so383673a34.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743092065; x=1743696865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBGuzgbgjNkNQcqVUiXqm271oXZ59Yt1bKTopnf6yGI=;
        b=nxF/g/+uqgnCDGfbHIK3MTUOKyl6X0UaHqew8MyVZlaGhor9RneQnCFGze43fa5Pfu
         He2fEM8KXp/hm9SrEvZUd3JLdFMOG2UmkMI0s4nJRVtWOyPG8yxtJlYiuYw3eIXpGnWN
         NYbNU5wRoRzDc13nszm9uXUW7RSK0gsxM/DGFTwLFgM3B568FvWsxi+t7kr0Q8gB7Q0G
         QJKT9394hFd6q63Key+eeslueFANbpvh6ommClB7hPqhe7ljgOA2gx+aMOlNGjJzi0DM
         sKCUr2tBBgGKMB6XmoGxUc+IIwEHiujHNe6ClngjJgBVkgsAdEKmrKRICOCgkxonh34/
         ZXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743092065; x=1743696865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBGuzgbgjNkNQcqVUiXqm271oXZ59Yt1bKTopnf6yGI=;
        b=cYH8rcW2XVVfVPyYWLR5lcktTYSKe2yuULy/rDuKNuqXRb0oH8XbHGSuk2C6X9zXFu
         S1iuN3dT61yfyFOlzGgs2L7katOOzFZReabthD5kch0W5g6Vi6Y7KjQn5QDCWmYTJl+B
         jibYAke1sLaxxrjFW+g9j3ZwZr2fevnwbhDExg+zKBmSk+sBBszCU30o5DetSdx4K3uN
         OQiTMxsIT6XxocH4bFyEKhnAOz+56cOiGSMiXFUnd6F+oJbFXqQVonujqCcHpGcYWhT0
         NZMqZhDvGVkUmgqvnxOahADGVhZItXOPzKvix1WqaKRKyoVAEBajFg0NVkqU5xF2r2Yv
         uiew==
X-Forwarded-Encrypted: i=1; AJvYcCUgx3fCJijUKmliwnqAsjW4Is2G7vDE2KUH1wUpLnpMAXxy3cuvNwQ8D+Znn9P3lwq7RyiSqc2KxMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9fw4zbXuMRMXDcLRX8tAXc2GZMjEi6GEazhZ43Uh6GXqy8Wu0
	UiN8Zt+rmToP5jlnj0UKypNNSCwxX5NM06AfnBeiGCAqKrHIrUVzCA9soGW4Mc4=
X-Gm-Gg: ASbGncsWKzyrr333zdXQhHMQ9Rt2xfZNSWxXOHfG38z4F2412pTPnEycoXbXs/aeTJ4
	vtFds5Y7jBOGJDvw4yK0x3kEWWVDWqjbDzOs9IkyvDAs3aoSv3itVajaRtL7uxlsCxOkKRxGXx7
	TD9qa/UenpqFTNe6Zx+VCm92JuKw9eiYGY+2Hk9B6/NsZBYCev89MkfzER0unaxR4vUKrqiaG1g
	GLIigQ2APvFXfJBw0J7ywU4/xLgUL28m+3Tp3QyML7ThQyITrqcgLTEyoPvTxeggWebSaHBdBxb
	HYOL9qZKtW3rDVfL7Z5SOXODZTBbEMR689OWeGfZmGFVMv4wLbRJisrdMKb5h9m/1w4vjXtWeYD
	7+YTt+A==
X-Google-Smtp-Source: AGHT+IHQtT1DhyUe9XWbkgNCSz3KecGCefNVcwrr5ys75LAC9LLkn90zz5VjZC9zznoSGi6+KerVrw==
X-Received: by 2002:a05:6830:2116:b0:72b:a020:a2c0 with SMTP id 46e09a7af769-72c4c9f2c77mr2663755a34.17.1743092065276;
        Thu, 27 Mar 2025 09:14:25 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c580fa72fsm35908a34.41.2025.03.27.09.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 09:14:23 -0700 (PDT)
Message-ID: <ab73f7d5-77fb-4264-ab4a-03ee78aeee06@baylibre.com>
Date: Thu, 27 Mar 2025 11:14:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] Documentation: iio: ad4000: Add new supported
 parts
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742992305.git.marcelo.schmitt@analog.com>
 <bb57e4452cb6bf9f644c0ea2c248d4b72ecc65b8.1742992305.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <bb57e4452cb6bf9f644c0ea2c248d4b72ecc65b8.1742992305.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 8:25 AM, Marcelo Schmitt wrote:
> Commit <c3948d090080> ("iio: adc: ad4000: Add support for PulSAR devices"),
> extended the ad4000 driver supports many single-channel PulSAR devices.
> 
> Update IIO ad4000 documentation with the extra list of supported devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Don't forget to pick up tags. I already gave my:


Reviewed-by: David Lechner <dlechner@baylibre.com>



