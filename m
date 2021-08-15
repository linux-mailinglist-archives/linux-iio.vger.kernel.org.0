Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168923ECA41
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhHOQhr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 12:37:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:59785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhHOQhr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 12:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629045411;
        bh=33kYRLOtW9jYqgjRtKdFlGSwripM/pPkFNQVoOiCuVw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cpD60BXIDeyWHqbR2EUVnqdEC5E4JWNpusyJoPYw3u0z88b2Yx4n/k48Pax3rDpJJ
         BmC0IaLyf+Ll1VJSr+lQZ0Y3zLE5FMStFUsCDTfm4E6KcLvzaTwSL/+kScy2bMduF1
         Yuuko5SdeceiBAxOmr7pPmyf1gokwb9Zr5o2+ksQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1OXT-1nD5Zo0iPj-012syZ; Sun, 15
 Aug 2021 18:36:51 +0200
Date:   Sun, 15 Aug 2021 18:36:39 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Len Baker <len.baker@gmx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] drivers/iio: Remove all strcpy() uses
Message-ID: <20210815163639.GA97260@titan>
References: <20210814135509.4500-1-len.baker@gmx.com>
 <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
 <c08cfa8b6bbf07e1860d7dc93739e71ff5f4c0c4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c08cfa8b6bbf07e1860d7dc93739e71ff5f4c0c4.camel@perches.com>
X-Provags-ID: V03:K1:DcMTbj03GA0QdqLKEsq08fXzV2XvGRYhdLwszDDw9BQGD+AnmAl
 9ebk50hy+bmvKaSpB6vDrqHeO0T2kCq06+aFs8POFLmH5fHHY56lvVX3hEiS0qNrul6h2TS
 8ZwZTbnQGPYBAeDVGqNc6OMwRJT3dLvo0R/XvZ3l5/PX4ChFUT1gBidhy2KLWCpbM5VsSXi
 fc34moaA4MbFXTd6sayEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xe/BmReg/10=:bx33yTBccTJ3yiKxhnaYwH
 0Tp/vGF9QFn/DAc2Q4nH7uj1Bx7lLMkW+SzEAPg87sKE7LETeaRtlVvqmQDCuJb9kwUyHOeP2
 eWzWLyvhoaV2SXhuNYEx3MbwlZbK0kLvNWAXcbrT9ke/m3bwkkJ872bbCUCaqoDdLa2wHwuyf
 z8WTT9Xr+lY7UU8rBvq4BxX9HLhs3AsuXywngViy1g2KXOt7fMPbDyGS8KSsnw6K6aSVwWtxo
 f2OrWzWky9+68zhIxiTPAQj7usgOJKEIOM15MbOaPxh80tdvmXyCX2p4SYkqZXecF/ZbevQ+4
 J9xOr0pZpskjcVsNC+n1vCTgpSxKjmK/QX71/k/t9sZ88b0SAQVD7TpD6UXxuNu469cTE76qj
 qsHL+cGL1jKerXBTcslHXbHt17NoawIiQ7fVg4zFDTgnq2ud42xgaQuc/smO/0NflOl0JrR7T
 3pWUHJJUNHoxRuwqlJho50zvPztjwizWkvrD6RQJd9hHDTZQmUE6xSvXZYg1HgqNnl3pzgZ0u
 OPe3yEFGxJvM4ApThcz+5bm+RX2pgsOiSl/un6j2jzvtYO45y1RpRO1RwUIzgrs9pQqkBd60v
 eB71JFQjhNCKtSCCbJUwp5kyiZ+n/M0HCiwagsCzv/TWDSIm7IoeI/aMhFex9sZHSbCJHv5lz
 KpCvVJmXEw7ttW/hwOZUHb/a1sigt6yPWPdj/VEgE05Awy80wxLMjbo5VExXUjvge64eRFkJt
 1Q3exp5RyL8pm1FZrOfGsNMQW8TtbMnXO84PrB/2kIbUANEyWvh3kE0tSn8MBZrCjUrPdEoAS
 K90F0RJtJAY5JyV3pARBS09x9q1iHydqqS2zvrrg4lcKPy/iMSakRaHxr+cmSG7YaYoM4yezb
 eGACdOcBcFF3ZDN6ZvEmg4BXtkoaZCa1YmhdGxuAINYGGAuM+a/CXxlr2U9ALYA/cqcnEv0WC
 tksuMILhXaXn3Ow0XWzMe0CxXkuLQQlIseTwXEZ/4sxJQPB7vcABi7aNzAfd+R72Py7Suu/l2
 SvXiLzX8mQIgJ12gdSrfAj3NwURFD88iTnscqcl3IOBb0+Wj5nM2DQeqk0Ecayjqxw8gMOSIT
 pMCz+2+WZCEN6DbQzmWrj4jvKOXGjW5WfZiV9ZvoO0QSg6VjZo1LRDxQg==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Joe,

