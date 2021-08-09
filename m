Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A313E4984
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhHIQPM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 12:15:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:41453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhHIQPM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Aug 2021 12:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628525673;
        bh=kXrKblaZ6CNYHnepl9Y8P+zAjCJhII6lv5A6I+8gfu8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=E1qz8619oknic+0M+CK8i2jhImlE40g45IgOmp6G+fWfGBVCsizP0Z2/CJ9Fn1Ne0
         Q5sOVQs1ZWAaZ8YOHbu5A9xpZJSSNp0ESUkF5inEWGgEdJfpJDQCeuys03+LCl2fCU
         XnFBqo0XRdvQy3YiSkwUiQfIwZovDTUnkdOTAtyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9nxn-1m9X1Y0Ulx-005qGA; Mon, 09
 Aug 2021 18:14:33 +0200
Date:   Mon, 9 Aug 2021 18:14:22 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210809161422.GA2619@titan>
References: <20210807152225.9403-1-len.baker@gmx.com>
 <20210808172503.5187cd24@jic23-huawei>
 <CAHp75VfSX-7UqH9Lbr_GxQRY3dGjGo7H8++kBdrrSds1p6nB1Q@mail.gmail.com>
 <20210809102131.000021eb@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809102131.000021eb@Huawei.com>
X-Provags-ID: V03:K1:JDBAWEA04QKyxXvnanhW35lkIvCUd2zrRIULromQ+zDfoiNARFp
 YMwUD2qwYZvHrtAI1DfvYFOHILplrlq/LPbuebE5J0wbpL+x9pP/WtuzCJs6bzhPnicdWBW
 VKHbhEnnZXUC4GdSwyzxA10/W6WGOZlqy42CgcQ4+2C8lPqViHqbXKHNe4rtZZKuGiJ1yK5
 IJ8YF8L5V4DTNDFnspkoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pbFVuiJtVnA=:HMUtu7bOW3YYjyChEVQY4L
 rb7ZMJUhQCKBAFhmgFT8548TxQOvuz4grKRCfplZQIglgOCWklhANPNEnQ9fIzo9jdGFRWH7f
 +AplbnYCSpdetF4icjLUWgwNHws2Brd9PI3Fbe/j48GNX2jybiCqVFhM6E8W5leMabQEmrsTx
 rDj2wFq9kzGVzWUoNpwhIshrnp1AzCjeOrnXctkUXVIgyOKR+lqdy6oWZpsYAU/vvtIu8G3NF
 yiwTX84EBjUWH+JU7M4Up3kFq27udfTFURrX25o95WKfk4JRTb6BTuUnVwC2YRdAfJ8/+PhbK
 VS3wkJ65zU9jIeHEWzRFThprhxT5IVsQGPwzep0mE/rs1FNjIMBSm2sM/8+Ndyd66x5txNftn
 i9rwDO3XNCqRLZQr5S30qbcHvusvpEqL9ZpBye7EYdlEgXJvo8NXsPrQC7eyrI54LeCfnVrk/
 veX/HiVyFe37ikZ4ag5c87EclrRwykwcvIaS3fpL2tGq5MHTyVHKhShJ51+tCzHGuOLu/buT5
 Z74Q60lp4HFe6/K+AtCH6msCNo0LH1x8AX7wCpj2M8kV81jQNdXUDN/zPS7gyVPho2s94QCZv
 /r8lxW6VCTDdEpzRyT8jgosQV5NRFHMTxRZvmSFhwtjW0jQ6Zr4GuR7rRRVj0v1dyYRbmxqHh
 Lb3r3IPcly7u+rWoEctxk5ryeHxmaJiELOCmApOLy3svPrroVrONqaSH0/gdbullf7RxCxqdb
 hbzb0h5f5h3SBvWfDwesijOAxjkGvKOxJJ5jg3mz1K5i1W0qYA0++ybVwhGxh/828XCstA25H
 a+TiEB7vgU3JMQFqmBGHSEhNLbX6CRrP24bWKhLIXcj5m2xFjIW4Bz0XNT8HRpRjM+/elRhK5
 bPtXT5oPDPX2R3PdQqKV2SlMjWwC1odoZeX2hpX181pp635RvPoyYfFRQDB2AagcPkHgkF7ja
 dj+VRi4so5qgIVn5fpCZwydGhdzHF4+bDwjwWe5DQkTO+5lgK7Hx4AaGghCQfx77RRPekJLDz
 hw196c0E4y1vyM3Tp41k7O940pJ1FkuIKcwaevWt4Tqv3wlBHV5Xd8Nf8R3XeuIBxEd6vX36K
 B6+Br3tg2YJBwWrLAByi+jyDq+nwvsReZ2ipwBxfMdSWaPhFgmMXlaJ4A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Mon, Aug 09, 2021 at 10:21:31AM +0100, Jonathan Cameron wrote:
