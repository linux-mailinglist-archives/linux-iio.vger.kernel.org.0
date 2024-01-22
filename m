Return-Path: <linux-iio+bounces-1837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79688836292
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057FEB26A91
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14143B196;
	Mon, 22 Jan 2024 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="MeBcuQOa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4543B290
	for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924147; cv=none; b=ajG8VyUdWBJsOLeNlbK703n+8klwz69oAcMFzMqLBk3lCq8rqYjmPObKyKr0YRe0eZY3zcFVUgzJYr1bKw55O+OshZEd5d+8Sk7Av0f50DR7Ea9uimAHh6MpM/sKUXqpJitpvaq/RnWwCCWarxJyeY58XB4rlMlswWZsvWfFwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924147; c=relaxed/simple;
	bh=o6hvUsz3qFGfZAA/SbershXt8NNurBAx8oKsg4weeNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=On/10DVW+X27xvgij2yeDkabk2Kj6KyJjZcWu4eDQ3QwOEi7ggBLc3gpE/hbXq0oLElTsFLAKuIzw5NDPgvKZT28ribdym/fAiMP0D2fppkYGC14ixe9zA2xcyl3nuBkdkic3uv5Sl21/jcZHVpCJf2Fwr+HQNUo6dqXJt1EURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=MeBcuQOa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5f252411aso13840275ad.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 03:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705924146; x=1706528946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXEn3cXPdxU4toPB4TVnucK68cp/O99DyU08A0F8/Fk=;
        b=MeBcuQOax2RS/R/1mGm7KQHpCo46ACk3S5qIY5sA4MzOQ+Obgy1lM82TuHc38hO913
         eVls0ZTPQVK4qFuB1OE9a+RMdQKApp1jqxLP9CLiy/KJhfbJM39Fs7siTuTBRc9uRMJK
         i/WpSVm0V+bO1pF2fUgDrseH/37f1u8gsUQjgrrtR2RJXggd3K6s5mvC9kGwLfUdSz7B
         GadKbuCin5tg3amtUU1Bt+W3Menn7om1bks34didsZWuy8uRIP5JUoco+L87Gm/cfZZV
         EvMM55NkDmR9s/weYCcvtYC89YOt5tvFvcoiQc7Kp5LUtYlfTiZyDs5VwHEZhotRchvE
         Pi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705924146; x=1706528946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXEn3cXPdxU4toPB4TVnucK68cp/O99DyU08A0F8/Fk=;
        b=Y3Um55AtvmBdyQ0VYB18CWBiidzxWjbhOPpIcpOSx5GF+p3tuF28SF9L63HSUXCPWr
         exuOTPgqfV84SzC7wacJFmkiW62wVuXyrbZFbRTqR40la8NCj9gdqF+3IeijmLTl/ITZ
         a91JaRG2W7Zh0DqhMJms/AJfuscspycZQD5nCD9koa3ggS7+QbBTuAyjZrzBqiLt8UGn
         h7nxRMvvY8jENh0hvSzDqNCuGV7P85rVRYpKAjh+WylvHCQW7/SMdXpawThjvDPP8K7K
         CWuHdGVH+57fUQ5Om4HELqEfJy1KZJyzrxduMT20EGZAQtkqhpIQHDlAD35uv6iHTBWM
         gAGQ==
X-Gm-Message-State: AOJu0YyN7E665wogCyXHHHF+QEgOqcMIrWeYiCb+fVWO0yaB4vIeOeHX
	Aptmvq9VYlyPQ6NusUk3cUJj69B+v1ui2xwipbWvBc+D19cSBcmyzTjXpJhKwOI=
X-Google-Smtp-Source: AGHT+IH3KTMp4c+D4F+1PZO0L4+z7GSdoxtVkjQ9blEEf5qFN4EvxOnK7yFnr7QdvTBNKO3gF7i/xw==
X-Received: by 2002:a17:903:2348:b0:1d7:600c:cc3b with SMTP id c8-20020a170903234800b001d7600ccc3bmr362296plh.22.1705924145963;
        Mon, 22 Jan 2024 03:49:05 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170903284600b001d7284b9461sm4339925plb.128.2024.01.22.03.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 03:49:05 -0800 (PST)
Message-ID: <2b06e7e6-e4b3-4e55-a194-7d8287323118@tweaklogic.com>
Date: Mon, 22 Jan 2024 22:18:56 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
 <20240121152332.6b15666a@jic23-huawei>
 <757a18b7-94f4-4d72-9917-5d8b1cd677f6@tweaklogic.com>
 <20240122110404.00001082@Huawei.com>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240122110404.00001082@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/1/24 21:34, Jonathan Cameron wrote:

>>>    
>> Thank you for your review.
> 
> Sorry for the inconsistencies!
> 
> Jonathan
>>
No worries. I owe an an apology for sending patches almost 3 months apart,
as a consequence these things are bound to happen. I can't keep track of things
which happened 3 weeks back and I don't even deal with these much code!
Regards,
Subhajit Ghosh

