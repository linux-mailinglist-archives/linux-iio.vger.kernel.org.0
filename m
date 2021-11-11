Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91E44D502
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 11:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhKKKe0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKKKe0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 05:34:26 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5430CC061766;
        Thu, 11 Nov 2021 02:31:37 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id az37so10791136uab.13;
        Thu, 11 Nov 2021 02:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4enwRC8TuKI2GB0AGVlP6QNL8DbsgjOg0CrVYrlGOUA=;
        b=ILoQYjHk7zJpnrivYmFTUEt3aohMdnm8X8NL/q2Juw27tzobMu2E/LxzuhtO0Dlhca
         5huWCJWp7czN/DbK4uBcINTRnDvQWTlTZI1ASJgI5EEY+pIxvqZSHb3+qZi5KmjtA8MG
         ZMA0HKeHp0zL6ZuAUmck9k8gUKnaHSwEFeaA83x2tQPpmHxOkqPGB0G1Ttj12WxCfVfy
         nvW1zorlAMVbEEv3BUdCGSRINcvPSNBXRprTgXB6RBuK1ZJdSax5qVxs8GrXd/bQzjv2
         3wOI3whOv99YhdkUT3KkqvUkKcRggjebYWBQUEyFLQDCCVryY65E7ZnFN7OSYS2dXJi+
         JiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4enwRC8TuKI2GB0AGVlP6QNL8DbsgjOg0CrVYrlGOUA=;
        b=FoNMNovfdD5zCzRRtgbgocEAaMu09Zp22uMbz6ZVIe1MrIIsY6M9j1rhOTkIOR498h
         ESLrt0/dN+1/OJstw+GhkwlRngJbyoBZOYkbLf3p7Wlu3F2EbmhmMiNCLFaxfNV/5bPU
         2Pml+hWVKei6yW27tLQaq6qhkwGCjgHzVU9/p3Uvtj2QfPqEw1TKdC8IEca1BJqsSswb
         WKxH/Tcqb2nYMtBAKWEmvZy/C8In8Ul5F/IV8Sptp0fP+tTtXkMlCmth4OUdmZbQxNL9
         eNWn5oaO4xiZ8lhQ6scS/UqOeIjNwFzIvtui/lLAfeAi/yGFAOrXToGGzMYaQs80DKsg
         IW3w==
X-Gm-Message-State: AOAM532bdyEmr4yIkRFPgw9ajB2JGun9npbbWE25muw6TJye1xB5JxbI
        MTZ3JwSkmfJUSwLXN855nJVR7jn7SKOQIy6yCxo=
X-Google-Smtp-Source: ABdhPJxM7Zqn7XS994yvFxrEsUq21I4hiwrV6KG12OVBJxfJ0cNGQ9M/sygXzAFBkMtWcG07qPbROzjYFjjdf8z+nD4=
X-Received: by 2002:a67:f516:: with SMTP id u22mr9305581vsn.47.1636626696452;
 Thu, 11 Nov 2021 02:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20211111083954.6286-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211111083954.6286-1-lukas.bulwahn@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 11 Nov 2021 07:31:25 -0300
Message-ID: <CAOMZO5B4k=UvE5XTgbsjCfoo0h0Y7H+xN6mwh9Bnc2L82QYzwQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imx8qxp-adc: fix dependency to the intended ARCH_MXC config
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lukas,

On Thu, Nov 11, 2021 at 5:40 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP
> ADC") adds the config IMX8QXP_ADC for this new driver, which depends on
> the non-existing config ARCH_MXC_ARM64.
>
> Hence, ./scripts/checkkconfigsymbols.py warns:
>
>   ARCH_MXC_ARM64
>   Referencing files: drivers/iio/adc/Kconfig
>
> Probably, the existing config ARCH_MXC is intended to be referred here.
> So, repair the dependency to refer to that config.
>
> Fixes: 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

This looks good.

The incorrect  ARCH_MXC_ARM64 symbol probably came when porting the
driver from the NXP downstream kernel:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
