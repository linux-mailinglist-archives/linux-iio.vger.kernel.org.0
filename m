Return-Path: <linux-iio+bounces-15804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893FA3C838
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 20:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A887118963A7
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 19:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49261F8BBC;
	Wed, 19 Feb 2025 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWUlymYt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0C1BC099
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991908; cv=none; b=KvJ+cH4+rO8zt1uYozbLk5ty8WD06+U01yTyJ0PSZo/cx2/UtYz15N9nR+T22GXXrb/g7/41KeOWkNOgOvMVRmDRv8OO1pDlnLetjze+914PRTM+e1YbnicFKRYby4mPK6JxOoe1YF/BOEoKBM38Xi7vipbeI/RVYw41kDTCCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991908; c=relaxed/simple;
	bh=bCzeIT26kUN4IZ7i5bplkDtzx6uNIBNINIEMfqIFDW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYXmllXnSN+1ALar+BpjXF/xIeIJhHQZIIfeQJOYPLAklSI7OHbccLc9XemuFHwv+IyrMm7BwDRyOnNr7JMSMx28kBmQAHglF3M3rZicZheisu1DJOdEE9y+bEm0etkTVKQKBvVLps1ASUnBoRfPfo9fE9xj9/CrHxdf93NZdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWUlymYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799DFC4CED1;
	Wed, 19 Feb 2025 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739991908;
	bh=bCzeIT26kUN4IZ7i5bplkDtzx6uNIBNINIEMfqIFDW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KWUlymYtqlaovvlHRu3KrF6QPQDrCwqZCl9ikU181qJws6PacLSNOs3Wa3AqUDjKs
	 t3SVXNYzlRUwyiUkd6rLzoSz3uRdQYkf16L+JYxjnIdcmIIesuNdWSnFSlBxNa4sIk
	 ZpeoUU+U6DpMsCIc3sTOnrZ4tgQS31I4CEJJQeSjn/oUy2Q9N3PH+595jBDxsDlG9i
	 dXp/YLxWeyjztDqBnKkQErMbW25zg8zqqwxmzGxJZv4t/+2YfDzU9SxnyTtJGkX1wC
	 YfpkYfeGagPn/uWDzdKNj9gCaYYk9Je7W6uMZ3wkVqzBN161exFQ4ovTSd4n3r/xav
	 Tgc658whjPuOA==
Date: Wed, 19 Feb 2025 19:05:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, linux-iio@vger.kernel.org, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
Message-ID: <20250219190500.01457211@jic23-huawei>
In-Reply-To: <2ad4ca67-5a70-4b7b-b744-d9bd92ce386a@baylibre.com>
References: <20250217140135.896574-1-jic23@kernel.org>
	<20250217140135.896574-6-jic23@kernel.org>
	<0e17116e-6160-4920-83d9-086218245299@gmail.com>
	<85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
	<ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
	<df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
	<ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
	<2ad4ca67-5a70-4b7b-b744-d9bd92ce386a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2025 09:25:00 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/19/25 6:21 AM, Matti Vaittinen wrote:
> > On 19/02/2025 12:51, Nuno S=C3=A1 wrote: =20
> >> On Wed, 2025-02-19 at 07:36 +0200, Matti Vaittinen wrote: =20
> >>> On 18/02/2025 17:42, David Lechner wrote: =20
> >>>> On 2/18/25 1:39 AM, Matti Vaittinen wrote: =20
> >>>>> On 17/02/2025 16:01, Jonathan Cameron wrote: =20
> >>>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>>
> >>>>>> These new functions allow sparse to find failures to release
> >>>>>> direct mode reducing chances of bugs over the claim_direct_mode()
> >>>>>> functions that are deprecated.
> >>>>>>
> >>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>>>> ---
> >>>>>> =C2=A0=C2=A0=C2=A0 drivers/iio/accel/kionix-kx022a.c | 14 ++++++--=
------
> >>>>>> =C2=A0=C2=A0=C2=A0 1 file changed, 6 insertions(+), 8 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
> >>>>>> b/drivers/iio/accel/kionix-kx022a.c
> >>>>>> index 727e007c5fc1..07dcf5f0599f 100644
> >>>>>> --- a/drivers/iio/accel/kionix-kx022a.c
> >>>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
> >>>>>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *=
idev,
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * issues if users=
 trust the watermark to be reached within known
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * time-limit).
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D iio_device_claim_direct_mode(idev);
> >>>>>> -=C2=A0=C2=A0=C2=A0 if (ret)
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (!iio_device_claim_direct(idev))
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY; =20
> >>>>>
> >>>>> Not really in the scope of this review - but in my opinion the logi=
c of
> >>>>> this check is terribly counter intuitive. I mean,
> >>>>> =20
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (iio_device_claim_direct(idev))
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY; =20
> >>>>
> >>>> I'm curious how you read this then. I read this as:
> >>>>
> >>>> "If claiming direct mode succeeded, then return an error!" =20
> >>>
> >>> I am used to seeing a pattern where function returning zero indicates=
 a
> >>> success. I have no statistics but I believe this is true for a vast
> >>> majority of functions in the kernel. I believe this was the case with
> >>> the old 'iio_device_claim_direct_mode(idev)' too.
> >>> =20
> >>
> >> Fair enough... Note though this is returning a boolean where true make=
s total
> >> sense for the "good" case. I do agree it's not super clear just by rea=
ding the
> >> code that the API is supposed to return a boolean. =20
> >=20
> > Exactly. Just seeing the call in code was not obvious to me. It require=
d finding the prototype to understand what happens.
> >=20
> > Anyways, I guess this discussion is out of the scope of this patch and =
if no one else sees this important enough to go and change the iio_device_c=
laim_direct() - then I am fine with this patch. So, with a bit of teeth gri=
nding:
> >=20
> > Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >=20
> > Yours,
> > =C2=A0 -- Matti
> >=20
> >  =20
>=20
> Would a name like iio_device_try_claim_direct_mode() make it more
> obvious that it returned a bool instead of int?

FWIW I'd consider this a reasonable change if people in general
find it more intuitive.  Conveys to those not familiar with the
fun of IIO that failure is something we kind of expect to happen.

Slightly messy to change the patches already applied to my
tree but cleaner to do so now than later as I haven't pushed=20
the branch out as togreg yet (it's just the testing branch
for 0-day).

Jonathan
>=20


