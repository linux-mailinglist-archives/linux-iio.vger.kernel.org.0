Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDCD373BBC
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhEEMxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 08:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhEEMxd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 08:53:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25913C061574
        for <linux-iio@vger.kernel.org>; Wed,  5 May 2021 05:52:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 124so2399466lff.5
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUJ6wIodjpCneHighQ0GfY8iqpoBiT6LHmEd2Kcx/xc=;
        b=EUV6OxDbgS6qzK3ecwukeDactMuVot2m/JQ5e65pqn9Y5KX9Wd0U4L5oGUUHTVMc8T
         sJTshB6mNhR87tzS/RUDKmqmDpZtp/jo9bgY/Ct9XH7TaNonjfjWYaCgAeffGhlGUuwL
         Ocm1KpZ1GTP60hKlL1xK4R9ryauExez8czBIh+EjqHYAaxBTcAEka/pXR83SOD/Db9V6
         ZBeuEb3hvfy0Mn5rfZMEDpph73rCJFBfpMIoTXc/IBnR0UPvWX2eFwM+hd98bki354Xd
         4bQAOMFTyavJo49o2wwbesF9tIzRDR0zbWYURxbxMmh7ypjI6+qua08ndZVANo5e+KGq
         vvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUJ6wIodjpCneHighQ0GfY8iqpoBiT6LHmEd2Kcx/xc=;
        b=q78wUZJkRAs5xBlfsGP61nLkvyoE+EDro6OS5XLCA/OCOv274v1vV2LDQsxLGPoRto
         lIhGAPEokOq/fvgH67oa4x5ktMZ3j1+P6mSZz78ikAmXdJtIovKz+1bew4ho2302Anrv
         HffEj0THMuiRmlocBpOqn65sK4Jy5GBDjRuC1WjcwOy/ReVqNEtpQPPGLfeM4+8XZ4I7
         vdwmgcKD4D6BD9xv55yWMurLM992zMbumDr5j4HGZCH5AX1sGhTf5u1Li9/egaiasdAs
         /Mj6IwUM1EsN/B99sorZU5CS7tGxXelIVXESEK8udKSW2h4J3kmwDeqKtkQ3ai2mJbC2
         hd6A==
X-Gm-Message-State: AOAM531oVZWU2aDTlqeIOHf1Ifisos2NmdTy3enzVB0YkJr7dbKz0kDI
        X/FEO2ev9PIQfH5M9o3E90mL5bLMv0B0qOOaAS6BYA==
X-Google-Smtp-Source: ABdhPJxYcof+sEcIS6k1g2fBI94Tsit285jfjEfq4xJ9sCMXYWCCpOkw77yViYGWgY2XHiMONxP5KDRPgNY4lIinde4=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr19983583lfl.291.1620219154638;
 Wed, 05 May 2021 05:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210503144350.7496-1-aardelean@deviqon.com>
In-Reply-To: <20210503144350.7496-1-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 May 2021 14:52:23 +0200
Message-ID: <CACRpkdZcnzx6+OQjG_3z8MP1EkhGFBKx1kDxaSFBmDcxs4KHGw@mail.gmail.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 3, 2021 at 4:43 PM Alexandru Ardelean <aardelean@deviqon.com> wrote:

> When the ioctl() mechanism was introduced in IIO core to centralize the
> registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
> core: centralize ioctl() calls to the main chardev"), the return code was
> changed from ENODEV to EINVAL, when the ioctl code isn't known.
>
> This was done by accident.
>
> This change reverts back to the old behavior, where if the ioctl() code
> isn't known, ENODEV is returned (vs EINVAL).
>
> This was brought into perspective by this patch:
>   https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/
>
> Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