On Sun, Aug 15, 2021 at 08:06:45AM -0700, Joe Perches wrote:
> On Sat, 2021-08-14 at 22:36 +0300, Andy Shevchenko wrote:
> > On Sat, Aug 14, 2021 at 4:55 PM Len Baker <len.baker@gmx.com> wrote:
> > >
> > > strcpy() performs no bounds checking on the destination buffer. This
> > > could result in linear overflows beyond the end of the buffer, leadi=
ng
> > > to all kinds of misbehaviors. So, remove all the uses and add
> > > devm_kstrdup() or devm_kasprintf() instead.
> > >
> > > This patch is an effort to clean up the proliferation of str*()
> > > functions in the kernel and a previous step in the path to remove
> > > the strcpy function from the kernel entirely [1].
> > >
> > > [1] https://github.com/KSPP/linux/issues/88
> >
> > Thank you very much for doing this!
> > Now I like the result,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> []
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_magn.c
> []
> > > @@ -261,6 +261,7 @@ int inv_mpu_magn_set_rate(const struct inv_mpu60=
50_state *st, int fifo_rate)
> > > =A0=A0*/
> > > =A0int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
> > > =A0{
> > > +       struct device *dev =3D regmap_get_device(st->map);
> > > =A0=A0=A0=A0=A0=A0=A0=A0const char *orient;
> > > =A0=A0=A0=A0=A0=A0=A0=A0char *str;
> > > =A0=A0=A0=A0=A0=A0=A0=A0int i;
> > > @@ -281,19 +282,24 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050=
_state *st)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* z <- -z */
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < 3;=
 ++i) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0orient =3D st->orientation.rotation[6 + i];
> > > -                       /* use length + 2 for adding minus sign if n=
eeded */
> > > -                       str =3D devm_kzalloc(regmap_get_device(st->m=
ap),
> > > -                                          strlen(orient) + 2, GFP_K=
ERNEL);
> > > -                       if (str =3D=3D NULL)
> > > +
> > > +                       /*
> > > +                        * The value is negated according to one of =
the following
> > > +                        * rules:
> > > +                        *
> > > +                        * 1) Drop leading minus.
> > > +                        * 2) Leave 0 as is.
> > > +                        * 3) Add leading minus.
> > > +                        */
> > > +                       if (orient[0] =3D=3D '-')
> > > +                               str =3D devm_kstrdup(dev, orient + 1=
, GFP_KERNEL);
> > > +                       else if (orient[0] =3D=3D '0' && orient[1] =
=3D=3D '\0')
>
> bikeshed:
>
> I think this change is less intelligible than the original strcmp.

So, if I understand correctly you suggest to change the above line for:
                              else if (strcmp(orient, "0") =3D=3D 0)

And yes, this line will be more readable ;)

>
> And separately, perhaps for loop would be more readable as
>
> 	for (i =3D 6; i < 9; i++)
>
> converting the 6 + i uses to just i.

Ok, no problem. If there are no objections I will send a new version with
these 2 changes.

Regards,
Len

>
> > > +                               str =3D devm_kstrdup(dev, orient, GF=
P_KERNEL);
> > > +                       else
> > > +                               str =3D devm_kasprintf(dev, GFP_KERN=
EL, "-%s", orient);
> > > +                       if (!str)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> > > -                       if (strcmp(orient, "0") =3D=3D 0) {
> > > -                               strcpy(str, orient);
> > > -                       } else if (orient[0] =3D=3D '-') {
> > > -                               strcpy(str, &orient[1]);
> > > -                       } else {
> > > -                               str[0] =3D '-';
> > > -                               strcpy(&str[1], orient);
> > > -                       }
> > > +
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0st->magn_orient.rotation[6 + i] =3D str;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
>
>
