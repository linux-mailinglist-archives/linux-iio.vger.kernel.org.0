Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A657B17D00D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 21:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgCGUsC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 15:48:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40619 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCGUsC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 15:48:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id e26so5877829wme.5;
        Sat, 07 Mar 2020 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ziFCZjudOEoSpdz7d2yWfia39dXlf0qOBljsEcTWZL8=;
        b=m3jRXFnC3RA86byBozOVT2XsLJXEYY2jFderK0EJ8xVynmByhkqqqMBL3p+jekRoT2
         J/JJ6ptLY4reR4iKMjOGp6VlKdTWwntQDpahN7QJ3ncwlnC0aREKd40UAxEW8Zz6Kvga
         N1GW4Q6V5xeNxUdRYNgETIFYvPvjvOKwZd9mr3p9nNmYZMM3Dvp2wITGRGDj6jbM9hv8
         dAltjy5UZSZM9LBa1oGx8/KgLoE0QY759DvAHpLDSXKCISm1PMH8YcGzfWTxiFfqhJ25
         9S2An6jXTA7zvR7hfxoQy1700i7zKkWTVwGFz5tU1v1Lx80xoREV930gxA+swXzFfPL1
         Eciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ziFCZjudOEoSpdz7d2yWfia39dXlf0qOBljsEcTWZL8=;
        b=SPrOnHvTBIrAtYy++4SrqiphUOYpuSW6zxF3EP0otSpvbmm86TNc0A4g5P0QpzHCzR
         1W1Nf8stcV2mbfb6YU/n6J7wZVFrFtWq51msHBz1JN6eo4/Execr/eRoC8RxHEK6LGh7
         U6/uEE1vedVakO6isBhzdnlvojC/sQkLpObMeuokd0EtpM+XumMJSIbGWN0actc0JXvq
         vw5TYLNdP4aPHUZQUorZVOYGLLki4liX+omJ4ybd0W5g4uTgsA2FevqJJFvY3UEl8trA
         fkg3Vz1au0Xd1yni9WAJCxpeFS9ehSXZjt/08vQ/Kw3q51KqsZ20EIbwmMMmOZssUmiN
         eLWA==
X-Gm-Message-State: ANhLgQ3/kmQakvYeAF+GCJcLlgzuF1DOBpmSQIfGop1pMGBMP2eceE3B
        M3g1r0erKmmBxVYvJhQEZVq7arPTVrQ=
X-Google-Smtp-Source: ADFU+vtNe+RN3wY1HIILDHoeDsBmXatP3JK6rafsZzvlf/PJADmLS6hLMwPn/0glIDzhkLN+KBVMhQ==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr11554301wml.90.1583614079020;
        Sat, 07 Mar 2020 12:47:59 -0800 (PST)
Received: from ?IPv6:2001:a61:24cc:fd01:4c3a:3001:350e:71a0? ([2001:a61:24cc:fd01:4c3a:3001:350e:71a0])
        by smtp.gmail.com with ESMTPSA id b5sm12229797wrj.1.2020.03.07.12.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 12:47:58 -0800 (PST)
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
To:     Jonathan Cameron <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20200225124152.270914-1-nuno.sa@analog.com>
 <20200225124152.270914-6-nuno.sa@analog.com>
 <20200303211045.31f977bb@archlinux>
 <9b9e18f279edbcb60122a0b0d4c067975868194a.camel@analog.com>
 <63b5c766-78a2-59c4-6efb-3eb35031a351@metafoo.de>
 <3bdae6c113381c7dd0645b7b98c67fac734b92ab.camel@analog.com>
 <13e355c6-af60-772a-92ec-aff17d0255ee@metafoo.de>
 <a6b4c76a337f53db1ee05a03eca06751b901d04b.camel@analog.com>
 <20200307113349.27e4484a@archlinux>
From:   nunojsa <noname.nuno@gmail.com>
Message-ID: <292029f7-e30d-b510-95b0-e6037182a63b@gmail.com>
Date:   Sat, 7 Mar 2020 21:47:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200307113349.27e4484a@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07.03.20 12:33, Jonathan Cameron wrote:
> On Thu, 5 Mar 2020 13:04:27 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> 
>> On Thu, 2020-03-05 at 13:43 +0100, Lars-Peter Clausen wrote:
>>> On 3/5/20 1:27 PM, Sa, Nuno wrote:  
>>>>> In my opinion there is should not be a difference in the
>>>>> userspace
>>>>> interface for chips that do support 32-bit burst and those that
>>>>> don't.
>>>>> For devices that don't support 32-bit burst it should be emulated
>>>>> by
>>>>> reading the LSB bits registers manually.  
>>>> Hmm. In terms of interface I think there is no difference. We
>>>> always
>>>> report 32bits channels (for accel and gyro). However, what we do
>>>> right
>>>> know is just to set the LSB to 0 if burst32 is not supported. So,
>>>> we
>>>> can be just ignoring the LSB bits if they are being used...  
>>>
>>> What I meant was that somebody might still want to get the full 32-
>>> bit 
>>> values in buffered mode, even if the device does not support burst32.  
>>
>> They are. Just that the LSB part is always set to 0 :). And that, in my
>> opinion, is wrong. As you say, we should do the manual readings if
>> there are any bits on the LSB registers...
>>
>> - Nuno Sá
>>> In 
>>> that case you can first do a 16-bit burst read to get the MSBs and
>>> then 
>>> do manual reads of all the LSB registers and then put both into the
>>> buffer.
>>> - Lars
>>>   
>>
> Thanks Lars and Nuno, I'd not grasped exactly what this was.
> 
> Hmm.  Not allowing for variable bit widths has bitten us a few times in the
> past.  Howwever, it's a really nasty thing to try and add to the core now
> unfortunately.
> 
> In some cases we've just padded the smaller bitwidth buffer but that
> is costly to actually do.  You get fast reads from the hardware then loose
> at least some of the benefit respacing the data.
> 
> Still it is definitely a policy decision so not DT.  It's ugly but if
> we want to support it and can't do it at runtime, perhaps a module parameter
> is the best option?
>

So, we can decide this at runtime. As Lars pointed out, the LSB bits are not
used by default (decimation and FIR filters disabled). However, applications can
change this by changing the sampling frequency (affects the decimation filter)
and the low_pass_filter_3db_freq (affects the FIR filter). If one of these filters
is used, then the LSB bits are meaningful and makes sense to use burst32. For parts
that do not support burst32, we should manually read the data.

I started to prepare the version 2 of this series and Im starting to have mixed
feelings. For now, I can see 3 ways of handling this:

1) If we assume that changing from burst32 to burst mode can occur at any
time, we need some special handling. We need to realloc the buffer used
on the spi transfer and readjust the spi xfer length. I'm not a big fan of the
realloc part...

2) Alternatively, we could introduce a `burst_max_len` in the library that could be
used in devices with different burst modes with different sizes. Max len would just
hold the maximum burst len (as the name implies) and would be used to allocate
the buffer to use on the spi tranfer. On the spi xfer we would then use the real
burst length. With this we would not need to care about reallocs...

3) More conservative, we would not allow changing burst modes if buffering is
ongoing... Changing a filter setting that would lead to burst mode change when
buffering would return -EPERM...

Either way, I will probably just send the v2 patch with 1) and then everyone can have
a better look on how it looks and we can discuss improvements/other mechanism in the
v2 thread.

- Nuno Sá
> Thanks,
> 
> Jonathan
> 
> 

