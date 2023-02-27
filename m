Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD66A3EC5
	for <lists+linux-iio@lfdr.de>; Mon, 27 Feb 2023 10:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjB0JzL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Feb 2023 04:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjB0JzE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2023 04:55:04 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3FD1ADCC
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2023 01:55:02 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h9so5803185ljq.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2023 01:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNF+sXNCpFOnAYnc4Ajw1e5lTQrcWVIRH7k0PrCR49w=;
        b=ig1I187VgN3nBpP0yGanrD2lY6h+8TwRLuuP3jWeGO4o0rg6AdRrBvvYIebdtH2TuB
         gKIeKtGvmBb4/SEUYRL3WoxCRIy+qXTKRpO1RD11jyBHAflvpR0dM4U/AegIST7DBav3
         555efUmTQ7NKb5PuK2ZS3w6MVW7Y9D4MSGjYJMMpUgsYQ/QqcK9ctrfkif6bWq6I1kje
         XUJWqkeeqoUoAzzcRr4JwqJmZcehJ5sMPsmUSGAOIszf1aFlxWg5WiOQio40ejvJuJOx
         OFVLSG2iQ2jkJFPRCzkGLyGOCIjS4F6Jmx1T8halBFx0GDndpfmuXDceUFtet7Izn3NX
         Y14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNF+sXNCpFOnAYnc4Ajw1e5lTQrcWVIRH7k0PrCR49w=;
        b=4Etu+yGD4huG4Mf2jVD8Jy0/94364OUgRQIZwnV8FzagG8FlcnFA5aCet0ubMPatQD
         XDRklVt/wcBBt+rZB8kNkBDqzGi2DrWO2cCJDz1Eqv2CfK8uyFveM0mf2L2mal8Lu1yX
         1u70empieSN3YJEbDJiWrWRS7rORaFGrgMnit0fzrS4Vg33FuXxncpBidKhYa1GxMsMw
         SRiyhS+zQsHZR78tHoVxWN8yDd8B0TDDoS7oPFumvjpxva+YibT0PKYkuY3rCsmFd+kU
         sY5Lb9lq0LflLqto1VT/vRwAf1Qeo+XUX2N1YKI1Uie5uiJ9xsvCmbHkYsBaHBTA+7rI
         ChyA==
X-Gm-Message-State: AO0yUKXle4PK82qA52hN3fo03sbbfrjVDIyBHE1Rc9UfCM//YQh+ZDlN
        Y3BylIqnzGrEdXrYbtsyqlM=
X-Google-Smtp-Source: AK7set94ljVGuFWkHC7pdt+26jW691hAv5BlGu+C4mabxbXzzAJEeREq9MxSAapxhnoZlUxXBa2P3g==
X-Received: by 2002:a2e:9c45:0:b0:295:b2a0:498d with SMTP id t5-20020a2e9c45000000b00295b2a0498dmr1289624ljj.12.1677491700449;
        Mon, 27 Feb 2023 01:55:00 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p16-20020a2e7410000000b00295b80aa93csm375377ljc.110.2023.02.27.01.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 01:55:00 -0800 (PST)
Message-ID: <c6224b43-b77a-2e7d-2273-f496a7e72e5f@gmail.com>
Date:   Mon, 27 Feb 2023 11:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
 <20230130130231.000013b6@Huawei.com>
 <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
 <20230202165714.0a1c37ac@jic23-huawei>
 <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
 <20230218172052.12c44aa5@jic23-huawei>
 <18a6709b-4d26-2672-b056-669750b4828c@gmail.com>
 <20230226172958.1b4a87f2@jic23-huawei>
 <c88c1672-badd-18ae-fcb7-bf2696319aba@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: ROHM ALS, integration time
In-Reply-To: <c88c1672-badd-18ae-fcb7-bf2696319aba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/27/23 09:22, Matti Vaittinen wrote:
> On 2/26/23 19:30, Jonathan Cameron wrote:
>> On Sat, 18 Feb 2023 20:08:10 +0200
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> Thanks a lot Jonathan,
>>>
>>> You have been super helpful :) Thanks!
>>>
>>> On 2/18/23 19:20, Jonathan Cameron wrote:
>> Hmm. There is another approach that I'd not thought of in this case 
>> because
>> in my head integration time is more continuous than it is for this 
>> part and
>> that is to fiddle the _raw values (we do this for oversampling or SAR 
>> ADCs
>> where things tend to be powers of 2).  The trick is to shift the raw 
>> value
>> always so that the 'scale' due to (in this case) integration time remains
>> constant.  That separates the two controls completely.
> 
> Holy cow! That's a neat trick which I didn't think of!
> 
> Basically, we could do >> 1 for the data when time is 100 mS, >> 2 when 
> 200 mS and >> 3 when 400 mS. We would want to use 19-bit channel values 
> then.

Please ignore my previous mail. It seems I am once again not knowing 
what I am talking about. If we take this approach, we shift << 3 when 
int time is 55, << 2 for 100 and << 1 for 200. With 400 mS we would not 
shift.

>> However, I'm not sure that makes sense here where the thing we typically
>> want to change when scaling due to saturation is integration time.
> 
> That's a bit problematic, yes. We could "fool" the user by doing the 
> saturation check in driver, and then just returning the max value of all 
> 19-bits set if the saturation is detected. This, however, would yield 
> raw values that are slightly off. OTOH, with max sift of 3 bits that's 
> only 7 'raw ticks' - which I hope is acceptable. I hope the user will 
> then be switching to shorter integration time and start getting correct 
> readings.
> 
> It's slightly sad to say "good bye" to the gain-time-scale helpers but I 
> guess you just helped me to solve this with a _really_ simple way. We 
> can keep those helpers in "back pocket" for the day when we need them ;)
> 
> I will see what comes out of this idea - thanks for the help again!
> 

But as you surely knew from the start, the saturation problems kick in 
with the 'non maximum sifts' when the _highest_ bits never get set. 
There the 'saturation detection' would cause a huge jump by suddenly 
setting the high bits. So, yes - this does not seem like a feasible 
option here :/

/me feels stupid...

Sorry for the noise!

--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