> On Sun, 8 Aug 2021 22:00:34 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Sun, Aug 8, 2021 at 7:25 PM Jonathan Cameron <jic23@kernel.org> wro=
te:
> > >
> > > On Sat,  7 Aug 2021 17:22:25 +0200
> > > Len Baker <len.baker@gmx.com> wrote:
> > >
> > > > strcpy() performs no bounds checking on the destination buffer. Th=
is
> > > > could result in linear overflows beyond the end of the buffer, lea=
ding
> > > > to all kinds of misbehaviors. The safe replacement is strscpy().
> > > >
> > > > This patch is an effort to clean up the proliferation of str*()
> > > > functions in the kernel and a previous step in the path to remove
> > > > the strcpy function from the kernel entirely [1].
> > > >
> > > > [1] https://github.com/KSPP/linux/issues/88
> > > >
> > > > Signed-off-by: Len Baker <len.baker@gmx.com>
> > > Applied to the togreg branch of iio.git and pushed out as testing
> > > so 0-day can poke at it and see if we missed anything.
> >
> > Isn't it too early? Or am I missing something (see below)?
> >
> > ...
> >
> > > >                       /* use length + 2 for adding minus sign if n=
eeded */
> > > > -                     str =3D devm_kzalloc(regmap_get_device(st->m=
ap),
> > > > -                                        strlen(orient) + 2, GFP_K=
ERNEL);
> > > > +                     n =3D strlen(orient) + 2;
> > > > +                     str =3D devm_kzalloc(regmap_get_device(st->m=
ap), n,
> > > > +                                        GFP_KERNEL);
> > > >                       if (str =3D=3D NULL)
> > > >                               return -ENOMEM;
> > > >                       if (strcmp(orient, "0") =3D=3D 0) {
> > > > -                             strcpy(str, orient);
> > > > +                             strscpy(str, orient, n);
> > > >                       } else if (orient[0] =3D=3D '-') {
> > > > -                             strcpy(str, &orient[1]);
> > > > +                             strscpy(str, &orient[1], n);
> > > >                       } else {
> > > >                               str[0] =3D '-';
> > > > -                             strcpy(&str[1], orient);
> > > > +                             strscpy(&str[1], orient, n - 1);
> >
> > Why n-1?
>
> n is the total length and this is printing from [1], so n - 1 is remaini=
ng
> space.
>
> >
> > > >                       }
> >
> > As far as I understood the logic, it  inverts the sign except the case
> > when it equals 0.
> >
> > I have a question here, why can't we always use +/-?
> > Why can't 0 be prefixed with a sign?
>
> Technically a userspace ABI change, but I agree it should be fairly
> harmless unless someone is rolling their own string handling routines.

I personally don't like the idea of zero having a sign. It's my opinion.
But if you prefer it I have no problem.

> >
> > If the above can be used, we may simplify this code.
> >
> > Len, I think this task may be considered simple, but I recommend
> > thinking about each case and finding a way to simplify it more.
>
Andy, is what I try to do ;) Thanks for the advise.

> It could be a little simpler doing this, so 'maybe' worth doing.

Ok, I will send a new version if there are no objections.

Regards,
Len
