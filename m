Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C73ED001
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhHPILe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbhHPILe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:11:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA4C061764
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:11:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w14so25185354pjh.5
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQn1mgnV4gtLAM9j6sf14FjLG1wGtocO/k50ZLRmUY4=;
        b=BYNFSqvlVj4LG6Sd9puyQov9UePSoFRljxg6Vj0tPXTvX7XITzyMqiMePyBoMg19Vk
         qoOl9wyHXiGeSepcZDYFQ1fFeWnDBILj7QFtZSJ+jHUA0a0YeSzPU29zRsPWHsiOVZMD
         wdz7HHOhD4HEWhoV77eOrfAoeL2fG01rnGG6gACtOX7w86pjfuBfGld/7qFhClWFNzpw
         IdCYbmx7O5z/yXHV26bHQMFQNEIRM9MZFA5ej6hBxemM2PB/75fGXiOsO8M8T1xoFMJD
         dr8bRzqoKikYu0lmdzJjqK1HZYHrFuAYEOJ1tynajCus4ttzfJRTWNKWKIh07NBE4s4a
         vXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQn1mgnV4gtLAM9j6sf14FjLG1wGtocO/k50ZLRmUY4=;
        b=Eog5A2+g/QZiTbfgspAlWGulEi0KtA9VDPuQ/L36F0PHL1JGipVB+15v9SwZVwRuOQ
         isjhnDtk2Z14jRvWvZND/+4fmwexDrsWJeIBH+0yxKdFb/9qyjlaNYFrZvAtnsBVl3o9
         +b2Tg8yR8ZR/SMX1/acR88C6/7vwskgQantjvQqMqXW2YpAyZ//+yzKzMxPel4eF1IMu
         Ol5TaExJpb14vAdgLUKUWM14x0R0DCGmtPVOXuoeoLAeOd/LWE1JfEslJ+u3ykGn43as
         OnoE/I/oWmOxaubZgP1+yaxweVoFlniX60R7RXEK26AShf894+Xp/YqVnhUY/gvcAJGz
         RXgQ==
X-Gm-Message-State: AOAM530O3QkpIKdtYNCMYcmrFYUCvZhf0DScL45OmuM92ygmWGzkViVa
        bNpfLj3hjAk3t1FzmY1R3Cf/jRoH7lEDN1KhBig=
X-Google-Smtp-Source: ABdhPJyQuZL27qgPpFys/XvhdXJyThmj7GoDkEkYkfu/tgnLo7YBK48evShjLVG2aE3ZOk5ruA0HYKq37NJu+z0LTjs=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr16136672pjb.129.1629101461558;
 Mon, 16 Aug 2021 01:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210811074827.21889-1-nuno.sa@analog.com> <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
 <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
 <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75Ve=C62FmC20qkLsMVFkc-rbhHqmY2StDtrYqG0=mjtcTw@mail.gmail.com>
 <PH0PR03MB63665918437E96CAF35B7CD799FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210814170204.387bf394@jic23-huawei> <PH0PR03MB6366A5DE7A67BE19759E929499FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB6366A5DE7A67BE19759E929499FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Aug 2021 11:10:22 +0300
Message-ID: <CAHp75VcMG9F33y0YrNrGc=weFZkZ6m7h6_tkjY=ygxPOnagXZg@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading consistent
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 16, 2021 at 10:54 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:

...

> Well, It seems we need to go through the support both 'num' and 'reg'
> route... I did some git blaming and it turns out 'num' was actually supported
> in the bindings [1]. After some time it was replaced by 'reg' [2] leaving the
> driver unchanged... I guess we have a significant window of time here
> where someone could deploy a *validated* devicetree using 'num'...
> If no objections, on v2 I will just try to get 'reg' and if not present, fallback
> to 'num' before erroring out.

Ouch, thanks for digging this out!

So, it means the following:
1) add "num" as _obsolete_ property to DT bindings
2) add support of "reg" to the driver

> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea52c21268e68cfdc1aabe686b154d73d8bf4d7e
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2cf3818f18b26992ff20a730df46e08e2485fd67

-- 
With Best Regards,
Andy Shevchenko
