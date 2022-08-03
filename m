Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0E58923F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 20:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiHCS1q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbiHCS1p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 14:27:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558445A2C2
        for <linux-iio@vger.kernel.org>; Wed,  3 Aug 2022 11:27:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s11so11128987edd.13
        for <linux-iio@vger.kernel.org>; Wed, 03 Aug 2022 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CgsRAN74WJvmSzS9JVuUR+OnAdqiFFQn7INDdzWbvQ=;
        b=p+YPivVJdwo5IPFYA4JUokAgeHffkqT5hSkYYCPil+8TUnfkwyvqy/qHcCkj2yWRed
         cPC31RWP+2YrsHLwOoxmxo1wbQSHo5MgMEMR+Un4+IFn1PHG5VRdNxmZRAatCw3y6C17
         jYzIAV6iP5ri0GmLXLnOCr5ztOyPske70yvjsSosPVBQetQvT6fuXO7TvO+ghmnjOqfi
         1CLCfMxx412AyzLr8gRzQnXuHi2IiWXFEyHteKnQr1vyHbAAUKdMubuJ9nRiLOuJehSn
         FqPsUlgDvPEDObL53jHvsxylDLyvHSUZKDMFqFsuZLBuEMUZkZlvJipwrLnyGSEubZti
         EBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CgsRAN74WJvmSzS9JVuUR+OnAdqiFFQn7INDdzWbvQ=;
        b=PgKbL1hYR8Jmc3/ScSo/zmvcrNWXKn2SVql6AsNho5YFVvTo3XPG37LYBonbHmTTnD
         vWvzpaA1lofABz/DuUA6jUi3LCAxB+qDOwy6f+ay0Om4sy2cEVb5/riihKtXSs5czELw
         yS0H33kDPWayscpHDvPBp4/Jro4UCI8IDE5Y8zyAz7r3+GOpAPOHhJb9Z2VIL/IIw8/h
         v6A3j296qxucx/hv9oJwY7xBkXPLy6vtbnKc0v0nm+OQVaR4dr4K1ump8Y4ujg/pcMCH
         q9ojpBVw66FhE45BXCbZVlDodMjYfd5hrM+aANwZ2puujgCEPsfFwBXF//CLjJA62pzz
         Lb5w==
X-Gm-Message-State: ACgBeo1h1eWSF2d4UbBF4Z6o+dquuc7Z9mj8zOtdh1LDfPDVRUTTuyMM
        01Z+GkXpHDcNY2c/l19+atQYHYIXN2X8he1+6YeVXQ==
X-Google-Smtp-Source: AA6agR5GO1f0s2L26bBOHH3T1rJe02UH7Rh9XGpRwEw1mQtbhhgLRwBSRWpQdMxBtw3uuck7/Zg1lU/eBQDSupW7n3I=
X-Received: by 2002:a05:6402:1777:b0:43d:85da:2fac with SMTP id
 da23-20020a056402177700b0043d85da2facmr18062550edb.32.1659551262955; Wed, 03
 Aug 2022 11:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
 <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com>
 <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com> <CAHp75VdDdKo7rt+cik4J+_4tDRgBXhgZYc8p+dOSH4s_gtCOUg@mail.gmail.com>
 <6e13daf2-179f-d37f-ace4-db5cd37be8d3@rocketmail.com> <CAHp75VdLBowZ7=6g4aFVr5zkN5Pkv7ir68vPCdkRmoFysqRz9Q@mail.gmail.com>
 <f8071532-14c5-c2a8-ca75-f4327066817b@rocketmail.com> <CAHp75VcPMZSpDS_S_4mM2bfq4154HVMHzZHvdJnP6oUA7RtpiQ@mail.gmail.com>
 <fa6c77e9-1d22-de2f-4cad-4afadf8c6a2a@rocketmail.com> <CAHp75VcsFmzvmk93eSNUwZCDoUN8-7gRkZZ1V4vbFHgnweq5uw@mail.gmail.com>
In-Reply-To: <CAHp75VcsFmzvmk93eSNUwZCDoUN8-7gRkZZ1V4vbFHgnweq5uw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Aug 2022 20:27:31 +0200
Message-ID: <CACRpkdY9_7ayVWKSHJ7sMfZrEMjyfY30SPosca8MftGjkbiP1A@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] iio: magnetometer: yas530: Add YAS537 variant
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 30, 2022 at 6:36 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> > I think the define and the formula both look strange.
>
> Definition is available in units.h, for most of the SI prefixes.

WHoa news2me, I never saw that file before! Learn something new every day....

Yours,
Linus Walleij
