Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B721717795
	for <lists+linux-iio@lfdr.de>; Wed, 31 May 2023 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjEaHOY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 May 2023 03:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjEaHOX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 May 2023 03:14:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1424113
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 00:14:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-974265a1a40so133519266b.0
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685517260; x=1688109260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=he+S+tKhJeczrt//An5I955xU1SlUZf1wS7TasfMwBs=;
        b=YdLeUgcGdnHHmTltj4+rt4eQvOOQRHAuskx3Baeo+K9kUwrVTcNq9dUYlnbcrvidg/
         uWnxGPGw8tAstMDZec8IbDmAFufgHMc4viEYk3n5/uFSwjPU03FWyxgC1ofepIolhVd7
         0dw+NSkiPgMSl7g+h5VDSRBiGm9nT849CufqJCOD6XYJhsysrogNqA6mgjdccnrZ2wOO
         ckyJcuzwz8OKBWPfW2uM457P2JnaQsqo5i99mA+J6tDcvW6793psVbZiaYtjHJIxZOoN
         UF9x5d2Bu1/3s4lJG39a8CzwWSkvR6GHfLFQecn1AbiETPbAy++loMD26Mo3qlJ5jeMn
         JPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517260; x=1688109260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=he+S+tKhJeczrt//An5I955xU1SlUZf1wS7TasfMwBs=;
        b=Nl1m0XYefsSS+Nw0Aa1Kp3zhsoUbU7LxTGPJp+Ev2gSACNPHUaN4CaKgJvEn8IYfop
         q6AnAkTMBq+7t9BQ6El2kfhp4eDk0PU0lDp6VzsCOe++qe0f0fBU4QlIWeFqXgJxYr67
         4bIJVGnVo9vH+SCUMwwfV6HKomn1wdSltp6/wtg0VHBfZhegeianvgqapyQ3p5eq3+UZ
         pk62LW8i3+berzimxF2w3T5ujaXKkuuMXrsRzQ1oN5aljuIxJCoGGZEK1XLoeEj9aXRg
         uy60mL4kLGzJqtT7RncuddtVyy2TV9ohTtIiC3N3Ce5irXZbIJNP5o5sWi2+GnvAaWVy
         2mLQ==
X-Gm-Message-State: AC+VfDygqT3I1mZXg+pmAxzg20de8vPtQhMv9zQ0pmWp8g2qMoZSw4Q2
        kHzElGScVHr9YpccQUlBG0yXrQ==
X-Google-Smtp-Source: ACHHUZ6MfUHxABvlX2Nt5wt1hTFu/V5ZBA/LWOr8iq4JaIzDK15YsEkF3nDdVctHxf3efDAu9whw9w==
X-Received: by 2002:a17:907:9721:b0:94f:2916:7d7 with SMTP id jg33-20020a170907972100b0094f291607d7mr4348816ejc.19.1685517260433;
        Wed, 31 May 2023 00:14:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090603c700b0096a68648329sm8425064eja.214.2023.05.31.00.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:14:19 -0700 (PDT)
Message-ID: <5d65b644-9b79-d232-d0d0-d2772325eef5@linaro.org>
Date:   Wed, 31 May 2023 09:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/5] dt-bindings: iio: ad7192: Allow selection of clock
 modes
Content-Language: en-US
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Conor Dooley <conor@kernel.org>
Cc:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
 <20230530075311.400686-6-fl.scratchpad@gmail.com>
 <20230530-cannabis-headstone-883c5b891dd3@spud>
 <CAPJMGm4=sRQGPmVi8NjAVvOVrr8s2By6PO8kKRKZt3W0FR9j-Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPJMGm4=sRQGPmVi8NjAVvOVrr8s2By6PO8kKRKZt3W0FR9j-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/05/2023 08:59, Fabrizio Lamarque wrote:
> On Tue, May 30, 2023 at 7:22 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Tue, May 30, 2023 at 09:53:11AM +0200, fl.scratchpad@gmail.com wrote:
>>> From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
>>>
>>> AD7192 supports external clock sources, generated by a digital clock
>>> source or a crystal oscillator, or internally generated clock option
>>> without external components.
>>>
>>> Describe choice between internal and external clock, crystal or external
>>> oscillator, and internal clock output enable.
>>>
>>> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
>>> ---
>>>  .../bindings/iio/adc/adi,ad7192.yaml          | 27 ++++++++++++++++---
>>>  1 file changed, 24 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> index 16def2985ab4..f7ecfd65ad80 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> @@ -32,7 +32,8 @@ properties:
>>>
>>>    clocks:
>>>      maxItems: 1
>>> -    description: phandle to the master clock (mclk)
>>> +    description: |
>>> +      Master clock (mclk). If not set, internal clock is used.
>>>
>>>    clock-names:
>>>      items:
>>> @@ -50,6 +51,17 @@ properties:
>>>    vref-supply:
>>>      description: VRef voltage supply
>>>
>>> +  adi,clock-xtal:
>>> +    description: |
>>> +      Select whether an external crystal oscillator or an external
>>> +      clock is applied as master (mclk) clock.
>>> +    type: boolean
>>
>> Am I being daft, or are these the same thing? If they are not, and use
>> different input pins, I think it should be explained as it not clear.
>> Could you explain why we actually care that the source is a xtal versus
>> it being mclk, and why just having master clock is not sufficient?
> 
> I may revise the description as follows. Feel free to add your suggestions
> in case it is still not clear enough.
> 
> "Select whether an external crystal oscillator between MCLK1 and MCLK2 or
> an external CMOS-compatible clock on MCLK2 is used as master clock".
> 
> This is used to properly set CLK0 and CLK1 bits in the MODE register.
> I guess most applications would use an external crystal or internal clock.
> The external digital clock would allow synchronization of multiple ADCs,

Description confuses me. Why would it matter what type of clock you have
as input - external crystal oscillator or external CMOS-compatible
clock? Later you refer to "internal", so maybe you meant here also
internal for one of the options?

> 
>>
>>> +  adi,int-clock-output-enable:
>>> +    description: |
>>> +      When internal clock is selected, this bit enables clock out pin.
>>> +    type: boolean
>>
>> And this one makes you a clock provider, so the devices advocate
>> position would be that you know that this bit should be set if
>> "clocks" is not present and a consumer requests a clock.
>> I don't seem to have got the driver patches (at least not in this
>> mailbox), so I have got no information on how you've actually implemented
>> this.
> 
> I see... When this bit is set, the AD7192 node should also be a clock provider.
> The clock is output on MCLK2 pin, hence it can be used with internally
> generated clock only.
> I tend to dislike the idea of a "conditional clock provider". Also, I'd guess

Either this is a clock provider via common clock framework or is not.
Don't re-implement clock provider via other properties but just skip
such feature.

Best regards,
Krzysztof

