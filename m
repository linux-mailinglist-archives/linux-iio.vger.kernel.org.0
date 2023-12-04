Return-Path: <linux-iio+bounces-603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04904803AD7
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3496280F98
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9DC2E417;
	Mon,  4 Dec 2023 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba7t9+j+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A465241FD;
	Mon,  4 Dec 2023 16:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BDCC433C7;
	Mon,  4 Dec 2023 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701708700;
	bh=fFXmEBT5AMl/e+v8v12kevHaf03zfjvJ1t3IxHwqbNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ba7t9+j+aC25aU7nX6xksyw/rfPPpMj8n/VfYLO3TpnArg0UAv+E45421nE8y0/MD
	 X/gOjv+U2EF1gFDddOk4wwf1RH2PkfuK7S4A0l8V4DZOOM/QRmWZRuQKeIdMjPjZYq
	 +48Nn6abrEeP3GxF0y2czaNjOvlsx+Ui2CNXmL9ztENe4cWVShNwgwUtcIvaZRd+C3
	 XVe9xHXL0/5+Mzx3NiNSr+N8KWkW6mUYUAEP0ZT4EK+qFJsLUbcDyBSSap4l6FeqAV
	 FWW4fvXp4I65VA03n8S1icgb0ke9JYVz+nBnRAdwp7ekbD+PKW0ugEa0hGxlwpX3FH
	 lc0IBcv3zSBww==
Date: Mon, 4 Dec 2023 16:51:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa via B4 Relay  <devnull+nuno.sa.analog.com@kernel.org>,
 nuno.sa@analog.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct
 ad9467_state
Message-ID: <20231204165129.130e189c@jic23-huawei>
In-Reply-To: <69a7ca77055fc57cff6d6be95fb5796723171230.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
	<20231204152301.6c212539@jic23-huawei>
	<69a7ca77055fc57cff6d6be95fb5796723171230.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 04 Dec 2023 17:10:01 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-12-04 at 15:23 +0000, Jonathan Cameron wrote:
> > On Tue, 21 Nov 2023 11:20:19 +0100
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> > > are done which means we need to properly protect the whole operation =
so
> > > we are sure we will be in a sane state if two concurrent calls occur.
> > >=20
> > > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad9467.c | 6 +++++-
> > > =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index 04474dbfa631..91821dee03b7 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c
> > > @@ -4,7 +4,7 @@
> > > =C2=A0 *
> > > =C2=A0 * Copyright 2012-2020 Analog Devices Inc.
> > > =C2=A0 */
> > > -
> > > +#include <linux/cleanup.h>
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/mutex.h>
> > > =C2=A0#include <linux/device.h>
> > > @@ -122,6 +122,8 @@ struct ad9467_state {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0output_mode;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct gpio_desc=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0*pwrdown_gpio;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* protect against concurr=
ent accesses to the device */ =20
> > Not very specific.=C2=A0 Concurrent access usually fine at granularity =
of
> > individual read/write as the bus locks protect it.=C2=A0 What state
> > is actually being protected?=C2=A0 A shared buffer or some state that we
> > need to ensure remains consistent between driver and device? =20
>=20
> At this point not any buffer/data... Just making sure things remain consi=
stent
> (typical case when you have multiple reads/writes to the device). That's =
why a tried
> to emphasize "accesses to the device". Maybe I should make it explicit I'=
m speaking
> about multiple reads/writes.

Talk about the data or state rather than the access to it.
Something like
'ensure consistent state obtained on multiple related accesses.'
Or if it's RMW then say that.
>=20
> - Nuno S=C3=A1
> >  =20
>=20


