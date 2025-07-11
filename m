Return-Path: <linux-iio+bounces-21586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DC1B023F0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 20:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E21F1CC4169
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320E2F7CF9;
	Fri, 11 Jul 2025 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NPZhpJac"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDF2F3C2F
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259102; cv=none; b=siECFOAr9CEevX6kp3KRFhhi9kt98x0W/MbxK1CXMzDcIxt46gVUzKhY4yefCCeOmg24kUBA/vbaBSyg8y4VmHhQmlFFE7kwxKZj3mj6WOGrDu/Xk+yiX+wHFPrRbWBwxckT3obiTOzGtmEfSej3i3UqJNHJBEvogimE7VsKkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259102; c=relaxed/simple;
	bh=uvayD8eZ81ck5n6ha9xbibj3shBXHK7+L0e+p/CrWS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sddyLhA9fxC9tI0T4SrLcHGFQGXYFaSvS6IN6hWPkKxZIfLOam5AlCdAVfFTpi1XIzmFRdvBNI+Ynvc0d0fmo6hP2sHv7aYYBmLqgzEy/Bz34EBprINDnRflBKrF4ySAaz0aOSkHtWqGxJSjOK75Kr7vJDsev2ckPdRiRSzLnUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NPZhpJac; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73d0152369fso246410a34.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752259098; x=1752863898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cp5rlyuG/Vsl7s1cN9TVa6qAclD7pr5ydYSWsYjavKs=;
        b=NPZhpJacv+Wjhaorv3IPwVvCetG1NqQ9KYjH4QuRYbohA3gc4b9yhG7zdpj+dxbFzB
         wwrJQ06wHsa0SRDlKRcQfCRQ0O3kKfsibN4TJaC6W0kmifSF25eus+Od+lqCmL/WrmJ+
         BXKbFJDjeL9cn7Mkf5/F5tELZK6ABwnzmARAefk21v5kAPOWwXOLXSYF7Mjfnv5+1Hx9
         JdulxnK49klFlJ0gXpy+Y77YqbMfovOCfwUOFENG+uerJ816OkRGf3CZ9TOba59DrfDx
         wts0zYHv0G9kTSa5tK7fdr0IB4N5r8BvWyNHDJPs7ouv1LPUQZQjMSiY3JeDlHstPQri
         r8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259098; x=1752863898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp5rlyuG/Vsl7s1cN9TVa6qAclD7pr5ydYSWsYjavKs=;
        b=LYwOLRZXO40f+levAyGidADoecixD2x5CWJgFhEGLGMP/ZfLNPgfpmAsEl6meYS63W
         zV+EG469dHKV+oEj58B85bzRY3eHpXKmnf/gH3L34KyJvkcstbvn7iOvTLx/2ZLpSUaZ
         i1jhjrIx/LNQDc1T0mu5wWqVjwmenKpG8whtnUw7xeQNuaEGyY04XD7GNLa5PwSpqd4k
         bs2kG8bF/o2BcSbvIw7LdbPWrMG57q7OTGBfxAk+76eiBtU/ospVRNmckmFvxxNEz7RK
         195cCXXB5+vC7XzBCxgs17zv7uDjGGL0WwyFJrzxcEbRzWO0ZvZwm5ELDfwB6nfqpadu
         Y92A==
X-Forwarded-Encrypted: i=1; AJvYcCUf5BQG3N/uA/T40ojmDiDmr7/1S+PmQyc/eMid3VTQcL2aWO8Lm2X3BHFxVqvUXacMw5CjPaog0SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrhIBbuDs+5qleUMfaqNzJI0cLWjEIQpJgb1uG/w0kwkVD+bu
	0ZTh9hHtiRa0wAVY67doIFprmcjMPu3rBSy71sCQlhwZ+1TXxhENnafbT2NwLjVFlQg=
X-Gm-Gg: ASbGncva25cuVMFLjRjo42C4Rr74wk4W9bSczyAfz89f7e+l2C/hFAupHNL4jMwCe3C
	9xW3y0KoStWVFxl7pWhVS8KKaIX40Je45gDwukeNkoX3phHK6+AJ5F9gVWD+1y0q18xeTL9BDvc
	YPU3H7HR4lvaDfWqAyONGhS6uao3om9mfCgxYVmN9dCpFtG4Cir4YYVzxQGe5F3jFeHItrInG+L
	2c/pfxirooEtnCcZyup1lIPY3ya6topwW7gt4fcA4z+CstUgp6j4O/wPvod2vROv1DXfMgVDyjY
	Vn8VQ0g+IzQwVGKqePwZPJEwwDBl/WxLSBWiRC0er4bUJl+1198+GC0kyLCBLAlujtAQtvjk/wt
	N6vrZbQcqEIiT3ekAZQsDQNcZxTy1BihzRbh8lRfrWM+OY2LJUS+1rsAcore0p6jPx9RICybRhB
	0=
X-Google-Smtp-Source: AGHT+IEx2HrfCirqlgeXyqq1Oi8u5uicmdKq6gt86ygPDIvQhwOI10dt+GHcgiSojjgliobmTZb4NA==
X-Received: by 2002:a05:6830:d1b:b0:739:fcb4:db17 with SMTP id 46e09a7af769-73cfb1d773dmr3028307a34.15.1752259098518;
        Fri, 11 Jul 2025 11:38:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12b62e8sm649705a34.60.2025.07.11.11.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 11:38:18 -0700 (PDT)
Message-ID: <4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
Date: Fri, 11 Jul 2025 13:38:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
 <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
 <aHFO7LhWXOuglaoz@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aHFO7LhWXOuglaoz@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 12:50 PM, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 12:04:03PM -0500, David Lechner wrote:
>> On 7/11/25 11:41 AM, Andy Shevchenko wrote:
>>> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:
> 
> ...
> 
>>>> +#include <asm/byteorder.h>
>>>
>>> Hmm... I see nothing about this change in the commit message.
>>
>> It is for __be16. I kind of assumed that would be obvious, but sure,
>> better to be explicit about it.
> 
> Isn't it in types.h?
> 

No, only CPU-endian types are in types.h. The actual #define for
 __be16 is in include/uapi/linux/byteorder/big_endian.h. This is
included in one driver in staging, otherwise it is only included
in arch/*/include/uapi/asm/byteorder.h. And asm/byteorder.h is what
Jonathan used for similar in some of his recent IWYU patches as well,
so I assume that is the preferred way to do it.


