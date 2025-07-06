Return-Path: <linux-iio+bounces-21404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A208AFA663
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DA43AD55A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8F3288511;
	Sun,  6 Jul 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JBAp93tD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D71C5D55
	for <linux-iio@vger.kernel.org>; Sun,  6 Jul 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818520; cv=none; b=B2pls5n4nOAztplqjjSgLJOfBxPP1SFgynCKbyiLQg6Kcni2YXFvPAdX0Bq7aG1kiaWqw4q/e/0KeFuZRWQt5ykFqRRlLZZKq/9An/rr2UC5s8waoZPHF08e3OO6c5FSSMSCukJ8fBExbB5AUGxRExz9aJ/BpIByVzAmTGJZ05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818520; c=relaxed/simple;
	bh=gAl855rLWquCepFOF4TJTi7lIXQsNdl/NaKUIwd2ESw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECGd03JVWaFotHrOVptCgFNxxvwTO+zXG//7la7AWKxoXDjgZFsHNmMregf+mW84uQ+ji4p5VLsG/4h7/Uyi8s5RrW99rX8jdodix2ATVqtlbR4l9XKyUxSUqKkdl257MQSKcBC0V8WsH0FTUyTcvYrv37Vbbv8ItUAMPfGhO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JBAp93tD; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2e95ab2704fso2324796fac.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Jul 2025 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751818516; x=1752423316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CCuIhaGw2JUP5L8X9VuvKKmy1/AXHlJm0W9YGonXO4=;
        b=JBAp93tDdjtqW7hELY1jleZr4J4UJBOt4lAE7Z40k5qRtW7t4IKWIohbJTZwNMxT0D
         Zn0AAGPk4CE5GK4NIJoUBdKe1QNGo14De++yr5QJ0e6/M0O1+8A92MLVn3h447VWlDLm
         8vkaBJZmtP/PFhdiFh037KlZHS9hExzNDQkx25a8nXbisqg23XMGW+I+xCcA+rXXd/Zv
         7msUTIePkrQhLgQ7zkBfl9JIcssYhHXtF9MWPO5yHuuT1hL9neJ98Eun5ZVusutC4E8i
         26dGvrEWXCcs8ykfxd6SIIoCHlbXtCHejQhrjxy+f3WTQetvd5SHszp2myFDSBWne2FL
         ac7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751818516; x=1752423316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CCuIhaGw2JUP5L8X9VuvKKmy1/AXHlJm0W9YGonXO4=;
        b=IT2u8eQAiddrH1OwYbZ2WWobiEPjF91vUHbDxsklKkJAJBSKD9k8d2tY/uLfOfRVDf
         K8LQAYRxNx/A2WLXKQaxt6Bh9gkfu5TqjjCdb0nDzt2p3Ny6nS4RStv1K8AnRkOjg+cx
         iLOrMIyOZRCi88Xq7zFb6Ft52T5QdNMi9RrkTu3c4uSVC9IDtNDy6WFohWIWHkP5d5nq
         5f55lcB6r6sS8307P8yD1zpC4KavPBKLyISf75g3a/N54suq0blkj+oN51JzrbyttM8t
         IXYkUwOr+CWirPSFOqZnTRkA0uvHnqg4cWOjpoN97cRtLeoXSTq5FSg7y/vVnVOyquMe
         aiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI9Cy2KuXVKeBlAKFTu+qvuz8Udf0kjpy8wmjbNoyzdc+HbKvBpniKLTtDInHQvf26SfwCOESfm9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRSzfM1eDBlK1SKlcz1Gc59WcmCqyDq0so9NhPIIB9wTfzzpv
	K4PyBpQQdNRJhO7qhYXHlQ/uNDjJr0/MkAwBrf0Ns3Fh+M60qlFotW1E2lIbibQgqKM=
X-Gm-Gg: ASbGncsqmKog2GOGtn7dQP8lq2nQinJrITHDGLgEaQXfYWhK16sIS5djJm/7OySDlDW
	HtzqwA6F6YMFpqQzFn6uehq09T8zYG70X1NMwcDy6a84YnhWRBEy7ZRPNE5QPOt8wl9rw8ZX+04
	K4rVbRpntP8tTBFBUyakZdN1lRh5SGUEiD5yzY81E3ZFHFmWaCWheHGXcjiZZbhNmWCJzVQO92+
	ACHhuUX7LxQ+3zKNMeTj+JXhoVu+cmHYqVccZ5fVoGl0J4BrEHCtnEt/J9POzD9L0ZAU06zahmr
	TcKRzV9dPt0BNvst878hyhJXeB3k//dgbkF3Itt3Zgb8KXRGKtRZ+IRugVyar1EOO9wEQQa2ET9
	nikLJpN6Jcf2YHVnKMi3Rv+xQu7Kb+5CexF6DhI7T/4g3Mkk=
