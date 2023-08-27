Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E842C789D53
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 13:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjH0LtB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjH0Ls3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 07:48:29 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67380130
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 04:48:26 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d780bca9275so2154485276.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693136905; x=1693741705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SOCpPWe7OKGhP+mivko2oCOZT+7pMKJtiqyOcjFKW4s=;
        b=sU+i4612l8iq6Q+vgFGPuT+B9hmqIxRTZKdUIWw00c+MSZTw4YmdvA0Uo8S8aXcPgk
         qkY5SjZnBhXS76NzxK60muAJV5d4PsMoFSaamO9jmkcR74CRGQvyvzGVuvjtAgRzP6Wv
         uCM0+bfiy5LmV00+ujYUgYIbbvtpEsJocEu3ORwjY4nCPd3mF8euH43Rhbu8SyIwd7Cg
         EV0EMm8YsxemHOOgBiSvRDhQSL3uLfVjouNaA9zz0d+Wz9BHdylfeldNSc4GqwryVQtk
         DuxeKXj9J7g/0VVtRmV1swqzKOKwGYE0qz0FYC5591h4w8I0YZi5AuxwC3PfJqFmFo5l
         E0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693136905; x=1693741705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOCpPWe7OKGhP+mivko2oCOZT+7pMKJtiqyOcjFKW4s=;
        b=g1KYFWj6xO5Rl8UNYHxwV+esWDPr1lvl0ugwJZ7cz9FXa9JoBkA8L3qiONIi5KJAuo
         fPeRc0rKBJlmv6t6JSSmXyM85gEFzd/Cjyj8su7lECVz3oiH+lIHmYcyYlu9gygAFsGm
         df7mcz+9NryhowD7BH82ksVaJZynFM//ZvPlYfFBozF/rWsdu/vWwUehHGz7EKCWt4QC
         k6IFwS56VQC55OZlCpfm7cwC7EZz2RiyS3XfUlIdqzxF8evvyIwWDub60xOZsbcy8Vs4
         Hac+O2tJVGmFO9715cbyNDakVPIO/2tUYRuRsLtjJID+Ei9ivQ17Ha8MFfenv9q213IH
         T0jw==
X-Gm-Message-State: AOJu0YxjjaNuy+nWbeo9PeKBXxBMu6w/UI8Maj3B60dAPA2TzGMowweG
        Q/RLncv6OSqz3kLT9cvD0makhbu4uyfxShCkWjsliA==
X-Google-Smtp-Source: AGHT+IFLYC8MWF6L7rtrBC0qkMHSJ92tbN2J+48NUnJzxXbVXtV/MtFa+jzW0Als7Y7HiKTZavgKbCgtjN+2toPccX8=
X-Received: by 2002:a25:bccb:0:b0:c15:c55d:c26e with SMTP id
 l11-20020a25bccb000000b00c15c55dc26emr21853470ybm.54.1693136905652; Sun, 27
 Aug 2023 04:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
 <20230827005920.898719-4-dmitry.baryshkov@linaro.org> <39af3ab5-4fa5-5b3c-395a-e86e70bbe803@linaro.org>
 <CAA8EJppw0Kxo3W560ucWey959368M1c8BFnvF4Ggi5XKCOfesw@mail.gmail.com> <74dcc5b4-dda2-5de7-9e58-4191a0fb7972@linaro.org>
In-Reply-To: <74dcc5b4-dda2-5de7-9e58-4191a0fb7972@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 27 Aug 2023 14:48:14 +0300
Message-ID: <CAA8EJpoWvoNfomMg34cL=h+qBLHQq3bZO2X-02Pcz6oLiKRxWA@mail.gmail.com>
Subject: Re: [PATCH v4 03/38] dt-bindings: mfd: qcom-pm8xxx: allow using interrupts-extended
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Aug 2023 at 14:12, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/08/2023 12:42, Dmitry Baryshkov wrote:
> > On Sun, 27 Aug 2023 at 11:35, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 27/08/2023 02:58, Dmitry Baryshkov wrote:
> >>> Allow using interrupts-extended, which is a preferred form of interrupts
> >>> specification compared to the interrupt-parrent + interrupts pair.
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 10 +++++++++-
> >>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> >>> index 7fe3875a5996..33d9615e63c8 100644
> >>> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> >>> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> >>> @@ -37,6 +37,9 @@ properties:
> >>>    interrupts:
> >>>      maxItems: 1
> >>>
> >>> +  interrupts-extended:
> >>> +    maxItems: 1
> >>
> >> The entire patch is not needed. At least should not be needed. What
> >> problem are you trying to solve here?
> >
> > The main problem is the next chunk, which (currently) explicitly
> > requires `interrupts' property. My goal is to allow
> > `interrupts-extended' in addition to `interrupts'.
>
> They are allowed. Why do you think they aren't? That's why I don't
> understand what real problem is here.

qcom-pm8xxx.yaml lists `interrupts' property under the `required'
clause. So I can not simply replace it with `interrupts-extended'


-- 
With best wishes
Dmitry
