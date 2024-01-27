Return-Path: <linux-iio+bounces-1945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEF83EDD7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 16:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5FB1F22375
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 15:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7905528DCA;
	Sat, 27 Jan 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmzFU+5b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A625777;
	Sat, 27 Jan 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368628; cv=none; b=cBGMSMxUFSCjQAtZ8J6io1BmTjwiqWIrzpYll/3NOQrhColnwnLXdp9LyZ99tZMJmgUBPWNLk0M9qGJIdphOyC8D/WOjBZIa5jbhmIWT6S18nlKU49Q1c4e7mfqBSzIwWfXXpG3y/qGexMatX0lctqVJQicRutmhBCFM/Oc7PLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368628; c=relaxed/simple;
	bh=NGotAnokrWKdTAmMNyUBbnClnEbT/hF/4pLPbxbMpQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiNwNoPu4SnS8kzvhMF3KwuSiMIwCZ5lRAl88xCeVFFtjVk51Z2M4d9Z2BA7oJkiQMooFONuUHuvfIwkBfvITK0WyUeTk3Gbg0PZDerboOrNSc62YHmbYV3bazFfT2nC3e+qqJdUQXNjcPn5tOnxxWKitaMX+K6MuGdn9P8BaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmzFU+5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13E1C433C7;
	Sat, 27 Jan 2024 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706368628;
	bh=NGotAnokrWKdTAmMNyUBbnClnEbT/hF/4pLPbxbMpQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RmzFU+5bvMnbNXeMCWSRzFRV/7mGvjIsk6xTQ7HM5H/+AJK9SLAikDKk0dH8D9+mz
	 vv3G9EPNfcMG/6/GVTUAf0DLcNHiQnu7xblHQwasYqwYtpvkAas7ucXIRximroOxzW
	 j1NX9ekKkb8GNbMt+qmiq7pJmLSEv/Dh7mDEEVQg2KDR20b5AvZzC5Z26jor6EmXXs
	 sYVhncnznbew1XN4FK676d5NivEAkXCEbKmztEP+veXialGXw+NLlBI6uafDVKbZBO
	 Ucua/rl+AzH5i+f4upAjhMinvsxAmPG930Z1mz58h05N47xBIjQcV/L7v0k2/IcQfY
	 ZUOGm6VmfaJaQ==
Date: Sat, 27 Jan 2024 15:16:50 +0000
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
Message-ID: <20240127151650.36393291@jic23-huawei>
In-Reply-To: <20240127150726.3c9150c7@jic23-huawei>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	<20240123-iio-backend-v7-1-1bff236b8693@analog.com>
	<CAGETcx_0wij8j5u7YRNPDgpPDkJoFq4AL7oRy0iFUELYTbc9Bg@mail.gmail.com>
	<20240127150726.3c9150c7@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jan 2024 15:07:26 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 24 Jan 2024 19:14:35 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>=20
> > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > >
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >
> > > The property is io-channels and not io-channel. This was effectively
> > > preventing the devlink creation.   =20
>=20
> I'm a bit lost on the devlink side of things. Is this something with
> effects on existing drivers before this patch set, or is it only causing
> real problems with the changes in here?
>=20
> i.e. Should we mark it for stable and rush it in as a fix, or can it wait
> for the rest of the set?
>=20
I'm also fine with this going via DT tree if that makes more sense.
If that happens.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Jonathan
>=20
> >=20
> > Thank you!
> >=20
> > Reviewed-by: Saravana Kannan <saravanak@google.com> =20
>=20
> >  =20
> > >
> > > Fixes: 8e12257dead7 ("of: property: Add device link support for iommu=
s, mboxes and io-channels")
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > >  drivers/of/property.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 641a40cf5cf3..bbf0dee2fb9c 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1244,7 +1244,7 @@ DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-ce=
lls")
> > >  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-ce=
lls")
> > >  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> > >  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > > -DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
> > > +DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
> > >  DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
> > >  DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
> > >  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-ce=
lls")
> > >
> > > --
> > > 2.43.0
> > >   =20
>=20
>=20


