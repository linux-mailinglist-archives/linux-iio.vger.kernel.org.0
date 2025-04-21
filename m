Return-Path: <linux-iio+bounces-18406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC9DA94FC4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48577A3CD4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054326158F;
	Mon, 21 Apr 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXLECnaN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1761220C47B;
	Mon, 21 Apr 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233301; cv=none; b=nef6MzPl18KKKFTHWdZqB2vok8FYW7LotnhuodiGfw4mPLcOT6uZWJKedmYwtfCZ8iUG2tE85Yj8W12JqctGuF7n5at4P9gHx8X9QjG9JbrAwTZmN3WNwLER4sJcFqqxZLgSKx8zZA2LwRipTB75/4JX2clG7DljdvoCtVVGUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233301; c=relaxed/simple;
	bh=cAvMCgZP+MhJK/LXW4szC3CbZw7bAtxZrpSXA2BIccM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7M1g1Koxo+Fjur4drEW+X5RhauaucLTcgDY21609o/Y17zNON8T0k+vmwmZ+dlt1x77J/JLkeFrJqFlZnpPR4P0X3liH0naKEb8bWDkdV8tvDC1JET6gm6qS8zU4UP58I6MQeCQ09XBTHn4flyOgslU4wkk6Cx2xzTZnNfzeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXLECnaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFF0C4CEE4;
	Mon, 21 Apr 2025 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745233300;
	bh=cAvMCgZP+MhJK/LXW4szC3CbZw7bAtxZrpSXA2BIccM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gXLECnaNhfDMCU2Q7DjLyyWR7aHYJf76zyRgnckXAnDpVOv+SXJ8PREme97O+kR3r
	 G0r42n7CrTB2m70Bu8ogXt9DbntJHe6nQ/yT2chNDTaQO0UCcfXP8Tu0aKW1P7mUhS
	 /+EDxlRkAhuaXC8M6Po+uaPwIf1Of1DvC2SZdxM+0PHR6LpDlN8a0CAfFYIamNReQL
	 h8fsOQbWkFt7Zus5kVslWN3qCCH+oHblirP/HY3oYRt9HndjiA/TbmnJY3CVexsd4Y
	 RS/hZNQV3RjD1wsX/xMEnDiUsXJhHPNMYHf4deewDA23yGpAKWdKVRCj7N89zjFsMD
	 02tr/2W2QAGwg==
Date: Mon, 21 Apr 2025 12:01:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, David Lechner	 <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Corbet  <corbet@lwn.net>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 sfr@canb.auug.org.au
Subject: Re: [PATCH] docs: iio: ad3552r: fix malformed table
Message-ID: <20250421120133.370cad4c@jic23-huawei>
In-Reply-To: <087b28aeecb54645a52627d84291a5ed6d309011.camel@gmail.com>
References: <20250415-wip-bl-ad3552r-fix-doc-table-v1-1-717ffd320c9d@baylibre.com>
	<087b28aeecb54645a52627d84291a5ed6d309011.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Apr 2025 10:08:09 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-04-15 at 09:44 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Fix malformed table.
> >=20
> > Fixes: 9a259b51e3ea ("docs: iio: add documentation for ad3552r driver")
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
I forgot to say I applied this a while back. Just noticed status was wrong =
in
patchwork!

Jonathan

>=20
> > Fix malformed table.
> > ---
> > =C2=A0Documentation/iio/ad3552r.rst | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/iio/ad3552r.rst b/Documentation/iio/ad3552r.=
rst
> > index
> > 582507abe8c4c2ecb51a1f8389d7deec44d20222..f5d59e4e86c7ec8338f3f4e82d7a0=
7587e3d
> > 8404 100644
> > --- a/Documentation/iio/ad3552r.rst
> > +++ b/Documentation/iio/ad3552r.rst
> > @@ -56,7 +56,7 @@ specific debugfs path ``/sys/kernel/debug/iio/iio:dev=
iceX``.
> > =C2=A0| Debugfs device files=C2=A0 |
> > Description=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0+-----------------------+----------------------------------------=
------------
> > --+
> > =C2=A0| data_source=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | The used data source,
> > as=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> > -|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ``normal`=
`, ``ramp-16bit``,
> > etc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ``normal`=
`, ``ramp-16bit``,
> > etc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0+-----------------------+----------------------------------------=
------------
> > --+
> > =C2=A0| data_source_available | The available data
> > sources.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
> > =C2=A0+-----------------------+----------------------------------------=
------------
> > --+
> >=20
> > ---
> > base-commit: 31c52fe3b2efeebfc72cc5336653baaa9889b41e
> > change-id: 20250415-wip-bl-ad3552r-fix-doc-table-589293c9b860
> >=20
> > Best regards, =20


