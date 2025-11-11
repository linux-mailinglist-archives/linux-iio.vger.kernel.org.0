Return-Path: <linux-iio+bounces-26173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E19CC4F97D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 20:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1F5B343051
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C7C2EA;
	Tue, 11 Nov 2025 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InNmF67p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64D2F28EB;
	Tue, 11 Nov 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889117; cv=none; b=fx4f20XHGFZiU07QPjany/LNWNuZc2xcnw+MxzhLuHm+BnrAl4nteX5my9CvDtQPbKpyf6n2shjttx/S/ERvk0WRgn+itWyKchiZ2B7ZHEJ2mmw27mtrjhhBlXHfLn2IaBe54W1mIKRjsNYaaYBKultqJIEMT5EuJvPSja/E700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889117; c=relaxed/simple;
	bh=IVQxVjxc4z1K0/u4zAAKxwl6Gk16icCKaP5SPNOFg7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mp4pgq+UiZANqLx2jrc5lsq4utcGYqIuF5zjhtiLNgv4P8Z135blcVxM6K5Fd+lxZM9gcSbQyXHctlJWCqQl5HE8VEMM+60J7rzwC/GppKyqZIfZ6sHqC1bail3wXWhLIfbO8HDef6GslkQg2At6JsjPObNpGDs3j3gDDGTmc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InNmF67p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED95C116D0;
	Tue, 11 Nov 2025 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762889116;
	bh=IVQxVjxc4z1K0/u4zAAKxwl6Gk16icCKaP5SPNOFg7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InNmF67phlhuM6WWZ4+J6R8uAQd81jpDlr+axxDpPgqIU9fLR7LDlKjYmLIDhRKWy
	 hjIowlPR4d5CDJ9ppWpPMmAmbxyJDv4RNqZgrxyn3CGDRVtmwCyXRfmS1z/TYUIa6C
	 DJ/agAs4n5OhsmL2nIayLm4q9tRDmozrb5DqdU23cuKR/YbHztfKzduf7jA2xssrS1
	 UNIf/fznf8r3W+mYhBW3OiFojs1/tL/xCUuluOrhqLH9varbDw+4tW0G2shAVwugLk
	 v3zxqRKsT1/XeKMVskHn3tM28wCvXOt9jbsNwwjUT5WHlYpn6P3793kDDdp4OQ504x
	 GyLah0d2t0x4g==
Date: Tue, 11 Nov 2025 19:25:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 10/12] iio: dac: ad5446: Refactor header inclusion
Message-ID: <20251111192510.15cedf67@jic23-huawei>
In-Reply-To: <aRDsU-Zy49vm7N0R@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-10-6fe35458bf8c@analog.com>
	<aQpE0_-YVeHmfL2v@smile.fi.intel.com>
	<20251109163030.66ad74fa@jic23-huawei>
	<aRDsU-Zy49vm7N0R@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Nov 2025 21:32:35 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Nov 09, 2025 at 04:30:30PM +0000, Jonathan Cameron wrote:
> > On Tue, 4 Nov 2025 20:24:19 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > On Tue, Nov 04, 2025 at 03:35:15PM +0000, Nuno S=C3=A1 via B4 Relay w=
rote: =20
>=20
> ...
>=20
> > > > +#include <linux/export.h>
> > > >  #include <linux/iio/iio.h>
> > > > +#include <linux/kstrtox.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > +#include <linux/sysfs.h>   =20
> > >=20
> > > Most likely the types.h is missing and maybe more... =20
> >=20
> > Looks like types.h belongs only in the header. =20
>=20
> Hmm... IIRC my suggestion was based on seeing one of uXX/sXX in the code,
> but now I lost the context and maybe I memorised that wrongly.
>=20
> > FWIW I ran iwyu against this with my usual iio.imp file
> > (shared previously on list)
> >=20
> > drivers/iio/dac/ad5446.h should add these lines:
> > #include <linux/compiler.h>  // for __aligned
> > #include <linux/minmax.h>    // for __cmp_op_max
> > #include <linux/stddef.h>    // for NULL
> >=20
> > drivers/iio/dac/ad5446.h should remove these lines:
> >=20
> > The full include-list for drivers/iio/dac/ad5446.h:
> > #include <linux/bits.h>      // for BIT
> > #include <linux/compiler.h>  // for __aligned
> > #include <linux/iio/iio.h>   // for IIO_DMA_MINALIGN, iio_chan_spec
> > #include <linux/minmax.h>    // for __cmp_op_max
> > #include <linux/mutex.h>     // for mutex
> > #include <linux/stddef.h>    // for NULL
> > #include <linux/types.h>     // for __be16, u16, u8
> > struct device;  // lines 10-10
> > ---
> >=20
> > So maybe those 3 extra in the header  but seem not much needed in the c=
 file.
> >=20
> > Hence applied with the compiler.h one added to the header.
> > Whereever that minmax is coming from is burried deep in macro
> > so probably isn't appropriate anyway =20
>=20
> If we use min()/max() or something from there it relies on the __cmp_op_m=
ax(),
> so probably it's needed.

That was where I got stuck.  Neither min nor max is used in this file.
Anyhow, I played guess where it might be.
I think it is probablythe MAX() call in iio.h (which includes minmax.h)
Hence I'm not bothered about that being included directly in this c file.

If anyone can spot a more direct use then shout and I'll be happy to add
that include.

Jonathan


>=20
> > and including stddef for NULL seems over the top. =20
>=20


