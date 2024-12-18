Return-Path: <linux-iio+bounces-13623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C29F6F0D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 21:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C331416D879
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324421FC0FB;
	Wed, 18 Dec 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sLOYUzKZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B6224F6
	for <linux-iio@vger.kernel.org>; Wed, 18 Dec 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555242; cv=none; b=ULBs2cUfzpT6bvoSFudP758wT/CIRJfSp2LN4svigGCpx3aVtIlUMqvzkAV7Rm+TP+lX1Ttjsh/I5DEhXnrTh0lG1DhENz+GXHIQqt5IxMNlZgoFz83YBWgyrY/TUwWIVoStQWRVsnROa4+1YJ+vt9GuQ+o4kF4pU9pYZVWyxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555242; c=relaxed/simple;
	bh=knev79UANFUZAIdGmXUO2SJjhZxyJ1aU8kCfLHYZQVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cE62eH2EtnOGDHcyeLekgqXVtrfpOrV5xLWdvIYuRvEmSPub9HcxhFNqwjuoDgh/+HkS3uVyUZmWYy382ncaVJood8SpfYk58pUOQfnqQd8kX8J3MbnJ3g6bT4K8XEhrw/Xw8tIQBP7Wbr/2yWpP7GR0Ejlg55FXkGTvTaF+ROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sLOYUzKZ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f2e370bb3aso9935eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Dec 2024 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734555239; x=1735160039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0acojO1+gNhjMt+ObDwyLasMCvHKTdlCGugB58ry4JY=;
        b=sLOYUzKZkgw3rIA2VF+LonPj0SqvRb8cmNOCDty7ysh5OpN8kGT1JpMhZ8V3kgnDwq
         EmQwYjdFg1/qMRnNxylWDq5bvhwsbmIpCrPTh2xv6SAh2+BGeG7v0KRHl7/BbVpElN0/
         o5t14SRXcjPLj0x9wj3HPpu1Tj/TRv6ji3NI0woVQMtrmG8vjxbWIHpQZ7QBCeBHPO1y
         LhSbSX8Jp2heI2Dz7wMnNotAPV4XWV8x89jtimHWfQ5XD7NZMzG26ZWxKLgZq2LLXdci
         AXiXeCzH9opJa0eMAH5C0U6niA21CNDzGOsf2tHBVrnbMsmCgKoV+DZEm8yB0HMr7RB5
         PfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734555239; x=1735160039;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0acojO1+gNhjMt+ObDwyLasMCvHKTdlCGugB58ry4JY=;
        b=ecKyf8veqyTgx+djBpivyMgmMbVR/qEtsdCaOmNCbrTQGIRqS7n1uN6E+RGqhD9l7T
         lGj3vgI0snmJneNWm5zE9Ns+65dn2w5tW3Z1CsWETcrUIWWf1tHaW7r2eREBCVJ3RuFP
         O+3ri9mWkNEG/QfT8IX30e++3gJlMJGk9Dn+gYJ9qpdsXJ421fD574l7M7mPKOmYOR2m
         fEctrjNg/7jy9Q1IqSCA/s0BVuFeCb1A/c89A3xhlpTVIgGABhzkSibrOBjpKQFxBGAH
         uqsy7CTRaPtnOmyXitB2B5UZ+qlRrXslOv9MGoJ7j1SDrFPJubKc40vSbOGdh+rtgQsG
         lRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzbq8dN4lsHOqnzMinBOtnAQxUiy8Ig5O6i1j0H+vMfwlhFp8KWBh21xXREXLRtC5SGma2CNCrMJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJ36pQjpEC15a/TGfj+D+CuapCHy6EyEQS1R2Ay2H5NvWJG7m
	iMSKu4qFlJxP4+yc8bvI3ciJJn7QpPRfp8qKIEHsOcjAQpt4kzcADxMqAFcMmqY=
X-Gm-Gg: ASbGnctzhRhlZEDPL9XZpUnc1iEeG+CP2C/B2QZg6NBFdyvo5tmN8lcFsgRKWwTtOmO
	6+zGf7PuNEFabKRKxctnw+LNLUqDJWrBAPMpVrKp4PsAb1z9P5ErWQDQcEVRzFD//ISC5uVp2Vo
	Oa6sjaq7OltL0PpAa/CQacUtXc6QXeUbrnM+u42Iai63Hyq21huiZTYONxiRdK7E5YcwIzs6CJo
	0/6KukVz3zLBrBCUDpKXfOJ3GJBwP5OF5e/iSEraPL5gckSobCwa0w1GrHoidg+D9peSDgcSQmc
	3ezvN+tzqb0jjYTg6w==
X-Google-Smtp-Source: AGHT+IE+Q4kvlehpGtXMxI99sieRh9Ap4fOdAJ7eTGygibKbYaU2XuiT+nkDWHmmwm4NzOjQ7KF8RQ==
X-Received: by 2002:a05:6820:2292:b0:5f2:d99a:5170 with SMTP id 006d021491bc7-5f4c9b19ce6mr2428247eaf.4.1734555238795;
        Wed, 18 Dec 2024 12:53:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48307dfbsm2781420a34.4.2024.12.18.12.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 12:53:58 -0800 (PST)
Message-ID: <296d9e03-1153-4589-95b8-87195d7bbdef@baylibre.com>
Date: Wed, 18 Dec 2024 14:53:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio: dac: ad5624r_spi.c - use of scan_type
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3f5ff01b-8c32-423f-b3cc-a95399b69399@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <3f5ff01b-8c32-423f-b3cc-a95399b69399@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/18/24 2:38 AM, Matti Vaittinen wrote:
> Hi dee Ho peeps,
> 
> I started drafting a driver for a ROHM DAC. I took a quick look at the ad5624r_spi.c, and the use of the 'scan_type' -field in the struct iio_chan_spec puzzled me.
> 
> I think this field is used by the driver to convert the data from user to register format while performing the INDIO_DIRECT_MODE raw writes. I don't spot any buffer usage. Furthermore, as far as I can say the 'sign' and 'storagebits' are unused.
> 
> My understanding has been that the scan_type is only intended for parsing the buffered values, and usually when the data direction is from driver to user.
> 
> I suppose I shouldn't copy the ad5624r_spi.c use of scan_type to a new driver. I'm somewhat tempted to send a patch which drops the scan_type from the ad5624r_spi.c, and adds the 'realbits' and 'shift' to the driver's internal struct ad5624r_state. This, however, will change the interface to userland so maybe it's best to not do that.
> 
> I wonder if I am missing something? (That wouldn't be unheard of XD). If not, then at least a documentary patch with a comment "don't do this in new drivers" might be Ok, or how do you see this?
> 
> Yours,
>     -- Matti
> 

I think scan_type is a convenient place to store this information even if
buffers aren't implemented. The struct is there whether we use it or not, so
might as well use it. And if buffer support is ever added, that is one less
thing to do (removing the duplicate fields).

