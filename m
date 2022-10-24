Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF860AF23
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJXPf5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJXPfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 11:35:32 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3597D76;
        Mon, 24 Oct 2022 07:22:57 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id w3so5660108qtv.9;
        Mon, 24 Oct 2022 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z95RGHhrq2RpkVpagLbxbym9uTh1REHQsUV1yjQ7WkY=;
        b=L13ity+YPc1L1SXl6GrXMurF79RdrsqFl3nO8Gd+biOii0FxyhcAYB2fL1AYmdme88
         ZC+DSWWsNPDyndApeebfPYY1QIMc1/CA2LB4i2IzJnu/Wr6hSDooEHVaD6l3uv6EeMDI
         Q4Wc/+T6iD7cEm06seJXGEEud3bTd9yW6MIu5bSnjrumR2QAlDKDS23ffNVHU2vgNuEA
         De0IeY7dL1n45UaPhVOhva+fn7Gjoqm30N8s1yFs+go0G403zWIDjckcvXboMFDsqprw
         VCRx9fshRCgx8k+4l50w4zhXcFGB22MXLAo5LFM6zS5BMmprJBk5cqTNk21rjuu1tCTO
         4QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z95RGHhrq2RpkVpagLbxbym9uTh1REHQsUV1yjQ7WkY=;
        b=kC/q1lWQXzFxEc1G0Rwy3LGioo3nUM3rmOHHm+jmxISPoyAB1TWffgxlUUMoQ2qDfK
         urKjS5DbhY/RCiORhi1044amAHDyUpfp4K86gxihRqvi2SGMgj76P7e4v7kulcL//a/Z
         eXx2MyWnrW016VGDLYgUDc/gx9Ka4ngcLZlIx/7PW3VuXFvQ0aBYXNwfzvZEL27r3hb8
         43xKM+S4snICmq9TJDVMW2PLg33IJKbQrBcx/nNd9qXjFKBxi40EnYz3iAEHgwGJ+tk2
         bAbB5Hi7Zm09Ni4w0BK/bHB9KouW6WRKZ9e2GWOharSIOFIGtVOYkM0/j11Liu6bnVDS
         mlaQ==
X-Gm-Message-State: ACrzQf3StRG08rwOpT+zORlxFrWYFH5Ib6bxpnIDcFNPlZkg9sDIrlsq
        HsT8ZIoARuqRWsaFg5fzuO+MXNt8tDgx6oSWGX4=
X-Google-Smtp-Source: AMsMyM4wZ3KM3bv1WBiHFnmWOO8Msm6909wuihlUA7xJv313iAW4xA1mzKBzJI2/4dgP//ip6ORR+aTOhySEHm5arhM=
X-Received: by 2002:ac8:7c46:0:b0:39c:fa92:a27a with SMTP id
 o6-20020ac87c46000000b0039cfa92a27amr25660189qtv.61.1666621148926; Mon, 24
 Oct 2022 07:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221024132757.3345400-1-sravanhome@gmail.com>
 <20221024132757.3345400-9-sravanhome@gmail.com> <CAHp75VeCGNvLhpsRvfzf8oedAhZVGuaiDQYJyahpPkvz1qQd7g@mail.gmail.com>
 <CAHp75Vd8L3vnfqahSP77b8bA-Z70w7rHOSNVgXPUXmOjBonLPg@mail.gmail.com> <40711ccb-ef96-4905-40ed-525c0a490fba@gmail.com>
In-Reply-To: <40711ccb-ef96-4905-40ed-525c0a490fba@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Oct 2022 17:18:33 +0300
Message-ID: <CAHp75Veht22nPGyZGp4G0yGvYm4hyjZGvX4fdz4qCz7VUJcEdg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] power: supply: fix wrong interpretation of
 register value
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 24, 2022 at 5:07 PM saravanan sekar <sravanhome@gmail.com> wrote:
>
> On 24/10/22 15:50, Andy Shevchenko wrote:
> > On Mon, Oct 24, 2022 at 4:50 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Mon, Oct 24, 2022 at 4:28 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
> >>>
> >>> fix wrong interpretation of bitwise as hex
> >
> > Maybe you can replace 0x with 0b instead?
> >
>
> Ok, I consider to changes as "fix the register value interpretation as
> 0x instead of 0b" does it fits !!

No, it doesn't because there is no evidence of 0b in use. I suggested
to use 0b in the code (as the part of your change) instead of
switching to hex.

-- 
With Best Regards,
Andy Shevchenko
