Return-Path: <linux-iio+bounces-15800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90423A3C472
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 17:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5108B17310B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32AC1FC0E7;
	Wed, 19 Feb 2025 16:06:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964F1EB195
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981178; cv=none; b=nhZejT0jlkb3dxFmzfMvYt1v0VWIiDjUbLrS7hKp4OYtt2eF7UyCDuCx5GDuLqFyYx1AtVBCwiU/hVlo7clVJY8iJQH8i6Q5N5uz5QuS/RUCdYd6eFbrbUeF4nRJKHEKYbIiRLXKLlpwPfldasd54tD6byhWubDCvdfET+GFxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981178; c=relaxed/simple;
	bh=Hu0If3mlWBwcmv138spO0M4vIhxxUoBa34IVKQCeJPc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qggp/k19enKkikQcPW4M2HRoOItyO0Be/c67SO6ffr+6EvYw+okgROM9TRfj5i5aqQP72THbddWYwmSB6tUvNX6WuXhpMfRxjiXRZYbO4YW797m52H+OiqaMJVQGWT3YuU0eFax1atpOXpnnoOO3JgYjXfchW4nUomflI56khdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yyh4V3WwXz6H6vL;
	Thu, 20 Feb 2025 00:02:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 501DE140382;
	Thu, 20 Feb 2025 00:06:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 19 Feb
 2025 17:06:12 +0100
Date: Wed, 19 Feb 2025 16:06:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, David Lechner
	<dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
Message-ID: <20250219160611.00007916@huawei.com>
In-Reply-To: <ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
References: <20250217140135.896574-1-jic23@kernel.org>
	<20250217140135.896574-6-jic23@kernel.org>
	<0e17116e-6160-4920-83d9-086218245299@gmail.com>
	<85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
	<ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
	<df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
	<ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 19 Feb 2025 14:21:51 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 19/02/2025 12:51, Nuno S=E1 wrote:
> > On Wed, 2025-02-19 at 07:36 +0200, Matti Vaittinen wrote: =20
> >> On 18/02/2025 17:42, David Lechner wrote: =20
> >>> On 2/18/25 1:39 AM, Matti Vaittinen wrote: =20
> >>>> On 17/02/2025 16:01, Jonathan Cameron wrote: =20
> >>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>
> >>>>> These new functions allow sparse to find failures to release
> >>>>> direct mode reducing chances of bugs over the claim_direct_mode()
> >>>>> functions that are deprecated.
> >>>>>
> >>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>>> ---
> >>>>>  =A0=A0 drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
> >>>>>  =A0=A0 1 file changed, 6 insertions(+), 8 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
> >>>>> b/drivers/iio/accel/kionix-kx022a.c
> >>>>> index 727e007c5fc1..07dcf5f0599f 100644
> >>>>> --- a/drivers/iio/accel/kionix-kx022a.c
> >>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
> >>>>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *i=
dev,
> >>>>>  =A0=A0=A0=A0=A0=A0=A0 * issues if users trust the watermark to be =
reached within known
> >>>>>  =A0=A0=A0=A0=A0=A0=A0 * time-limit).
> >>>>>  =A0=A0=A0=A0=A0=A0=A0 */
> >>>>> -=A0=A0=A0 ret =3D iio_device_claim_direct_mode(idev);
> >>>>> -=A0=A0=A0 if (ret)
> >>>>> -=A0=A0=A0=A0=A0=A0=A0 return ret;
> >>>>> +=A0=A0=A0 if (!iio_device_claim_direct(idev))
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 return -EBUSY; =20
> >>>>
> >>>> Not really in the scope of this review - but in my opinion the logic=
 of
> >>>> this check is terribly counter intuitive. I mean,
> >>>> =20
> >>>>> +=A0=A0=A0 if (iio_device_claim_direct(idev))
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 return -EBUSY; =20
> >>>
> >>> I'm curious how you read this then. I read this as:
> >>>
> >>> "If claiming direct mode succeeded, then return an error!" =20
> >>
> >> I am used to seeing a pattern where function returning zero indicates a
> >> success. I have no statistics but I believe this is true for a vast
> >> majority of functions in the kernel. I believe this was the case with
> >> the old 'iio_device_claim_direct_mode(idev)' too.
> >> =20
> >=20
> > Fair enough... Note though this is returning a boolean where true makes=
 total
> > sense for the "good" case. I do agree it's not super clear just by read=
ing the
> > code that the API is supposed to return a boolean. =20
>=20
> Exactly. Just seeing the call in code was not obvious to me. It required=
=20
> finding the prototype to understand what happens.
>=20
> Anyways, I guess this discussion is out of the scope of this patch and=20
> if no one else sees this important enough to go and change the=20
> iio_device_claim_direct() - then I am fine with this patch. So, with a=20
> bit of teeth grinding:
>=20
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

This is copying what happens for the locks that can fail. I agree
that it would have been nice to get the advantages of sparse with
the old interface but from what I recall I got a lot more false positives
so wanted it to look more lock like.

Jonathan

>=20
> Yours,
>    -- Matti
>=20
>=20


