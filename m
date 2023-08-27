Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B078A0E1
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 20:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjH0SGi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjH0SGN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 14:06:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BA818B
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 11:05:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5007f3d3235so3852329e87.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693159555; x=1693764355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCvDnqW2L7Ij8+HnjKPfzqCAmR4DqEsTCL9vNoCu5/w=;
        b=E/QbAPkdZRfFqTIkB8kVpr1Zm++z9EveIMU7CZbQ+0/BMN1O38Ax+fgMQg517VcEQg
         Nr/j/aijQMb6xtOVlfSytjiV6hy99hYbOc8poTe/L3PniNvqeSwl+FXEwU90EqGwGQ+7
         FdZCfvn3OcdiB5yKS3edRSlQ/rSfC5mjO63+dAUxDuO+alccyv20Gu9R2HtjdrF82d+e
         FjLsqazl5rtRgzjvzHRUwXzHfVA3WM5CjMvICsAakN2C0V125DpOqi0n/6GSCjWC9f5j
         IV3gfded2s7c13wFG3MUIBQUhkQfZVCW2JvK5RI5a7le7zl5F7eusj3ICdI4LtkwMZe8
         mIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693159555; x=1693764355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCvDnqW2L7Ij8+HnjKPfzqCAmR4DqEsTCL9vNoCu5/w=;
        b=OfqBt6ojNh5ZVbPkAe3Jn2QB1JkHbiBcpFXPfr8Slc92Bja0aRI1KYVpjmdKmIwrXo
         C1IFjkGqKGkrBTAhW4+dr5oO3Dqu2q+eCeETunGcAIUANHvgGXtZnD900UoIWXaYRi40
         cAfxueXAn2nmRCYZIBcv5cv+IIUZMm3P1/Jx3oe3sjDMiJ9oPW2dW6jswfr3/3xlOdiD
         brQJffG79eYXHzYxmZqaMXVOS92UlzUpTNoZ1Jx1JPr8ycD1hvJA4LyoNmEPdJLNHu5U
         9KNfp1aR/Dzspd/7C4UcFZSiq6Cihov29mOE7yG8IJNSo4ow4L3r3iibbzguSmuE7zgN
         0brg==
X-Gm-Message-State: AOJu0YwjRbnTVjA8tEbN08b3vrZK8PUj+IQ3EqLlXEvWysbkVJlkll1+
        hAsRE7cRNDehfWr2RoUETgn6GQ==
X-Google-Smtp-Source: AGHT+IELaR5h2o8X/ZZEhdmsgOUt4QqD9H2QGql9YX+tqSUrcyKhdRnm7c/Zhwfbk5KyhBM/azIuLg==
X-Received: by 2002:ac2:4e0d:0:b0:4f8:77db:1d9e with SMTP id e13-20020ac24e0d000000b004f877db1d9emr20230809lfr.12.1693159555164;
        Sun, 27 Aug 2023 11:05:55 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id da25-20020a056402177900b0052a626daf4csm1195821edb.47.2023.08.27.11.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 11:05:54 -0700 (PDT)
Message-ID: <f54feed5-4dc6-b22f-b72e-faecf322bfa5@linaro.org>
Date:   Sun, 27 Aug 2023 20:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 03/38] dt-bindings: mfd: qcom-pm8xxx: allow using
 interrupts-extended
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
 <20230827005920.898719-4-dmitry.baryshkov@linaro.org>
 <39af3ab5-4fa5-5b3c-395a-e86e70bbe803@linaro.org>
 <CAA8EJppw0Kxo3W560ucWey959368M1c8BFnvF4Ggi5XKCOfesw@mail.gmail.com>
 <74dcc5b4-dda2-5de7-9e58-4191a0fb7972@linaro.org>
 <CAA8EJpoWvoNfomMg34cL=h+qBLHQq3bZO2X-02Pcz6oLiKRxWA@mail.gmail.com>
 <e6340d20-40f3-be5c-b4fc-33da59799d91@linaro.org>
 <CAA8EJpoWEABv6RrZn9FE+5N79Kz=24BhmpdnGbnO+vzX3A8v_Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpoWEABv6RrZn9FE+5N79Kz=24BhmpdnGbnO+vzX3A8v_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27/08/2023 14:57, Dmitry Baryshkov wrote:

>>>>>>
>>>>>> The entire patch is not needed. At least should not be needed. What
>>>>>> problem are you trying to solve here?
>>>>>
>>>>> The main problem is the next chunk, which (currently) explicitly
>>>>> requires `interrupts' property. My goal is to allow
>>>>> `interrupts-extended' in addition to `interrupts'.
>>>>
>>>> They are allowed. Why do you think they aren't? That's why I don't
>>>> understand what real problem is here.
>>>
>>> qcom-pm8xxx.yaml lists `interrupts' property under the `required'
>>> clause. So I can not simply replace it with `interrupts-extended'
>>
>> Since when? So again: The entire patch is not needed.
> 
> Hmm, interesting. I'm pretty sure that I saw the issue, but now I can
> no longer reproduce it. Maybe I misinterpreted some other warning
> which I saw while this was WIP.
> I see that it is handled by the `fixup_interrupts` in dtschema itself.

If interrupts were brought by some other schema and that one did not
evaluate, then you could see errors about interrupt-extended. But that's
not the case here.

Best regards,
Krzysztof

