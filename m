Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03458C5B2
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiHHJfD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbiHHJfC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:35:02 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA0DE7
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:35:00 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j11so5930662qvt.10
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yr0G4RJl/pMi6o8rpymnFMWdmtE6JfTo+vAB9Bk1aGg=;
        b=iBd3fsAaItmCBm4iq9lLExvdhAVfmr+9lB7TqK2K1nqiaZw/GTGKLwFY3O8G/h5X4t
         gu3MfMcKa8qHuEX7Z3/Dn1O2/ii43lx4/pN/OkdlekGzkx6XNjlYfPi8HaPMM0Ymahoh
         UaV0FynGiDIB0iAdB3vpNiN/i3eUJYftRUPkl6jSelfNA9UalorH/HgiTL7wmMroiV9t
         tpSZ4vtelcmw6V53F0ruRZlLs+mvolyY7R2hFDgNi98oRc+794gzEL41WxR/uuL4tWGy
         M+bmWT5NMZEN6ZCGq/NlWQLlP9IBuYflsIXe/yHh5zR7pLhTtnjJhMpO8vx1I5XPk5+M
         26sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yr0G4RJl/pMi6o8rpymnFMWdmtE6JfTo+vAB9Bk1aGg=;
        b=CN31G1P2WrW2267oSBPPZN6qi3ZXYQKPB9xVYvr4f4puF3D7ZFK09z8wGbrNhoZOaA
         bNatvuuKAa+JYvKO6IXvfuoHpdrxIZx3A2V1hQgXfKuOvE7Ozk0faoaro0l1J6ofnch0
         i04E3soYDgUAj17yTQwpYJqSh3FaFB9NiV2n7n5Wu4cjMv3iyxMM+X0bkCvV9c0BeR38
         CO8wTVZnzFfleAN9e65Fftvkbxu0fDyvyX0Dj7gJvlTg8FpNSb/QrwFrLJ6WVuZiGGhy
         UbzWpHHVDlNp+A/jRHZ57i7jt2eEte4O2OpzSTiRSbdRIcbP3sSRCR/RLmZ2js/hse1K
         ybAg==
X-Gm-Message-State: ACgBeo2hHDhSQxf7EztGh5rUFQII7hyu23dxm4+zwTNv0mrjuuo4hp1x
        3ncHMgP6pCLHsmQ0tDHxZclF7yHZnmcHQILqhCvPVfD6Jtw=
X-Google-Smtp-Source: AA6agR6XGLbaUFs95QX7+nUBfToJ+/YOUZW2XPTmbvogPCpF5tyIBDymj3ChLD4OCnYg2gDnIOCs1lZ1O+iU6KExRMk=
X-Received: by 2002:ad4:5cc3:0:b0:474:8dda:dfb6 with SMTP id
 iu3-20020ad45cc3000000b004748ddadfb6mr15133830qvb.82.1659951299862; Mon, 08
 Aug 2022 02:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220807190712.1039403-1-jic23@kernel.org>
In-Reply-To: <20220807190712.1039403-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:34:23 +0200
Message-ID: <CAHp75VfFGUQevM3skOF_wSxSvTTUy98KCDqyOXUhBLpZ6-g4UQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l: Use RUNTIME_PM_OPS() instead of SET_*
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
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

On Sun, Aug 7, 2022 at 9:11 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Here we could use DEFINE_RUNTIME_DEV_PM_OPS() but that would have the
> side effect of providing suspend and resume support.  That would be
> harmless but also of little purpose as this driver does very simplistic
> power management with synchronous power up and down around individual
> channel reads.
>
> In general these new PM macros avoid the need to mark functions
> __maybe_unused, whilst still allowing the compiler to remove them
> if they are unused.

...

>  static const struct dev_pm_ops rzg2l_adc_pm_ops = {
> -       SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> -                          rzg2l_adc_pm_runtime_resume,
> -                          NULL)
> +       RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> +                      rzg2l_adc_pm_runtime_resume,
> +                      NULL)
>  };

DEFINE_RUNTIME_DEV_PM_OPS() ?

-- 
With Best Regards,
Andy Shevchenko
