Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045D244A7D3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 08:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbhKIHvB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 02:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbhKIHu7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 02:50:59 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C407DC061764;
        Mon,  8 Nov 2021 23:48:13 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id p37so35676114uae.8;
        Mon, 08 Nov 2021 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/QUEnlz9pnTv5dACFw29fj1vZqzy6D8L2Zl3G7etHJI=;
        b=DpS92VDr3SpzB2I8Png0q/ldI3iVnAh/bbRvssTSlyDttzU9kJgHIPZpbHKuVbg8t0
         9zS6nNghulnmtybgfdWV6fWXWJPikaZenGBuDaAJTtcJ7PFPPzqwDbI+tZBg16K2bftC
         1D50ZOiJpMt7miq6u+TZqq8o05D1gjv6qNR6P28Arsk2wqAUaQi5rGK3ecfmACKSEnVv
         2jYtFEQbTSqWq2w0nMmIm5ePzI6r9VeCOss+X8dqJq3AghTHOsfQsgAxiAWrytJZKtiK
         gwgRCEZVaSQN0sy0nrRLgxAJD/n2OzPJeGhFicjgp/bKCEdlpSIwsDb4gFCKCA3K4tKh
         Bn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/QUEnlz9pnTv5dACFw29fj1vZqzy6D8L2Zl3G7etHJI=;
        b=pNlWssPMvByrm4iQ/rj8qk+KJJ7AT3fEgCbbg5GUOoBBeV8y2iuqtHaiuKLzUil7Dt
         P274wozfmKB3xEsNdx8o3xDRe43C3FAbJJrBSdWQghaBiWXVHFz41ANus+Z9RhfGYmFn
         dLYGC+SlEitlFNnvuqaw2glQjXnyVwTPspn3gsWxwk+/49P2Vtb8Hu6PbzNc+AJKTHLm
         fSrujnYUS97M+zs2kF81z6h7bEv2a8DLdbxrBQcrXeMn379dpF6lXI+nhOgEt3Y71m4q
         9q2U6ntoRKKAtdAVjLUPxq4tyhLuoMYxtgpunSk6RaKnfhtrlHhgO+DJRQJ3PAp/JRM0
         YgHQ==
X-Gm-Message-State: AOAM5325Rht2JTQkPuJYm5RAcAe6F/mITVfDP9/3aGvNWcQ0LS70WDzF
        C40+H/jNXSokUZetgVB2RTG2fhWyIh/DegzybgI=
X-Google-Smtp-Source: ABdhPJyln6kAbCxuptY5D50Rsgr0Hfun9PuAxCl69DwrLLLnJ3ocMWCToG1ec0gNaUCvtXdPAXlAN7P6jeqC3RzLepo=
X-Received: by 2002:a05:6102:3166:: with SMTP id l6mr27912064vsm.51.1636444092898;
 Mon, 08 Nov 2021 23:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-3-andrea.merello@gmail.com>
 <CAHp75VeYRBe_-uMRTwM1_MYYHYBTZeZ21SxAyCeeWu6pgJy5BA@mail.gmail.com>
In-Reply-To: <CAHp75VeYRBe_-uMRTwM1_MYYHYBTZeZ21SxAyCeeWu6pgJy5BA@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 9 Nov 2021 08:48:01 +0100
Message-ID: <CAN8YU5ORN1=smUvNcWHpqE1e12n3+T2gaHAEbW9RHnarXKqsOw@mail.gmail.com>
Subject: Re: [v2 02/10] iio: document linear acceleration modifiers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno gio 28 ott 2021 alle ore 12:32 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
> On Thu, Oct 28, 2021 at 1:18 PM Andrea Merello <andrea.merello@gmail.com> wrote:
> >
> > This patch introduces ABI documentation for new iio modifiers used for
> > reporting "linear acceleration" measures.
>
> Because of ordering and absence of Fixes tag I haven't clearly got if
> this is an existing set of attributes or that that will be added by
> the series. If the former, use a Fixes tag and place it first in the
> series. If the latter, move it after the actual addition of the
> attributes in the code.

The latter. Will move in V3.
Thanks

> --
> With Best Regards,
> Andy Shevchenko
