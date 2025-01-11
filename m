Return-Path: <linux-iio+bounces-14123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8AA0A0C5
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 05:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581FE3AAB2E
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 04:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D023153812;
	Sat, 11 Jan 2025 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="UCVz/Tp7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD182149C6F
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736569057; cv=none; b=uFZ0kV/qGn9GnvxIWg6ut0Un5Z+qdNGR2YCMmXA7BKf+wFia/g5WtgOc0HXF+RSc7W30dmiv6rPM2Yh+8Mssqig3vKf4MLVqh3mvZNu4TtCt5CgmJvPycGFs11Bszymp62l+p2NbY+IMdAbgGJYiLlX6KyhJmwcpfo1D41qg0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736569057; c=relaxed/simple;
	bh=K7gRjzmtM/J7U7/lf6E/qQ9zy+evV0LUEE9IeCzR8A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7tuWhptVFFg0tpr+ALkE1j5brL6cdOP3ahPTS57jBJWiDmXGEqS43ELFpZmhXeOsDhU8gY0sXjCMJ2o5NgIL5FVMuoGZlq9UnJ0+6VMIsD4D1sDeKw5+58s7hs2FqJdFTkbH3BU//5OZPwLhNstqJaGSV0uUrYMJ6f//kmg0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=UCVz/Tp7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2162c0f6a39so66820115ad.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 20:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1736569054; x=1737173854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrtUXt/u1nUbUgY5XqlvlTqRPS1ObOgO+r968EJV84o=;
        b=UCVz/Tp7Kg/uQHEHgSBRYjyVHR2evQKbOvAH4Qp58WNanicjPq22GLG6Pb+yg0DPks
         JgXOGOnkSxal0xIGfXMbkR+ns6k51xkU4wCbshqlQ2d/g9RG5IN16O8JW0HldGU9OJJh
         U7H7IY9zA/C/FY3b3vrOIL5LB0yhAjCJqB2vfwPqd4Dy1OZIVGK7J7GzJrgKlRcin5Ei
         hFbS/qcew5g1RlrQ7mzbMo6Ke/j8DVGE7HaBRoSw4qFKAP6GO7brOxo9CtjTPeAQ0jXe
         wO9y44UkCIExcAb7b99N9oWIeX80SCXpz3sOKB0l84N54ug4KkfhhDPcFkhJ42vnCWjg
         kgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736569054; x=1737173854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrtUXt/u1nUbUgY5XqlvlTqRPS1ObOgO+r968EJV84o=;
        b=iUXcCsO8qpMPiU+DZWgKstQz6mBJINMu8KXMWFTOizevcVslFQ1fEvuYkGDftU5sOs
         grUaTmncxxtvqO+bG3XmXZnkawlRAQMGau2zkmkq12vFyx8wc5/bAiHh3KX49GhucujH
         9aMOieHp2uvtSyG44/NUYJiKL7rsv6DGXW7gYgB4czB4Yz4xLYOclw0QTiyvALlsqykh
         VRw2otfmVHvjYMNt5QZ5JnQ5U/Bq7S4N1emetQLfCG41Wz63YVGHy0rVvBGIuOJ6V2Im
         9dfIl41yOus6E0kSCfubyr4KqSHE8PUptCy1+vHmx8YTAf2yDlDVEgz8JyqTp4Dnoghy
         6j3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhTNAtaYHp2HNa16LUxvv9cdbE2SkreScTjsNbRH4p2o608AaNn7uiJfer5F4aJtsPZi9zZkL+AVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyC//3T+GksxUOGWEqMqMhbpkgdFB7bv24l2rRtUrr7ss7u/4s
	Nr05lDurShvRb/suzvkUcwQhdKkfWl3mvymip/B7Cpv1ITnszC1Q8S/CvmhhcF8=
