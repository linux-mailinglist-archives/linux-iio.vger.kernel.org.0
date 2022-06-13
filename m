Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC53549BF4
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 20:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348647AbiFMSoT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344231AbiFMSmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 14:42:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E51A6438;
        Mon, 13 Jun 2022 08:24:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id s12so11880809ejx.3;
        Mon, 13 Jun 2022 08:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVUmU20kbF7o45eINMXcQWhA2++Jt1Gz7TIlLBAcfGY=;
        b=bwm6mo5S+Gfcv1FtTvhbUmEl+3+gpq1UllxZg8RO3eCO4jH/9iRV+/9jRKxOB8I0v1
         O53eX56xsqmNdIHD4FIIElyXl01I1g6vvb07e02rn/1y3BOaPFhG0NUkc3KvoB9QG1Ek
         A3wPgchW4XJuBpVa8i4osiHqSkvDVk3Hn90gBQeCEHum7dmIMn7jQ/d4LtdvSxvsVKsS
         Q+ijW6ghutHfQ2CR3/EgsDFx6JDWnq+Efe0NMhB4bh8n7XfZv71rHEgro93XnIJHGQy6
         a3uT1QO1mlS6raV1UYEwivp+e+Rwh4aDsG34o8nMqXYJ0c9g0joEDX/8X+ocDsbhsQoo
         6/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVUmU20kbF7o45eINMXcQWhA2++Jt1Gz7TIlLBAcfGY=;
        b=4pmpYkpZlkluDuQ3DOy8/bg6eMfGnUfXpwBtCCxFWSGshO4A62NJQYIQ96bekivhjq
         u8sKKNMse3BxJbI4BWbOZrHSjaqZ4XPh2r9ZFy6h44qF3HlYm3KVRRJwOKYUQaDCqM7T
         PvsIPPnbyknNNxbBi8V1ryza6oBKOf+wawrxaozdsTX2zgykEXINsHVgsyWjpTfInxUV
         lcy6BcEXwcsTR8135j8tadffknUcLkfARFhn1OxRKRxSR0r5LMD1YcNQfBVDfyV7AM7P
         hXCKWQ3/jOBcnI4ezIVsavyg4/r+KM2HRcTYMq1AYv2/Vv0iOxPb2naNRC7+abjKpWAk
         qZkw==
X-Gm-Message-State: AJIora/AR/Y1dyqMNw9G9xO42dxxL5Nog9J3MsTXXR3+rviP9hWFhX3u
        Ijybf12esY4MmI7E5kH9bbplDVQPeIQ2AZBDWpml3D7zTSS6xA==
X-Google-Smtp-Source: ABdhPJwalqVJwz9r4TQJ/IECZdmTNaWdK14VSAxs6++szwRya79SW6hSRzILoyilYEaEWdeXSphA4YEWDHKA8TJtoaY=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr351775ejm.636.1655133868940; Mon, 13
 Jun 2022 08:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655081082.git.jahau.ref@rocketmail.com> <cover.1655081082.git.jahau@rocketmail.com>
In-Reply-To: <cover.1655081082.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jun 2022 17:23:52 +0200
Message-ID: <CAHp75VdEyaENBYLP5MWh9aZ0kvxHPGzEMQCF+gHTpqc0Nqks9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add support for magnetometer Yamaha YAS537
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
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

On Mon, Jun 13, 2022 at 3:16 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This patchset adds YAS537 variant to the already existing driver for
> Yamaha YAS magnetometers.
>
> Patch 1 is a fix on the current driver.
> Patches 2-6 are cleanups and refactoring.
> Patch 7 finally adds the YAS537 variant.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for patches 2-6.
Patch 1 is already reviewed, patch 7 needs a bit more work.

> Changes in v2:
>  - Reordered the patchset by moving patch 4 v1 to patch 1 v2.
>  - Removed patch 6 v1 ("Remove redundant defaults on switch devid")
>  - Accordingly, added "default:" to each switch statement in patch 7.
>  - Moved renamings in patch 7 v1 into a separate new patch 6 v2. I added
>    the "Reviewed-by:" tag of Linus to both patches, hope that's ok, else
>    feel free to comment.
>  - Removed regmap reads and related debug dumps in patch 7 in function
>    yas537_dump_calibration(). As this function now applies to version 1
>    only, replaced switch statement by if clause.
>  - Also removed "hard_offsets" debug dumps in that function.
>  - Fixed typo "initialized" in commit message of patch 7.

> Jakob Hauser (7):
>   iio: magnetometer: yas530: Change data type of hard_offsets to signed
>   iio: magnetometer: yas530: Change range of data in volatile register
>   iio: magnetometer: yas530: Correct scaling of magnetic axes
>   iio: magnetometer: yas530: Correct temperature handling
>   iio: magnetometer: yas530: Change data type of calibration
>     coefficients
>   iio: magnetometer: yas530: Rename functions and registers
>   iio: magnetometer: yas530: Add YAS537 variant
>
>  drivers/iio/magnetometer/Kconfig         |   4 +-
>  drivers/iio/magnetometer/yamaha-yas530.c | 790 +++++++++++++++++++----
>  2 files changed, 684 insertions(+), 110 deletions(-)
>
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
