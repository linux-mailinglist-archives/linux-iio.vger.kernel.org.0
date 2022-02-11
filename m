Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF64B1AFE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 02:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbiBKBLJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Feb 2022 20:11:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244155AbiBKBLJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Feb 2022 20:11:09 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF9B3F
        for <linux-iio@vger.kernel.org>; Thu, 10 Feb 2022 17:11:08 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id c6so20563260ybk.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Feb 2022 17:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWAtxFOBnLmSYM035NYdRT/JcWj28PeqsxQriuBme8Q=;
        b=FtK4Te4IWb91V1Vn3LbRCzTDklDYen9d6sDgXkXByFFmubx6ljKSsJPvwMg67kw6tv
         wYLQm1716CF6qADAGZSDDlhHPLRl2GGrQTbsRPQNmli7SkCnK49NRLklstyVsI+0OuCi
         1dBwDNzD4+qlfQfJB5Zn5vR2COw0+c5o5YBtP2Kn4saAKWoydQx7p6HYtKqf3a/juzhQ
         ffB4IHmG4WG+8ovXGYk2xosv39og706wSC5QPzOOkg1Jg0VbAhzKSYqAzExljQ6CVZBu
         hbzNVjQ9W2tkXFIz+S0eWHkKOZmNPBZ8w7IB6mf2JhcOhJoD1yKRBoJy52D3G1q+fkil
         3QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWAtxFOBnLmSYM035NYdRT/JcWj28PeqsxQriuBme8Q=;
        b=GS6cGubTOvA1OQ3rkXtVkgTbsjhbtpE67dqzahl43X5zuFfKnsn6mG63rLYMxyFIdf
         HkF31nyvsL2MhTaryOummfgaTU4pCL2w0FpPhgXUIwiMUF51CWeVQ76aOezXWucle2Ra
         1C+kU8RP1Qujf0rqIJBwg+nn6fDG2lDOtaQg4bRUODZhoKQYH+ClkDs8eSjZGq99miRM
         oW8kr0OYp6yqOESqcHvs4pIN8yHjBzvur0MIER8dLp2ZA8mCqz/yrxsg+TcAp7MAtH5l
         BaXYW9rLetCoKn8IylMtDzxtlcaCsxevq9AQEW1+BHkCSziYUBixmhCUKRBZ9p2iQSNe
         Wz/g==
X-Gm-Message-State: AOAM530dECOmznFUpNVnpL1Em68SgCdaK3uE9N3YHYyiTrn1EWi7sEfq
        PYIwlnnsVxi3le82H56+belggUqXRsfwNm2CODX9vg==
X-Google-Smtp-Source: ABdhPJx0NDMuKKHpiSyjhCxVZGm2u9pnNLdHss+U+hAwmB8phM3KI4DuksHpnZJQDm77hJ1ypE+Egc3/AdlqSbYf5dE=
X-Received: by 2002:a25:30d4:: with SMTP id w203mr9347222ybw.511.1644541867928;
 Thu, 10 Feb 2022 17:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
 <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com> <20220207090443.3710425-2-massimo.toscanelli@leica-geosystems.com>
In-Reply-To: <20220207090443.3710425-2-massimo.toscanelli@leica-geosystems.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 02:10:56 +0100
Message-ID: <CACRpkdaERtyiYhJVB536YOgB6JOMTV=eME2Tq6ed3JndZkhq7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: st_sensors: add always_on flag
To:     Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        caihuoqing@baidu.com, aardelean@deviqon.com,
        andy.shevchenko@gmail.com, hdegoede@redhat.com,
        Qing-wu.Li@leica-geosystems.com.cn, stephan@gerhold.net,
        linux-iio@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 7, 2022 at 10:05 AM Massimo Toscanelli
<massimo.toscanelli@leica-geosystems.com> wrote:

> The st_sensors_read_info_raw() implementation allows to get raw data
> from st_sensors, enabling and disabling the device at every read.
> This leads to delays in data access, caused by the msleep that waits
> the hardware to be ready after every read.
>
> Introduced always_on flag in st_sensor_data, to allow the user to
> keep the device always enabled. In this way, every data access to the
> device can be performed with no delays.
>
> Add always_on sysfs attribute.
>
> Signed-off-by: Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>

This creates special dependencies on sysfs poking etc.

Couldn't the runtime PM solve this problem in a better way?

If you look in for example:
drivers/iio/accel/kxsd9.c
how the different pm_runtime* primitives are used, you get an
idea.

Especially note

        /*
         * Set autosuspend to two orders of magnitude larger than the
         * start-up time. 20ms start-up time means 2000ms autosuspend,
         * i.e. 2 seconds.
         */
        pm_runtime_set_autosuspend_delay(dev, 2000);

This creates a "hysteresis window" around when the device is
on, so it is not repeatedly shut off and on, but only after 2 seconds
of inactivity.

This way no special userspace is needed to achieve what you want,
and it benefits everyone.

I wanted to fix this for all the ST sensors but never got around to.

Yours,
Linus Walleij
