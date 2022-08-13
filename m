Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BCA591C70
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiHMT5j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHMT5i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 15:57:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E513CC4
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 12:57:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i14so7266644ejg.6
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JGYHeKzOnPNjlc3OvvMKt2SLhpqG2CadqQbgqAwYLc8=;
        b=cBu1gX955Ca5O0bgIBvDOeVQmOF+rnz03U2tY9avsgtMrBGu4SqEZOYSQN7zVxHoxp
         zMYINRKP8R63yRW+WUQxe1bY/Ooy3Bw64feqNJ/2kk14MSeUuWOteO+y5r4dN+uzJTK4
         LeoGB0XQM6xHxXKJE51Tz6/NwLY1vhbim6561V54zz9L6PqDmeE6wuCMWnbMkFLuA1bA
         xJPd5CtB+WKYE27WuCUl6vxHmKetIfMF5TISbZRKrmdGsA9wV21lLAPyzPlB4dQaAKvc
         wuP/zW6nWPfXhWAY7kjCeknHDRFiWXF45q5DKjlDVI+/rwSPOt0YBLz4wl8Yuq7rTKbt
         2qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JGYHeKzOnPNjlc3OvvMKt2SLhpqG2CadqQbgqAwYLc8=;
        b=7Ja3eMBc1QzQRxqCVYc7PlZr3wxewP5o+P/0CdMDz9voVY4H8n8DLglpUgViK31sV9
         /ei2MLQYZESbsUEE7P+XpP+QtLVRnpLraxVAwblIMUwbuzuW992oo/kUwjh07+qZpoYm
         EkQLMCGo+PbnmD51f/Ek/J3NXVjdE0B9B7K+LMAWqlTCBMR4wefFEDB2NMGZPnA16ach
         HVmmZqfQ45gajgkP+81BZLuweG+hTAhtIcvoZmLHaDcZnInkc4bswASDO+3yUKAPmuLN
         TDka2io2qa817r/SS1kUYrjtnBzDZ7+k59RV3/AcEscts1fT7pWJCEbwatDTuPoLySdM
         Y6Og==
X-Gm-Message-State: ACgBeo2nX7nz2X6hhhhxtCChJALZ1zRMT0+E6VCJgjJxmTVTpl3D0rrE
        WxR8hgVCKcPUvPiHf+CzT/4YJL4uwnLbiPzifV/VQQ==
X-Google-Smtp-Source: AA6agR6byjWAkLF7RgcR8NnyDLpre6XNFIhaJVHwkXh8pa1vGfcsOAPQBNsnrWL7KbaJndQU0ecWXrunsUrX1jcv9Ag=
X-Received: by 2002:a17:906:5a71:b0:730:aaa1:a9ec with SMTP id
 my49-20020a1709065a7100b00730aaa1a9ecmr6168817ejc.440.1660420656213; Sat, 13
 Aug 2022 12:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660337264.git.jahau@rocketmail.com> <93b50c20adb1b2acb4cddb1ab25755070edd7c07.1660337264.git.jahau@rocketmail.com>
In-Reply-To: <93b50c20adb1b2acb4cddb1ab25755070edd7c07.1660337264.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 13 Aug 2022 21:57:25 +0200
Message-ID: <CACRpkdZbbyiRBbdEGJAZwM7cWDWKaLLxyHV92j263cM6aQKwbw@mail.gmail.com>
Subject: Re: [PATCH v6 07/14] iio: magnetometer: yas530: Move printk %*ph
 parameters out from stack
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
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

On Fri, Aug 12, 2022 at 11:56 PM Jakob Hauser <jahau@rocketmail.com> wrote:

> Use less stack by modifying %*ph parameters.
>
> While at it, in the function yas530_get_calibration_data(), the debug dump was
> extended to 16 elements as this is the size of the calibration data array of
> YAS530.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
