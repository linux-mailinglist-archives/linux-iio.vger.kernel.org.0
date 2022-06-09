Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD585446AD
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbiFII4N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jun 2022 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiFII4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2022 04:56:02 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E82F5AB2
        for <linux-iio@vger.kernel.org>; Thu,  9 Jun 2022 01:54:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s39so13087924ybi.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Jun 2022 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46B8xqgLyA2nIxxCyJgy2mwyMAn4omtDFOknFYC1OSo=;
        b=ypJShre3mVtGuITyKsNvvLFGwgERn/nfK1UfwvJGpR1pD12miAvWPE/i9FoXF+TKx4
         bchH7OIGTVVKu6xaHAlFkCdxPBmAlGqEO+/b0ALwQGHI0KNJZMB/AJyuTfw1HSHXJ/gg
         TlV3P8LEVi0I8RuQ4JRlQGD0OpdZ9boZe3F4iAv9XIy4t6e+klPYTEBisJzskHJCXzcG
         F6jC5SkxvUiviRtu/yYrwcJHuvHns13yet7Ae2JWtDxgNBtAWwS74zVf6QfNxH0z3RgD
         DtQNCqPy+zhby7JCAsEvYy02Y/VX71aSXPIeC5VD1NE//SD4ulUf5yNfaOZ3ZMDaY0bY
         +/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46B8xqgLyA2nIxxCyJgy2mwyMAn4omtDFOknFYC1OSo=;
        b=Is7ruUIHGq0g4Lb6ubgSe80sSSzQDNIV5eAYBNbZ1U7OFaf+azFJx0RW5xdc9jb/CQ
         2E7wOVxNw6I/jS6YCWmsu6w5NtF0D/c6b/2RXR7VbTmE9ClI6xOliOjdicaCkrrnu0Ny
         KS3gnYorqBwmFVE0sQhqVzdbN7bKQX6glBK9kDL3bF4W3sdSftt9iN1Sr4NiWUv/1ZxG
         4B+HIjcIYJb+uV/VkjKYM2D9XOuF/U7u2mq0IZ5vD2vFMzjfMtTRYWzB4wcCN1RBZ850
         91XS4pkr0s/BQNGJfuRIOsDpbymD93QC8GBZPDzHID1ot/TfA1d+gvjoj+f8IiNGe7Gg
         HJsA==
X-Gm-Message-State: AOAM530NETTRQArdngo5koemzipxIbiCH2FDr2mr5+4A+0fd+O5J18KS
        IvecmSQKY3QAs+xQow2WGcVsEulk5unOVVkPiFL48Q==
X-Google-Smtp-Source: ABdhPJxuEA/NjpHEQHsLDGdROeL0iVH20a4K0OemuI+2q7iVzFAizFSdq6JiVCmXYBIgKbh0SgJRRuN24JI//rkgc2s=
X-Received: by 2002:a25:b686:0:b0:664:2b6:8e13 with SMTP id
 s6-20020a25b686000000b0066402b68e13mr6741653ybj.533.1654764856347; Thu, 09
 Jun 2022 01:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <1b6e152e1dda138c68ea8c207e46f91337989d35.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <1b6e152e1dda138c68ea8c207e46f91337989d35.1654727058.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jun 2022 10:54:04 +0200
Message-ID: <CACRpkdZJkG98feCSB2EUELRSNBocEV+x_1q3MtkZufJbPMfiqQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] iio: magnetometer: yas530: Change data type of
 hard_offsets to signed
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 9, 2022 at 1:38 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> The "hard_offsets" are currently unsigned u8 but they should be signed as they
> can get negative. They are signed in function yas5xx_meaure_offsets() and in the
> Yamaha drivers [1][2].
>
> [1] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas.h#L156
> [2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L91
>
> Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
