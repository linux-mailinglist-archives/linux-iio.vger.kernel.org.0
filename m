Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1272C2295E3
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 12:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgGVKXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 06:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVKXi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 06:23:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB74C0619DC;
        Wed, 22 Jul 2020 03:23:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so990220pgf.0;
        Wed, 22 Jul 2020 03:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=351AZ2ekNDQ3m5sRAihkmJTU7M8Jo1Yfnte60wYBP14=;
        b=RKQFyU7Z0jmcWuaFp3mPqomB4elfcjfPsGGbVGUeVH7pNz1N7B3QlSKSKeEVwE0GwJ
         v0FMMi05JhglpwUcvnqQFgsaA/AkhjsAcu0QT62f0c/BvJ22NPxdZzcsvToc8hYEZXSg
         +KvQRDm5kJ7qjev+0WgkRtCl+nO4V4Lx9ogrT8XZwjTqqJx42DisqG7Fed44iZlKD4/K
         77Ef26mQcJxunrv06/NWkLC4FdJ1kspGDEqs+6DyatqTK/PeSipS64cCgmYl96sGsqqQ
         Z0H5b+TMwVOR94ztgy1nHZkjwVbkOadhUY+eyj6dxHX12w/Vo2SqsC9OXLBRJwDkwFPv
         90qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=351AZ2ekNDQ3m5sRAihkmJTU7M8Jo1Yfnte60wYBP14=;
        b=BU4DF3PNtRJYnrnSuiSRAK/CKiO3VoGeHKWL/dNppmyPg7UmnPxRjaJAY6oSBBsGR+
         JlURbtDN+JjygXzIdpuaTQ5QeUmaw2dAml/oA5oDUGTryBAuaUwDjdRGujdJ8zo/b4j3
         EjDn8+TsJk3z6uF9lcQCGgUYmTYk01Q1Erzptf+vKQZkwIfw5zU4Xmmo2IeRCNM7bous
         04VlzsXJigc5PQh7b6Ehn8oGwUUVMsk73WwqA5wyD8Tmzw0lMySE6/OdwBMVUfAwpO/o
         bOhyxivOU9tEo/ae+3FetBd3VVqi76StZDq7pItXOrVcEzvDvy++Z8FYdU5FUxYG9agc
         fSBQ==
X-Gm-Message-State: AOAM5332aZ6KcA8KZ1homv4zahLyDXC3QHmvt/ugwEO8apk6p2VrESI7
        9Rfr/Zhuq7I4EM2qbkcJ86PElzQ2hR54Dko8Wb1HXoeT
X-Google-Smtp-Source: ABdhPJznhHV4wRh1vVD3DRvPc5ORyCZWKGQAPgNl60Kc27nGzVkS/w4wM4PCmFTDGiEhu1h2Tr7X33OVxCsHGWBvdF0=
X-Received: by 2002:a62:7657:: with SMTP id r84mr27188292pfc.130.1595413417435;
 Wed, 22 Jul 2020 03:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200721181926.27046-1-nish.malpani25@gmail.com>
 <CAHp75Vdr+Uo2uw3mzYP+LMRgp-eyi+YjG=O+wGVqyYx-+MRCaw@mail.gmail.com>
 <7ba8469a-dd8c-1686-6d26-e2a4cbfedce9@gmail.com> <CAHp75VdYVC9n7-2MH62J46N0p+sNSE9QVwonor5QfdnvL4hoLg@mail.gmail.com>
 <5cb55101-af5c-b6a2-d770-9717f8a463cc@gmail.com>
In-Reply-To: <5cb55101-af5c-b6a2-d770-9717f8a463cc@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 13:23:22 +0300
Message-ID: <CAHp75Vc5e0HfVe04yzyfGC_qqhcPNnJOHXcADLfz+RKMuFBbcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: gyro: Add driver support for ADXRS290
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 12:40 PM Nishant Malpani
<nish.malpani25@gmail.com> wrote:
> On 22/07/20 3:08 am, Andy Shevchenko wrote:
> > On Tue, Jul 21, 2020 at 11:35 PM Nishant Malpani
> > <nish.malpani25@gmail.com> wrote:
> >> On 22/07/20 1:16 am, Andy Shevchenko wrote:

...

> > Can't you declare table as const int?
> >
> I'm not sure I understand you completely here; do you mean const int *?
> So, an array of alternate integer and fractional parts? I suppose that's
> possible but we'd be introducing unwanted complexity I feel - for
> example, currently the index of the 3db frequency in the table is used
> to directly map & set bits in the filter register corresponding to that
> frequency but with the approach you share, we'd have to apply a
> transformation (div by 2) to set the same bits in the filter register.
> Do you think the added complexity justifies the removal of the casting?

It was a question. If you think it is too much, don't change :-)

...

> >>>> +       /* max transition time to measurement mode */
> >>>> +       msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);
> >>>
> >>> I'm not sure what the point of interruptible variant here?
> >>>
> >> I referred Documentation/timers/timers-howto.rst for this.
> >> My reasoning was shaped to use the interruptible variant because the
> >> transition settles in a time *less than* 100ms and since 100ms is quite
> >> a huge time to sleep, it should be interrupted in case a signal arrives.
> >
> > This is probe of the device,
> > What are the expectations here?
> >
> I fail to understand why this can't be used in the probe() but perhaps
> in a routine to standby/resume. Could you please elaborate?

I didn't say it can not be used, what I'm asking is what are the
expectations of the interruptible part here.
In other words what is the benefit that makes you choose this over
plain msleep().


-- 
With Best Regards,
Andy Shevchenko
