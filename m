Return-Path: <linux-iio+bounces-20563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59699AD77A6
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDB1892C90
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8FC29AAF4;
	Thu, 12 Jun 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Re/3dRW2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C929A9CB
	for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744383; cv=none; b=RPJ+eszWa0IEOXiuqW5/cljCQUSLkhJg+2LwfV/qx+O1kUPuvsId87udr6x8xyJmKnkH3QMCivlukdabOuSAYGp8+ImOFmDqDGC7LeRHNy58G5SfgxLC4L/TiC6KLpJXAVjrYJYFTkm7MHB7vJIJxpNiQ4aKfjzWjpGr+KOl/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744383; c=relaxed/simple;
	bh=04GkUWrTTqQUp181YEIvcJyQTVFi48opIFB+InHSc5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PixowBHjH0L2gKS16tFWDU3dDxcvMqBd2VVDfjxXa1R4NyqX8opQ2EwdBwJX1MXjFVqlyvdo1AlPx2/2rrmRFV6CXPKS/EBCBNROR/owPKQRIpvXSbiIjy1QBrjxml3bj8cnbFmsmjw8RhtvhjtUd50SPOaghHDNTwJIEV9PAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Re/3dRW2; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2e95ab2704fso711111fac.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749744378; x=1750349178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udm2JNtgUVnGtTALc+UG19LJaRFqXt9eusqJiG8Hlj0=;
        b=Re/3dRW2GO2T1linoO7pdxEfl+o7fEpuCbVNWWkd5ALiX7+bZEHN+0wYnXjYG0gH/8
         LzTcsFGe3lf9+tJkFMOdtw+aJh+/m7FvZ9C/wssZ+UOyaQW4Z3pXVItVakdu05tkMIMD
         Es7pZ0QtrV/knk9Y7NTZRt1RG1o+9h+rJHSnN8Wf1QrCh76HJ/1oGs+bEblVJGRw+nvJ
         TjnlVm9nXofjXRf6LhVZX8BKEyHoxHjWjqULqGVsZmAyw1csSp3nXXEsHTw917ySO2rC
         82jWsMxiU6OxcMaewmUpKWlxKA1qmIG+94TQ974lZFTyrEMpqbj1P9CKzaqzDnR8z8vD
         zYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749744378; x=1750349178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udm2JNtgUVnGtTALc+UG19LJaRFqXt9eusqJiG8Hlj0=;
        b=hTR5wYk+vW1qKEUiFDHg2Zh7GgR6GSVO0br3qZ2jbJbxJ34cM/3nXKtTQpsmMSzT+s
         fRKHObqLpwRXiHWftmDOFoRzeMuYHHmE0hBnI8XZWMX+QxzYIqz6OrnFVQdvDJptfJF3
         lR0kZybB4WB1cGtYLtkE95g496iaM//bO1RJlqBTx1YfwBzxPUAGK3C1cgvAoQr4elNq
         RAo2F6LHW2JWrPMQVerDKDNm1afeLj68KVlSvuySgQGaRgQzP/tr+Ug1xMQSNWpsu3gY
         4KwdpZ3AjogxnLC+mQDrvUeyKZ1TqtWeQXrD1zql03QQHGNktW0ZS01WYxtNX8vWmuEK
         X4XA==
X-Forwarded-Encrypted: i=1; AJvYcCVhYbOYBy9oFl270Ku8t7Q2KKv+ldsFJzyte+qPWb6/tOffpB2tWo6OmrwJXfoTJILk9+j5AOgGyxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDlQCbV+sMGiBqDSpCEOsDb8kePhyJ/jFQ4DRCnw9mUOV0fGd
	AUMZjni3oV/bydW3lUD6vxd4YSgqdN5bNAgMEK2fO0Vl15cD/lqUiWa9xwHjtFpN58E=
X-Gm-Gg: ASbGncvKXEWZMgjl459pyL6CRqkKkIR7i+h/mEuXI7vPYs66cQdO4sOGW5XgwbWtG83
	I1uPJcCVYPUylQceOAKDGTHA0A5hcJoaRBCk6MNQcQd09leD2BUwf7b2OTivA+5Ct+neTndmLBj
	njWxSdfUGTTLGpwpkXF9DjbceMpjKUuIF9jzIyRN7igzo9tRRpY7fWhnxop6yrDol5j/olwyuOx
	CK9rmo0DeKAl2qpoNFfEaK/McGtGTfsMs7y+HudNEjoWT9tbqXHgMKH52/fLzGB0tE8Sv1vWYyh
	d7k7239xkA5JLoNANJqHsFBsKqhgn68t8d7lmAw2EF8LT7ZRhH7fs1gzMjN7hykru5AV7Pbc8zo
	GT4YYoog2bMDLbwM5qUrVq+R+AGR5PLvjKkoeFdM=
X-Google-Smtp-Source: AGHT+IF/vr0JdR7BhUZF/CLVXT/7bWNiAbEwT6msbj/HgBgDO3T/ANvkscC5qNafqYzSb/qLbMi0kQ==
X-Received: by 2002:a05:6870:9c89:b0:29e:74a0:e03f with SMTP id 586e51a60fabf-2eab46e5dd7mr2125102fac.24.1749744378382;
        Thu, 12 Jun 2025 09:06:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4753:719f:673f:547c? ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2eac0c17211sm221571fac.18.2025.06.12.09.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 09:06:18 -0700 (PDT)
Message-ID: <1c1c2888-be50-4578-8afd-bfbe4bd9cbae@baylibre.com>
Date: Thu, 12 Jun 2025 11:06:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
To: kernel test robot <lkp@intel.com>, Andrew Ijano <andrew.ijano@gmail.com>,
 jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew.lopes@alumni.usp.br,
 gustavobastos@usp.br, nuno.sa@analog.com, andy@kernel.org,
 jstephan@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>
 <202506122309.FvJPaMhh-lkp@intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <202506122309.FvJPaMhh-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 10:52 AM, kernel test robot wrote:
