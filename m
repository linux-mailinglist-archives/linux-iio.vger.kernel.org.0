Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A898A12D21A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2019 17:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfL3QlK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Dec 2019 11:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfL3QlJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Dec 2019 11:41:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932D8206DB;
        Mon, 30 Dec 2019 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577724068;
        bh=S3LCPEu7j2zssV2YoOmiHjovCCGMiALDmsVMzQt1l9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rchlbcKrjz532H2AYzkmhnyj4w6m+CNay9la+sYbi2s4T2K/IPvDWJOMr0XFdzNJM
         DE5AqJ5FKyqZ0DFZZTm0TC8QXeIaRaYqE4vlHJfDDVnvtzIRASxWhogZl0KfFbC6Q7
         lUy00wj06wZvqz8/WVrQ+XuN3xpPjpz5m69ZUuhU=
Date:   Mon, 30 Dec 2019 16:41:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3] iio: buffer: align the size of scan bytes to size of
 the largest element
Message-ID: <20191230164102.20ef4c67@archlinux>
In-Reply-To: <1aba5eb9-43b4-0fb5-f67f-f4792ce94bfb@plating.de>
References: <kcis.016016E0AABB4ABC824358438D87FE25@mail>
        <9e68de59-db62-5ba7-c5b6-26d2a59610a2@metafoo.de>
        <20191223170530.1dcfff85@archlinux>
        <5d8a64e5-d745-bfc4-57e1-4a24f097d36e@metafoo.de>
        <1aba5eb9-43b4-0fb5-f67f-f4792ce94bfb@plating.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Dec 2019 10:45:46 +0100
Lars M=C3=B6llendorf <lars.moellendorf@plating.de> wrote:

> On 26.12.19 22:16, Lars-Peter Clausen wrote:
> > On 12/23/19 6:05 PM, Jonathan Cameron wrote: =20
> >> On Mon, 16 Dec 2019 08:51:27 +0100
> >> Lars-Peter Clausen <lars@metafoo.de> wrote:
> >> =20
> >>> On 12/15/19 10:09 PM, Lars M=C3=B6llendorf wrote: =20
> >>>> -----Urspr=C3=BCngliche Nachricht-----   =20
> >>>>> Von: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
> >>>>> Gesendet: Freitag 13 Dezember 2019 14:58
> >>>>> An: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@g=
mx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeer=
w@pmeerw.net>; linux-iio@vger.kernel.org
> >>>>> CC: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
> >>>>> Betreff: [PATCH v3] iio: buffer: align the size of scan bytes to si=
ze of the largest element
> >>>>>
> >>>>> Previous versions of `iio_compute_scan_bytes` only aligned each ele=
ment
> >>>>> to its own length (i.e. its own natural alignment). Because multiple
> >>>>> consecutive sets of scan elements are buffered this does not work in
> >>>>> case the computed scan bytes do not align with the natural alignmen=
t of
> >>>>> the first scan element in the set.
> >>>>>
> >>>>> This commit fixes this by aligning the scan bytes to the natural
> >>>>> alignment of the largest scan element in the set.   =20
> >>>>
> >>>>
> >>>>
> >>>> After re-reading my commit message, I come to the conclusion that it=
 really is sufficient to align the scan bytes to the natural alignment of t=
he *first* element. This would save us the `max()` comparisons for each bit=
. At the moment I am not at my workstation, but I could submit a v4 next Fr=
iday.
> >>>>    =20
> >>>
> >>> I thought so too in the beginning, but as Jonathan pointed out, it do=
es
> >>> not work for all cases. Lets say you have u16,u16,u32,u16. If all
> >>> channels are enabled the size is aligned to the first element, but the
> >>> u32 would not be aligned in the second dataset.
> >>> =20
> >>
> >> I'm sitting on this at the moment... Can I confirm we have consensus
> >> that this patch is the correct fix?
> >>
> >> Lars and Lars? =20
> >=20
> > Current version looks good to me. =20
>=20
> I agree that the current implementation will fix the aforementioned cases.
Applied to the fixes-togreg branch of iio.git.  Hopefully
we won't have anyone relying on the previously broken alignment...

*crosses fingers*.

Thanks,

Jonathan

>=20
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> >  =20
> >>
> >> Thanks,
> >>
> >> Jonathan
> >>
> >> =20
> >>>>
> >>>>    =20
> >>>>> Fixes: 959d2952d124 ("staging:iio: make iio_sw_buffer_preenable muc=
h more
> >>>>> general.")
> >>>>> Signed-off-by: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
> >>>>> ---
> >>>>> v3:
> >>>>>   - Fix the problem description in the commit message
> >>>>>   - Add "Fixes" tag
> >>>>>
> >>>>> v2:
> >>>>>   - Fix subject of patch which marked it the first in a set of thre=
e.
> >>>>>   - Add a description of the problem in the commit message
> >>>>>
> >>>>> ---
> >>>>>  drivers/iio/industrialio-buffer.c | 6 +++++-
> >>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/indust=
rialio-buffer.c
> >>>>> index 5d05c38c4ba9..2f037cd59d53 100644
> >>>>> --- a/drivers/iio/industrialio-buffer.c
> >>>>> +++ b/drivers/iio/industrialio-buffer.c
> >>>>> @@ -546,7 +546,7 @@ static int iio_compute_scan_bytes(struct iio_de=
v *indio_dev,
> >>>>>  				const unsigned long *mask, bool timestamp)
> >>>>>  {
> >>>>>  	unsigned bytes =3D 0;
> >>>>> -	int length, i;
> >>>>> +	int length, i, largest =3D 0;
> >>>>>
> >>>>>  	/* How much space will the demuxed element take? */
> >>>>>  	for_each_set_bit(i, mask,
> >>>>> @@ -554,13 +554,17 @@ static int iio_compute_scan_bytes(struct iio_=
dev *indio_dev,
> >>>>>  		length =3D iio_storage_bytes_for_si(indio_dev, i);
> >>>>>  		bytes =3D ALIGN(bytes, length);
> >>>>>  		bytes +=3D length;
> >>>>> +		largest =3D max(largest, length);
> >>>>>  	}
> >>>>>
> >>>>>  	if (timestamp) {
> >>>>>  		length =3D iio_storage_bytes_for_timestamp(indio_dev);
> >>>>>  		bytes =3D ALIGN(bytes, length);
> >>>>>  		bytes +=3D length;
> >>>>> +		largest =3D max(largest, length);
> >>>>>  	}
> >>>>> +
> >>>>> +	bytes =3D ALIGN(bytes, largest);
> >>>>>  	return bytes;
> >>>>>  }
> >>>>>
> >>>>> --
> >>>>> 2.23.0
> >>>>>   =20
> >>> =20
> >> =20
> >  =20
>=20

