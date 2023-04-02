Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA22B6D37C1
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDBLzO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 07:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDBLzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 07:55:13 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1979113F4
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 04:55:11 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-544787916d9so501709107b3.13
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680436510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCb+PvVz9vDjaUXWhXFHA5eliELDec/Jtrdt7VRzzHI=;
        b=P+CWpB2UIFi7fSl+IhvqqE3HDSFwVgZ3g5oitw7gV4Iw2zlCjzmspx475zX0JXaEv4
         UBIRKMn+PaS38WH5q/AYJC0FQJWSeYnCOlN4e6pPOYrExnxzxkt/MiNby+G8VC2lSkj2
         OTIKTgCjCWa7+Rp20UKuhgeme84Pb50kS3qZMeuwIxT+v38Km+/7GZjns44qwrJJYpMD
         buVJBeMjH3dbBm5Y7jFdGTqw6U4vSSTlgOCttNXMr8+fefXoX1X76agn09SEDCoHbNmL
         D7j4/To5+q8MPj0hfZQxrB4QT8vYp6IFuMD4Lohk3vLEbcTH+ZT7Ndt6INxABBUJMcBH
         g+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680436510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCb+PvVz9vDjaUXWhXFHA5eliELDec/Jtrdt7VRzzHI=;
        b=UWlAeYhQf2WzROHx+NZKGKynn5alD7utFa080uDt6oG5so1CJDZ/4Uz7FP1l2sutcZ
         mZwq0Q6jxdJpKVGuWmlfOFyNjz1qOlU+nD/UpAmTeDZS1rqVTho2RWTH+HnR6ymyhAfT
         D5RJJrstNo8l3wBkEmAXcgiDKNZ4ArX6AjevOKjeqo6msLQ1yP/3QZ3RBlfGImkeYexW
         LI0Lcdsb3Fqex6e93AsnzMBblFFNfixyG6KcAi1Ao35OOKZq5tl46HWMc+HQvu0eoac6
         vX5BgVaBzEXWRTA6GluTcTs4N0PnHO5aaZDyDtEw7HYcTF7VbuHcJJr5sNAnnkr4pZWb
         WinA==
X-Gm-Message-State: AAQBX9cJJ1ZfV5+o7Zf9gUi7jRUtlsZZh8YvBlc4NnqVC8tVhHwDOpnU
        pc4nTWN+w4J4qyVHIvMXa2CHYLo74X2+9rcv9QpwsQ==
X-Google-Smtp-Source: AKy350b5CVIF0s9p1uDLO//v8xxaCU59UCLNsAz4bzleOn08Q3r/xLEZFSD+qiYv3wKgQFzHm4Dux3TWxzNRWXM2G7g=
X-Received: by 2002:a81:7e10:0:b0:52f:184a:da09 with SMTP id
 o16-20020a817e10000000b0052f184ada09mr8060907ywn.2.1680436510167; Sun, 02 Apr
 2023 04:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-10-dmitry.baryshkov@linaro.org> <127c7d41-b7dc-6c9a-0653-f5bf2a626907@linaro.org>
In-Reply-To: <127c7d41-b7dc-6c9a-0653-f5bf2a626907@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 2 Apr 2023 14:54:59 +0300
Message-ID: <CAA8EJpqg15KVx+H_29kJO-KfDEN3LFHZCfpfTWM40WMa2PoAXw@mail.gmail.com>
Subject: Re: [PATCH v2 09/22] arm64: dts: qcom: pmk8350: allow overriding the label
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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

On Sun, 2 Apr 2023 at 12:44, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/04/2023 00:07, Dmitry Baryshkov wrote:
> > sc8280xp-pmics.dtsi incorporates a copy of pmk8350, but the dts files
> > use labels following the markings found in the schematics. Allow
> > overriding the labels in pmk8350.dtsi.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi | 13 +++++++++
> >  arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi | 14 ++++++++++
> >  arch/arm64/boot/dts/qcom/pmk8350.dtsi         | 28 +++++++++++--------
> >  3 files changed, 44 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> >  create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> > new file mode 100644
> > index 000000000000..1c81269f0783
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +/* cleanly revert the effects pmic-dyn-header.dtsi */
> > +
> > +#undef LABEL
> > +#undef _LABEL
> > +#undef __LABEL
>
> That makes the code less readable.
>
> > +
> > +#undef PMIC_SID
> > +#undef PMIC_LABEL
>
> And it keeps growing and confusing.
>
> > diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> > new file mode 100644
> > index 000000000000..75f0448568bd
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +/*
> > + * Preprocessor symbols to assist in describing PMICs which have configurable
> > + * SID. All effects of this header (or its parameters) must be reverted in
> > + * pmic-dyn-footer.dtsi.
> > + */
> > +
> > +#define LABEL(name) _LABEL(PMIC_LABEL, name)
> > +#define _LABEL(pmic, name) __LABEL(pmic, name)
> > +#define __LABEL(pmic, name) pmic ## _ ## name
>
> No, defines in DTS should be simple. This makes it ungrepable.

I see. I still think that we should remove this duplication. Would you
prefer for me to define all pmk8350.dtsi labels individually? What
kind of approach could you possibly propose?


-- 
With best wishes
Dmitry
