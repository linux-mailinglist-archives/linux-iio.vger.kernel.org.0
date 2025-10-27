Return-Path: <linux-iio+bounces-25448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E90C0BD20
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 06:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9579D3BA9AB
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 05:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF512C08DA;
	Mon, 27 Oct 2025 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="kTU3L11y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA5267386;
	Mon, 27 Oct 2025 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761542872; cv=none; b=bvcy2ScJakXvghHFx+gjsHknya57MWrS8UX1UGDkoAF187wMLTefn4WQX8nHzIEYhbLSqo2u8tiiev+1G929Xl7F4m3OojcDaFGhwMKQZqo6xEayEslni4V02JAwjhAF9zd+6B101UJwPqwdt7g8lJs4ozlgU0am+8Ckq2c4ECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761542872; c=relaxed/simple;
	bh=Awy4ce0HvlHevMpAawicSrxtE5vQmpxQBetCDOKBd1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb7MVDI8kEm57bYWm6zd0ArBAEGcYqK6lX+m3iS/JQbpM75lm/Xnh5sZEVQ5wSHn0IIGnPerPMtKGWF73a+P4e3VHeDAHYKKZEXkOyssReViO+42Xgp2nSvQm8vFMROkgL34hd21yocA7D0h6uN1z0j/kLYKFDIyK86oNEM4f0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=kTU3L11y; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 316B6160209;
	Mon, 27 Oct 2025 07:27:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1761542858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iKH1TKrzGmY5KwdEN+igCoenmbB4AdbiIJJBSZeAVQ=;
	b=kTU3L11yw9v3NK/o1ko4Fdk8kzycsOwWBF+GtirAp4FqI3IaXzlEufT0RKCcyBHZkevm4M
	ObhFwxpQcV1qe6vfnOcQ3FEAHfRUXA6yOdXUeHSMIGz+mmbXxGUL2dBExh+Rze3ogTOgzP
	UbPI8Jg44YKVbxZ823pVX3/e79ummmzAAQk3L6a0f7YO0oaG5o4NNZrOA5yYdHyfu7ljN6
	QP7/8Dq+DISWYulA41eU6gIP46ZfOYLAMltHyunc1lkHZiIUhBU7GMPlBJPLaGrJkwXCLg
	u0i4VOeUlsRR5ki9XWT9ocVC+rxXmYJr3rt/UMMrBtv3zeVbnNnbrLKTQ/VW/w==
Date: Mon, 27 Oct 2025 07:27:35 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: accel: bma220: move set_wdt() out of bma220_core
Message-ID: <aP8Cx7gMxGfpfb6n@sunspire.home.arpa>
References: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
 <aPjE-n0wKNIJd2-M@smile.fi.intel.com>
 <20251023182318.00004319@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251023182318.00004319@huawei.com>


Hello Jonathan.

On Thu, Oct 23, 2025 at 06:23:18PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Oct 2025 14:50:18 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Tue, Oct 21, 2025 at 01:31:49PM +0300, Petre Rodan wrote:
> > > Move bma220_set_wdt() into bma220_i2c.c instead of using a conditional
> > > based on i2c_verify_client() in bma220_core.c that would make core
> > > always depend on the i2c module. =20
> >=20
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > But Kconfig for this driver is a bit strange. Usually we do other way a=
round,
> > i.e. make user visible selection of the glue drivers, while core is sel=
ected if
> > at least one of the leaf driver selected by the user.
> >=20
> This comes up from time to time.  There kind of isn't a right answer
> to my mind in the trade off between complexity of configuration=20
> and desire for minimum useful set of Kconfig symbols and people wanting
> to build only exactly what they want.  So we've ended up with a mix.
>=20
> I don't mind setting a policy on this for new code going forwards, but
> that means we need to decide which approach we prefer and document
> it somewhere.

I will come back with a new patch to Kconfig once you decide what is the be=
st way to handle dependecies, but in the meantime can you please accept thi=
s current patch?

I keep getting automated errors that would be fixed by it:

https://lore.kernel.org/oe-kbuild-all/202510210604.mAtgE54g-lkp@intel.com/
https://lore.kernel.org/oe-kbuild-all/202510222324.SxYlIaLW-lkp@intel.com/
https://lore.kernel.org/oe-kbuild-all/202510271347.115BMnsC-lkp@intel.com/

If the current patch does not correctly reference the automated 0day-ci rep=
orts please tell me what I should change within my b4 workflow.

thank you,
peter

