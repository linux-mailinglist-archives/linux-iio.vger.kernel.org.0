Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F56E1263
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDMQf0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDMQfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 12:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A85212C
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 09:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3008263FF6
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 16:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C9BC433EF;
        Thu, 13 Apr 2023 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681403723;
        bh=MQap10sIfoQGy+3xWL45BYM5Wo1+UAESY4od4klXD+c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GznSIeMYvEUt/zpb7hADCaCbG/DqN75rsHSd0ScywUbNYHWmIQ1rAIuU2MNBasG8A
         kRD45yuVeDqHhNN4sS5bDvv76w06dB6tTYV6cpngi1kPOHUnjudenZky7r4LHXo8t2
         7DL6dHVm6KeuaOoro7E3jdZuD+PVC+hZvUk75iZhwytiEklOdjKUFnGCFaCR30Mt72
         ShCx+laIapkoMFQl6g9+NWV5+zP4PvgVlf4vinTSqyPsWPTvYhgWdwh204fIJgeYA2
         91LbhxwJOv8NcIza9/U3tW8/ByJ96ue7r5NAFpvQkHP3SMQwx3x0tX8Oi1c06ixXhI
         dQt1SyjsBWAiw==
Message-ID: <d3c93e92-605a-c486-201d-6c31f55e64b1@kernel.org>
Date:   Thu, 13 Apr 2023 18:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
Content-Language: en-US
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
 <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
 <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
 <0e86cb99-dfea-5a89-3301-894a90f0964a@kernel.org>
 <CAPJMGm58m8-Uo2AdABgJNuigtrLE2=_qh1eZnj=1mg+hVPV3EA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAPJMGm58m8-Uo2AdABgJNuigtrLE2=_qh1eZnj=1mg+hVPV3EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13/04/2023 18:07, Fabrizio Lamarque wrote:
> On Thu, Apr 13, 2023 at 4:21 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 13/04/2023 10:36, Fabrizio Lamarque wrote:
>>> Added undocumented properties:
>>
>> Use imperative.
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>
>>>
>>> - adi,clock-xtal
>>> - adi,int-clock-output-enable
>>>
>>> Removed clocks from required properties.
>>
>> Why?
> 
> Current documentation does not follow existing source code implementation.

Bindings describe hardware, not current implementation.

> Patch 2/3 fixes a commit that caused an unwanted logical inversion and
> thus prevented the use of  external clock/crystal.

OK

> The driver has been originally designed to operate with the internal
> clock when clocks property is omitted.

Not really a reason to do it. Reason could be - hardware does not always
need clock input.

> 
> I thought the reason is clear from patch 2, but, as Nuno Sá already
> suggested, I will describe the reasons in full again, each time I post
> a revised patch set, even if it is quite verbose.

Your commit must answer to why you are doing it. What you are doing is
easily visible from the diff. Rephrase commit msg to explain it and add
proper rationale (hardware related, not driver).

> 
>>
>>> Renamed avdd-supply to vreg-supply, while keeping backward compatibility
>>> (deprecated avdd-supply).
>>
>> Why?
> 
> From AD7192 datasheet, you may see AVDD pin/voltage has no
> relationship with VREF pin/voltage.
> avdd-supply name is misleading, since it is treated in code as AVDD
> pin and iio reference voltage instead.

Then why removing AVDD? It is a supply, as you said, thus bindings
should describe it. I don't understand why AVDD is being deprecated.

> The option to change the regulator name or add a third regulator would
> have broken compatibility.
> Other ADI drivers already have the vref-supply property in place.
> 
> Here again I partially left the reasons in the first thread, sorry.
> 
> In any case I will remove this change on a revised patch set.
> I will leave the avdd-supply name but I'll change the description in
> documentation.
> 
>>
>> Use subject prefixes matching the subsystem (which you can get for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching).
>>
> 
> The single change on documentation will be prepended by
> dt-bindings: iio: ad7192:
> The invalid change I suggested intended to change avdd to vref name in
> the driver too.
> I misinterpreted the meaning of a single "logical change", sorry.
> 
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> You decided to ignore quite a lot of entries, but most important - also
>> lists, so it won't even be tested.
> 
> The patch is indeed based on the latest version; however the driver
> maintainer does not work in ADI any more; the first time I sent a
> message I got the email bounced back.
> I see I omitted a necessary step though.

Just use get_maintainers.pl.

> 
> You are right in saying that I did not follow carefully the
> instructions provided, but it was not deliberate. It's the first time
> I am trying to send back the changes.
> I appreciate the feedback and corrections; in the next patch set I
> will try to remedy everything you indicated.
> 
>>
>>> ---
>>>  .../bindings/iio/adc/adi,ad7192.yaml          | 28 +++++++++++++++----
>>
>> Bindings are always separate patches.
>>
>> Corrupted patch.
>>
>> Run checkpatch, test your patches with dt_binding_check. This really
>> needs a lot of work.
> 
> I kindly ask you whether the entire (corrected) change on the
> documentation file only (without any change on the driver source code)
> could be accepted as a single patch.

I don't understand the question. Each change should be one logical
change, but bindings are not related to the driver.

> 
> Unless I was wrong in doing copy/paste, the only feedback I got from
> the tests is a warning message telling that the changes to
> documentation should be isolated from source code changes.

Yep... and this should stop you from sending it.

> I will make sure these tests pass without any warning.

The patch is corrupted. Try to apply it from mailing lists...

Best regards,
Krzysztof

