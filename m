Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E903ECA6D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhHORNU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 13:13:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:55349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhHORNT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 13:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629047531;
        bh=iVY2eT07p6wla7PUQvqOvAgRk8cL7jO3dFPhVSTv32Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ULsZwXn/Km4z4/IV8PQqn/1JHQIzOohQJvC8pJkgZKz4KP5bsjbghnWfHsoPDv+8l
         3Vi6Zf7Qmpw5VCDbqN2WI8rfK3jT9wjIEyW8I33UoKIcDo1HdfRF7Q9qeN9m9ClHPz
         /2l8zkbFzkdSo55Prjco/q2S43rX/2vIW0R3BEBs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1mEUCK09vT-00496y; Sun, 15
 Aug 2021 19:12:11 +0200
Date:   Sun, 15 Aug 2021 19:12:00 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] drivers/iio: Remove all strcpy() uses
Message-ID: <20210815171200.GA103145@titan>
References: <20210814135509.4500-1-len.baker@gmx.com>
 <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
 <c08cfa8b6bbf07e1860d7dc93739e71ff5f4c0c4.camel@perches.com>
 <20210815163639.GA97260@titan>
 <eb51990402a466821b855092a3fa2171b5a98bcf.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eb51990402a466821b855092a3fa2171b5a98bcf.camel@perches.com>
X-Provags-ID: V03:K1:gQFUIsQgrrC4I0WSXEMkVtHibykSSrGVjvYOe9QxTuW1Lr82xhG
 nqCQtZBFia5AoGL6lAVWawASZpG51q2/UuMX/IfvjnsjHZpj1mev4QcpEccISZWQCmhcryR
 7t6gqq6eC8Di9Rq0q/G6uKxvdxuDWXAQQn0o3+1SfvGgdLQQa6q1eQLekTSlixoAvU4actf
 vmy2+T18/07/aeC8ygpTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jCFit4HvshU=:/vU2goQu7BJanTeNIsXBy+
 qR6QcjB5wzk3z8Drfaiuc2ruij/U0+9217RjNeHF27GfDkcnlll6uszYEcdZyZ1heO/09NIAz
 VLjjQemp7Hrgqf+bfinPbyMdlFWH3VH3iZSIv09km9JAuz/38cs8rNFxtKjT+aT2LXnDYYUC4
 rnkL3Tvw7oPUAQ464vd3btbE6bZhx+p1YmAg7ZlDpAEaOTxO8lFMDb78qfCjEgQzACjJxlUft
 LdveSdSz3/NzfsslNpHA0n0EznUxwDGn2ULlri7EXdjQ2iJhnR6lfQbpe87uJXv2eNLCs83AR
 oK3b3GNhSD47/ybGQkSyEBb4YvHCq1vyyzNVgDO8fQ3IOcRlxtNPMnfpiC92OO+DOkqqJ6pO/
 t3hoTKE5Jw7EzDwMiwTbK9lmlE7NthmsJYm2jaR5ZQSrHOcv/DMzEba0BLTnZMckdh5C05K/r
 IxyJtybHj6Ja9KudsblSZzthVMooiesSwvWDdMyFLB5/PtTBlmuvB/OkXN1Zau6dtLX8CaRYa
 WzOnyRHvo5l2FU8GZfDKUmyE30C9/xI1r7HOyxqWdMtz27bcqsSL0+NJt1WVaqblTGX7LAi7m
 BBug7swAYEwhfiSZoclCepWu2XyiJ/8pqYbejk2UiVnXE20HRx6OJG1tVTAnd2OY48tkItdfA
 7XqlfSv/hAN7ZAdcmvymwQJtvNZzv7DNhvA+X5MMuVnoQ70SDJVTTNVMBM1Wjwy+g4hO/5UPc
 4ov+6rTEtROGORcqHG6bjHkJRPw/PQ0VoNThszNGrogO/uChjWg07H7+H7GTJz4vaImsX9c4l
 oqBjayUPrBGVpzaP3RiojLol5TbPU8u+vWRJ9WklFyfq+vE1KwgLqS+fi/OuAu4zczTKv7rj/
 m75q8LJYhxql0ofN7BULiMzY0w5XEN9eYGtjO8R087EwQMddWHlwta7dGDb13CYt3i1I+E9Af
 Jms9vlIwPUkeanS6EPnCDLOwXPTfpnbtckS6FLpg4zt1zVAiouxmUhzo02BL5+CNobCHK2gvI
 dg2kVWEqj5Ga2v/5gP4BTOsYVSRyO2m9mkAlkxY9WE9t0YUhE5lhHibBAnu6QToGvs5f1YGE5
 j6tVefUoudILKx3qFX1pPLKRzdPoWIhzDeBsNpQqbEri1A+rJROJ1uWCA==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Sun, Aug 15, 2021 at 09:58:02AM -0700, Joe Perches wrote:
> On Sun, 2021-08-15 at 18:36 +0200, Len Baker wrote:
> > Hi Joe,
>
> Hello Len.
>
> Don't take this advice too seriously, it's just bikeshedding
> but it seems to me an unexpected use of a strcmp equivalent
> in a non performance sensitive path.
>
> > On Sun, Aug 15, 2021 at 08:06:45AM -0700, Joe Perches wrote:
> []
> > > bikeshed:
> > >
> > > I think this change is less intelligible than the original strcmp.
> >
> > So, if I understand correctly you suggest to change the above line for=
:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0else if (strcmp(orient, "0") =3D=3D 0)
>
> Yes.
>
> In kernel sources it's about 2:1 in favor of '!strcmp()' over 'strcmp() =
=3D=3D 0'
>
> $ git grep -P '\!\s*strcmp\b' | wc -l
> 3457
> $ git grep -P '\bstrcmp\s*\([^\)]+\)\s*=3D=3D\s*0\b' | wc -l
> 1719
>
> And it's your choice to use one or the other or just your V4 patch.

I will increase the !strcmp() statistics ;)

>
> btw, according to godbolt:
>
> gcc -O2 doesn't call strcmp and produces the same object code as your
> byte comparisons.  clang 11 calls strcmp regardless of optimization leve=
l.
>
>

Thanks for the feedback,
Len
