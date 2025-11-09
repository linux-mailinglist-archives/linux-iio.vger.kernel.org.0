Return-Path: <linux-iio+bounces-26092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62AC4425B
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E364C4E1D9A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B94303A16;
	Sun,  9 Nov 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYMOE2Z3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA401FAC42;
	Sun,  9 Nov 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762705837; cv=none; b=K+APa92zJWwMbMd/PRXB4UY0VyGzwC2oooHExUDCDWUmR0ZWDRdUIIi/ABezODY+hDhMmBhq7MLobcHDJuT7sMSXxSSKrQ1PAxvaLIqTCAOJxLnACP9JaQCvGOH2iZ63CQyym3sFsozBwdMro7Da2Vr+wjjggOScbhtBZpf3N6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762705837; c=relaxed/simple;
	bh=GQOYC53N5CzlfoyKniuKwA7c2+W3Yoa2YxAso2W0plk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmrV0zJeEVo9/3l9Ktse0jamqBiC3TR59Oel0IAMqsjNtSaOIT3dKCKn4tDwTBJrmKNROzO7c78ng/6gOvWDlxJpSa9069KpzsNchc0+ltjtyoRuCWk24TpTViHe7MSV+43X9fc5EqaZT01IiJ6mY+UrH9iIPSRy4Ctx5vm+K10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYMOE2Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B97DC19425;
	Sun,  9 Nov 2025 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762705837;
	bh=GQOYC53N5CzlfoyKniuKwA7c2+W3Yoa2YxAso2W0plk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LYMOE2Z3ReasZlYAWJC+Ep0D8Yq0hXBTXxB2o9GI7s1+FlSw8dlQRgo3rvfox3FQJ
	 ZSVdFKtC2A9diUlTz+ZEJxyJhCiMu0VcRRixzHsg0LxJrnW8KtLGuziVwrzoG/uzDS
	 h+hqzJnIfmc95XiZ2aCyLx6By3jujE+QuSh0Qm4Eawd/HTWXd3S5IYQtWrvg86GqZd
	 PIcWRRVhcoHhZ1mJTnr9m9bFID2eB8+vSpR2Kuk29WBCEjHAhEhAdMwk2AX9sNxCZY
	 unwuPXbywW/qooEMWkX7yHXaATMRo7h4mOaGWjfQeAWq48cU1iT/SV7Y8pbWO/S2mO
	 AhtNRGsHgerCQ==
Date: Sun, 9 Nov 2025 16:30:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 10/12] iio: dac: ad5446: Refactor header inclusion
Message-ID: <20251109163030.66ad74fa@jic23-huawei>
In-Reply-To: <aQpE0_-YVeHmfL2v@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-10-6fe35458bf8c@analog.com>
	<aQpE0_-YVeHmfL2v@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 20:24:19 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 04, 2025 at 03:35:15PM +0000, Nuno S=C3=A1 via B4 Relay wrote:
> >=20
> > Make sure include files are given in alphabetical order and that we inc=
lude
> > the ones that were missing and remove the ones we don't really use. =20
>=20
> ...
>=20
> > +#include <linux/export.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/kstrtox.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/sysfs.h> =20
>=20
> Most likely the types.h is missing and maybe more...
>=20

Looks like types.h belongs only in the header.

FWIW I ran iwyu against this with my usual iio.imp file
(shared previously on list)

drivers/iio/dac/ad5446.h should add these lines:
#include <linux/compiler.h>  // for __aligned
#include <linux/minmax.h>    // for __cmp_op_max
#include <linux/stddef.h>    // for NULL

drivers/iio/dac/ad5446.h should remove these lines:

The full include-list for drivers/iio/dac/ad5446.h:
#include <linux/bits.h>      // for BIT
#include <linux/compiler.h>  // for __aligned
#include <linux/iio/iio.h>   // for IIO_DMA_MINALIGN, iio_chan_spec
#include <linux/minmax.h>    // for __cmp_op_max
#include <linux/mutex.h>     // for mutex
#include <linux/stddef.h>    // for NULL
#include <linux/types.h>     // for __be16, u16, u8
struct device;  // lines 10-10
---

(drivers/iio/dac/ad5446.c has correct #includes/fwd-decls)

(drivers/iio/dac/ad5446-spi.c has correct #includes/fwd-decls)

(drivers/iio/dac/ad5446-i2c.c has correct #includes/fwd-decls)


So maybe those 3 extra in the header  but seem not much needed in the c fil=
e.

Hence applied with the compiler.h one added to the header.
Whereever that minmax is coming from is burried deep in macro
so probably isn't appropriate anyway and including stddef for NULL seems
over the top.


Jonathan


