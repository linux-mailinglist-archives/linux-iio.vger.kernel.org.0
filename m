Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11CD418925
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhIZNyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhIZNyb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 09:54:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B688C061570;
        Sun, 26 Sep 2021 06:52:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e15so64144718lfr.10;
        Sun, 26 Sep 2021 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxJ72FcMdSH92d2FNKqbZnLbX5VbUeijKpG1xPwvjMU=;
        b=jarbjZcJDaXtDYmpZgQDQJGEMw182TJW8z/2Ek/YhIB+A7iepkU6b+X5AuVkqO8QN3
         g75BHG5Xa+gNf8pmGaXra9Icsz9Bl5HAiFFNWbSJ8fSzRCIUcnljGsxhdHqetPHW6ENm
         EnwfvLu28jXiKHcwi2TY+y6zUnw3RUq+CnBWJ8QibEXsl31aumaDSS53sL9p0KFErPeM
         FYi8uLc0ULxx9hDOrztHXBH4AbD3zxpzGopBvfGBAg9gmhfBjEg9yYDNCLsQYcH6SgPx
         eurPREIItz0OzBp35MrBLbjgmUL6Y6+1lntM6zlduw0rA4Ki6EaVcS5ciqwn1V+F9OUQ
         jxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxJ72FcMdSH92d2FNKqbZnLbX5VbUeijKpG1xPwvjMU=;
        b=LT9ETOtxxFk77ixkvTRwS+96nhV+jRrHvubqw452vm+Woaj0x1V+D9On7REhxTCvZZ
         +eBtPOJnHN+WAATUnXtuOTKHw2Dgq8GnvWlbNMVpbZtZCtQFy/ha4THzp/65+C6qkVAh
         vmpevAoG43DTNq1FjbUgIR+8x6PJWqfzYDI94lwKVqJrfNeSSylAkd/MqvYo2troLdx7
         mbTCLYQtLGdL+ShKrSk985KvKS5adHYkjJCCA+txTBxkQsGBM49c61tIzNSgdMt70p9a
         h/8QBiObM072LpR5PIKP13ah+lf5Ami/8htiprDr2ftyFCaBlImNilbWoWdRqD+vDqbd
         jJgA==
X-Gm-Message-State: AOAM5320tckxIPuYxVLxz0e/xAhb5yFJEY+Yk2kR6nD0Kirdd96ZoNrC
        gInePCEY/fHtKLJ538XUh7yTRG76pEjCAAqFag8NxS/Y
X-Google-Smtp-Source: ABdhPJylo9nH+WiaUcYvnkU640a5uADvMYHCuXNZ++jcY3Ss55V+7pp6ppOLzAaXrDk6tLprjPh0+3qEA66hLf7G8ak=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr19264813lfq.113.1632664372764;
 Sun, 26 Sep 2021 06:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210925020555.129-1-caihuoqing@baidu.com> <20210925020555.129-2-caihuoqing@baidu.com>
 <20210926124137.0121a68d@jic23-huawei>
In-Reply-To: <20210926124137.0121a68d@jic23-huawei>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 26 Sep 2021 10:52:41 -0300
Message-ID: <CAOMZO5C9vGNus4AeCNA_qadC3UBKZCJGeSnUVBE9zEBgQyjBvQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] iio: imx8qxp-adc: Add driver support for NXP
 IMX8QXP ADC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Sep 26, 2021 at 8:37 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 25 Sep 2021 10:05:45 +0800
> Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> > The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add
> > driver support for this ADC.
> >
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> Hi Cai Huoqing,
>
> Having had a 'final' read through of the driver, I am basically happy
> to merge this after Fabio has had time for another look (plus anyone else
> who wishes to of course!)

It looks good to me:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
