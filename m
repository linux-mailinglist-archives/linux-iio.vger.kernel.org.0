Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A73319BDF
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 10:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhBLJ1g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 04:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhBLJ1c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 04:27:32 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37AC061756
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 01:26:52 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a25so10790768ljn.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 01:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYyTdHiOphi5wy20sCohGohSDGJFzJ14qi5hSzM5U+A=;
        b=Wo5odOySF/CFjO72mwfuehexVpDt5boeTBrjIi8eYdCX5x91Ji2sDZLyQY0eiM1n7J
         JR2GkNIaK5Y3PyjM+xg4Dkaublh/xAdcOhoNGhuS5QTsZikUhv+DZprC9Q25ghrVeerl
         jh2sYwpMfJcWeG1pUt0h6qPLrHnYxwzUpkWdWKWmYwNcWDRRILxxRh/P87sZR8ZIHQMB
         dqqwC1BFHhlq+4x++uWHc6z4Cl4Pse2K7iluG4dEEQ0pCh6UylDjSgKVkQ2kr/SjbCQo
         exvFjK6ZWi2hKR9YxMWiLG449QDlyi1psLns9RExwklkzgPexbJ4O198qXtn4aOou7Ff
         m9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYyTdHiOphi5wy20sCohGohSDGJFzJ14qi5hSzM5U+A=;
        b=A7IWk0XW0kzSvsL9+7VGBrbiAQPfuSBIAUmEIHCjVRRc2dXrhvNt3Fum3lAHpN0d3Q
         7VqywRa+WlIvhW6KBn9lX51jLpg3GCVD+clXcNM7kKWHGN3OKwTigq9UIF5882LKTwq6
         TpoLZI9j7JAI9rdaYHFUH9pIHDIIOTzY/YEMbQCQQzHUlV0MuclFRok9Os56fcmCL7XP
         3N5YGRnVzX33Nn/gC4QYuF81u1pJj8VuXJMHsOKb+8s2tSusnkH0m5FjTpLNS47NogW/
         GR3lfr+lNbpeGFdiWk5t+AIIcnwdSaySzpNki0Imsefq2VtnjsYfX7+hjyb6peVMWyVL
         +G7w==
X-Gm-Message-State: AOAM530D//la9up0ghSTXhp7Xonr4oUh+IPjmNICUn3DvhhPpR5EygPU
        u/y20XBGWcN4vSb1+mdF4AQzM1hvLPkdxt7qpYLBFQ==
X-Google-Smtp-Source: ABdhPJyTM3mAjXEWmeU9qHDaKPjX79dsGxohgA/kWmyN9gOGAk4Q6lBeaCJkUYRDfjmJdhz1GKgMtr5vBbKYhePpE30=
X-Received: by 2002:a2e:6c17:: with SMTP id h23mr1222875ljc.326.1613122010712;
 Fri, 12 Feb 2021 01:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20210208135347.18494-1-o.rempel@pengutronix.de> <20210208135347.18494-3-o.rempel@pengutronix.de>
In-Reply-To: <20210208135347.18494-3-o.rempel@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 10:26:39 +0100
Message-ID: <CACRpkdZ5ZQDcy5RP=CVPJ14Lyktw_4yOuELJRweeDpPKRL3RVA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 8, 2021 at 2:53 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add simple IRQ or GPIO base event counter. This device is used to measure
> rotation speed of some agricultural devices, so no high frequency on the
> counter pin is expected.
>
> The maximal measurement frequency depends on the CPU and system load. On
> the idle iMX6S I was able to measure up to 20kHz without count drops.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

From GPIO and interrupt point of view this driver looks good to me.
I don't know about the userspace interface etc.

Yours,
Linus Walleij
