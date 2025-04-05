Return-Path: <linux-iio+bounces-17642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB0EA7CA45
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6D63B9CC8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF13174EE4;
	Sat,  5 Apr 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGtKP4eZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD52C9D
	for <linux-iio@vger.kernel.org>; Sat,  5 Apr 2025 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743870891; cv=none; b=H4IgInO2hqiIRam88UCxhHXm5AGFVztD6iFOAky5RedEMZLFY82Hl61/qHtSU/QTA921zX+4CQEsZTVRyGJfCxY9Q0n9IFBcKw0kHCI1kWhD5eKlxZTuf1IJ/YRkcSnFTEN+IPGu+4Pwb4pGemjWGIH8crxlpV55U/OTkXSatT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743870891; c=relaxed/simple;
	bh=C819EzFVSyE8R5TocAXCrRmPHCDGK5uwQv6h8AuNY7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jy9W8xGoTGZm2lLfevUR4W9Agw7Is7Xr2AUJ/P2MJbqiHDqY13C3qiLqQwthBGOp0cPdT4Cx6FX5MIgpoqamMUr2+VNksDrmBlHXCZvRcGxKxfnvTBeznD5l+OhjmtkfscA6M9eW8f94qy2nWFdaYFMhi1q8STuLNcixSpUWdOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGtKP4eZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0152FC4CEE4;
	Sat,  5 Apr 2025 16:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743870890;
	bh=C819EzFVSyE8R5TocAXCrRmPHCDGK5uwQv6h8AuNY7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dGtKP4eZ7mE0wVDohUTc82RRjwJyJXuZuLzxyy7M+cV6bRJGWW7FpNPV09OkwoWXq
	 wt9fUrrubzVTZ+P82P+IucqpzG3Cf0T754N5yyn84rOMTY4PSXetYJI46nWVWEcnJe
	 uuFReRmbpY/O3fxZ4bCNPdrCcRv90VjzXAHUgLNbImqNIUGxGEtmZurJq3iOrNEpTn
	 mEb1H5uiGPk1SxCGL/EvFMAV+wfph9gsg5eWtpKEl9yUDyJtNT6sjVvJS1yTc2WYnn
	 T515w0Dpe1QXyK6eAQJs8iGhKNixW2mxKwXsLSSFhIS3eOiXKLJOaeW7ghIqCjx1av
	 s1DgS63ELedFA==
Date: Sat, 5 Apr 2025 17:34:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cosmin Tanislav
 <demonsingur@gmail.com>, Roan van Dijk <roan@protonic.nl>, Jyoti Bhayana
 <jbhayana@google.com>, Nishant Malpani <nish.malpani25@gmail.com>, Eugene
 Zaikonnikov <ez@norphonic.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Shen Jianping
 <Jianping.Shen@de.bosch.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Yasin Lee <yasin.lee.x@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 37/37] iio: Adjust internals of handling of direct mode
 claiming to suit new API.
Message-ID: <20250405173439.5a6d7980@jic23-huawei>
In-Reply-To: <CAHp75VdUU4p95+b31mP1-fb5ytBPeisi5e0gf4sAniLFYabE7A@mail.gmail.com>
References: <20250331121317.1694135-1-jic23@kernel.org>
	<20250331121317.1694135-38-jic23@kernel.org>
	<CAHp75VdUU4p95+b31mP1-fb5ytBPeisi5e0gf4sAniLFYabE7A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Mar 2025 16:41:42 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Mar 31, 2025 at 3:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Now there are no remaining callers of iio_device_claim_direct_mode()
> > and iio_device_release_direct_mode() rename those functions to ensure
> > they are no used in new drivers. Also make them now return booleans =20
>=20
> not used
>=20
> > in line with the sparse friendly static inline wrappers. =20
>=20
> ...
>=20
> >  /**
> > - * iio_device_claim_direct_mode - Keep device in direct mode
> > + * __iio_device_claim_direct - Keep device in direct mode
> >   * @indio_dev: the iio_dev associated with the device
> >   *
> >   * If the device is in direct mode it is guaranteed to stay
> > - * that way until iio_device_release_direct_mode() is called.
> > + * that way until __iio_device_release_direct() is called.
> >   *
> > - * Use with iio_device_release_direct_mode()
> > + * Use with __iio_device_release_direct().
> >   *
> > - * Returns: 0 on success, -EBUSY on failure.
> > + * Drivers should only call iio_device_claim_direct() =20
>=20
> Missed period.
>=20
> > + * Returns: true on success, false on failure.
> >   */ =20
>=20
> ...
>=20
> > -EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> > +EXPORT_SYMBOL_GPL(__iio_device_claim_direct); =20
>=20
> Can we move it to the namespace while at it?

I'm personally not convinced by the namespace defaults in headers
thing pwm.h does.  So to namespace these is a massive patch
adding the import to most drivers.

So I'd rather deal with that later.
>=20
> ...
>=20
> >  /**
> > - * iio_device_release_direct_mode - releases claim on direct mode
> > + * __iio_device_release_direct - releases claim on direct mode
> >   * @indio_dev: the iio_dev associated with the device
> >   *
> >   * Release the claim. Device is no longer guaranteed to stay
> >   * in direct mode.
> >   *
> > - * Use with iio_device_claim_direct_mode()
> > + * Drivers should only call iio_device_release_direct() =20
>=20
> Missed period.
>=20
> > + * Use with __iio_device_claim_direct()
> >   */ =20
>=20
> ...
>=20
> > -EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > +EXPORT_SYMBOL_GPL(__iio_device_release_direct); =20
>=20
> Namespace?
> Note, the good outcome of the namespace is that we can easily see who
> (ab)uses these... OTOH, there are static inline functions in the
> header, which provokes this to add MODULE_IMPORT_NS() into the header
> as well. That said, perhaps also get rid of static inliners and have
> them to be real functions?
As David said. Unfortunately not :(

Though static inlines using these is fine as any driver that
doesn't import will still fail in the correct way. It will just
be a bit 'weird' to fail like that.  The missing namespace
warnings are pretty obvious though so that should be fine.

Jonathan

>=20


