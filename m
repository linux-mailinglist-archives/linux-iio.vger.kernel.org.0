Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036341A8CAD
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgDNUl5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730053AbgDNUlz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 16:41:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32287C061A0F
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 13:41:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so14652802wmc.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRD6ER0kESZyvLzhCicmTVhbpnrsXVXBsNz/nRRqon0=;
        b=UW03JANvjlup8MIxgaN12OcWZzq7aMnlQ1ahjWwW0fKJ3LVfWDPay6E/5n+/DshVIF
         vsqX/H0BWReIctV3h6m0IbsfCf3/op3n9k9KqN/7abhhc6P7mSI12NkG8sfsIy9RRPvz
         OZ+JuhkoD38d75gQcIBDzbOwuCyJd5kABsk3la8pblyaMB+WmO56/XDeZHtO1dBSBWOp
         iDerYsJ+kySrEkSFs1CLjZY2Dh3PHscv752KQmzHpUOHnzZdNVPt7ya0qgqz4F2PXaSg
         yZCIOtDwCiMjVL7PwmSCpPEONHpMVxYK0//DDBb7tK5GrXc8KD5tIMFvCFHVJEJfB44T
         JEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRD6ER0kESZyvLzhCicmTVhbpnrsXVXBsNz/nRRqon0=;
        b=NJzLB9GaisWDKGY4LrlzjO145bWR/WecJIrg3QTs06LdGmVNjWKxmeIGaAdxFt0OBR
         TvYQhrcbPPAgEOtXATgJiwv/WLQLAIEZ+MXgvShCyvcgE3T7TthTs2mf3O3LAaZdAjAP
         ermjT12JQ1yazhiAm9RyuvmSCMOry6uatH2NRUUnlv8kcyOAi6Uyek7N424iARE0KmSj
         p66o1iZvwWOvGSnt3H5KuDMnmuktG2NEMGYWDTIW1MbGrrXYyHXFZRYd563qwru46yMy
         yj8/aAqznxwnA5/36hQSe3+gOTtIEU1HxyaL9P9UqECbS52lTr1UtyI1r7vIMtAohrvf
         nfug==
X-Gm-Message-State: AGi0PubmwdD99weZqJPTfq3NgNGBll2kBgymg641dwhXiNhGQj8g8XLA
        VNGR5fMqQ62L0JEetb3K93+OG7GgwHVL7GbVK/ANzw==
X-Google-Smtp-Source: APiQypJfqEPibYcj2k65XEXixEnNsItmQI+g5MjRJaCCFk2dep2r9dX3R/rTcIvaSElU3BOpks6akiiqS+ParjXVlXs=
X-Received: by 2002:a1c:5ac4:: with SMTP id o187mr1719537wmb.79.1586896912367;
 Tue, 14 Apr 2020 13:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200408175058.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
 <CAHp75VcuPoVK_+KV+88Di1dUFZ9S8-1nNqo2s8a_n3vgSMoecg@mail.gmail.com>
 <CAHcu+VZMiFVt9L9kNCTtsmxUP-7tO+pBpCOtMHQPotuye_2w1A@mail.gmail.com> <CAHp75VemvD0mvDHWorSFhqOKaQ1Y_vLYVAQmnb8iz30AH431+Q@mail.gmail.com>
In-Reply-To: <CAHp75VemvD0mvDHWorSFhqOKaQ1Y_vLYVAQmnb8iz30AH431+Q@mail.gmail.com>
From:   Daniel Campello <campello@google.com>
Date:   Tue, 14 Apr 2020 14:41:16 -0600
Message-ID: <CAHcu+VbZjqnxmfw-fN9H=qwWAdR9Y8JuQC2e39xe7UtFfCXf8A@mail.gmail.com>
Subject: Re: [PATCH 2/2 v8] iio: Add SEMTECH SX9310/9311 sensor driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 3:11 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 14, 2020 at 1:56 AM Daniel Campello <campello@google.com> wrote:
> > On Fri, Apr 10, 2020 at 4:52 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Apr 9, 2020 at 2:54 AM Daniel Campello <campello@chromium.org> wrote:
>
> As far I understand you agreed on the rest.
> Correct?
>
Yes, sorry for not be explicit before.
> ...
>
> > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > Signed-off-by: Enrico Granata <egranata@chromium.org>
> > >
> > > This is not understandable. Are they who helped you develop the code
> > > (we have a special tag, i.e. Co-developed-by in addition to SoB), or
> > > just people in the middle? Then the question is, how come author is
> > > you and not Gwendal?
> > >
> > This patch was initially developed by Gwendal and Enrico (here:
> > crrev.com/c/1089826).
>
> So, tags should include
>  SoB: Gwendal ...
>  Co-developed-by: Enrico ...
>  SoB: Enrico ...
>  Co-developed-by: yours (if you developed it)
>  SoB: yours
>
> and on top git commit --amend --author="Gwendal  ..."

I sent v10 with this metadata changed. Thanks!
>
> ...
>
> > > > +#define SX9310_REG_IRQ_MSK                             0x03
> > >
> > > Is MSK abbreviation in datasheet? Please spell it how it's in datasheet.
> > Yes, they indead use MSK.
>
> Okay!
>
>
> --
> With Best Regards,
> Andy Shevchenko

Regards,
Daniel