X-Google-Smtp-Source: AGHT+IFCTPIZ0WXVRAmR7v768qE2jySN2EB/oekDv6XWLXwEPF+k2fWpAsncS+4yrAvfVEulhT/Vvw==
X-Received: by 2002:a05:6871:79a5:b0:2d4:e101:13dd with SMTP id 586e51a60fabf-2f791cebf01mr7263590fac.1.1751818516500;
        Sun, 06 Jul 2025 09:15:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29a:290f:4321:4624? ([2600:8803:e7e4:1d00:29a:290f:4321:4624])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f79020d17csm1749699fac.34.2025.07.06.09.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 09:15:15 -0700 (PDT)
Message-ID: <ca0be466-6673-425d-97ab-292791253a63@baylibre.com>
Date: Sun, 6 Jul 2025 11:15:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the iio tree with the spi tree
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 linux-iio@vger.kernel.org
References: <20250703163824.2f08d866@canb.auug.org.au>
 <20250703093122.00000684@huawei.com>
 <b0b0443d-143f-4e41-b8b8-91c6726e838f@baylibre.com>
 <20250706115053.368ce9e9@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250706115053.368ce9e9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/25 5:50 AM, Jonathan Cameron wrote:
> On Thu, 3 Jul 2025 07:28:07 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/3/25 3:31 AM, Jonathan Cameron wrote:
>>> On Thu, 3 Jul 2025 16:38:24 +1000
>>> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>   
>>>> Hi all,
>>>>
>>>> Today's linux-next merge of the iio tree got a conflict in:
>>>>
>>>>   MAINTAINERS
>>>>
>>>> between commit:
>>>>
>>>>   e47a324d6f07 ("dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI")
>>>>
>>>> from the spi tree and commit:
>>>>
>>>>   0dd88eaa7126 ("dt-bindings: trigger-source: add generic GPIO trigger source")
>>>>
>>>> from the iio tree.
>>>>
>>>> I fixed it up (see below) and can carry the fix as necessary. This
>>>> is now fixed as far as linux-next is concerned, but any non trivial
>>>> conflicts should be mentioned to your upstream maintainer when your tree
>>>> is submitted for merging.  You may also want to consider cooperating
>>>> with the maintainer of the conflicting tree to minimise any particularly
>>>> complex conflicts.
>>>>  
>>> Thanks Stephen,
>>>
>>> David, do you prefer these merged or kept as separate entries?  
>>
>> Ah, shoot, I forgot that we had added the gpio one and just made
>> one section like this.
>>
>> I think it would make sense to also merge the new adi one with
>> the reset to keep things compact.
>>
> Is there a path to do that cleanly given the multiple trees things are
> coming from?  Maybe this is a let things resolve whatever way this cycle
> and tidy up next?

Agree, waiting seems the simplest option.

> 
>>>
>>> I don't think it matters either way in practice though this is the
>>> more complex merge (the other being just putting the blocks in order.
>>>
>>> We can put a note in the pull request on preference but ultimately Linus
>>> will resolve this however he prefers! 
>>>
>>> Jonathan
>>>
>>>   
>>>> -- 
>>>> Cheers,
>>>> Stephen Rothwell
>>>>
>>>> diff --cc MAINTAINERS
>>>> index dd764b947dab,d0809d62ff48..000000000000
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@@ -25333,19 -25201,15 +25341,20 @@@ TRADITIONAL CHINESE DOCUMENTATIO
>>>>   M:	Hu Haowen <2023002089@link.tyut.edu.cn>
>>>>   S:	Maintained
>>>>   W:	https://github.com/srcres258/linux-doc
>>>>  -T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>>>>  +T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
>>>>   F:	Documentation/translations/zh_TW/
>>>>   
>>>> + TRIGGER SOURCE
>>>> + M:	David Lechner <dlechner@baylibre.com>
>>>> + S:	Maintained
>>>> + F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
>>>> + F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
>>>> + 
>>>>  +TRIGGER SOURCE - ADI UTIL SIGMA DELTA SPI
>>>>  +M:	David Lechner <dlechner@baylibre.com>
>>>>  +S:	Maintained
>>>>  +F:	Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
>>>>  +
>>>> - TRIGGER SOURCE - PWM
>>>> - M:	David Lechner <dlechner@baylibre.com>
>>>> - S:	Maintained
>>>> - F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
>>>> - 
>>>>   TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
>>>>   M:	Dan Williams <dan.j.williams@intel.com>
>>>>   L:	linux-coco@lists.linux.dev  
>>
>>
> 


