Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46431CF37F
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 13:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgELLjn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbgELLjm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 07:39:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E8DC061A0C
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 04:39:41 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b71so5047182ilg.8
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=82wlzvxc4cUevFf7lS158+dfx+2Wk90cq43I2NE+tJA=;
        b=fwmwQVor+BVls0Gxnt04b+Bx3fs1+44ZEpzSA6pguH/3rpAoY1AQHDQq4r12BJ9hnO
         tRrFfniYQMHj3HjcSIm/IKBkr5BKXNvpbHJKbUifG8NyL9QY9EQ3Gp82G1FNFhn1ehKa
         Uzk6X9GAE2gRo0L7Gv4S3GcrrCvoyZH1XmS4AfPmdfoZi8RQ8LRClDbSCLZ/5myiMKGh
         GVeQL6qA9f+0YXSuhhWKAgdT0DQA/0P7UGeLUzQX5Cwm9j4O8Rs5ShmO4PRaQTvglRpb
         8pxYgfjuGIconF9WOC5ENJWbjICuPtLQQxr3A9VlCz/jnU1gCWr+NxHJlra51CJlHb1q
         Z5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=82wlzvxc4cUevFf7lS158+dfx+2Wk90cq43I2NE+tJA=;
        b=SE+YdsYybwidM5qnSucKlB4X+5+nm4/TM4pl3cpczzkRnXZBVvvVJZsW1SO091teHu
         vbjpcU91YzsOyrDxOkn1Z3Rhnk5HhlHNLbHw/v02uJC4a3Yi82OU9x2fF3aVu2WRiUbE
         B97fTiSTHmzLTo3Ywqx5xyxFJVo96ME7zoJkX2Tj9YGMuZeiwizSeYwCAxp1X3By2aa5
         kni6WpPM2r1ggMngtAUrOUFv0udxPUEXkKTJVj7Z92hxoUFqQ0gv+oICmoqu3RLnjN16
         vrSNoJ3xar8ZRmVIFFn61d4SiZ+bxpILuWF0zfwtFFjPnbb8ZCv/54dZdxmJKDZ4gZ72
         s1/g==
X-Gm-Message-State: AGi0PuY9UqYge7tQUdx49B8z31zz6M0kqikhpMT/ATUtn/pR5rpFE0UA
        sJuv443q2E/Jb2CPVv1Dy6744RhAbt2imMzPsDuRZw==
X-Google-Smtp-Source: APiQypJX6Y0cUV2cemLkrS2Go8eRPQEWf5bC8pEpzDXndwLpIVW3shXYAC1XeLWr31wt+dxDA0HL6zRK8I5i2SsZqbk=
X-Received: by 2002:a92:8c8a:: with SMTP id s10mr1319233ill.220.1589283580567;
 Tue, 12 May 2020 04:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200430143019.1704-1-brgl@bgdev.pl>
In-Reply-To: <20200430143019.1704-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 May 2020 13:39:29 +0200
Message-ID: <CAMRc=Mc=0jc0negE779mpjifFyxic=UO7pAqPoKO6Dg-s4yuCA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] irq/irq_sim: try to improve the API
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

czw., 30 kwi 2020 o 16:30 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The interrupt simulator API exposes a lot of custom data structures and
> functions and doesn't reuse the interfaces already exposed by the irq
> subsystem. This series tries to address it.
>
> First, we make irq_domain_reset_irq_data() available to non-V2 domain API
> users - that'll be used in the subsequent patch. Next we overhaul the
> public interfaces - we hide all specific data structures and instead
> rely on the irq_domain struct and virtual interrupt numberspace.
>
> The end effect is that we limit the interrupt simulator API to three
> functions (plus one device managed variant) and zero new structures.
>

Hi Thomas, Marc,

I've been posting this for many weeks now without any major changes
and I dropped all controversial changes. Any chance of getting at
least this part in for v5.8?

Bartosz