X-Gm-Gg: ASbGncu+mxmOB+2sudB3skQWYatxAXeo424kMdBIKmZQ4VK32P/DwpVNqdGD34WGZRb
	gicXBIS0I+j+6jywFnCojvh8zmuWcEB4KUej1vmZcf94ONHuAORlcws+zkEz6zOCRgCXwtj8JQ0
	y9jX6Trq72dbnO/90Oq5ZLvMVlo/50k06hhDKsPeft63vileza003ykD5zG54jaZM7WUpwsvMvw
	muL6cnjBHsQFtuKHJwGphIrQK5AQwy489XucDYvKrSEUntxwRMFss8fXz23UfuAP+9dxT12Fobl
X-Google-Smtp-Source: AGHT+IGTv3Geg9Zg0MonI/5srbNCzhCmd4d6jcre+MPqD6TPKTLmRJHAo4NKsnVxDeGO7doERNefbQ==
X-Received: by 2002:a05:6a00:4096:b0:725:cd8b:d798 with SMTP id d2e1a72fcca58-72d30393c81mr14194667b3a.9.1736569054104;
        Fri, 10 Jan 2025 20:17:34 -0800 (PST)
Received: from [192.168.50.161] ([180.150.112.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405943c2sm2218746b3a.79.2025.01.10.20.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 20:17:33 -0800 (PST)
Message-ID: <b25638fb-15c1-4270-ab26-769be0ce57c9@tweaklogic.com>
Date: Sat, 11 Jan 2025 14:47:28 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: gts: Simplify available scale table build
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Mudit Sharma <muditsharma.info@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z1_rRXqdhxhL6wBw@mva-rohm> <20241220192118.3e9ba7f9@jic23-huawei>
 <9c07b71a-160f-4336-8a8d-cad7003e4b68@gmail.com>
 <a49a57c0-e3fa-4d4a-aec7-be8f7a681f3b@gmail.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <a49a57c0-e3fa-4d4a-aec7-be8f7a681f3b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/1/25 00:56, Matti Vaittinen wrote:
> On 22/12/2024 11:24, Matti Vaittinen wrote:
>> On 20/12/2024 21:21, Jonathan Cameron wrote:
>>> On Mon, 16 Dec 2024 10:56:37 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>
>>>> Make available scale building more clear. This hurts the performance
>>>> quite a bit by looping throgh the scales many times instead of doing
>>>> everything in one loop. It however simplifies logic by:
>>>>   - decoupling the gain and scale allocations & computations
>>>>   - keeping the temporary 'per_time_gains' table inside the
>>>>     per_time_scales computation function.
>>>>   - separating building the 'all scales' table in own function and doing
>>>>     it based on the already computed per-time scales.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> Looks good to me, but I want to leave it on list a while before applying.
>>> Ideal if it gets some tested-by or other tags before I pick it up.
>>> As always, this is fiddly code, so the more eyes the better!
>>
>> Please, let it wait until the Christmas has passed. I got information we might be getting some testing before the year changes :)
> 
> Well, the year changed and no tested-by tags emerged. I suppose my sources weren't right at this time.
> 
> Yours,
>      -- Matti
Hi Matti,

Hope you had a good Christmas and new year. After my US trip, it took me some time
to come to terms that I have to work for a living!

The code works fine. I tested it with apds9306 driver with stm32mp157-dk2 board.

Tested-by: subhajit.ghosh@tweaklogic.com

Just want to report something else which may not be related to this.
When I tried to cross-compile with linux-gnueabi-gcc version 12.2.0 with Linux kernel 6.1.28, I got the following errors:
   CC [M]  /home/subhajit/opensource_contributions/apds9306/apds9306_backport/./drivers/iio/industrialio-gts-helper.o
/tmp/ccn9UpwF.s: Assembler messages:
/tmp/ccn9UpwF.s:22: Error: junk at end of line, first unrecognized character is `I'
...
...

I had to remove the double quotes from the macros for all symbol exports:
EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, "IIO_GTS_HELPER");
to
EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);

However the x86_64 native build of the mainline kernel 6.13.0-rc6 on my laptop went just fine with this patch.

Regards,
Subhajit Ghosh

