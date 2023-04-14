Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AEF6E1F19
	for <lists+linux-iio@lfdr.de>; Fri, 14 Apr 2023 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDNJSZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Apr 2023 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNJSY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2023 05:18:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9CC59FF
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 02:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8413645B5
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 09:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7285C4339B;
        Fri, 14 Apr 2023 09:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681463902;
        bh=A2GVqZ+CdjCC8bFCLlF+m8qluI7C+SmBfJsHF8UlGNA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UOmbSHEAbkb4zeoBXqYlok3mXenJAU3BPMViReW87Tnfkpjfw4CLIn9rcGQZVvcW3
         NONW1KqddmxEoPNpWsXcjDS/YwQjKYp9/bvM4T/v8PwJDjKKu54/ZOF9G5tJiyVoB7
         8N6SGah5ieH1Vt9Rdxmmy+/ejRRSmaUl92ZeHDx7cErqn/C2/r0/FlUwJN74rR4XNj
         AyYMSuEQnK/5NM4wYL5clTISF2rOnr7CBIyzLsnkgk0taqJsl88pdTuMKG+yWBMDe9
         v+nPjJHEHrHFu9jjFVyFmVpmUE0PrHMkgzZcsHlyMEqqXASLlxBayrfpJz1T1+0CyC
         SS5jVgn67+1AA==
Message-ID: <8f14a0b8-8f02-b2a4-725d-0f70c39af9b6@kernel.org>
Date:   Fri, 14 Apr 2023 11:18:18 +0200
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
 <d3c93e92-605a-c486-201d-6c31f55e64b1@kernel.org>
 <CAPJMGm6JNu8wP2pa1Gr02AoECMesonKzK_OY8TyFvXG1SLxdvQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAPJMGm6JNu8wP2pa1Gr02AoECMesonKzK_OY8TyFvXG1SLxdvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13/04/2023 20:19, Fabrizio Lamarque wrote:
> On Thu, Apr 13, 2023 at 6:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 13/04/2023 18:07, Fabrizio Lamarque wrote:
>>> On Thu, Apr 13, 2023 at 4:21 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 13/04/2023 10:36, Fabrizio Lamarque wrote:
>>>
>>> Current documentation does not follow existing source code implementation.
>>
>> Bindings describe hardware, not current implementation.
> 
> OK, I'll keep in mind the perspective while describing the change.
> The bug corrected by 2/2 was found because the external crystal
> oscillator did not work and the internal, fixed clock was always used.
> Before the correction, the  driver did not load correctly without the
> clocks property. At the same time, the specified frequency was ignored
> and the fixed, internal frequency was used instead.
> After the correction, I found the documentation telling that clock
> property is mandatory, while omitting it is the way to use the
> internal, fixed frequency, clock.
> The documentation did not explain how to choose between the internal
> and external oscillator, but the driver was already designed to
> implement the choice.
> 
>>> The driver has been originally designed to operate with the internal
>>> clock when clocks property is omitted.
>>
>> Not really a reason to do it. Reason could be - hardware does not always
>> need clock input.
> 
> I hope the change in perspective will be enough. The external clock is
> mandatory for some applications.
> The internal clock might be required for others.

I told you that reason you wrote is not enough and you answer "in
perspective will be enough". Wait, what? I don't understand it at all. I
gave you example reason. If you do not like it, find other reasons which
refer to the actual device, not to the specific implementation.

>>>
>>> I thought the reason is clear from patch 2, but, as Nuno Sá already
>>> suggested, I will describe the reasons in full again, each time I post
>>> a revised patch set, even if it is quite verbose.
>>
>> Your commit must answer to why you are doing it. What you are doing is
>> easily visible from the diff. Rephrase commit msg to explain it and add
>> proper rationale (hardware related, not driver).
> 
> I am really just suggesting to align the documentation with the
> driver, since the driver operates the hardware as expected (after the
> two regressions fixes).

Does it mean you are not going to answer to "why?"? I cannot accept such
commits. That's the basics of software development and versioning. It's
not even Linux kernel related...


> Without this change, one should read the source code to understand
> which clock is used and when, which bindings have to be applied, and
> find that documentation mandates an (already) optional property.

How is it related? I did not refer whether change is reasonable itself
or not. I said you commit msg is very poor and you must answer to "why".
Not to "what".

(...)

> 
>>>
>>> I kindly ask you whether the entire (corrected) change on the
>>> documentation file only (without any change on the driver source code)
>>> could be accepted as a single patch.
>>
>> I don't understand the question. Each change should be one logical
>> change, but bindings are not related to the driver.
> 
> The question came after this:
> 
> On Thu, Apr 13, 2023 at 1:21 PM Nuno Sá <noname.nuno@gmail.com> wrote:
>>> I kindly ask you to confirm if, as per your suggestion, I should send
>>> a v3 patch series with the proper "fixes" tag and this last one
>>> changed as follows:
>>>
>>>  - No changes on driver side (keep avdd-supply instead of vref-supply)
>>>  - Indicate in bindings documentation that avdd-supply is vref instead
>>> (with the "Phandle to reference voltage regulator")
>>>  - Add dependencies to yaml bindings
>>>
>> Yeps, but note that for the bindings patch you are making distinct changes (
>> adding missing properties and changing one) so someone might complain. But for
>> me, personally, they are simple enough that can go in one patch. Just properly
>> document it in the commit description.
> 
> I really need to send a proper, complete and acceptable v3 patch set,
> or drop patch 3/3 from the set.
> 
> Would you accept the change to adi,ad7192.yaml file alone with both
> the change in description of avdd-supply and the additional missing
> properties?

Do you mean by this changing bindings without changing driver? Then
depends on the context. The driver must implement bindings, so you
should not send patches which break the implementation of interface.


> Is "Phandle to reference voltage regulator" as a description for
> avdd-supply acceptable on your side?

Sorry, how is this related to our topic? Anyway, drop "phandle to",
because you should describe hardware, not syntax of DTS.

> In case you feel the proposed adjustments are not enough or changes in
> documentation are unworthy, I feel it would be better to leave them to
> the driver maintainers.

I don't understand. I wrote nowhere that changes are unworthy. I pointed
out specific issues which need to be fixed. Can we focus on specific
issues, not on some other unrelated parts?

> Otherwise, I'll do my best (according to my limited expertise, to the
> available time and the acceptable costs for the company I work for) to
> provide something acceptable.
Best regards,
Krzysztof

