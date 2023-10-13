Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A707C80F0
	for <lists+linux-iio@lfdr.de>; Fri, 13 Oct 2023 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjJMIzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Oct 2023 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjJMIzA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Oct 2023 04:55:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20FED9
        for <linux-iio@vger.kernel.org>; Fri, 13 Oct 2023 01:54:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ae75ece209so299651866b.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Oct 2023 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697187296; x=1697792096; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8JKGwUdtfI1UibvU08qy7GVuAI+nB0XIQdzpOpzSSg=;
        b=R+EiyWoP31Irvq7IKhtzusGibou/eRuJMG4YoX+vb8wooHWC1mT/8aONpZU1afd9mX
         wfPndGJRV28Rt93F1Mqv/IF9aHEU/6iO2lvOk3ZNtLwbq/sn6uov0oMwGEwEfujI/aZu
         7ctCGtjfeU2fetAuEwnuu3aDKYbLwyi6R/C6/+9Yb7MwjwQgHhjhuR43v8NBZvvLpVw0
         NmSaFFOKx414YlIEYxToaBZ1/+ium4SezdUgH7aqHm2z2oyAJWJGyOY6nbxqGUtyNsst
         c1UZ+7Eh1uFDTPhCGSwr91AynwvV17NhwmJ8C5snrNQAwQgbzQXleTNg7rTHSXuF5q8c
         m4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697187296; x=1697792096;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E8JKGwUdtfI1UibvU08qy7GVuAI+nB0XIQdzpOpzSSg=;
        b=dcZ35yBMdqJzLN8xz9W9SgwQUsKaXplmFleiBWGZe0Yc8JtJE2Ydh9m68DQqZTsMrE
         BufoA/8S6L57WBhISF0+YgEhdFAY2hsQSNq66fGdQvvKMy8xu1Si3IOhwUUlY0eAK5lv
         IuxYPjSDqlSsV72g2OjYo2/4E9wUF9l1hTBMvAYBimd9JlKvjSMu6qau0hJ6RA0Sn6iU
         zyVPjlVOVS3N/nBbZ4HvdCnl8djWQPh8m+eWPPy7r92eLyA52/6mFQEAks1WfKswN0yM
         R8Fdm6Dsxq617j0D1h89Mr+ODKXOD1qtdjnKFkwftbYwrYDIXT2OockT/LEDwkhqXDQC
         qB+Q==
X-Gm-Message-State: AOJu0YxCh/mEV2W2vDfUPNRPhetcEwa6Ve6+Ayo6PNIa3fsVj38KArJT
        AM6pPmzgCPeYusNUyQ1eEWJc6A==
X-Google-Smtp-Source: AGHT+IFQW+e6DzHU2VifEKGLahVlTkYJYnI7A6Tsm8CCDJVU+34O2IQjYZBMFJQFchrXoyL66dYLVQ==
X-Received: by 2002:a17:906:23e2:b0:9b9:b12c:133d with SMTP id j2-20020a17090623e200b009b9b12c133dmr19287609ejg.53.1697187296173;
        Fri, 13 Oct 2023 01:54:56 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id oz10-20020a170906cd0a00b009ad8acac02asm12219112ejb.172.2023.10.13.01.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 01:54:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 13 Oct 2023 10:54:55 +0200
Message-Id: <CW76ONZKCJD7.RH8K3GG6ZT9R@fairphone.com>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: adc: Add PM7325 PMIC7 ADC bindings
X-Mailer: aerc 0.15.2
References: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
 <20231013-fp5-thermals-v1-1-f14df01922e6@fairphone.com>
 <d1c8a6e2-1c12-4b67-bc67-45f0b41a2fef@linaro.org>
In-Reply-To: <d1c8a6e2-1c12-4b67-bc67-45f0b41a2fef@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Oct 13, 2023 at 10:38 AM CEST, Krzysztof Kozlowski wrote:
> On 13/10/2023 10:09, Luca Weiss wrote:
> > Add the defines for the ADC channels found on the PM7325. The list is
> > taken from downstream msm-5.4 and adjusted for mainline.
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

Seems very inconsistent (git log --oneline include/dt-bindings/iio/qcom,*)
but I guess this would fit better?

  dt-bindings: iio: adc: Add PM7325 PMIC7 ADC bindings

Will update for v2.

>
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h | 69 +++++++++++++++++=
++++++++
> >  1 file changed, 69 insertions(+)
> >=20
> > diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h b/include/=
dt-bindings/iio/qcom,spmi-adc7-pm7325.h
> > new file mode 100644
> > index 000000000000..96908014e09e
> > --- /dev/null
> > +++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
> > @@ -0,0 +1,69 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
>
> We expect the bindings to be dual licensed. What was the license of the
> original work?

Yes, just GPL-2.0-only:
https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blob/LA.UM.9.14.1.r1-086=
00-QCM6490.QSSI13.0/include/dt-bindings/iio/qcom%2Cspmi-adc7-pm7325.h

Unfortunately it's the same situation with all the other header files
like this one.

  $ grep SPDX include/dt-bindings/iio/qcom,spmi-adc7-*
  include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h:/* SPDX-License-Identifie=
r: GPL-2.0-only */
  include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h:/* SPDX-License-Identifi=
er: GPL-2.0-only */
  include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h:/* SPDX-License-Identifi=
er: GPL-2.0-only */
  include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h:/* SPDX-License-Identifi=
er: GPL-2.0-only */
  include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h:/* SPDX-License-Identifi=
er: GPL-2.0-only */

If you know someone at Qualcomm to ask nicely to relicense those (plus
ones that will presumably be added later), that'd be appreciated.

Regards
Luca

>
> > +/*
> > + * Copyright (c) 2020 The Linux Foundation. All rights reserved.
> > + */
>
>
>
> Best regards,
> Krzysztof

