Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A096DD175
	for <lists+linux-iio@lfdr.de>; Tue, 11 Apr 2023 07:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDKFS3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Apr 2023 01:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKFS2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2023 01:18:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83746E7C
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 22:18:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m4so8714087lfj.13
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190305;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=055G5++0hrj+lGE+bpYDHnB1n7dRzj5SrUQtAgHYbb4=;
        b=qCMmZ6/7fc+5qqfrXQZp4giePZXvu5nQnjih/LB8tc2xfVWrLyOLOk13I3VTAsefGn
         noB7uH3lcuzaJkLwT/22M6Qj84Oy9ZvnowIdhZP1oXo9lRvOzFDlfoS/Q2VVzbwuKpcr
         f8LBsPqcPUTLvc3MCaIRJQjwehpCuW7mZ4M8PksWWqSjZqdOnTJqqQ/c7hcCt86vH+Jv
         lR/gUuuatIMJJ8T92uIo0zL+7ImPQkA2jsYwphne+yI0kt3fNN6wweLDBLP9cSkItKoK
         KeXaOM/pg2H2WAcpi9JmegQP0DLZ6KkimVnQ5jUXMVwoKiMgIv+uKIoFLBTHlqEFKwMe
         njQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190305;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=055G5++0hrj+lGE+bpYDHnB1n7dRzj5SrUQtAgHYbb4=;
        b=Q2pdA8fQElDoD/m0V7zEvWc/RjeogXAZuCyjmgLs2IUxQgS9iFmffn2G19loCUDqvM
         1GjPvaPPzqP9G7+MtBP8PnDJM1Kae9iOsm8PydHFJdX289ly2HasBAjT4OCf0lvFP4cJ
         xb+xJYugBXQh3f6OiNLxi9Xmtbq2W+Kye2TlFTxJR+yPOjuuvFiSQe9bQmxQkO3/7t5X
         xawtJpuxjmrpIkerrpA7RLDV+nEPgaCqnI7CmNWXMG3ziLuczjXckjNdDHVCiro+hfgY
         nXE/B5lFNLesVv0eurSkj9URl8EkT0fwInsexXByXnIaBSI1m2BIgdtGyDs8lKykLbsa
         AWXQ==
X-Gm-Message-State: AAQBX9ebhwd0pC/JXHEYQkkCOeWwOlOCwV2BJexCXkXYfDqeJineg+ee
        HjRYweqAPGmZt1Yl8BeCPW+IKYqKvUQ=
X-Google-Smtp-Source: AKy350b8cv3X8R+4HXQ2wN1oscbVBnTCECN88RT5W5bVZ2m9HEV86G+ZBGcsYGPDB7dAKLQyMiHmUw==
X-Received: by 2002:a19:f613:0:b0:4dd:a57e:9960 with SMTP id x19-20020a19f613000000b004dda57e9960mr409008lfe.5.1681190304465;
        Mon, 10 Apr 2023 22:18:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id k18-20020a2e8892000000b002958a51df76sm2596820lji.92.2023.04.10.22.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:18:24 -0700 (PDT)
Message-ID: <8e61fb87-2533-9a81-1682-2e5ee376389d@gmail.com>
Date:   Tue, 11 Apr 2023 08:18:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <5942c0c2-3997-e10f-0872-30d201bc52ae@gmail.com>
 <20230410171654.66605efe@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: ROHM BU27008 RGB sensor
In-Reply-To: <20230410171654.66605efe@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/10/23 19:16, Jonathan Cameron wrote:
> On Tue, 4 Apr 2023 15:04:38 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi deeee Ho peeps,
>> I have following questions:
>>
>> 1) I have no good knowledge as to what units the register values
>> represent. I know the greater value informs greater color intensity -
>> but that's about it. I currently just send out the raw register values
>> via IIO_INTENSITY raw channel - but I don't know if this is usual or if
>> typical user-space would expect the values to be some how 'normalized'?
> 
> Given these colour curves are normally devices specific, it's often very hard
> to give them any units that can be compared across devices.  There are standard
> colour spaces, (CIE 1931 RGB for example) but basic sensors tend not to be matched
> to these. Sometimes there are documented approximate conversion calculations
> (similar to the ones you get for illuminance calculations).  In some cases
> these are highly non linear with different approximations for different parts
> of the colour space.
Okay. In that case I'll probably just go with the raw register values, 
thanks!

> 
>> With the current setup user-space needs to either just compare the
>> different channel values to each other to decide which colour dominates
>> - or perform some manual calibration using known light sources. I have
>> no idea if this is usual approach with RGB sensors?
>> It seems to me that
>> for example the adjd_s311.c just returns raw register values - but I
>> don't know what the format is. Any insight on if the values should
>> represent some 'units' or if they can really just be 'register values
>> proportional to intensity of measured colour'.
> 
> There isn't usually a way of measuring which colour dominates.  That depends
> on all sorts of things that affect human perception of colour. All you can
> measure is that the intensity of a particular colour is itself increasing
> or decreasing.


