Return-Path: <linux-iio+bounces-17917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34FDA84760
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDC8178E94
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F731DD889;
	Thu, 10 Apr 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KuLJm3Cg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736B1DE3C7
	for <linux-iio@vger.kernel.org>; Thu, 10 Apr 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297815; cv=none; b=cPdU68MDn0yySnR4iYzrVM7xM8Q7OjDnXT2jNiCHrqM9kKIDQzr2/CNqXmaaOQf6PKZHofIK76t6g1A1Fvm6xx9mL/GlckCNOZV/1T0SgbwwXt6NqadEJ6kdTBZXhwDJT31ZUlkxRl4i73MlgWcJC1s7HonP6LV/cBGLyaulTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297815; c=relaxed/simple;
	bh=clQ76r5v5NBAAlxlXOnSgck78T+r1c8I2ly4pB3R084=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qj0e3u5sY/96I31oWON9LIvD7ZoB8dGQHzBr4gT4Ki9F0M5oQSvb0Cbmp6/+rOn3enc8qsP2vwUYqTV4MB1t+up45VysM6XgYUan7ZTU9sFp+92YvnLF7KKF83OtwknpXKUTY+FcFq96YETr6MH24Q/ZhMaQxewIcT9dAXsaIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KuLJm3Cg; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c7b2c14455so541597fac.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Apr 2025 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744297812; x=1744902612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSVaecQLnHoOQXz9idkykvGiR6nfobFtIIlrAziyXag=;
        b=KuLJm3CgZsuf8ZNhuk/bXr7CRETbcAgaO6hZ/tfWcNT8o4COB/SNMb3RPTyxiJdcoG
         4u769Pp/Ya6G5MQksxfZYD+SlMSBzKP9VmCEtL26qdesaG0XFzgRBApME8D2trCxnQ1D
         EYltQRVcMjGpIdv9mO+inWHG3wHpopmxsynpVnDEDWL1UoKv3Nd/chymvBP/yea+HjHn
         EOAwiBobjS/gzxQq9uj5caHfpRQ9lBZSPtVa0tNJLr1seMfcU0SFbyT1gUwomST2e9Gp
         GsHXqPFcVSTzHdbtrQxZJVNLD5HGxjwojDhYo5Bjzf+fUFzmQwI7rWvcuJ2O3+E6eb2x
         xm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744297812; x=1744902612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSVaecQLnHoOQXz9idkykvGiR6nfobFtIIlrAziyXag=;
        b=DLLinWvle08FZrIOyVCNSZxOllr7oCIDlUjT6UhGjGvA71QlChQ+LSJlMaa0ICfmSz
         aLWuqXZY+kGer1xATvQyTOYD18m+wsdKY6k1gQH+0QztuUf2Jwh407tYQyhRDwKh0MqL
         Ces0SVnt0+BTnjvMJg08Pqab/XbRe8ZzO6ZeieNH9TXxRKSrKD1it+xdLGrhneWkHw2W
         jMk8CzYAQYm5qwO3PRpMiRZt5RS3tu0E7/VJEUt9bw1TypF19ZXjezriiwN9HsrsYauN
         ndxYYxEUsNpZ2ST0VNf227wUIDNbRmSyZ3pNza/najP0lh8/fuMdhMjbgruD2GcqrWyq
         +zHw==
X-Gm-Message-State: AOJu0YyRAI12J279+jTBJyALMC2CeEl2WnhUMFHzavXV64bIXNPOskR6
	KNZOr1YJQwa94vo88TK13uHwtSzWyg0+NHYOjnGD+euf/Jqe1pltc4VSHAlsQ74=
X-Gm-Gg: ASbGncux0qd9EbWK+LIHa4XhDnP9+MwXt8AM9bfH4+1OvTLYYLOOc3XZgox+wwkwzTI
	jgcGzZzfqZnijzMYJBoPw/EApqVQ4egv7KwAxsdze6CWuSrq1eFtTtN+HI0hybpVCnOn/gt0E+S
	vi12VOEuwVCEmmuKcQ5Z4IZ/vAAOyNiAeTloTJc6FFdbWweOZnNkWsJZL/h//bPTfAKorxQht21
	1cgsOcl19cYMMMfZuSNhUPdFmVW7uj2KHLgkwf2xbQ7QOh83DpS5ax+biZ0CNg487Fgk6x9laLK
	Oibgg8moPKm4FBm2+qlLh2Ah1g/Ugfc/XSQcD3FkQCgRIRYCRimcwWqKgN8Fy0X/VY+mhRQPjuH
	Czg==
X-Google-Smtp-Source: AGHT+IFJDDCvJdEYXfHiAwKLzA0w8KMAfVXNdsnsfoajtcszQBzW7GYmADv0+34QgN8Gqv7LYEuNTA==
X-Received: by 2002:a05:6871:a608:b0:2c2:5639:3a4d with SMTP id 586e51a60fabf-2d0b38b5e45mr1563111fac.38.1744297812101;
        Thu, 10 Apr 2025 08:10:12 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d0969b722fsm702882fac.28.2025.04.10.08.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 08:10:10 -0700 (PDT)
Message-ID: <22034f6d-f2ee-4792-a3c0-a5c0d69ef25f@baylibre.com>
Date: Thu, 10 Apr 2025 10:10:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Adding support for QMC5883L magnetometer to IIO subsystem
To: Brajesh Patil <brajeshpatil11@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com
References: <Z_UvBIsQ4rdIYTN8@brajesh-IdeaPad-3-15IAU7>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Z_UvBIsQ4rdIYTN8@brajesh-IdeaPad-3-15IAU7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 9:13 AM, Brajesh Patil wrote:
> I have a QMC5883L magnetometer module that I’ve been trying to integrate with my 
> Raspberry Pi using a kernel-space driver. While checking the mainline kernel, I 
> found that there is a driver for the HMC5883L (under the hmc5843 driver), but nothing 
> for QMC5883L.
> 
> I compared the datasheets for both devices and confirmed that they are not 
> register-compatible — the QMC5883L has a different I2C address and an entirely different 
> register map from the HMC5883L.
> 
> Given that this sensor is widely used (often as a drop-in replacement for the 
> now-discontinued HMC5883L), I was thinking of writing a new driver for it under the IIO 
> subsystem.
> 
> Would it make sense to move forward with this? If so, I’d appreciate any guidance or 
> suggestions from the community.
> 
> Thanks,  
> Brajesh 
> 
> 

Go for it. :-)

My advice for writing a new driver: Don't try to implement every feature in one
patch (or even one patch series). Just start with the most basic functionality.
Then add more features in separate patches as they are needed. (Devicetree
bindings are an exception and should be as complete as possible in the first
patch.)

