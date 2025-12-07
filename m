Return-Path: <linux-iio+bounces-26916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83DCAB973
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 20:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8D2301514C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A3425F7A4;
	Sun,  7 Dec 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvtval8r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6431222566
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765136271; cv=none; b=tvchYE5fQrApPbVDcpI/sbEDZrj9lcem3/C9X1RsQ/YGssI76hNPaoqfMi4dB01/yOK/bCrlUf0cjGRO7mTMS0F0AGg2TC9eyhiDK7wVLzIEwYjEp5RVeJkefrUn3k2P02xpZCYIOOV5WMSBEgs0kmd5pMpAlVqcnKFl7+ppBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765136271; c=relaxed/simple;
	bh=KY6+gWRgPhjFl1RHTwRHE+W10PE92C/SLKP6LgTc1FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blsSwsoiKVVdmuqIaBgDmvXvA7OE/GqQgP+qIRtwWMEUyIOYi24rTTS2zgBhmf+G5tb2N7RCVHQVeVfo37a0LiAax2iIk0pnWR1Uptoo60VIJxbNrJOdGlpa+SmscEb3WnqbfQoyp7JzBKZp6rGQlTFfUXqeht6pIZol/XWZ4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvtval8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A02C4CEFB;
	Sun,  7 Dec 2025 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765136271;
	bh=KY6+gWRgPhjFl1RHTwRHE+W10PE92C/SLKP6LgTc1FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gvtval8rWvBViabsWVHFd/BcSdxxt+tVT3sN05X60F61K0lyyBiciU1a5qJqMmz9Q
	 eZZ2sR0YQwF3WF/cq5fJbp2GAVB+RJP0O9J+5dqAxPHEwS896mnbrOJEjYHxhkasR0
	 HoAvmNEmZ5UeIeSzouUZdDilMyZs1sV117j3+jQEv8FevNShooPj3pOtMKvujNV47I
	 tj5870UfTzwaJWCCxFy6efuBRK7zb7I4MX0mafgnjbVAyOI4wbkDq/0kaOp15UPUwR
	 /twkSToJNmRgSIelqS/vuvVAXdAq/JYZWbnMpkhkJRv/Ws+GHHdQKioOokrfYGGVNi
	 ihmigJ63a4ZXQ==
Date: Sun, 7 Dec 2025 19:37:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "=?UTF-8?B?S8O8YnJpY2gs?= Andreas" <andreas.kuebrich@spektra-dresden.de>
Cc: 'Jonathan Cameron' <jonathan.cameron@huawei.com>,
 "'linux-iio@vger.kernel.org'" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl
Message-ID: <20251207193744.019c0ee1@jic23-huawei>
In-Reply-To: <PAXPR09MB50402CA81386A6A999727729B4C9A@PAXPR09MB5040.eurprd09.prod.outlook.com>
References: <PAXPR09MB5040DBBE59B2BA98F1108581B4C9A@PAXPR09MB5040.eurprd09.prod.outlook.com>
	<20251117155406.000002af@huawei.com>
	<PAXPR09MB50402CA81386A6A999727729B4C9A@PAXPR09MB5040.eurprd09.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Nov 2025 16:23:47 +0000
"K=C3=BCbrich, Andreas" <andreas.kuebrich@spektra-dresden.de> wrote:

> Hi Jonathan,
>=20
> > > The chip info for this variant (I2C, four channels, 14 bit, internal =
reference)
> > > seems to have been left out due to oversight, so ad5686_chip_info_tbl=
[ID_AD5695R]
> > > is all zeroes. Initialisation of an AD5695R still succeeds, but the r=
esulting IIO
> > > device has no channels and no /dev/iio:device* node. =20
> >=20
> > Hi Andreas,
> >=20
> > Thanks. This is another one for a list of reasons not to use an enum an=
d array
> > for these! We used to do that a lot, but current best practice is separ=
ate
> > structures.
> >=20
> > Wrap commit descriptions a little shorter (75 chars is typical).  Tooli=
ng tends
> > to end up indenting these for some reason so that convention has been a=
round a long
> > time. =20
>=20
> Oh, that's something the kernel docs don't mention; I tend to wrap my com=
mit
> summaries at 72 and extended descriptions at 80. Though it seems I've man=
aged to
> hit 81 instead, whoops. Good to know in any case; I'll keep that in mind =
in the
> future.
>=20
> > Please could you provide a fixes tag. (see submitting patches). =20
>=20
> Right, will do that.
>=20
> > Replying to this email is fine rather than sending a new patch. =20
>=20
> Then here's the updated description:
>=20
> The chip info for this variant (I2C, four channels, 14 bit, internal
> reference) seems to have been left out due to oversight, so
> ad5686_chip_info_tbl[ID_AD5695R] is all zeroes. Initialisation of an
> AD5695R still succeeds, but the resulting IIO device has no channels
> and no /dev/iio:device* node.
>=20
> Add the missing chip info to the table.
>=20
> Fixes: 4177381b4401 ("iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R s=
upport")
>=20

Didn't matter this time, but no blank line here or it breaks scripts that
expect a contiguous tag block (or ones that are there to moan if they aren'=
t :)

> Signed-off-by: Andreas K=C3=BCbrich <andreas.kuebrich@spektra-dresden.de>

Applied to my local fixes branch - I'll push out once I can rebase that on =
rc1.

Thanks,

Jonathan



