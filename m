Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C02C7536
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbgK1Vt0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbgK1Sm7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 13:42:59 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED958C02A182
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 03:33:26 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so8944671ljc.7
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 03:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKPvFn4lbegJK70IF9mRAT16SFZjn/X0197EAhYHLLQ=;
        b=Wsgvqs5Kfz10ZOSGhgSWRHsxlR0h5Ya/M0vcDGuOwEQYH8DHkbAMphjiG/YF76u6wP
         PqbYjgFl87K+F/iulXDoEqDEjn6g6S2JCktEQow/uZ42luigGWnAGA7/CxEu/g9cbOPB
         264Cx67ayUyEoEquIiXqne748PDFuloELOujwO/OHLmLEeQPWGrxRlUWHefyJRJMOi5y
         apnQsNBn8m7liJFvQYlWtn3s4/vfvqFljR1V8nZyIypbiBGcYWL7Gdp4JmfIlJJPmv2J
         WN/JtGU7q/01o9qsXLDGB9Uz3p6oPSKP66I2e9CPGBVi7duntPyvCE0TrtH8buhUTpRT
         XEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKPvFn4lbegJK70IF9mRAT16SFZjn/X0197EAhYHLLQ=;
        b=trxPcSXU8NJFMtVzauolLoQS6C/+KkkcltqyyeBPaOrVbjI6V+VIPzunFSqLyUltlr
         8IsUZoZv0q1ziBxDLxRGVeLegmFZtz0AoBCTn8Oc5Cwh67cI1dYshoby1vOelclAjC1i
         qYTfBpPkHU84v/FIm0rgaea6xet6qY3cJDkLK2lTUe5f1J/fLEEM+tFnYL0T+G2r2YTx
         ss8DYw5+ztYU8fYr6x61spxHkeaCNbIjWALvppxNsQmk/G2QBGek+2L8+vR4Z1ajYGOT
         jPbA7TTJlLwV0gd30ZtKZnJXtaY6qcS8d6wyTx/8/YhalUjeeXexVbcgY/H9BxCQqNlW
         PwhA==
X-Gm-Message-State: AOAM533+9Atdg4ljUuhhSQfeMDtA1BexiPf5b1jFgBX1yTtnVibG2lpQ
        JerODgSBudsJH9PsOHn94VuSXi72iyfj7evcyh0S8g==
X-Google-Smtp-Source: ABdhPJwGY8O21QclJ7LQgaZvcNRsXUjT7S6+h39sfyyDVX1y8W6wzFa9fT/PJBGV3iEIX7G2FYuo5NBIlw6LoFBgaM4=
X-Received: by 2002:a05:651c:39d:: with SMTP id e29mr3999203ljp.144.1606563205299;
 Sat, 28 Nov 2020 03:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20201128004038.883289-1-linus.walleij@linaro.org>
 <20201128004038.883289-2-linus.walleij@linaro.org> <X8HNcg4fQKbo8yd5@builder.lan>
 <20201128112735.57398b74@archlinux>
In-Reply-To: <20201128112735.57398b74@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Nov 2020 12:33:14 +0100
Message-ID: <CACRpkda=_hSfbgTJNCkrHfQ3K7OHhPwbWnvVw0MDNxh-Xdggdg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: Add driver for Yamaha YAS5xx
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 28, 2020 at 12:27 PM Jonathan Cameron <jic23@kernel.org> wrote:

> Even better to use FIELD_GET
> which does what Bjorn suggested under the hood.

I didn't even know of the existence of that thing, and I was still
looking and scouting around for something like it.

I'll rewrite the thingie using FIELD_GET, no problem!

Yours,
Linus Walleij
