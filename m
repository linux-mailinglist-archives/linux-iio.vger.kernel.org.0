Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6618EAA3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVRDD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgCVRDD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:03:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557FE20724;
        Sun, 22 Mar 2020 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584896582;
        bh=FC8f42LrzM3LM3z5glrs2yzPEu23CwcVxoLsC9Kmaj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wfPc2ENOFhFnKKcmap5OjSUWOS/zaG/bfv1luQjBzEIfrvVgoBFbt6QQlIOJL5AC0
         I0CCpL6bT4T2Wm5cAsR+RrmZN2Wp6+GjL2BG6Caz5Vt9I5Uk6CvmHeqQEX8PJ7d/B7
         YXU64T6MFlZGpSEWY+dt0oTr08EYPChWHRU/8IhQ=
Date:   Sun, 22 Mar 2020 17:02:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer: re-introduce bitmap_zalloc() for trialmask
Message-ID: <20200322170258.3abd9454@archlinux>
In-Reply-To: <46516126-d22f-4bf8-a711-8218277d69f1@metafoo.de>
References: <20200317123621.27722-1-alexandru.ardelean@analog.com>
        <20200317125223.GC1922688@smile.fi.intel.com>
        <cb09b6f882a786a74919eda8812f27d502363150.camel@analog.com>
        <46516126-d22f-4bf8-a711-8218277d69f1@metafoo.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Mar 2020 14:18:43 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/17/20 1:53 PM, Ardelean, Alexandru wrote:
> > On Tue, 2020-03-17 at 14:52 +0200, Andy Shevchenko wrote: =20
> >> [External]
> >>
> >> On Tue, Mar 17, 2020 at 02:36:21PM +0200, Alexandru Ardelean wrote: =20
> >>> Commit 3862828a903d3 ("iio: buffer: Switch to bitmap_zalloc()") intro=
duced
> >>> bitmap_alloc(), but commit 20ea39ef9f2f9 ("iio: Fix scan mask selecti=
on")
> >>> reverted it.
> >>>
> >>> This change adds it back. The only difference is that it's adding
> >>> bitmap_zalloc(). There might be some changes later that would require
> >>> initializing it to zero. In any case, now it's already zero-ing the
> >>> trialmask. =20
> >>
> >> FWIW,
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> =20
> >=20
> > Thanks.
> > And sorry for the hiccup back there. =20
>=20
> It looks like a merge conflict. Both patches are in parallel sub-trees.=20
> I guess one went through fixes and the other through the normal tree and=
=20
> then when they were merged, the issue was not resolved properly.
>=20
> 2019-04-21 Greg Kroah-Hartman   M=E2=94=80=E2=94=90 Merge 5.1-rc6 into st=
aging-next
> 2019-02-20 Lars-Peter Clausen   =E2=94=82 o iio: Fix scan mask selection
> 2019-03-04 Andy Shevchenko      o =E2=94=82 iio: buffer: Switch to bitmap=
_zalloc
> 2018-02-20 Greg Kroah-Hartman   M=E2=94=80=E2=94=A4 Merge tag 'iio-fixes-=
for-4.16a

Thanks for the detective work. I've added a note to the patch description.

Jonathan
