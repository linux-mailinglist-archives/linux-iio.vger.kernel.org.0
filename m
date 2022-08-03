Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8F5891FD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiHCSBF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHCSBD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 14:01:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DD19012
        for <linux-iio@vger.kernel.org>; Wed,  3 Aug 2022 11:01:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gk3so20647958ejb.8
        for <linux-iio@vger.kernel.org>; Wed, 03 Aug 2022 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FEstCjeeSsKgPzr0PUQYEeFkaVuCOOWn7ERWELXDCpI=;
        b=J+DcTGWUKL+BYbQY//xOdo/6VcSLm7HJZREslX9QB4cLIqkKixszsVRbEV/HkqfcXM
         6bUL17N59MRJUrt5UewksXafKwNL6uqDWwvmV9be7+IocWY7tckWt0i9P494nvEdMVw6
         pGv7bqL+Bso+1R3aBFHWDuGVzK9gpe1pUX5Dh659atoeWU0vxCwbedf9rMB7A+zeoc1t
         n+jepDHtq1wLOMiSmIJ//b14LKyS78HacTYUnmB7b1o1vDqlhIGskUpXJvkL/szboPHv
         uG5CTBFnRsp5hYzB1Cebnpfw7L87V/5boadgXYF3UmTRTGPO2CGd9ZOA7yEXtcJ7vMLt
         5zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FEstCjeeSsKgPzr0PUQYEeFkaVuCOOWn7ERWELXDCpI=;
        b=BNdFRJt5muC5OB9QxszZN0PioUb3YIoC3x/cwoIArHj4WD1cVeBpaPUG0CVHH9qNHi
         5ZxOytPPN+OqnMEXiCTNYQsBhfxYEWlb1vDWNyNQ7zdSjlEIkdr+nGEkWdZzDzmEhsgn
         uJ1aBhuaPkPPrGp+ZABtzqfVd4H/5aR0SZer+9Es03W60L+gJsC4ByCCMct0qS6KEsuz
         Vsv3zEuo+nNY201ouY9N7o+pd8uqB+6Fp/O2CzShjz+U1a/mlzO4QF1KqGboKDpIOQEx
         X+7Pja6dkXPDxAyzdiJYI6u2je58S8sIXaaXdTYZZM7lklZjK/IcPMyRKfgoHq+uZldj
         kocg==
X-Gm-Message-State: ACgBeo33xx1zW56/ebX23UhTBy9MvRyE52T6WgDvu6H2o6tovTwCCNdo
        D4wM7z0t6NeYjSQVVgOOabx1bVKH2i5a3q1rulU=
X-Google-Smtp-Source: AA6agR7K9g3GYgSre8ghOM8oy1p5KcbvD4oVgcvlKt1LzFUWfT47ZHyidqO5vC7jMEK2k9Bdx5EcqtJ/TuL1Y3bWpj4=
X-Received: by 2002:a17:906:e8f:b0:730:9480:9728 with SMTP id
 p15-20020a1709060e8f00b0073094809728mr10217278ejf.99.1659549661298; Wed, 03
 Aug 2022 11:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220803115720.89848-1-matt.ranostay@konsulko.com> <CAHp75VeBSxHK_Nf+PSvRtACeszGeomUyK8Cx1V1FpFiSS013Cw@mail.gmail.com>
In-Reply-To: <CAHp75VeBSxHK_Nf+PSvRtACeszGeomUyK8Cx1V1FpFiSS013Cw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Aug 2022 20:00:24 +0200
Message-ID: <CAHp75VegV4YiY5WZ8SXmK9DCS1msKpmAykgYTskkHi+Zfx-U_g@mail.gmail.com>
Subject: Re: [PATCH] iio: add NULL pointer checks to iio device additional/removal
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Wed, Aug 3, 2022 at 7:57 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Aug 3, 2022 at 2:04 PM Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> >
> > Check if __iio_device_register and iio_device_unregister indio_dev
> > parameter isn't a NULL pointer.

A couple more things:
- make sure you include all maintainers and reviewers (you may use my
"smart" script [1] for that)
- explain why you are doing this change

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko
