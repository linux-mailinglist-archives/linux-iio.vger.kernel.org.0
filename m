Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A06A3BA9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Feb 2023 08:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjB0HWR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Feb 2023 02:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HWQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2023 02:22:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFF8EB72
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2023 23:22:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id t11so7286429lfr.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2023 23:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EU7lHYsPK0BWCqBE0nYCFNdNDwxT7EF2/blreDR8nLs=;
        b=GWatyUcsFty5U/jB5iKgm1jxuhlDE6Mdob1y5NBw2UAofcD5HQuQ6fE/KDseqkEYfg
         WT8EL7wk/CwQdXAto9N45nCeyT24vavrlY4SwvfZ0JgQIi0GHcaGa62q3tZYfv6DRm9g
         c27QhqKXGPTmCDjES45d5OQwbw88DlpGdpw08mucBAKPEXZl7e+wohGA81B4r/EX6hKB
         fVnAokQT4C4hnfVvHilIREvbFTvY9JP9nYjArnq1Hz7MemPhF2oTYz+yzDzV+T0wqfxi
         21GTTB+GXsbsNI28elQvx1p7/x6byq4yXequcTy1SpEwvwytbdp/kgCPtsP6vaFXqua9
         UA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EU7lHYsPK0BWCqBE0nYCFNdNDwxT7EF2/blreDR8nLs=;
        b=EorMqZqnsDeXze8J35QpoXpsQLujysHH1vK4OYYeooS1B857HuybffFLkhlv9yIPti
         PBkLJifMKJNHY6Y8cw8pT5VoCTrP+9BuW025NS1yBXM396SezwjoILMLQFPGyh+pESjC
         Uz/bssIVPzmRJZ67vQaT66xpPniLubs5B6lEwLIz/g9ys3slzB1WAscKyEaxTS/lY/rL
         Rc4v/xhGD4ylVxGFsH9iYVITLzKtTb0dxOh500TyYes63rGvzbGL5f7vxtQyeGVGCBqi
         ao0Xoxk1KkqxblOcsa0J1Zbx6lxrcwyDy3OV/CuDkBx/4gefw79wsbKsIp3Lzej7IkSX
         PQxA==
X-Gm-Message-State: AO0yUKV1D4+8TKWmatejRRC/JAiTbr7KnTPF2vxsWwORF48Oj74Rc5iN
        Vmv1rqMJzTPLFLT/8p/D6XnF0UxAfeU=
X-Google-Smtp-Source: AK7set8DZmqn/X9NbZZhyDiK65ExHR89h4exn6c2G4Q0k4oL0v4/TL8zFoROXrpnKd5vmomGNQHA8w==
X-Received: by 2002:ac2:46d9:0:b0:4dd:ac8d:671f with SMTP id p25-20020ac246d9000000b004ddac8d671fmr2986285lfo.34.1677482533672;
        Sun, 26 Feb 2023 23:22:13 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25594000000b004dc4feeb7c6sm817960lfg.65.2023.02.26.23.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 23:22:13 -0800 (PST)
Message-ID: <c88c1672-badd-18ae-fcb7-bf2696319aba@gmail.com>
Date:   Mon, 27 Feb 2023 09:22:12 +0200
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: ROHM ALS, integration time
In-Reply-To: <20230226172958.1b4a87f2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/26/23 19:30, Jonathan Cameron wrote:
> On Sat, 18 Feb 2023 20:08:10 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Thanks a lot Jonathan,
>>
>> You have been super helpful :) Thanks!
>>
>> On 2/18/23 19:20, Jonathan Cameron wrote:
> Hmm. There is another approach that I'd not thought of in this case because
> in my head integration time is more continuous than it is for this part and
> that is to fiddle the _raw values (we do this for oversampling or SAR ADCs
> where things tend to be powers of 2).  The trick is to shift the raw value
> always so that the 'scale' due to (in this case) integration time remains
> constant.  That separates the two controls completely.

Holy cow! That's a neat trick which I didn't think of!

Basically, we could do >> 1 for the data when time is 100 mS, >> 2 when 
200 mS and >> 3 when 400 mS. We would want to use 19-bit channel values 
then.

> However, I'm not sure that makes sense here where the thing we typically
> want to change when scaling due to saturation is integration time.

That's a bit problematic, yes. We could "fool" the user by doing the 
saturation check in driver, and then just returning the max value of all 
19-bits set if the saturation is detected. This, however, would yield 
raw values that are slightly off. OTOH, with max sift of 3 bits that's 
only 7 'raw ticks' - which I hope is acceptable. I hope the user will 
then be switching to shorter integration time and start getting correct 
readings.

It's slightly sad to say "good bye" to the gain-time-scale helpers but I 
guess you just helped me to solve this with a _really_ simple way. We 
can keep those helpers in "back pocket" for the day when we need them ;)

I will see what comes out of this idea - thanks for the help again!

> 
> Jonathan
>>
>> Yours,
>> 	-- Matti
>>
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

