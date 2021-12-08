Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3746D35D
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 13:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhLHMgt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 07:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLHMgr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 07:36:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D5C061746
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 04:33:15 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so7730055edd.13
        for <linux-iio@vger.kernel.org>; Wed, 08 Dec 2021 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wHz2DdIi4ekvlMF8BXo5ffG+d3/smTw0HiuaWNyqW4I=;
        b=W/DV2lZ/yYsHuvC9oCtBjlZTW45qo6PTkI/uN/3wKYGM07xXv+fQ+rZWzf1PfdQLhg
         wfeCx4H4xtPchEZD/o8WEgBucpLc6/mRKUerKF473la85etwbSwXGBJNfHz9+ldhPdwh
         CTmWYEFYFYtEUh8+CHvBSPhs9U5Tesqn4r3Jeyg07IPyAycHoSrfYF9RRBOVt/DGfRqW
         0YdQfrsZv2TCsMtDSgbfdEQe1/ZhD6S/btcTmBQ0DkF2PfxVTYyNzNFZnDEPccyp0MUY
         Y7hsbVG9EowsqKWIX7jCOMLIG9eUDILozTACome16PZPBkWTymaYBDhSF50jGmXiUWgw
         XJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wHz2DdIi4ekvlMF8BXo5ffG+d3/smTw0HiuaWNyqW4I=;
        b=nGRyQbzrslaW7HQ4lCrN/RMLtW7252TcqCRsJ9Y4wBAwy1gM7BWzJ4b9Zbcra2aBzX
         P5vA8JCHN+jrG0cz91wz+QzLPhIaJM/Dw24bcT5urTw166z04qJtZG1WAiaip2UL1x1f
         Vgzxp9bDWDMiij8stOeTmh3Vuld/0tCD7n6B45gNuEp+cSKDqW0zrmV/Luz9rPiSuKLn
         4tI6A1DyUTdlybdpzNwP7mBr4HvNlT248J7SLCmyEFk+742bHD69tbKyEo1KU+s/cGu5
         xHhudROnwb0IduudZbqWiS57c5tj/94AK5ysHiVOq3hACu0qFHXxvFNZ49sd0g51Zb9t
         w3xQ==
X-Gm-Message-State: AOAM530ZIedX8eGkSYo5ZMGUOXlwNw0ldY4zBr7Z2L7odUgiyeKU9dqX
        uEFGkIDdxRVp9j2TzxMwpKomAB12dGpkC6quSkw=
X-Google-Smtp-Source: ABdhPJzfitr+W5zLjzxslKbEffGhVgeSSxcJ7W8qzao9CnuzzH90iZrOc3Yg/ZoHIdGF6XtSTxJflaaZWkNdrmGo1g0=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr6956711ejq.567.1638966793803;
 Wed, 08 Dec 2021 04:33:13 -0800 (PST)
MIME-Version: 1.0
References: <9bd04e6d-7418-9d01-6e80-52fd7e84086f@deathstar2.nl>
 <20211207161338.000012bd@Huawei.com> <CAHp75VdB5vquGKnHSZhkLJDnUTXo68-mvHsRfPg+eqgb8pueTA@mail.gmail.com>
 <CA+U=DsrD1S0QMFXgjf4tNUmprS5j40hv2Jhp+ykbYqn70V2mJw@mail.gmail.com> <9a48b2f6-2e20-35c3-7856-cfc019cdd94c@deathstar2.nl>
In-Reply-To: <9a48b2f6-2e20-35c3-7856-cfc019cdd94c@deathstar2.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Dec 2021 14:31:41 +0200
Message-ID: <CAHp75Vc180Yvrp4=oSjADt2EAXyq+X+8YcN8v6DUrWSAMxcX=g@mail.gmail.com>
Subject: Re: iio display large numbers
To:     Henk <yoda@deathstar2.nl>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 8, 2021 at 2:23 PM Henk <yoda@deathstar2.nl> wrote:
> Wouldn't it be an option to extend the IIO framework with a unit
> description like Hz, kHz, MHz, GHz....

You probably meant SI scale factors. Because units may be way
different and sometimes behind physics (as a science) standards.

But even with this you may lose precision if, let's say, units are Hz
and you need to measure in a range of 10GHz:s you would still need
64-bit value for high precision measurements.

> Otherwise I am happy with the IIO_VAL_INT_64 for the time being.
>
> Btw... software developers should not decide which precision is a real
> world issue or not :) but only decide to support the need.
>
> For the time being it is a bit stupid that my 2.5 GHz output from my
> LTC6951 shows up as a negative frequency :)

P.S. Please avoid top postings.

> On 12/8/21 10:49 AM, Alexandru Ardelean wrote:
> > On Wed, Dec 8, 2021 at 11:33 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Wed, Dec 8, 2021 at 2:56 AM Jonathan Cameron
> >> <Jonathan.Cameron@huawei.com> wrote:
> >>> On Tue, 7 Dec 2021 13:40:19 +0100
> >>> Henk <yoda@deathstar2.nl> wrote:
> >> ...
> >>
> >>> Two options for this.  If the thing we are controlling is the raw cha=
nnel then
> >>> we have the option to provide _scale reflecting the fact that a large=
 value
> >>> e.g. GHz is not normally controlled at a Hz granularity.
> >> But some sensors can be really high-precision ones, although I
> >> couldn't imagine a value that requires more than 32-bit for that in
> >> general engineering. Where one may ask for more is something like very
> >> precise physics experiments in CERN :-)
> > Yeah, and this is where IIO and some sensors and clock generators seem =
to go.
> > Research and military, 5G networks, aerospace, etc.
> >
> > It's a bit tricky to pin certain sub-systems (for some of them).
> > Like, the clock-framework can only represent up to 4 (or 2) billion HZ
> > (I forget if it's u32 or i32).
> > So, this creates limitations/discussions with some clock-chips and
> > where they need to go (IIO or CCF).
> >
> > On the other end, there was a discussion [a few months back] about
> > needing lower than nano scales in IIO.
> >
> > So, this opens up a new set of discussions, like:
> > 1. How should people use Linux for these types of devices?
> > 1a. Should people use Linux for these types of devices?
> > 2. [If 1 is Yes, then] Which sub-system to use?
> > 3. Once a sub-system has been chosen, how to do it?
> > 3a. Extend the common framework (and how?) to support these new sets of=
 devices?
> > 3b. Or do some custom attributes?
> >
> > On point 3, a lot of times 3b is the chosen route [by chip vendors],
> > because these new chips seem to come out faster than the ability to
> > extend these common frameworks.
> >
> > To me, it has become obvious [a few years ago] that the Linux kernel
> > has been very good at serving computing needs mostly targeted towards
> > data-centers (big physical servers, lots of VMs, networking and all).
> >
> > We're probably going to see more of these specialized devices trying
> > to slowly pop up.
> >
> > And it will be an interesting journey to see (after all of it unfolds).
> >
> >>> Where that doesn't apply or the range is really very big we do have t=
he
> >>> slightly nasty option of IIO_VAL_INT_64
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/=
?h=3Dtesting&id=3D6bb835f3d00467c9a5e35f4955afa29df96a404e
> >>>
> >>> This is very new, so not in mainline yet, though it is queued up for =
the
> >>> next merge window and should be linux-next.
> >>
> >>
> >> --
> >> With Best Regards,
> >> Andy Shevchenko
>
> --
> =E2=80=9CDo. Or do not. There is no try.=E2=80=9D...
>


--=20
With Best Regards,
Andy Shevchenko
