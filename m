Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBB654D78
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLWI3P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 03:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiLWI3J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 03:29:09 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD02734D2E
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 00:29:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so6166378lfb.13
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 00:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:cc:content-language
         :references:to:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lAPnAFAPMmCL9GyOe3FaeDXi2cJ+AVPL4q0fGkCBYio=;
        b=Kki7zRjMHrqzdQgVZyuM6yYpITKHCpIa5Z4fSQmGy7EvdH9pw2i97U4S4QfSq7JRcO
         rR9l6j1ZpIDeSrEJ7i7BBRmfnBvHOyBXw5AF2YhXpU44dsAj5mLNcqdWJINitT23ZLXf
         kk1aO3H0FLKsCJ0E9RxuU23vsiqj5trk8IcJnhzFU9t2dPCbfur0BO3teo4wjZ2nWKbk
         /VD58f8LMbBAe6rUKCKi6a234JPibdwJc1hKU7c8UF+lYzNNFGilynt4sSrfHpLWWidc
         m3WDuvHFwE2uR1qalkkFHSSsPVokUfhKAygqcbOt6ufHj1gyTk5/A45HJ0YHVbsjqTeI
         9zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:cc:content-language
         :references:to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAPnAFAPMmCL9GyOe3FaeDXi2cJ+AVPL4q0fGkCBYio=;
        b=mAIPN65D/7U810rheX5IyeDmnhO2liftgwlf8Ur61zwijtEaHqneZCHTzAAC858C4i
         2/v2+GiemT+GD6DiANtysf+03AB/V4xIiMjd0FGtTkaxlC/Z91iZ7SiCW9zRS1bEb4fi
         4mMvQnRagpNzCh0gn/mg+ijrCZTsKK6LOdj1M7p2h641KIDPlvlhTFp2lBcl+Z0Sf4Cy
         46gjSXBTkIDVSzYo3g0aa3fZGo4wNOYHs5eW5w1T5JKsuRKXNXBBCAI5hMJGaBtnOwOf
         +AfPDGjP/xmOAThRd0jZimFMFRjuqCaXFtCHTplJ6uzRsCqZPkfAVrdcQZ4vpQufzjZm
         3L+g==
X-Gm-Message-State: AFqh2kq59cL+K257fWmcexihs+ZSKRX/0eS8E6mBlxmAJf6nIpGyQM5p
        yIX/WBEvHi4R7r2cX/PGLq1Yvaw0B3M=
X-Google-Smtp-Source: AMrXdXun6Y5vF4KxP4C9u8XGTO1tNnSE44E9F1fmulaBGexJthEpeNUlDA0gqVrSJydhkgdISFAtvA==
X-Received: by 2002:ac2:454b:0:b0:4b5:5fc1:9d1e with SMTP id j11-20020ac2454b000000b004b55fc19d1emr3149407lfm.44.1671784146930;
        Fri, 23 Dec 2022 00:29:06 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::b? (dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::b])
        by smtp.gmail.com with ESMTPSA id q8-20020a2e8748000000b00279f213302bsm315163ljj.57.2022.12.23.00.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:29:06 -0800 (PST)
Message-ID: <0adad745-004d-8f70-510c-8af3c0935c2a@gmail.com>
Date:   Fri, 23 Dec 2022 10:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Mehdi Djait <mehdidjait@gmail.com>
References: <CALpf1uAE+H+kMHmCoeACF65YDK0cNwie5MG3a11rkVKs59XLLg@mail.gmail.com>
Content-Language: en-US
Cc:     "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: KX132/134-1211
In-Reply-To: <CALpf1uAE+H+kMHmCoeACF65YDK0cNwie5MG3a11rkVKs59XLLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Mehdi,

On 12/22/22 16:06, Mehdi Djait wrote:
> Hello Matti,
> 
> First of all I apologize for bothering you out of the blue and I hope it 
> is not a bad time to send you an email with a couple of questions.

No problem. But I suggest you CC the IIO mail list when sending this 
kind of questions. It may be the messages where the list is not in CC 
are regarded as spam by my mail filters... Besides, others with more 
insight to IIO may be able to further help you when the list is CC'd ;)

> My name is Mehdi Djait, I am a student living in Germany currently, 
> REALLY interested in linux kernel development and still trying to find 
> something to contribute to the kernel. The IIO subsystem seems like a 
> good place to start for a kernel Newbie and am currently investing my 
> time in learning the subsystem (reading driver implementations, the 
> IIO-core, lurking in the mailing list ...) I have been looking lately 
> everywhere for sensors without a kernel driver and I stumbled upon the 
> KX132/134-1211 accelerometers and that's why I decided to send you an 
> email with these questions:

Oh, thanks for contacting me :) So, you have the sensor hardware at your 
hands? I think this is mandatory when writing a driver.

> - Am I correct in assuming that the accelerometer does not have a kernel 
> driver ? I looked in the RohmSemiconductor Linux-Kernel-Input-Drivers 
> and Linux-Kernel-Sensor-Drivers GitHub repos and grepped inside the iio, 
> staging and linux-next trees

Yes and no :) There is a kernel driver which supports many of the kx* 
accelerometers in the ROHM downstream Linux-Kernel-Input-Drivers, and I 
believe it also supports the KX132/KX134. Yet, as the name suggests - 
these drivers are not exposing the accelerometer using IIO but the INPUT 
subsystem. Reason is that quite a few device manufacturers still use the 
accelerometers via HAL written on top of the INPUT. Heikki Haikola (in 
CC) has authored many of these drivers. The INPUT is not the preferred 
subsystem for acceleromerers though - so you're correct when planning to 
write an IIO driver for upstream.

> - Is anyone working on a driver now ? If not, I am really interested in 
> trying to write one for some basic functionality. I am fully __AWARE__ 
> how difficult the task is (I did read your LinkedIn posts) but I am 
> truly motivated and I will use every example I can find as reference: 
> the drivers under iio/accel, the GitHub repos from RohmSemiconductor and 
> your KX02AA driver that recently landed in linux-next (Congrats :) )

Upstream support for (ROHM or any other) ICs is very welcome. It enables 
more and more people to benefit from the ICs. Companies can rarely 
support small customers and open source drivers make it possible for the 
people to work without this support :) This work has been on my TODO 
list since I added KX022A driver - but it has had low priority and I 
seem to always have some other tasks. So, Your work on these ICs is more 
than welcome!

> I’m eager to receive your feedback! (and sorry for the long text)

It was not too long :)

If you wish to proceed with the driver, then I would have couple of 
suggestions to you. As far as I remember the KX132 is not really _that_ 
different from the KX022A. Sure the resolution is different as may be 
the G-ranges. But the logic of the register interface is largely same. I 
suggest you to study the possibility of extending the KX022A driver to 
support the other variants. I would differentiate the IC types based on 
device-tree and fill in the register offsets/required quirks in the 
driver private data.

The other suggestion from me is that you could check the IC's logic from 
the Linux-Kernel-Input-Drivers. I think there were some minor 
differencies in the behaviour for example when the BUFE or PC1 bits are 
toggled.

Feel free to ask us if you hit to problems with the work, but please 
note that most of us in Finland are having a holiday season right now - 
so many of us will be offline until January.

Yours,
	-- Matti

> Kind regards
> Mehdi Djait

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


