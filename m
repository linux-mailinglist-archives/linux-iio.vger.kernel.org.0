Return-Path: <linux-iio+bounces-7783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4BE9390AB
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED101C21084
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F26D515;
	Mon, 22 Jul 2024 14:31:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41738C1A;
	Mon, 22 Jul 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658684; cv=none; b=klxYMQYrA8H74iHm38hnz+N7Ajre1oNUmD08dY8H3FOgjptwJXEXZ4dGUkAL8LwgJ7GVAVpTMOP1ssH88tr2S+MAEtdVMMTENuCfOENUzZWAOS/6oJb9L2OyLiyjN0eqJGfPJTWvUHX3so4atnNovOojuZxDUwe9h1A4065+mbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658684; c=relaxed/simple;
	bh=rapf4oFoI+WA3AOgT0/UquPXp4pcbY2UpSY/HF7NMk8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=T3Sy4CYsdtgFgzoL6p0UXCopCYNoTGZW0c1zL1LrGbiUcMMK9pyg1IPlXUCTJDH1CPvPExbc71w8n97+k5y/jhb9Etg44gXWcqIoR2KZqH5et2aUdhodeSYBVWfPlswPzwKFIZ72y2agtz1yZUngzL3uv3AapoW+uj3iPEZaO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id AD5993780523;
	Mon, 22 Jul 2024 14:31:20 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240720142236.22f8dbb2@jic23-huawei>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240714193709.543509-1-shreeya.patel@collabora.com> <20240720142236.22f8dbb2@jic23-huawei>
Date: Mon, 22 Jul 2024 15:31:20 +0100
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Marek Vasut" <marex@denx.de>, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <337fb5-669e6d00-5-3b412bc0@82250038>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?iio=3A?==?utf-8?q?_light=3A?=
 =?utf-8?q?_ltrf216a=3A?= Document the device name
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Saturday, July 20, 2024 18:52 IST, Jonathan Cameron <jic23@kernel.or=
g> wrote:

> On Mon, 15 Jul 2024 01:07:09 +0530
> Shreeya Patel <shreeya.patel@collabora.com> wrote:
>=20
> > Compatible 'ltr,ltrf216a' is used by Valve's Steamdeck device
> > via the ACPI + PRP0001 mechanism.
> > Document the device name alognside the compatible.
> >=20
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Hi Shreeya,
>=20
> I'm guessing you used get=5Fmaintainers for this.  Always check that =
there
> isn't anyone else who should be added.
>=20
> Given the root of this was the discussion about dropping this undocum=
ented
> binding the DT maintainers and list should definitely be CC'd + Marek
> who was part of the earlier discussion.
>=20

Sorry about that, I used get=5Fmaintainers like you said but I'll keep =
this in
mind next time.

> The fact that this isn't a typical ID from a Windows consumer device =
does
> change things a little, but I'd imagine a firmware update for the ste=
amdeck
> is equally unlikely to happen in order to fix the vendor-id.
> (I was surprised to discover they provide windows drivers for it but
> not seeing the light sensor in the list)
>=20
> So my opinion is that we should keep this ID in place with an enhance=
d
> description.
>=20
> The other suggestion from the Krzysztof's thread was the risk of this=
 getting
> abused.  Perhaps we should specifically fail to probe if that ID is u=
sed and
> it's not an ACPI firmware?
>=20

Rob said in another thread that use of it can now not pass the validati=
on
with dtschema. So I'm guessing we don't need to add any extra checks an=
ymore?

However, I'll send a v2 with enhanced description alongside the ID.

Thanks,
Shreeya Patel

>=20
> > ---
> >  drivers/iio/light/ltrf216a.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf2=
16a.c
> > index 68dc48420a88..e97ff8f7ecd0 100644
> > --- a/drivers/iio/light/ltrf216a.c
> > +++ b/drivers/iio/light/ltrf216a.c
> > @@ -528,7 +528,7 @@ MODULE=5FDEVICE=5FTABLE(i2c, ltrf216a=5Fid);
> > =20
> >  static const struct of=5Fdevice=5Fid ltrf216a=5Fof=5Fmatch[] =3D {
> >  	{ .compatible =3D "liteon,ltrf216a" },
> > -	{ .compatible =3D "ltr,ltrf216a" },
> > +	{ .compatible =3D "ltr,ltrf216a" }, /* For Valve's Steamdeck devi=
ce */
>=20
> Add that the steamdeck is an ACPI platform using PRP0001 as that's
> the key part that is different from a normal 'wrong' of=5Fdevice=5Fid=
.
>=20
>=20
> >  	{}
> >  };
> >  MODULE=5FDEVICE=5FTABLE(of, ltrf216a=5Fof=5Fmatch);
>


