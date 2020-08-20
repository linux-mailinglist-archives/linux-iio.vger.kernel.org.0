Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85F24BB5B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 14:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgHTM1o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 08:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgHTM1c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 08:27:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5171C061385
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 05:27:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r4so1822375wrx.9
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOn4j3FkCQ7CzTEYqLehaNT1O82KIOD2oKWkS4ZyjOw=;
        b=mtD74Wx3EzbH0YV2w9RI5wzFktW00EzG4UrAxyDYkaIAsSbp3kcBlhFiLmFOnGqHsH
         81FyD/DSx/rhdbqE8dX/QmXLH6bPflO6oTfYHyM1SwhJns54FzCHDDd1LFiV0UsN67dz
         VbIbV5sXnB4LtbYSJzbH8YMbYoUnn7KmhqdCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOn4j3FkCQ7CzTEYqLehaNT1O82KIOD2oKWkS4ZyjOw=;
        b=Tc3FKCiW79lJkVYrpou9slDY2FTny8+eTj9BvN6OIe3SLXc7zKHIYCqZ3HdDiBJkmU
         l3y0XJaSTgiN7euvTq4C28BU8ocp5F3XwkfQPwKU8l/s3VjRQVVPqsFIyG9Rp7kImUN6
         8svRwkN16kahNUT7/4N1DA6lnQADSabY3vmKiu93TGa0ysw82jTbTAZPNY042Vj9SWED
         kLNFp76Aap6FJCYga+lxPdAhjUKufJRbGoSZIwxyqhA/SI03OO+Hl4+7ijxcDk4+vwiR
         gMJaXQQUY2EuZsYFKGdseSMHCxy6zN2n+ATjBiDj3sKBYF1wCvSAusTcPr7Az+BhCYLT
         p4wQ==
X-Gm-Message-State: AOAM532M8SkNGOtEpzEWDcI9+pixpglwP4psGysG4zGlATppWvOysW+T
        HZskfbaUUeYGt6HStf9tfCVVDzRJJ1+AIthsAxuzpQ==
X-Google-Smtp-Source: ABdhPJxtZYd6pbvyUIcVLhm2ppf69h/SIG/xC0YrDQ+N1S1KhCLbcONfbkGToc0c+o1r569PphB6yfHHYXqL8yWjXxM=
X-Received: by 2002:adf:cd91:: with SMTP id q17mr3076188wrj.5.1597926448214;
 Thu, 20 Aug 2020 05:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200811134846.3981475-1-daniel@0x0f.com> <20200811134846.3981475-3-daniel@0x0f.com>
 <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
 <CAFr9PXma7_FUVZbGk7kzfc1xgYH8WdMWj6FZuO4wO=kNp=iR-w@mail.gmail.com> <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 20 Aug 2020 21:27:16 +0900
Message-ID: <CAFr9PXkNBunBhrfyrYn1nU=hSw9A2n_fVSSH6HMAtEQ7+MnBdw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and SC7A30E
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mario TESI <mario.tesi@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Denis,

On Thu, 20 Aug 2020 at 03:19, Denis CIOCCA <denis.ciocca@st.com> wrote:

> I strongly disagree that these parts will be supported by STMicroelectronics driver.

The alternative seems to be write a totally new driver that does
exactly the same thing, use a lot of people's time to get it ready to
go into the kernel etc when we could come up with a way to allow the
driver to accept a different WAI register value in a non-intrusive way
that can go in the bin at a later date if it turns out supporting
these chips is too much hassle.

> We DO NOT want to find out one day that we need to modify our structure in order to support competition.

I think Jonathan suggested adding me as a reviewer for these parts
thus making me responsible for them.
I'm fine with that. If it comes to the point where the driver changes
so much that it's not possible to keep them working then you'd have my
blessing to just remove support for them.

That said I'm not going to force this on anyone.
This patch was a spin-off of a personal project to try to make cheap
Linux capable SoCs available to makers[0]. One of the devices I used
to reverse engineer that hardware had one of these Silan parts, I
noticed the registers looked exactly the same as ST parts supported in
the kernel already and upon testing they worked so I thought it was
worth throwing this out there. If you guys don't want to deal with it
I'll just leave it in my tree.

>If they need to support this chip, please provide a new driver for that part leaving STMicroelectronics driver managing our parts.

To be clear I'm not working for Silan and I doubt they have any
interest in supporting these parts.
There are hacky drivers for them in 3.x kernels that some vendors are
still using and that's probably as much as they care.

Thanks,

Daniel

[0] - https://github.com/breadbee/breadbee
