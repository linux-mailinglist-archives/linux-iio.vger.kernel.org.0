Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4844A6035CC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Oct 2022 00:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJRWVZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Oct 2022 18:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJRWVY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2022 18:21:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF2B5160
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2022 15:21:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b2so25099131lfp.6
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2022 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fggrqhInI7xpy+PC1UYZVyunQrqfb4y2woizFMD5abQ=;
        b=DA9iS0jiVPNv+NEmLRaoZjhJkdIPktXNkP0ykF27tm/9RMW+K0KUodiuSAd5EA9EtT
         s/Tvd/OnvzjonHIct/RgXOmTWsV4M6LFASw4kOWObgMzZbfnCUBIC5yvqoC9IaNbRvcY
         8ua2eFasBB/e/SUGjOPcZa8awT6XYYBYn8Khk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fggrqhInI7xpy+PC1UYZVyunQrqfb4y2woizFMD5abQ=;
        b=YCxU003cKwTsGBwE0J/7Dt3aZfbQJT0IWTYX5u/HzkyA5qX3iIDmFQyUMsraNwwBkC
         onc1wYrJOuqiB9SSDM98YA7i8eOfdS2BUVW7ASqF9WIgnszvENb6/eaSARIjOyTU4SVA
         GviQDB4KFc5HFaF4j7FbU6/wnAjM1he7YL3v+Jr09RIqXJTxV/vKA5NBNRDqMQ5u7SO2
         D4VOzlkPhsTeBeGumTLkPnJpWyGkFozOj+HFegGSEV2mfeRNPNSr2jsPWnJZHByW/E+i
         0iFJFiZwhcv6PJ5NikMnuu9hp03YPzkq7gAluw5L3tXovgHUQxiGVFZ+0NUP+K9Bl9OF
         h2SA==
X-Gm-Message-State: ACrzQf2DlK6aqXnKThpKJEcJ05d7MDdjhtB171l+dH1EGkNKUVEgUW7q
        dDLWewdywunj1r4Sqba9TTry8hwcKxW2w0UK58wY1g==
X-Google-Smtp-Source: AMsMyM71Ke9oSFS1d5tOX0ooERKxFqMvV8f7wZ5iQe85PckqxHOFZTcwi80lOlsfx7S91KVT8IFBrAfcXDqW0O5x5p0=
X-Received: by 2002:a19:7518:0:b0:4a2:4593:6e14 with SMTP id
 y24-20020a197518000000b004a245936e14mr1722701lfe.82.1666131681897; Tue, 18
 Oct 2022 15:21:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Oct 2022 15:21:21 -0700
MIME-Version: 1.0
In-Reply-To: <20221016163409.320197-13-jic23@kernel.org>
References: <20221016163409.320197-1-jic23@kernel.org> <20221016163409.320197-13-jic23@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 18 Oct 2022 15:21:21 -0700
Message-ID: <CAE-0n52Fq8toTaZG+Fa=hyMAoJMs80huak0eNK9JB+LPdTL2bg@mail.gmail.com>
Subject: Re: [PATCH 12/14] iio: proximity: sx_common: Use devm_regulator_bulk_get_enable()
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2022-10-16 09:34:07)
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This driver only turns the power for some regulators on at probe and off
> via a custom devm_add_action_or_reset() callback. The new
> devm_regulator_bulk_get_enable() replaces all this boilerplate code.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
