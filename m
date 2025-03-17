Return-Path: <linux-iio+bounces-16929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1281CA642FA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9B83A3E67
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 07:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780811C6FF3;
	Mon, 17 Mar 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqllYVQp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9EA207E1F;
	Mon, 17 Mar 2025 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195475; cv=none; b=MAx9Po3kB0TRuWqJ6iDv74PAxW2tnoKfwTPtESnzSxEPthfr9kaZPMn/Av94N42Br3dc9BOYvR4SCrU0FgLuGq6FYS3Z6PDVF+xLX6/WbCE6vfZln6Zy2Jl3kNM1Cfe0dMSXASTribko1K8dt9bMgJo5BKNNwciqOI34wPUg/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195475; c=relaxed/simple;
	bh=bxC9ANzFX9uX0dn0RdpNnhuv0Rw4vLPvZggRh2iBFK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ysuxt37fM38zTdbnCOzhu/BBVUcLCZEwRoKEFeOYupf6fbGrF9rTzkMH8GsXUO7yp9lRmvyJUo/4bLerVyBt6rg9CbtBrIx5WAHFVHjUY1FJLq1/3FQLmLxS6YDw97YjodlY4yqCnHCJQux5LmpWhA7PagN1ak0yz99j1ErjXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqllYVQp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54957f0c657so4198147e87.0;
        Mon, 17 Mar 2025 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742195471; x=1742800271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HalaitR3wNqHBLiZ26kGsVTmgpsmEjHSTSSRfu+eT1s=;
        b=WqllYVQpsONClsPGWqnm1ycuLzM/kztRJIbXIqz44BIU05hD0vwF4FjrDOAKFOXcj8
         E1fY2AvgkG5nbI+z5+0H4BVJTNqRLxiVgv2py/Cn37KgFFVFicpfFnnwd/yrN/exQMr1
         iIKJEkCPx7ZMW3Zh8hsekR2jFz85/la3W2CMTvi8GKeQTo+3bSoqJlSAbBaRx+hwy8K8
         sgdjvOt2ocoZmxs0hnTNITcBfrJlYBpyYPRnfciH+WBtpCRZmuUVaWgzGpb60bZE+O9k
         WubHgQ/NQ3WdfYC6MXyesv1CTSGZ8/k9Mm8yT70NGgmkb2uaP0U8ne30VXTdu5FtJfo0
         Koyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742195471; x=1742800271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HalaitR3wNqHBLiZ26kGsVTmgpsmEjHSTSSRfu+eT1s=;
        b=vbomwccoAHQWmaRGQAK9ybF2OxQhLs8Ysb6MRyVLZdo09H6np9/spSqD/snoGzdiqd
         NZsRCjzMEjzxjv+BXozAhk24e803eUA161JJSe6x/qJiMwE3rZfF4PihAzSQTnoCRALX
         yE4eXwlgDA9+0f8P1E8y8WWFimjV0qSlWR/hyeI18/ujrniaKqiWxEhemMV4TEjN/muY
         GttGkuhQMz5NbE41UhEnNagHR+HLBIhytCClfQXJulZg9X51Y3FEILSV8yiwSrPLAhmp
         R3JWpfGFteCYQOfBfpzdBQyxAmAE9qvTM64rvHnTjVmsUmvf51FA/q8dYJoEmClQu6BG
         hWjw==
X-Forwarded-Encrypted: i=1; AJvYcCUKw/y4KkIOijQWUHpTJHDsAjmOsbQaCsMIgPoGCdqxnyjfkkZab5smMLOa0cORo2TPueY4/ZLmXraEsHXL@vger.kernel.org, AJvYcCWPFuDKk9yX6cYb18Td+VhacoIXVEHuM/lqQP/J10xMA/ISFfRKwiQoJB15+2Rc2fy/7MRzA4rDDMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7htM1QLBPSmQVcutuvtl6B+SIhKH3NXzD0w+JEsGOlAmX0Fno
	L8eXJKZGJPydYklqa4TGe635F1d5J6sGdRDB7iX6G3XmiZxa6DwD
X-Gm-Gg: ASbGncvJsqco8M2XYK6EtjhBlVHUsNBNd++BpvqzoaYYUcpXeMnCA3P7iAye2xYCM+X
	oTHJkjUcv7RXd6G5MuDsqnrpv4KpQeeWjqkQ0N0QQA5zvz8Z2pAMafUNNQBNnEltFEhXDp+RsLg
	GaOnS8vOIXPupWvaNaFMsamGoYikNPC3xqCPcRPxDjz9R1O1nl90I19tatnCyGbpkgdhO8tCGji
	ZBeunx9K3GXJXKfSpzh3lFj5T6wCc0EOv8Q+PkQqN8ZBiB/Q42dqg0zOGePKxFA/zwYHopcgiVi
	Lbwc1sfwEVu/PgtclbHbtUFbXmoLTTBwOgIfj5KFtKFW44e6oz6XYno70hqjeATxmMl2jjlug/d
	aoeAiiDY7TJMbdYCffDFtxy++HQ==
X-Google-Smtp-Source: AGHT+IGYn0VINpzgzh6MdKG0thylUkI/oz83FeKBKYjY8VACZiA9L37BUf8dAo+M8/olFMTjah+v2A==
X-Received: by 2002:a05:6512:118a:b0:549:8f14:a839 with SMTP id 2adb3069b0e04-549c3f23817mr5553692e87.11.1742195471393;
        Mon, 17 Mar 2025 00:11:11 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a761asm1220851e87.229.2025.03.17.00.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 00:11:09 -0700 (PDT)
Message-ID: <50b126c5-248e-4694-9782-4f28d6db5fce@gmail.com>
Date: Mon, 17 Mar 2025 09:11:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <df0b2b53affbef5ccb7219328cc15db3ba843737.1741849323.git.mazziesaccount@gmail.com>
 <Z9LQ0O34EUM8WZku@smile.fi.intel.com> <20250316094112.6731bd01@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250316094112.6731bd01@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2025 11:41, Jonathan Cameron wrote:
> On Thu, 13 Mar 2025 14:34:24 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Thu, Mar 13, 2025 at 09:18:49AM +0200, Matti Vaittinen wrote:
>>> The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
>>> help drivers avoid open-coding the for_each_node -loop for getting the
>>> channel IDs. The helper provides standard way to detect the ADC channel
>>> nodes (by the node name), and a standard way to convert the "reg"
>>> -properties to channel identification numbers, used in the struct
>>> iio_chan_spec. Furthermore, the helper can optionally check the found
>>> channel IDs are smaller than given maximum. This is useful for callers
>>> which later use the IDs for example for indexing a channel data array.
>>>
>>> The original driver treated all found child nodes as channel nodes. The
>>> new helper requires channel nodes to be named channel[@N]. This should
>>> help avoid problems with devices which may contain also other but ADC
>>> child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
>>> string didn't reveal any in-tree .dts with channel nodes named
>>> otherwise. Also, same grep shows all the in-tree .dts seem to have
>>> channel IDs between 0..num of channels.
>>>
>>> Use the new helper.
>>
>> ...
>>
>>> +	num_channels = devm_iio_adc_device_alloc_chaninfo_se(dev,
>>> +				&sun20i_gpadc_chan_template, -1, &channels);
>>> +	if (num_channels < 0)
>>> +		return num_channels;
>>> +
>>>   	if (num_channels == 0)
>>>   		return dev_err_probe(dev, -ENODEV, "no channel children\n");
>>
>> Note, this what I would expected in your helper to see, i.e. separated cases
>> for < 0 (error code) and == 0, no channels.
>>
>> Also, are all users going to have this check? Usually in other similar APIs
>> we return -ENOENT. And user won't need to have an additional check in case of
>> 0 being considered as an error case too.
> In a few cases we'll need to do the dance the other way in the caller.
> So specifically check for -ENOENT and not treat it as an error.
> 
> That stems from channel nodes being optionally added to drivers after
> they have been around a while (usually to add more specific configuration)
> and needing to maintain old behaviour of presenting all channels with default
> settings.
> 
> I agree that returning -ENOENT is a reasonable way to handle this.

I agree - but I'm going to use -ENODEV instead of -ENOENT because that's 
what the current callers return if they find no channels. That way the 
drivers can return the value directly without converting -ENOENT to -ENODEV.

Yours,
	-- Matti

