Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14166D43A9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 13:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDCLiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 07:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjDCLiD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 07:38:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3DF4213
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 04:38:00 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id m16so14006642ybk.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680521879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kOtVINJ/hc23uS0iMesRcqKkmMZoIVagEw2q0yZm6ro=;
        b=ooObK+1ussEz9MkPWv2L7OY6QejUJuirtapW60/NR2vaLWVRdQS9XfRZg1rRrs4ZW5
         iR1tA0v3jClQD1Myhlc7Lm8/fV1rdf+zd18TpFDnFH78TE41qDVAX1uXz4LJp/itzO8l
         0Wbr03FkIXSpwwU29ojU/6b6OPoftJJLsMrJeP8lO9zAjL8npYM6VN10xBYvfO7vQeRG
         7hn0CtA6U2l7hOP5pLf/9Lg8ajZ+hRO2IJwh5vxvYfdW/KG08RGPZPgdvNYm8qa6BEXM
         lGB2JaVsAbwNmAfa3QAA/Y4lFP9zXXKzU3zGsqTSledNRwWC7Rs4i2LBzCxsvdQqDFXI
         Cs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOtVINJ/hc23uS0iMesRcqKkmMZoIVagEw2q0yZm6ro=;
        b=Na2GqUSP5TQMR9QcEMpsAolTENfpuRsSCcRbH2mKQpGXljqMNE/FxOGnZb6OgY6SS3
         o89zQT390MBQ7shaXmJh9E/VJrH3tnhJHh1SqO3D1W4u5wu3jDbbC4V2GfbnywYN7T3E
         cXVUtgHuJvChCex59UPltpSNVEHxdqf6np3Calzx4KVPc3+ACpZ0KZonGtJxUqHX6ftR
         UVQLyojI+zZ4eiOZ0RudmOH/w2ug4Qgd81lJVznsp3VsTppmGupPxp6+KMALkUv+CPB2
         L2Wu3ALuECUyiWZqWgL6ynJB8XTo9LSR76fitPwLCe+D+51BNaV4zZRQpERsHtkbTPpK
         Dn8Q==
X-Gm-Message-State: AAQBX9c00ajzsNR3eKF04KGkF/Kw6kPVnO7AtKFGishQwl9i7h37Srdn
        tBGujPGO00Rw9d0uTfTI3nDjvITEfDTovZeYihWtQQ==
X-Google-Smtp-Source: AKy350afzcPqX3jlKimzowQ9CIxvNv5ojFUPC42RPy1gJ6dnsBFzCwXMuJQXuXZzFt6qjVY8bCXUnQ8H3swFp+zc73k=
X-Received: by 2002:a05:6902:1501:b0:b4c:9333:2a2 with SMTP id
 q1-20020a056902150100b00b4c933302a2mr18709043ybu.9.1680521879578; Mon, 03 Apr
 2023 04:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <10626c79-46da-3f66-0327-66576b3e5f2c@linaro.org> <c6f20137-299a-afb1-c42d-35f7386b1e27@linaro.org>
In-Reply-To: <c6f20137-299a-afb1-c42d-35f7386b1e27@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 3 Apr 2023 14:37:48 +0300
Message-ID: <CAA8EJppU7LRqgWoDBWNSY_dnGf9TNO-f3WqAf1eP=aWCMu0pJg@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] arm64: dts: qcom: remove duplication in PMIC declarations
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Apr 2023 at 13:44, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 2.04.2023 11:55, Krzysztof Kozlowski wrote:
> > On 02/04/2023 00:07, Dmitry Baryshkov wrote:
> >> The sc8280xp platform uses its own copy of PMIC declarations. This can
> >> easily end up with the issues that are fixed in the main PMIC include
> >> file, but are not fixed for sc8280xp (and vice versa). For example
> >> commit c0ee8e0ba5cc ("arm64: dts: qcom: pmk8350: Use the correct PON
> >> compatible") changed pmk8350 to use "qcom,pmk8350-pon" compat for the
> >> PON device, while sc8280xp-pmic.dtsi still has the incorrect
> >> "qcom,pm8998-pon".
> >>
> >> Another example is pm8280_2_temp_alarm device, which uses interrupts
> >> tied to SID 2, while having SID 3. This can be easily left unnoticed.
> >>
> >> Employ a small amount of C preprocessor magic to make
> >> sc8280xp-pmics.dtsi use standard PMIC include files
> >
> > Preprocessor magic is disliked in DTS. We allow only simple defines, no
> > undefs. Sometimes some nodes or strings could be concatenated, but in
> > obvious way. You should not parametrize it and have different, generated
> > labels in DTS based on something coming external to that DTS.
> This again begs the question, is it time we start moving parts of the
> dts code to be autogenerated?
>
> Should we keep a separate file for each SID?
>
> Or should we consider the SPMI 'interrupts' implementation flawed and
> work towards one that does not require a SID to be specified within?
>
> Currently it's:
>
> interrupts = <USID PERIPH_ADDR>>8 IRQ_WITHIN_PERIPH IRQ_TYPE>;
>
> So the first two cells are effectively useless and can be retrieved
> from the parent node and the reg property.
>
> Getting rid of that would solve a decent chunk of problems that this
> patchset concerns.

While I agree with the USID part, the PERIPH_ADDR part is not always
like that, see pm8916.dtsi / audio-codec@f000.

I'll give it a thought, but it is probably not in the forthcoming future.


-- 
With best wishes
Dmitry
