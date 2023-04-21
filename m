Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96D6EA5DB
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 10:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDUIaO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjDUIaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 04:30:13 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D5524B
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:30:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b992ed878ebso1208960276.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682065809; x=1684657809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5klHMq64VIljoSVkOwPJ2cgj8nj1Si169hW4IY+bP4U=;
        b=lrQhs+vo1k2UBUSg8IofSsZ0KVGmRL89oDZ8r7Zsg/81K9QtNTz6+xArvTE25AQkL9
         BP0uHNf/IPGoUxcGQHCgqUORb2Gtr5OsXnQB9uJbd5eqCC/zfA5ZrCnP97clOCzTNa5d
         mdD0NN1a6M7wE2U8hzBjrWffRXQWPMwKTYOh9O23KUEypN98MMGQhVbYBiZPKQwI0Ctw
         pSXb56zGQtocA0R7fJxPCqoruGf80AFomCpYq0IDtzX+1vcZGVGjdTy4JS4OaVnPCD2s
         gGD5i9mwhakqDnYpSsy858vGSBeCSAXzcSwkRjAcYDllLLMjU2Q16vs0pDIsEQwMeRvp
         tEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682065809; x=1684657809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5klHMq64VIljoSVkOwPJ2cgj8nj1Si169hW4IY+bP4U=;
        b=CopseOqe3xwLxcwDDriPLfjNFICT45m59mRzYeiV+rvr8vw4WI7H/tZ1EAbYBf0sdH
         5bYBzaGfRIY9w+1MzsHRZ3scqukYbnkRruA8fxteavQnpKErxJ8xTayEfQ/QK0wEksVo
         i423DBxJt8Gm4fULcjudxSfH2xMpNgP364S6UUBwddo6KN/046DQo4Il64Mje45CCm38
         yg5jH9Zk1sH0H5RUny/YnEJXjgBfobJ4Gk5Q7pauS1k1pMHhV8ddXskZAhqmb/Oa2P+e
         UaT1wZnEu3yazfWouGILZQAGqdjTsJoK7XBe8oglSSpOcf0mCsx/aIO8e8YiR2IUWu/4
         8AJA==
X-Gm-Message-State: AAQBX9eDkEkuqtKFqYpBQdXUXkJ6D7EhO3lbEeSRzP2UMtYrURItwh36
        jpRNyrvoNppV2HzXdilVar6YSrKErcgI6/EvTsM1AQ==
X-Google-Smtp-Source: AKy350Zns/U+3vpNmpMzNn8WbDce9++folijXpvxedcLeNyjLrhBVN1M2j1Bs3JSk09cKtYRX5696eR1QSUH/+GFEPI=
X-Received: by 2002:a25:46d4:0:b0:b8f:1cea:e064 with SMTP id
 t203-20020a2546d4000000b00b8f1ceae064mr1238150yba.32.1682065809654; Fri, 21
 Apr 2023 01:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:29:58 +0200
Message-ID: <CACRpkdYgDC0QJhH4s1P2ga3W=xXqjovhsNS2i5nikgu_ikenKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add PMI632 PMIC and RGB LED on sdm632-fairphone-fp3
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 18, 2023 at 6:43=E2=80=AFPM Luca Weiss <luca@z3ntu.xyz> wrote:

> Add support for the PMI632 PMIC in the spmi-gpio & qcom-lpg driver, add
> the dtsi for the PMIC and enable the notification LED on fairphone-fp3.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
(...)
> Luca Weiss (8):
>       dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
>       pinctrl: qcom: spmi-gpio: Add PMI632 support

Patches 1 & 2 are finished so I applied them to the pinctrl tree so
Luca does not need to keep reiterating these for the next kernel cycle.

Yours,
Linus Walleij
