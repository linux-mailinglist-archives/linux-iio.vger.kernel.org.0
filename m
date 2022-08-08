Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525CA58C58B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiHHJ34 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiHHJ3z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:29:55 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91413FAD
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:29:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id e23so6059450qts.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=r1uqG9+jieGDCpiV7x5Bnk/XpV7trZB+LLERPLkAKaw=;
        b=PU0ZzM0Wwe3juq9a+lvQE6eoYaUHTbFjmpjCkyXGXRxe8qcNrYABwD5RZK7+1bXahG
         5roQMWtXiUxxM7kFWZZcOo0RPX53uFQhDsE9JTftYaDkNWzpyaA2LjPoPVAhey7slO/q
         WYlA6uaKPVMRUcsAJunUTcBcDufWqgV5s3ppXlBvXyvqF1uD2PaVVYdhuQTjIRDbdWow
         n1jPsgs2QkvfMwxmAYx5xFF/n8XusFKwtoP7yk1eGdreApg+odxteJVirAwnwezVGQ2K
         si1J70rnBLdDny+TeLhomAk5NhC7xXzUxMUg6hSGc8MnM3CQDufc0RFdkx9JWxwF5Byn
         /8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=r1uqG9+jieGDCpiV7x5Bnk/XpV7trZB+LLERPLkAKaw=;
        b=xOX35h8xQaP9mY83CU6NS1ogX1pX5MFXSGiuSF3fRKF+f8l1KEuY/6HOWnuFauEk74
         FuyMpLHgLKcnqoeQXYE9AqKkbZwBMpgT5E92FdtjwnTfd9TMz/KWkk31WToY9ndZ40AS
         y+o50WJfZBZfqhqkWkSFEu/v3bGEuKLzRJW7oAT2PaY54PgQ3J2p+SByY9Djl0PYIyYU
         IfJnEagZTLtaVl4aWPXyM4xlPy54M+dRZWvNxKCwtQR9mfyjhp7cXwCYNYCNrRNGkNiz
         8Bo/RjFoRQyljYbkhF0MqR2oCIfUHmyofqilvEAH56UDFyq39R1fZdgf3yMogKPj9hko
         qnGw==
X-Gm-Message-State: ACgBeo2+ZqyWtwA3ynFo8YTe9pq38eDDQKpcFsErBpfK7szpbEGSGX8N
        YKiOALOfML3fQXD87GUbZWiUEKB6LLAh0NP3BX8=
X-Google-Smtp-Source: AA6agR4Cl84o1TVd95V+kfq6sIIUjZleUEZ9B5Z/z976CAnITS2OTwsfhwudcnVhFEInT8QVaKDVEUWI6mxi3RGhvg0=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr15253447qta.429.1659950994361; Mon, 08
 Aug 2022 02:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220807185618.1038812-1-jic23@kernel.org>
In-Reply-To: <20220807185618.1038812-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:29:16 +0200
Message-ID: <CAHp75VdKJcpy9eiEgqxAwVrePGpEwkohk+3X+J3iQNUQ_4mV9A@mail.gmail.com>
Subject: Re: [PATCH 0/6] iio: PM macro rework continued.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
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

On Sun, Aug 7, 2022 at 8:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> These are straight forward cases so I've grouped them together.
> Aim here is to move to the macros that don't need __maybe_unused markings
> and generally simplify the handling of different CONFIG_PM* options.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for non-commented and, once addressed as suggested, for commented.

> Jonathan Cameron (6):
>   iio: proximity: sx9310: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: proximity: sx9324: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: proximity: sx9360: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: proximity: srf04: Use pm_ptr() to remove unused struct dev_pm_ops
>   iio: accel: bmi088: Use EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS() and
>     pm_ptr()
>   iio: light: st_uvis25: Use EXPORT_NS_SIMPLE_DEV_PM_OPS()
>
>  drivers/iio/accel/bmi088-accel-core.c | 15 ++++++---------
>  drivers/iio/accel/bmi088-accel-spi.c  |  2 +-
>  drivers/iio/light/st_uvis25_core.c    |  9 +++------
>  drivers/iio/light/st_uvis25_i2c.c     |  2 +-
>  drivers/iio/light/st_uvis25_spi.c     |  2 +-
>  drivers/iio/proximity/srf04.c         | 10 +++++-----
>  drivers/iio/proximity/sx9310.c        |  8 ++++----
>  drivers/iio/proximity/sx9324.c        |  8 ++++----
>  drivers/iio/proximity/sx9360.c        |  8 ++++----
>  9 files changed, 29 insertions(+), 35 deletions(-)
>
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko
