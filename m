Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E85857A8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jul 2022 02:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiG3AyX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 20:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3AyW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 20:54:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF09172EF3;
        Fri, 29 Jul 2022 17:54:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o13so7653858edc.0;
        Fri, 29 Jul 2022 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HiX7UZw83z65upkOi8fzhvPs9EuIeKpV4I9Y1lg/dkM=;
        b=CQoKjaEltHTvhH0yPkJeFkyXVZBJ0boHa8rjowvJXaxwlf2kImZTIDryfE7Nvwtm5a
         4ChFsph0c0MaJauQNQ+nYWg/BHLpOhuGlQeiYK6WUqtHPZ11FcTZDmi69yUNO594XPbZ
         nU4h6Bf8kuycorLi6Ov7fyolTlrBTcEgeuwZ/eBFNTfHTskKKp0gPqNUNUaFbF9fU5t/
         KFqP9aGsaiwCekGxmSyjDg6fwnf/NDs97ePwQ8jtDOsPmkvXNDUOZQLJhNw+GM8N3PpZ
         qrlOycIdQgb9j08uuYKc/DjFR48xsSis07JcFC6HktiikcjfwUeRWkrD30R8kegx28Wp
         c3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HiX7UZw83z65upkOi8fzhvPs9EuIeKpV4I9Y1lg/dkM=;
        b=Ap7EeCqYdJDpsrEx/xzSuzsSQmDwm/TdardwTH0KDHsAwpfi5uwBsRsV/g5ubRqqpl
         ruPTLSXT2cZJfMELWgLom0mejg3rURtEHMu4aREeJzGHoZKufi4St7WdRoAcV+x7pAID
         Tz+lTtLQMhI+j6zCDyogsSlLBJR12QSgrGL+Z2wW5Xem3zWTXaWtk4Z/ymvDpLYU+O8M
         xYJFqxsfD+euWTYxoy8taU2HneeCrpCtxfCgi4sfPR4DMjxU81UzQ3rq1xJtj4Z8Th4W
         1/rFqdb9vMl3zXoUUH+ih22bHrQT32rinubTb/PQWP459RPiLN8XPureuB0Oket5LOOe
         VwwQ==
X-Gm-Message-State: AJIora8VPmosydw7mdApN6rf+dsN/IA9Mybk9kySZJCpNixKF+avrHnx
        gwXug9P/jiK0Xm7gKwnPLkJfuiUO73SawFQSRc4=
X-Google-Smtp-Source: AGRyM1tUVTpxiDLTTTJzAJjWmjbGLDXV8sBbEonp2bC2OiTZrFV1hPmVHZ47eXNINQZjgXPJAkU391MxbP3NdyOA+fc=
X-Received: by 2002:a05:6402:501d:b0:437:e000:a898 with SMTP id
 p29-20020a056402501d00b00437e000a898mr6006440eda.265.1659142459180; Fri, 29
 Jul 2022 17:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
 <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
 <8639301c-ae9e-54ac-919d-baeb8760a31b@rocketmail.com> <CAHp75VecjLe67XfK6qgM4eZfKiTJ-UabD40i6Q_YmMpyWAWMkg@mail.gmail.com>
 <c52e34f1-1cc3-4351-e03b-6b9bf83481b6@rocketmail.com> <CAHp75Ve_0srfZbvKJ4z8dW3Mp_a8CHSTqASSAY_SOJiD20K0eA@mail.gmail.com>
 <30ce3ff6-14bf-19e5-e330-d7b8b30c1727@rocketmail.com>
In-Reply-To: <30ce3ff6-14bf-19e5-e330-d7b8b30c1727@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jul 2022 02:53:42 +0200
Message-ID: <CAHp75VdO+bZLjetjMB7o5Uqc7pUYg1P6myp7em-tdOehE=z=vg@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] iio: magnetometer: yas530: Introduce "chip_info" structure
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 30, 2022 at 12:56 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 29.07.22 18:13, Andy Shevchenko wrote:
> > On Fri, Jul 29, 2022 at 1:06 AM Jakob Hauser <jahau@rocketmail.com> wrote:

...

> >>         static const char * const yas5xx_version_name[][2] = {
> >
> > yas5xx_version_names (note S at the end)
>
> As I understand you, it's to be applied on "yas5xx_version_names" only.
> In the chip_info table, it would then look like:
>
>         .product_name = yas5xx_product_name[yas530],
>         .version_name = yas5xx_version_names[yas530],
>                                            ^
>                                            S

Yes.

> >>                 [yas530] = { "A", "B" },
> >>                 [yas532] = { "AB", "AC" },
> >>                 [yas533] = { "AB", "AC" },
> >>         };

-- 
With Best Regards,
Andy Shevchenko