> Hi Andrew,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on linus/master v6.16-rc1 next-20250612]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Ijano/iio-accel-sca3000-replace-error_ret-labels-by-simple-returns/20250612-034940
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20250611194648.18133-4-andrew.lopes%40alumni.usp.br
> patch subject: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for handling mutex lock
> config: nios2-randconfig-002-20250612 (https://download.01.org/0day-ci/archive/20250612/202506122309.FvJPaMhh-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250612/202506122309.FvJPaMhh-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506122309.FvJPaMhh-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/irqflags.h:17,
>                     from include/asm-generic/bitops.h:14,
>                     from ./arch/nios2/include/generated/asm/bitops.h:1,
>                     from include/linux/bitops.h:68,
>                     from include/linux/kernel.h:23,
>                     from include/linux/interrupt.h:6,
>                     from drivers/iio/accel/sca3000.c:10:
>    drivers/iio/accel/sca3000.c: In function 'sca3000_read_raw':
>>> include/linux/cleanup.h:258:2: error: a label can only be part of a statement and a declaration is not a statement
>      class_##_name##_t var __cleanup(class_##_name##_destructor) = \
>      ^~~~~~
>    include/linux/cleanup.h:319:2: note: in expansion of macro 'CLASS'
>      CLASS(_name, __UNIQUE_ID(guard))
>      ^~~~~
>    drivers/iio/accel/sca3000.c:699:3: note: in expansion of macro 'guard'
>       guard(mutex)(&st->lock);
>       ^~~~~
>>> include/linux/cleanup.h:258:2: error: a label can only be part of a statement and a declaration is not a statement
>      class_##_name##_t var __cleanup(class_##_name##_destructor) = \
>      ^~~~~~
>    include/linux/cleanup.h:319:2: note: in expansion of macro 'CLASS'
>      CLASS(_name, __UNIQUE_ID(guard))
>      ^~~~~
>    drivers/iio/accel/sca3000.c:731:3: note: in expansion of macro 'guard'
>       guard(mutex)(&st->lock);
>       ^~~~~
>>> include/linux/cleanup.h:258:2: error: a label can only be part of a statement and a declaration is not a statement
>      class_##_name##_t var __cleanup(class_##_name##_destructor) = \
>      ^~~~~~
>    include/linux/cleanup.h:319:2: note: in expansion of macro 'CLASS'
>      CLASS(_name, __UNIQUE_ID(guard))
>      ^~~~~
>    drivers/iio/accel/sca3000.c:735:3: note: in expansion of macro 'guard'
>       guard(mutex)(&st->lock);
>       ^~~~~
>    drivers/iio/accel/sca3000.c: In function 'sca3000_write_raw':
>    drivers/iio/accel/sca3000.c:748:6: warning: unused variable 'ret' [-Wunused-variable]
>      int ret;
>          ^~~
>    In file included from include/linux/irqflags.h:17,
>                     from include/asm-generic/bitops.h:14,
>                     from ./arch/nios2/include/generated/asm/bitops.h:1,
>                     from include/linux/bitops.h:68,
>                     from include/linux/kernel.h:23,
>                     from include/linux/interrupt.h:6,
>                     from drivers/iio/accel/sca3000.c:10:
>    drivers/iio/accel/sca3000.c: In function 'sca3000_read_event_value':
>>> include/linux/cleanup.h:258:2: error: a label can only be part of a statement and a declaration is not a statement
>      class_##_name##_t var __cleanup(class_##_name##_destructor) = \
>      ^~~~~~
>    include/linux/cleanup.h:319:2: note: in expansion of macro 'CLASS'
>      CLASS(_name, __UNIQUE_ID(guard))
>      ^~~~~
>    drivers/iio/accel/sca3000.c:835:3: note: in expansion of macro 'guard'
>       guard(mutex)(&st->lock);
>       ^~~~~
>    drivers/iio/accel/sca3000.c: In function 'sca3000_write_event_value':
>    drivers/iio/accel/sca3000.c:881:6: warning: unused variable 'ret' [-Wunused-variable]
>      int ret;
>          ^~~
>    drivers/iio/accel/sca3000.c: In function 'sca3000_write_event_config':
>    drivers/iio/accel/sca3000.c:1188:6: warning: unused variable 'ret' [-Wunused-variable]
>      int ret;
>          ^~~
> 
> 
> vim +258 include/linux/cleanup.h
> 
> 54da6a0924311c Peter Zijlstra 2023-05-26  256  
> 54da6a0924311c Peter Zijlstra 2023-05-26  257  #define CLASS(_name, var)						\
> 54da6a0924311c Peter Zijlstra 2023-05-26 @258  	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
> 54da6a0924311c Peter Zijlstra 2023-05-26  259  		class_##_name##_constructor
> 54da6a0924311c Peter Zijlstra 2023-05-26  260  
> 54da6a0924311c Peter Zijlstra 2023-05-26  261  
> 

These error messages aren't particularity helpful, but what I think
this is try to say is that you have to be careful with guard() in
switch statements.

The guard() macro is declaring a new local variable, which shouldn't
be done in a case: statement without enclosing it in a separate scope.
Some compilers complain and some don't so even if it worked for you
locally, we need to make it work for all supported compilers.

So the code needs to looks something like this:

 	case IIO_CHAN_INFO_SAMP_FREQ: {
		guard(mutex)(&st->lock);
 		ret = sca3000_read_raw_samp_freq(st, val);
 		return ret ? ret : IIO_VAL_INT;
	}

