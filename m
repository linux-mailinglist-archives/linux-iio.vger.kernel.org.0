Return-Path: <linux-iio+bounces-3403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A64877272
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30791F21BB2
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC607200A6;
	Sat,  9 Mar 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvB46gNj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F32901
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710005216; cv=none; b=rUgWVg/X5zl5kzdU2B4x8P/x8AKfFw9WEpY+BZy972TjgXP1nXy/0Q19hNUxYmebpTyEbXqHxAGivDG1PNr4WYPKLDJ+uYnOWnX31gjdjKtT5zmjjL7RSnz6aIf1ZOZaOPo5r13U0JAkYeY54cSvQRhuCAra5tqtjqs0t5cat+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710005216; c=relaxed/simple;
	bh=qhhvF1Q75p+ohp1iQJTGGgB80vP99ur+R9qs8vf7fxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iykGrgr7v/M8+zuV0ij1epbDWmW9Y1sqIgKPguNQVhqrON/JuIjKJ8pKxBMbqaGNs7jzS58C5e+m+6SnL6xgViuI+gZHJYfHaMkLXuozRBRmH+v2aZPWgncGrTRZC7iY1E10NuXL79y/632yq+V21ZVmZfs/MgPrZh/VBxMEFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvB46gNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7CFC433C7;
	Sat,  9 Mar 2024 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710005216;
	bh=qhhvF1Q75p+ohp1iQJTGGgB80vP99ur+R9qs8vf7fxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvB46gNjkbZGb54U4EgwAU+Ut57livH+W30pBtF6OBWTqi1zFyJ25N+KfXarlehn8
	 aWRl9w1RInn8hOrQJulDI0VTgs6B3Bn0FDEFvyPeBrWoRWBlHeocFW8CaPlBTNpVBM
	 X6i2p98EluhG9g9xMIf7QnptA2QNmuqbPcBSSI2VKQxQIzLzlJRI15DQlLOCEBUMBF
	 5Jl9CIF785LAfnKG00ytSDVZhLjANDmr8JQyo6Rio6OVh9iuVAj0J5rOMplMO2U++1
	 iRRV7lUZ2Pt53qe4l5aTv+JPmHTNcITa0/QsrTYTUhf4KuhFKY1n+skqHkgljirHSv
	 EJnSMnwmgUojA==
Date: Sat, 9 Mar 2024 17:26:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com
Subject: Re: [PATCH] iio: dac: ad5755: fix unised of_match table
Message-ID: <20240309172645.2273b8fb@jic23-huawei>
In-Reply-To: <e0bee548-9a62-469a-8c2c-9548626616d6@codethink.co.uk>
References: <20240308181411.1916460-1-ben.dooks@codethink.co.uk>
	<e0bee548-9a62-469a-8c2c-9548626616d6@codethink.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Mar 2024 18:55:09 +0000
Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> On 08/03/2024 18:14, Ben Dooks wrote:
> > If the ad5755 is not being built as a module, then we get an unused war=
ning
> > about the ad5755_of_match[] array as this is only used by the macro
> > MODULE_DEVICE_TABLE. Fix this by adding an #ifdef MODULE around it to
> > silence:
> >=20
> > drivers/iio/dac/ad5755.c:866:34: warning: =E2=80=98ad5755_of_match=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
> >    866 | static const struct of_device_id ad5755_of_match[] =3D {
> >=20
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> >   drivers/iio/dac/ad5755.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> > index 404865e35460..fb99c8472788 100644
> > --- a/drivers/iio/dac/ad5755.c
> > +++ b/drivers/iio/dac/ad5755.c
> > @@ -863,6 +863,7 @@ static const struct spi_device_id ad5755_id[] =3D {
> >   };
> >   MODULE_DEVICE_TABLE(spi, ad5755_id);
> >  =20
> > +#ifndef MODULE =20
>=20
> Just noticed the use of ifnded instead of ifdef here. Will fix Monday.

Krzystof posted a different fix for this a while back but that had some iss=
ues.
https://lore.kernel.org/linux-iio/20240226192555.14aa178e@jic23-huawei/

The simple fix is just hook up the of_device_match pointer.
But to use the general data matching from spi_get_device_match_data()
the data needs to change to be pointers and not enums hammered into a point=
er.
I'm really not keen on the horrible workaround of avoiding the enum value o=
f 0.

So this needs a more complex fix in general - for now we can get away with
using the table and the fallback stuff that relies on the of_device_id
and spi_device_id table entries matching but that is fragile.



>=20
> >   static const struct of_device_id ad5755_of_match[] =3D {
> >   	{ .compatible =3D "adi,ad5755" },
> >   	{ .compatible =3D "adi,ad5755-1" },
> > @@ -872,6 +873,7 @@ static const struct of_device_id ad5755_of_match[] =
=3D {
> >   	{ }
> >   };
> >   MODULE_DEVICE_TABLE(of, ad5755_of_match);
> > +#endif
> >  =20
> >   static struct spi_driver ad5755_driver =3D {
> >   	.driver =3D { =20
>=20