> 
>>
>> 2) The gain setting is once again ... eh ... complicated. The RGB and C
>> channels are sharing gain setting. There are a few supported gain values
>> - ranging from 1X to 1024X. The IR channel _shares_ again the high bits
>> of GAIN setting with the RGBC channels. Two lowest bits can be set
>> independently - but again, quite a few gain 'selector' field values are
>> marked as forbidden.
>>
>> To make it worse, the IR gain values matching the selector field are
>> same as for RGBC - except the first selector. The sel 0 equals to gain
>> 1X on RGBC, but gain 2X for IR. (1X is not supported for IR). So,
>> changing gain selector from 0 => 1 will cause gain to jump from 1X => 4X
>> for RGBC but from 2X => 4X for IR channel.
>>
> 
> That's "novel".  Feel free to tell the Rohm hardware folk that I think they
> are crazy in a really unhelpful way.

As a ROHM employee, I should probably be a bit taken aback - but this 
actually made me laugh. Well, I was on a vacation when I read this so 
maybe it is Ok ;)

Well, ROHM hardware folks have a long history of making hardware, and 
typically hardware for a specific customer and for a specific need. 
They're actually truly novel at times - and they tend to solve pretty 
impossible problems with pretty "out of the box" solutions (at times). 
Unfortunately, these novel solutions which solved a specific problem for 
a specific customer tend to be inherited to next products where these 
'hacks' may no longer have a purpose. Furthermore, (as far as I know) 
for a long period of time, the software for ROHM ICs was also written 
either by a customer, or by a subcontractor. The (driver) SW was written 
for a specific project and it was not necessary to make it fit for 
generic use-cases - hence, things like this 1X Vs 2X gain did not really 
matter as SW could be tailored to just do the right thing for a specific 
product. When the product was out the project was done.

This means that there has been no "feed-back" loop from SW engineers to 
many of the ROHM HW colleagues. So, even though you hit to the spot with 
the comment - there is a very understandable reasons behind things being 
somewhat ... peculiar ;)

And yes, I have been and continue to be giving feed-back to hardware 
colleagues. And even though I am very much tempted of using your quote 
as my email signature, I guess it is more productive to try a bit more 
gentle approach with the feed-back. XD

> 
>> I see two options:
>>
>> 1) Use fixed high bits which means supporting only 4X and 16X gains -
>> for which changing the low selector bits is enough. In this case the
>> RGBC would have own gain setting, IR would have own and there would be
>> no shared bits.
> 
> That's pretty nasty as I suspect the high bits are the useful ones.

I kind of agree. So, while that would be the simplest thing, it would 
also drop most of the gains the HW is capable of.

>>
>> 2) Allow full range of supported gains to be set for RGBC - and disallow
>> setting gain for IR. However, change the IR gain to have same selector
>> as RGBC gain when RGBC gain is changed. (This prevents IR gain selector
>> from changing to an unsupported value when RGBC gain is changed). This
>> means that if user-space changes the gain for RGBC, it should also
>> read-back the gain for IR to detect the change. I have no idea if
>> existing user-space apps do this.
> 
> We've had other cases where setting a gain affects a subset of channels
> (shared gains for pairs of channels for instance). In those cases userspace
> has to read back the values.  I suspect there are no userspace programs
> that do anything more complex than setting gain to a value in a config
> file.  So if that's valid then all is good.

Oh, interesting. I don't know how userspace apps utilize these sensors. 
Nor do I know what these RGB sensors are mostly used for. I however 
thought userspace apps would be detecting saturation / measurement 
values going close to zero, and did dynamically change scale based on 
this. Config file sounds like most of the apps just use a static 
settings - which indeed simplifies things.

>> I think that no matter if we select option 1) or option 2) - we must
>> have own scale entries for all channels. This is needed for option 2)
>> because of the 1X vs 2X difference mentioned above.
>>
>> I have currently implemented the option 2) because it supports wider
>> variety of gains - but I am unsure if this is "the right thing to do".
>>
>> Any insight is appreciated!
> 
> Hmm. Given the pairwise case I mention above requires that any write to
> gain can change any other and there is no strong reason it must change it
> to the same value as the one written.  So setting channel 1 scale to x2 might
> result in channel 2 scale doubling from x2 to x4 (think of a fixed x2 multiplier
> on channel 2 with a pga in front of it (this craziness happens on SoC ADCs
> sometimes) I think you can be more generic about this.
> 
> Have all channels have their own scale + scale_available.

Ok. My current draft did not have 'scale_available' for IR because 
setting scale for IR was forbidden.

> A write to any of them changes the value with exception of when it affects only
> the lower bits where you can separate off the IR channel.  If the change requires
> changing the upper bits than fine it changes the IR gain as well.

Thanks for the suggestion. In my head this felt too complex but now that 
you wrote it down, it does not really be that complex. We can simply 
compare the old and new values for high bits and set the lower bits for 
other channels only when high bits change. (I wrote it like this because 
I am at the same time working with yet another RGB sensor model, with 
yet another messy 'shared bits' gain setting. The other sensor has 
individual 'low bits' for all channels, while having shared high bits...)

> Another option comes to mind.  Just have one scale value and don't allow the
> lowest gain value.  That way you can always program the scales to the same value
> by setting both registers.  So basically hid the oddity of that different
> 1x vs 2x initial scale by not supporting it.

Yes. That would be an option. Not supporting 1X makes the 'saturation 
point' for RGBC to jump 4X lower though... I will see how the code looks 
like when implementing the 'check if high bits changed' logic you 
suggested. Well, thanks a LOT for the help! This means I will soon(ish) 
pour some more patches to your review queue :) (Might be I do some PMIC 
work before that though).


Thanks,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

