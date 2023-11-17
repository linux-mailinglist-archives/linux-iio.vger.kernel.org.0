Return-Path: <linux-iio+bounces-150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93797EFC0E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Nov 2023 00:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AB7B20AC0
	for <lists+linux-iio@lfdr.de>; Fri, 17 Nov 2023 23:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7945BF3;
	Fri, 17 Nov 2023 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDMzpQBA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837BD6D;
	Fri, 17 Nov 2023 15:19:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692c02adeefso2340824b3a.3;
        Fri, 17 Nov 2023 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700263172; x=1700867972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUz1ZMfERfyYEZDG9gNO+HP+4waGni/sH3yv+ujzJzs=;
        b=bDMzpQBAJc4BOsmqt2fk9Bp+es6wdMfYGGyiFzy9lXyPIvDmI8kgR6dNnHwXrWgY2w
         1h1UTb+cZMywhFufnMo0Dj3xvHe9FKEKvjP2NsM5PXFKMx3Y+bPX/BXCPb1PhPvbJ7Qv
         A558ijzLlnIGdeO9pMhNDGwgUdNzXilJ/2WVQb/+gUVILnfXVM65sCGyGnGtr+5yRxbq
         cjnUTHAKpEx9r93G4QN537FkcRBdw7drlh7aa+dksIOuyXoE/fLRrhOKRF7e95ROH+3X
         Li/LgcnuUVyuYwuBeDEaWXsxaioeM6XZ4V4nmz4g9apy+7y0g+BvTyFK1EwHtLF4bkI3
         NnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700263172; x=1700867972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUz1ZMfERfyYEZDG9gNO+HP+4waGni/sH3yv+ujzJzs=;
        b=sCivBi9B2EPhaiiBXihEs2FrhzEQa7BvG0mQfd4gs7C72Xix1ANW9A+hm+7VZ35DhN
         61dWlE74Wdgttmdeb/Twrrsy4agcVvwF9PMKsFkJM/If8g1SkE2yoW3Kw+pO0xg8BSV2
         5TzFwyFHzoCGvdMCTPIq6sl3/ToBas81s4VFkJ4mK83fr8sJ809CEb4KjxMbaEJWnouk
         FvtPYvNRlMNdKCF6Pkr7KXLlsJQB16VZ8YbL5g8ICATE7iGHWfuVVONm11/kwYvVTl9Q
         5kxd5yKupCyzp6t6yw18g3+UWMt6nBiiJ+UZpHdul8+STLYQcX4Q0QnDbrFvkF/ZIbME
         33PA==
X-Gm-Message-State: AOJu0Ywp+8J3l9z+aWPUtrPnY4/AsogYceoNDP8eHWo+KpSv8dy+RoAS
	v2r8Dvj0Ux2LxwAksID+Xoz0lvtysJpTbg==
X-Google-Smtp-Source: AGHT+IGXfHa5y7X8ctpxO7+OEukHXWA/m8SgO//i3C/4fQlgN7ws8MdVrTO3Pyh7LyT3GJaDU2MFDQ==
X-Received: by 2002:a05:6a00:93a8:b0:6be:2991:d878 with SMTP id ka40-20020a056a0093a800b006be2991d878mr1099966pfb.15.1700263171966;
        Fri, 17 Nov 2023 15:19:31 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x3-20020aa784c3000000b006933866f49dsm1979809pfn.19.2023.11.17.15.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 15:19:31 -0800 (PST)
Message-ID: <af464a37-63d4-45e6-971d-455507facef9@gmail.com>
Date: Sat, 18 Nov 2023 06:19:23 +0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: add judgment condition for Kconfig help test
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cixi Geng <cixi.geng@linux.dev>, apw@canonical.com,
 Joe Perches <joe@perches.com>, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, akpm@linux-foundation.org, rdunlap@infradead.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Cosmin Tanislav <demonsingur@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Maksim Kiselev <bigunclemax@gmail.com>, Liam Beguin <liambeguin@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Industrial I/O <linux-iio@vger.kernel.org>
References: <20231116153904.15589-1-cixi.geng@linux.dev>
 <ZVarTLiczTZ8oCBg@archie.me> <ZVfXmlBbB3Y12Zz3@smile.fi.intel.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZVfXmlBbB3Y12Zz3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/23 04:14, Andy Shevchenko wrote:
> On Fri, Nov 17, 2023 at 06:52:44AM +0700, Bagas Sanjaya wrote:
>> On Thu, Nov 16, 2023 at 11:39:04PM +0800, Cixi Geng wrote:
> 
> ...
> 
>>> the checkpatch result:
>>>     WARNING: please write a help paragraph that fully describes the config symbol
>>>     #23: FILE: drivers/iio/adc/Kconfig:1050:
> 
>>>      	help
>>>     +	  Say yes here to build support for the integrated ADC inside of the
>>>     +	  Say yes here to build support for the integrated ADC inside of the
>>>     +	  Say yes here to build support for the integrated ADC inside of the
>>>     +	  Spreadtrum SC27xx and UMPxx series PMICs.
>>>
>>>      	  This driver can also be built as a module. If so, the module
>>>      	  will be called sc27xx_adc.
>>>
>>>     total: 0 errors, 1 warnings, 17 lines checked
>>
>> This confuses me. What are you trying to achieve there?
> 
> Is the indentation correct in each line? No TABs/spaces mix?
> 

IDK as I'm not the patch author...

-- 
An old man doll... just what I always wanted! - Clara


