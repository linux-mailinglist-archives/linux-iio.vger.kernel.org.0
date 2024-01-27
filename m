Return-Path: <linux-iio+bounces-1943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DAF83EDC8
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164E7B20FBC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ACC28DC0;
	Sat, 27 Jan 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUZOZ5SA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD31DFCF;
	Sat, 27 Jan 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368061; cv=none; b=mHR2n8RXhryuHCtk+RmVHEvp/NoGPFi8NLqGeXJSWeV3mjNgfrkrRAWCDP1CYG3H7Gy4E5ubUNmm+egNZ9bAwtG7uARHE4EfBinOruFxnyzKyzgPHa4aA/7paruLD8qK6eqrS3l6JJe4SOua9wFMWF2DCYdZtH5gLbEoxCZ97DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368061; c=relaxed/simple;
	bh=rZwDtEhFcIhvYVAuZjqQWQT/i7mXce1eL6ztvZDzyl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibYZW8IHoKvxulvnThVwvtGtMkjEh7XVSKLVegbBB93075emMtbLSw/Nw6Z0n7Yjm4R3RVsL+11YUOUZu4s9pLOPfi2H50Eu779p0PucGGVezyA4Kzwoinykwl7uMMwVR7g+wIbR/VoA4chtsghe0iPLygMSgBLZuw1dOm3uxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUZOZ5SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B616AC433F1;
	Sat, 27 Jan 2024 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706368060;
	bh=rZwDtEhFcIhvYVAuZjqQWQT/i7mXce1eL6ztvZDzyl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUZOZ5SA82PlkxmRgWFVR0+bPQG7pU2rP7NBK/u5S/pZi3TnU5i844gWRiAesm0Ee
	 BwzNPGpjD6gef+QpmDSujHhQUJ1V54MHKB81VZxkLgPlUUoUixvEzJuSGcTZWORY4N
	 WfFkz73Smggxkce4Nc5TsS2Qvvit6jh0MMZROr3O+2+AbCKzusPxI0pibYsY/bB6jB
	 bauHH+8dBUYr4L7z+hNgk9Th6sKUPlnjzVPjMAOxQ3xvNv6yIlK0iGLyMp15RqEuBf
	 TMjF6ldNAd/7ke4mNZ2tZYylweKjSMlPbjqWsHj0c1lej+z69IOKovGcvFTzmGXVrB
	 mh74nP4GoOGIw==
Date: Sat, 27 Jan 2024 15:07:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v7 1/9] of: property: fix typo in io-channels
Message-ID: <20240127150726.3c9150c7@jic23-huawei>
In-Reply-To: <CAGETcx_0wij8j5u7YRNPDgpPDkJoFq4AL7oRy0iFUELYTbc9Bg@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	<20240123-iio-backend-v7-1-1bff236b8693@analog.com>
	<CAGETcx_0wij8j5u7YRNPDgpPDkJoFq4AL7oRy0iFUELYTbc9Bg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jan 2024 19:14:35 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >
> > From: Nuno Sa <nuno.sa@analog.com>
> >
> > The property is io-channels and not io-channel. This was effectively
> > preventing the devlink creation. =20

I'm a bit lost on the devlink side of things. Is this something with
effects on existing drivers before this patch set, or is it only causing
real problems with the changes in here?

i.e. Should we mark it for stable and rush it in as a fix, or can it wait
for the rest of the set?

Jonathan

>=20
> Thank you!
>=20
> Reviewed-by: Saravana Kannan <saravanak@google.com>

>=20
> >
> > Fixes: 8e12257dead7 ("of: property: Add device link support for iommus,=
 mboxes and io-channels")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  drivers/of/property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 641a40cf5cf3..bbf0dee2fb9c 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1244,7 +1244,7 @@ DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cell=
s")
> >  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cell=
s")
> >  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> >  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > -DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
> > +DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
> >  DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
> >  DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
> >  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cell=
s")
> >
> > --
> > 2.43.0
> > =20


