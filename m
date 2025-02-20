Return-Path: <linux-iio+bounces-15886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF943A3E306
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 18:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7394918997D1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD2213E60;
	Thu, 20 Feb 2025 17:49:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F38D2B9AA
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073790; cv=none; b=pMSNlI7EwRGxpEt6buyvxRoUZgC58ylPpZdk2DZDsV8OWSBGnot/UFXlpzC5PODJ6Lj96W57KjE+nfRp0GQM5iVg6e5gIi06X2BPcIFB7lMzz89BpM46m2n6oonhrtHQYNBhHOiMtrnlzOfb03RwNVOjXFN6GwgrkopzogFQddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073790; c=relaxed/simple;
	bh=/1Bk29yA0ggig+w51gXm0ILJcPS6DzEsw675uIqK2+0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kN+P6ywKYfUOxDSaYpnuMSJv0bBjGfh8Akk1r3smKXjU+LQGe+7A9lKXV1uou6nDHBg69cj+t9IFuVZSPiO5/Cj+2a97HWA+Af0B56tHITiClaI1PXoqIzgzJNFqwcKRdX1NGSpbbMpmbpgUNs6GUwAq5fqEZ0od+1oMhPtqxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzLLN06tgz6M4hB;
	Fri, 21 Feb 2025 01:47:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E23C0140A9C;
	Fri, 21 Feb 2025 01:49:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 18:49:45 +0100
Date: Thu, 20 Feb 2025 17:49:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	<linux-iio@vger.kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
Message-ID: <20250220174944.000046d9@huawei.com>
In-Reply-To: <cb5dba6e-79cd-4752-a2fb-6cfa1913e2eb@gmail.com>
References: <20250217140135.896574-1-jic23@kernel.org>
	<20250217140135.896574-6-jic23@kernel.org>
	<0e17116e-6160-4920-83d9-086218245299@gmail.com>
	<85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
	<ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
	<df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
	<ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
	<2ad4ca67-5a70-4b7b-b744-d9bd92ce386a@baylibre.com>
	<20250219190500.01457211@jic23-huawei>
	<cb5dba6e-79cd-4752-a2fb-6cfa1913e2eb@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 20 Feb 2025 08:31:23 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 19/02/2025 21:05, Jonathan Cameron wrote:
> > On Wed, 19 Feb 2025 09:25:00 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> >> On 2/19/25 6:21 AM, Matti Vaittinen wrote: =20
> >>> On 19/02/2025 12:51, Nuno S=E1 wrote: =20
> >>>> On Wed, 2025-02-19 at 07:36 +0200, Matti Vaittinen wrote: =20
> >>>>> On 18/02/2025 17:42, David Lechner wrote: =20
> >>>>>> On 2/18/25 1:39 AM, Matti Vaittinen wrote: =20
> >>>>>>> On 17/02/2025 16:01, Jonathan Cameron wrote: =20
> >>>>>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>>>>
> >>>>>>>> These new functions allow sparse to find failures to release
> >>>>>>>> direct mode reducing chances of bugs over the claim_direct_mode()
> >>>>>>>> functions that are deprecated.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>>>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>>>>>> ---
> >>>>>>>>  =A0=A0=A0 drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
> >>>>>>>>  =A0=A0=A0 1 file changed, 6 insertions(+), 8 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
> >>>>>>>> b/drivers/iio/accel/kionix-kx022a.c
> >>>>>>>> index 727e007c5fc1..07dcf5f0599f 100644
> >>>>>>>> --- a/drivers/iio/accel/kionix-kx022a.c
> >>>>>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
> >>>>>>>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev=
 *idev,
> >>>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0 * issues if users trust the watermark =
to be reached within known
> >>>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0 * time-limit).
> >>>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0 */
> >>>>>>>> -=A0=A0=A0 ret =3D iio_device_claim_direct_mode(idev);
> >>>>>>>> -=A0=A0=A0 if (ret)
> >>>>>>>> -=A0=A0=A0=A0=A0=A0=A0 return ret;
> >>>>>>>> +=A0=A0=A0 if (!iio_device_claim_direct(idev))
> >>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 return -EBUSY; =20
> >>>>>>>
> >>>>>>> Not really in the scope of this review - but in my opinion the lo=
gic of
> >>>>>>> this check is terribly counter intuitive. I mean,
> >>>>>>>    =20
> >>>>>>>> +=A0=A0=A0 if (iio_device_claim_direct(idev))
> >>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 return -EBUSY; =20
> >>>>>>
> >>>>>> I'm curious how you read this then. I read this as:
> >>>>>>
> >>>>>> "If claiming direct mode succeeded, then return an error!" =20
> >>>>>
> >>>>> I am used to seeing a pattern where function returning zero indicat=
es a
> >>>>> success. I have no statistics but I believe this is true for a vast
> >>>>> majority of functions in the kernel. I believe this was the case wi=
th
> >>>>> the old 'iio_device_claim_direct_mode(idev)' too.
> >>>>>    =20
> >>>>
> >>>> Fair enough... Note though this is returning a boolean where true ma=
kes total
> >>>> sense for the "good" case. I do agree it's not super clear just by r=
eading the
> >>>> code that the API is supposed to return a boolean. =20
> >>>
> >>> Exactly. Just seeing the call in code was not obvious to me. It requi=
red finding the prototype to understand what happens.
> >>>
> >>> Anyways, I guess this discussion is out of the scope of this patch an=
d if no one else sees this important enough to go and change the iio_device=
_claim_direct() - then I am fine with this patch. So, with a bit of teeth g=
rinding:
> >>>
> >>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>
> >>> Yours,
> >>>  =A0 -- Matti
> >>>
> >>>     =20
> >>
> >> Would a name like iio_device_try_claim_direct_mode() make it more
> >> obvious that it returned a bool instead of int? =20
> >=20
> > FWIW I'd consider this a reasonable change if people in general
> > find it more intuitive.  Conveys to those not familiar with the
> > fun of IIO that failure is something we kind of expect to happen. =20
>=20
> As I replied to David's mail - for me renaming is not likely to make a=20
> big difference - but maybe it would help someone who is more used to the=
=20
> mutex_trylock() and alike. I'd still like to see someone else thinking=20
> that renaming would help before asking for anyone to go through that hass=
le.
Ok. I'll leave it as is for now. I don't mind circling back to this
eventually. I just don't want to have a mass rename in the middle of
making the change to the new ABI as it would be really messy.

Jonathan

>=20
> Yours,
> 	-- Matti
>=20


