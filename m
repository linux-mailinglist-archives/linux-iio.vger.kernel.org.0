Return-Path: <linux-iio+bounces-11877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390089BA87B
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 23:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78411B20E59
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA518C320;
	Sun,  3 Nov 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vht3JLKE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966118C021
	for <linux-iio@vger.kernel.org>; Sun,  3 Nov 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730671819; cv=none; b=b2IIZRJZVueMRm2YNY27J57LSLG+U5EzJbkv2HeGZrKZUaFYdPxq1nzY0kSRIarn8WRwwuigtTr6FUpTWrH5G0wCoAxrAT4LhN9ITfxd20POZ9dlFqGnVcffZrO1y+8V08cGE0Yslr7GuWLLTEuudBR7WnS4H4PA06tpMgrncDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730671819; c=relaxed/simple;
	bh=YfV5iYFCey8uL8RvVFXKpCmMrpkP6Yn7Yg2LpgeM26E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEYiP0U8610qDSoXeS5EFz/o0XqX4CSPd51iXRWQJ/CPDcJ25hd8v5rwd0j0jb/EQr+HMcHPPJh4H4T6dyZAMwSa1i0+PgvaSnJFP0vkgoLEKTokKQ5d3lnYFYgrAUuFADzmhXst1ScYM+8fhCUvjtE3EddXrH702f8Xm4foEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vht3JLKE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71808b6246bso1929702a34.2
        for <linux-iio@vger.kernel.org>; Sun, 03 Nov 2024 14:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730671814; x=1731276614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUWYuqtR3aHLEhG7mg7lZrCRFDuphm1pLOvMuWzILNI=;
        b=Vht3JLKEVK758BtpHL1BLTVtaBpG2uF4Q3UG8skuu2U+kfcId35eHe7kNkDf6n0ZQY
         kudwvrbw6wVGJICEhd9mrurgYwJ1ViZNYV/JLUQmtxtsman9BFUuBOrWWtXomGo5cwzs
         adjrXDgzmCWLuO/8/WpicVXxPxz/q++jKMHrcbYNjsXunavpJpKv8mQbMxHJl3TzQ2O/
         GfaaS5lWHtYtk8KowIifsY8ikWNC7jrx3VkEohZSuiNoroUANGklvt5VfkwjOyaLj44R
         Ph09aImoZQUFrZkKxKK6ogyVNJJr7Tw4Tm086A2bEJr9JSaDFrvzN1RC0/LkExSZg9OH
         TeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730671814; x=1731276614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUWYuqtR3aHLEhG7mg7lZrCRFDuphm1pLOvMuWzILNI=;
        b=M69wxngyhJhiaj06YFTBETIoud2KGMf40G110YYja7hbWNND+Li7F6sNW0TkNEu9dd
         7uFR0qnNGWD0WL/XzAZi1f72YKgr1ViAvIom4jLIPDmW4gwxdOzGhkVcG6LUdYViuwQ6
         zNTS31jZo0/o8EDkHAg85sPN4q8wfeYoPCUeg/QWUCNdHhlLWlPZDrrwrL6Zfv56/O6m
         /VsNP8KzChOxDwMWzOJkv2z3pyOI0rgry9Q8VIOjPHTCrCREZs0S0oTnAZEQWejuakJ+
         3x3rt1aCYc6JQFhbckzRLW5sYAXAXl1jWoDhfd9fLpa5aYop/F1la+BETCi6Fdybnerq
         py7w==
X-Forwarded-Encrypted: i=1; AJvYcCW0vWNucRYuEQHm8YU8I/4o3dOGuhVlsiKo0XbrAnM6sXW9cDhP26I+RbUUf/4fKNG9SVKUv8WfVTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23YDe9lgRyhPEHP/3mcFwLcHEpL1s8t3vYBfCHmzTxteUhcGN
	YZ+oXZyjk1qNmcddM6+/Qxde2Isann7P/+xmDXbbhnXgFGtI7hhMM1eLacK4CNw=
X-Google-Smtp-Source: AGHT+IGMfVh9LXk0iaYFioOzlB6HVEvHUV0T09OtRUqjTerOH+6ZJQ5jtvM98lKCEUKMBpdWBa6SFw==
X-Received: by 2002:a05:6830:310b:b0:718:118d:2be8 with SMTP id 46e09a7af769-719ca25bdd4mr6851108a34.28.1730671814414;
        Sun, 03 Nov 2024 14:10:14 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189ccb15c0sm1745498a34.60.2024.11.03.14.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 14:10:13 -0800 (PST)
Message-ID: <88b1e5a4-a962-4ef3-abff-724af2f6c09e@baylibre.com>
Date: Sun, 3 Nov 2024 16:10:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Guillaume Stols <gstols@baylibre.com>, oe-kbuild-all@lists.linux.dev,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
 <202411020101.5Hs6MkwQ-lkp@intel.com>
 <d44ab5s73kmochmwis3buhd6ci7ff4rwd7kgh47aqar6xeyqna@f4plwf6qbvlm>
 <awpjqzq2ksbqvlfkbh4xnpwqxrnf4np6amifdweasrh52v3jl3@lz3md7ydyhji>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <awpjqzq2ksbqvlfkbh4xnpwqxrnf4np6amifdweasrh52v3jl3@lz3md7ydyhji>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/3/24 2:20 PM, Uwe Kleine-König wrote:
> On Sun, Nov 03, 2024 at 03:00:14PM +0100, Uwe Kleine-König wrote:
>> Hello David,
>>
>> On Sat, Nov 02, 2024 at 01:50:35AM +0800, kernel test robot wrote:
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on 6fb2fa9805c501d9ade047fc511961f3273cdcb5]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/pwm-core-export-pwm_get_state_hw/20241030-052134
>>> base:   6fb2fa9805c501d9ade047fc511961f3273cdcb5
>>> patch link:    https://lore.kernel.org/r/20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230%40baylibre.com
>>> patch subject: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
>>> config: i386-randconfig-141-20241101 (https://download.01.org/0day-ci/archive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/config)
>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202411020101.5Hs6MkwQ-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/iio/adc/ad7606.c: In function 'ad7606_read_raw':
>>>>> drivers/iio/adc/ad7606.c:765:23: error: implicit declaration of function 'pwm_get_state_hw'; did you mean 'pwm_get_state'? [-Werror=implicit-function-declaration]
>>>      765 |                 ret = pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
>>>          |                       ^~~~~~~~~~~~~~~~
>>>          |                       pwm_get_state
>>>    cc1: some warnings being treated as errors
>>
>> The problem here is that there is no declaration (and implementation) of
>> pwm_get_state_hw() with CONFIG_PWM=n. Does it make sense to enable the
>> ad7606 driver without enabling PWM support? If yes, we should add a
>> dummy implementation of pwm_get_state_hw(), if not, a depends on PWM
>> should be introduced.
> 
> Looking at the driver, the PWM is optional. So I rewrote the commit from
> patch 1/2 in this series and added a dummy.
> 
> Best regards
> Uwe

Thanks!

