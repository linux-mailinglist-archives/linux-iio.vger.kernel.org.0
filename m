Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D659BC3C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Aug 2022 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiHVJEd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Aug 2022 05:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiHVJEc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2022 05:04:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E418E24
        for <linux-iio@vger.kernel.org>; Mon, 22 Aug 2022 02:04:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u6so7898618eda.12
        for <linux-iio@vger.kernel.org>; Mon, 22 Aug 2022 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8t6DRoxgkPozFEWeJjBY16ppRcOF6Bnal2wZ0hlJ6iQ=;
        b=lbUYYMD/RybmC+VdXZHCkHhqfOpZRvN9VMpZ8ln6xNR4ja/S4YYUbgsmx6pVAcq0Jf
         SbPujLMYmBnlOJHUAdTd+ALc0IKwvkwBX4uZb53dHnvuINqD95E7VLVsGMWv/Jndr7Q5
         VkoJESZxNwpGucjTKCez/cGwrKPQMtmyIwkjRW5eUeX1IKW6SXgMWeE/TZBtqMTJHI6q
         wzpvweJ4Gv+kOKCuojyX+kKuzeefaQJBdtuXmG1B28qipr41zvPZu7lQg1LK+d+6tWA+
         ylpmrPgpfd9rMDpA4GgTVjar8ZmYOsTeWmzE3zCHjAbro82ymXTGQSXPkNaG5HEjUanj
         RV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8t6DRoxgkPozFEWeJjBY16ppRcOF6Bnal2wZ0hlJ6iQ=;
        b=sTNcK+JUDQnfe1k7i3uQcEAskC0QJpy1SL+uakGU1XtHH7qvol6+W/ohVee3vLVA+S
         ZL697OhIW3jYXojd4sQkNmAtOqOFOaMYrwwPgQJMjAqW7Xe+AUvX093dc3b0yINlyhhn
         HKjDhy4dPQzieaDFkaSzaug4jyhdmoDLPGUVpUtx6Qy490BPGhTZSSkpPAsfQ3XfNi/4
         PC+yhiKG5ExLl97bUbMnRSYWKNmXfHkO8kq6GUsey++erk3I1wtQpGFcz0ccxvT/XBBt
         Huubf4fCLdTESU/Fg3cqZDKpePOhLcG18nX7QNdrv21eWZ2EE8ckx/FhlOYdK8zY5c5R
         QrCw==
X-Gm-Message-State: ACgBeo33pj7C1sIoEqMYImXR1Nsx0vunkRTnbWCvvjuO6r4n09OXj/On
        hlOEzsrc+Yj4zjKBCG4dxF8PxVSO/VvlzXgoSedn0A==
X-Google-Smtp-Source: AA6agR6SjlNjb9aBWck/aucsuQC/f/aOmME+qBmC7T/H8g9Hp1h1hVA34bfSVjsAkBDD0b0AD104HkPw0t7Cr4A3h34=
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id
 ew4-20020a056402538400b004316d84b451mr15046123edb.46.1661159069522; Mon, 22
 Aug 2022 02:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220807192038.1039771-1-jic23@kernel.org>
In-Reply-To: <20220807192038.1039771-1-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2022 11:04:18 +0200
Message-ID: <CACRpkdb6qxO38kS1=cEja-KZSR5RcV-oWX36ikxggsLm8Y5ixw@mail.gmail.com>
Subject: Re: [PATCH 0/5] PM: Introduce EXPORT_NS_GPL_DEV_PM_OPS() and use
 cases in IIO.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Sun, Aug 7, 2022 at 9:10 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Perhaps the most complex case we can have is a core driver module (usually
> with accompanying per bus modules) that exports, in a namespace,
> a struct dev_pm_ops. The driver has different handling for runtime and
> sleep suspend / resume so (almost) all callbacks are provided.
> The pm.h helper macro _EXPORT_DEV_PM_OPS() could be used here but the
> handling of the last two parameters is unusual and very different from
> the macros intended for driver usage. First parameter needs to be "_gpl"
> and second needs to be the namespace specified as a string.  Other NS
> macros take it without quotes.
>
> As such, this series proposes introducing a suitable macro and then provides
> a number of IIO driver conversions. Where relevant the exports from the
> driver are moved into the new namespace.
>
> If accepted we can either take the whole lot through the PM tree and hope
> there is nothing much else overlapping with this driver code in this cycle,
> or ideally we could use an immutable branch and pull this into both the
> IIO and PM trees.
>
> Jonathan Cameron (5):
>   PM: core: Add EXPORT_NS_GPL_DEV_PM_OPS to avoid drivers rolling own.
>   iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
>   iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
>   iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
>   iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace

I like what you done here.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
