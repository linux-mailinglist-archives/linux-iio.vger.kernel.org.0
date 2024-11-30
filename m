Return-Path: <linux-iio+bounces-12859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B81BC9DF14C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B204B21362
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935519EEA1;
	Sat, 30 Nov 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSrUhEed"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51E18A6B0;
	Sat, 30 Nov 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732978122; cv=none; b=X6WgXg0rFCk5oy+qduHS7qSCyQFqXKPjmxuTRN26Oi1czUj9WXa/8fnaimy2NvZkrzcxPJN2jfjnTyOG8Ng1GTaSeBa2f8HiRTdxe+vPxvbVsCaGzp87UKvkDkyMNQC5uQLL3p9KFdYZZntp5LZPitrqIHTTXYw2ioAzofONLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732978122; c=relaxed/simple;
	bh=XpBt2IA2C1y1bAgrhc+9pDm8IfbSAPsRs9l8LxNyhYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3y48s56iNvURCgL5sxs48gK61eIEkPgpM2JLuQ+YfdWSuzB01I5H5KdIXHcz/Oau/JGVpURgiIyznpSvPH6DCj+sX0tUxjtGhO5tMMXW2KVLskE3ybRTcf+t0Io5i+R2k72x+lC1N96Gx/79/iFYHXBvriwQTteDg89TU+omgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSrUhEed; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de771c5ebso3144208e87.2;
        Sat, 30 Nov 2024 06:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732978119; x=1733582919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjBN8FHqofZFhfGz5zgZiUkeKx5ijBV2yFNDfXzDp5g=;
        b=ZSrUhEedgdj1CMdrNDW7vOqFDo4YiiiFDgKpCJYjOuon1sOjg3/bidAWmnclpchW+I
         IiV8rhLMXIaHtfsxO3YO1rS+k8kkfUX+bHSvj/UK4rxohCHXSfpKmuloRBtzM8f0T+wj
         TnozBZVF+qlH94eUCiuROJ9XeTKFqpix/K2gScLOSH5eUh5bGVGfVr73oI6XQzXfj5Jx
         tMUnnPBTYe52NNpuc9dNPIhtQeP3oI1SqTtXQ80/yZTGE4lsvBKZl40lfNtkbdgTS2SV
         DghSztYh/HQ5Stqs+HmG9TXJWXOOTbSFs9biYK458oeFMzjmQXbjVfdzwQMm+m8KEdzY
         IWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732978119; x=1733582919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjBN8FHqofZFhfGz5zgZiUkeKx5ijBV2yFNDfXzDp5g=;
        b=GPEMNOaXZVA2idFYHyekkE5szAjbrflBzPKd2dlUCMovAjM4eEs3bsgVYX42G1j5LY
         3cehfndeUIRcTXqxtFiGRWC8c2N3WinRgpd3AcmjQemZtJ/kqQt3ajQWt3UxWK3NLTM4
         h+2nZiB7qmGhVSOYXdde5+UZPE6SsV6++0zH/briMMUZT3HrkvP09gbW2Hzq2pWH/ySJ
         LybFx9+EulSBqetaZowGiJSGjGSZOlCQCrgBoxrgmdrME+hBlQQSUMlTCuTRgQXwAR/R
         dIKuRqo2jxHOTsgsyMW78utPM3TkyHjZlpRDwmOI9Wr+joDL+x3VBMnBSxQ5dHYy9qd3
         gw6A==
X-Forwarded-Encrypted: i=1; AJvYcCUb0FLuMz3dRpF6EDt4fJLfNExibll2biFqkWv56TMikxkcpmWKQ8aZ+vDYDNwFvHsKA92iStqZiKPH@vger.kernel.org, AJvYcCWIig185vM1OvuWmYN5fALp4J5+12PSSN4NLzxSw10aTCnUplWhuXhNfdFgYBfHaQLxcQnmIedYzV+oXU9b@vger.kernel.org, AJvYcCWgIFsi9nQ2BR+3WVK0xXkFI4+qIiY1k58vGzzNifFaoUFapfhKpLElr+kYGP8hIE/yOr9K4FKzhd6r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyr5VjblH3jIXQZtwae2rmrkOGefHAjsSFYH6UOeOl/KptR3zO
	8gTx9u1LwhO2cp5ec2ywTekQ+LMeAB8B907tFMRKSi/mXsf9C2Xi
X-Gm-Gg: ASbGncsQTeArjfrbvS0W8PNL1Xc2ypakTUIlcTv5UhaczlBThHpMIAbI6PuuCu/xiNE
	zFl1YzHUkGbSRczbLYk7CBD4Schlzmzfqk1WfRnEuoAfPlX2h9f/X4YsRckio9pQPGz5HwFPVmi
	dNbWrUpiRmw1UZcuOwOrrzkoRo/9t9TyH42va1R4S0FsEUtzQYCK7x4RIN9uKJI77/NjvTaAfJq
	12A6TGs72GfWOA4NNGtmRC5XH+AUToaHWTeTl0FKiFC/e8Zsk1IQmAxeEbldwFQ/brSwh8RWbNu
	04jBjtSUTCl9ESvK4/h/79nZaPPIj6A=
X-Google-Smtp-Source: AGHT+IFFmt53FkWLvs52tT0yFLqkml98yksR+S4w0x/5qHa4y4YXGIOmEoHRtxWOCqi/BLr1I0ZHtg==
X-Received: by 2002:a05:6512:3a87:b0:539:8fcd:510 with SMTP id 2adb3069b0e04-53df00d0392mr9915981e87.20.1732978118984;
        Sat, 30 Nov 2024 06:48:38 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496bdbsm770953e87.208.2024.11.30.06.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 06:48:37 -0800 (PST)
Message-ID: <19ab6891-0549-4cf3-9baf-661e867f1234@gmail.com>
Date: Sat, 30 Nov 2024 16:48:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Drop BU27008 and BU27010
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Arthur Becker <arthur.becker@sentec.com>,
 Emil Gedenryd <emil.gedenryd@axis.com>, Marek Vasut <marex@denx.de>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732819203.git.mazziesaccount@gmail.com>
 <Z0nOxEtNk6APoNo0@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z0nOxEtNk6APoNo0@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 16:25, Andy Shevchenko wrote:
> On Thu, Nov 28, 2024 at 09:34:54PM +0200, Matti Vaittinen wrote:
>> Drop the support for ROHM BD72008 and BD72010 RGB sensors
>>
>> I accidentally hit a BU27008 data-sheet which had a big red text saying
>> "Obsolete". After a few queries I received a word that the ROHM BU27008
>> and BU27010 RGB sensors were cancelled and never entered mass production.
>> Supporting not existing hardware makes no sense, so it's probably best
>> to drop the drivers and dt-bindings.
>>
>> There is still a RGB sensor from ROHM called BU27006.
>> https://www.rohm.com/products/sensors-mems/color-sensor-ics/bu27006muc-z-product
>> Based on a quick glance this should be very similar to the BU27010. If
>> someone wants to create a driver for this, then the bu27008.c might be
>> worth looking at.
>>
>> As writing of this I don't have the BU27006 at my hands, and when I
>> asked about creating a driver for this IC from the HQ ... I got an
>> impression that at the moment ROHM rather pays me for doing something
>> else. So, currently I have no plan to add support for the BD27006.
>> We can always dig the bu27008.c from the depths of the git, if it later
>> appears such a driver would be a good idea.
> 
> The best series ever from you, Matti, on which I have
> not a tiny disagreement with!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the review. I guess you might've had something to comment 
regarding the recipient list though XD

I don't really know what I did to get the patch names in recipients. Sorry.


