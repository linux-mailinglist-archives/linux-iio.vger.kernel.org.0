Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867F058C5B9
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiHHJhQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHHJhO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:37:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECEE13CF6;
        Mon,  8 Aug 2022 02:37:12 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o1so5999457qkg.9;
        Mon, 08 Aug 2022 02:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=v8KZt+LyMWBjFGT+ME/T51TbKuZGV0hwxyxfIm9EW7w=;
        b=pnVfDWriqZbwKLAQjlRX/nJ/z7kqL9sFDHoPNcqcj7G1pd155sse5G/J5XkZvHnRBl
         TOm+/6SLxSdhi18HxbB/JKlw59qwdTYT/kh4hl/a+w0Jtb1Pt2hZQDTPQ2T09wsunze8
         mq8nxLoFP6wtwzLEGrAPSC2kzAJYoeufBR1er7L0/yR3eDLTH+QJWWQ0b7KQVqxRU74F
         GdXr51RXDLSVTVA3Vl55oWit/U4ncoE6zxS5gqVTtg1fuUTa1q+O8JHfP2cSfgfi20it
         vL33EgdaDSU6rb+mIVhP+HakOGGnXgaANoAeaMoVmGxlFYcYvjSeqQmxNKYT2tP64uqK
         2Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=v8KZt+LyMWBjFGT+ME/T51TbKuZGV0hwxyxfIm9EW7w=;
        b=Jt5ITcjF/u18a174ywlvIUAV8KGXtreRKoSKmnJ7A4kkhhCCgt+gMcHPI2TBvNYuEA
         O9AEy/Zqq2M4NfaiQxYStwf3j/dhieMk3hFj3eoMbQuEjLUzuw6iAGCXJuhssh985d4j
         tL4IA9fGwTBmoH7kxKIZH59LQ18taa22qDxiFIkCD4Uwu69VEcAZPrbFaajzrel+rLug
         zQN3j4rdun6NMk+vzq4/JYOnZfGbrp5/vXDuf8v07rsM+N36p3E9ub+zogxObz/39Uw9
         b7t/Ev8avL5PbRuRumn9rUYefidC4kTD5H3vZ3nNTck3YjGc6RLIy6HEdNNTm6rb31nG
         8EdA==
X-Gm-Message-State: ACgBeo0N/hbkTwem8yNZ9kXrI9rbhm4pgtv5AciknfXYKdVA8YGhqBu0
        FRJWNGpvL0ckXCnANl8w51K29Drq0gkejHUm7Bs=
X-Google-Smtp-Source: AA6agR5yFoEmXZOJwcTBSTXM6YfPfQyZ+9xJthgTthQBfIrohO/QVfSIkjgitceVtirlgRl/MwzAYv82rgUzoUTf5wY=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr13326042qko.383.1659951431390; Mon, 08
 Aug 2022 02:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220807192038.1039771-1-jic23@kernel.org>
In-Reply-To: <20220807192038.1039771-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:36:35 +0200
Message-ID: <CAHp75VeGP5M0dpxBHarDw7-n=d3+csnqedeSEu1bfJCg=SrV8A@mail.gmail.com>
Subject: Re: [PATCH 0/5] PM: Introduce EXPORT_NS_GPL_DEV_PM_OPS() and use
 cases in IIO.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 7, 2022 at 9:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
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

Pretty straightforward and looks useful to me, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Jonathan Cameron (5):
>   PM: core: Add EXPORT_NS_GPL_DEV_PM_OPS to avoid drivers rolling own.
>   iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
>   iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
>   iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
>   iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace
>
>  drivers/iio/accel/fxls8962af-core.c           | 17 +++++++--------
>  drivers/iio/accel/fxls8962af-i2c.c            |  2 +-
>  drivers/iio/accel/fxls8962af-spi.c            |  2 +-
>  drivers/iio/gyro/fxas21002c_core.c            | 21 ++++++++-----------
>  drivers/iio/gyro/fxas21002c_i2c.c             |  3 ++-
>  drivers/iio/gyro/fxas21002c_spi.c             |  3 ++-
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 21 ++++++++-----------
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 ++-
>  .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 18 +++++++---------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  3 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  3 ++-
>  include/linux/pm.h                            |  5 +++++
>  13 files changed, 52 insertions(+), 52 deletions(-)
>
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko
