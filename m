Return-Path: <linux-iio+bounces-11793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C092B9B94A8
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C801F2218E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E491C7B9C;
	Fri,  1 Nov 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVs0UfvS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C8B2CAB;
	Fri,  1 Nov 2024 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475905; cv=none; b=OAn+tYqslvWiI2deUUkmXgRM8IlHLBuiUCshsNB19SwQiQhCGf0H9RnyNesBOSq3QQ0wm1d7J18ouE53PvHtIips8M/KAQUjE0GKuqXbPatOrvO8Cf9bzyR6YSccboIaONReNpZBddoLt0be4ybejp5ctwp/hNdVyXet3hxhwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475905; c=relaxed/simple;
	bh=t1pJkvv5ArO95EBUpDZbdsLDepiY0M1etPEVdzcYgMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuTpVe0gHuiW9bAKxx+aqJGGjFtbOLyUJEG+mp02mb/svoPhoPjuMaJv10/0f+XIhchqbu4f5bFHrOfDKOqBhPn76mA07A5cFuONakg/ZSrrmpFIFQHwf2sXZ3MDgvhgIjGMtUC+xc55Fe5nCOSmL0t7qhzp8moogFIOk57o4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVs0UfvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA75C4CECD;
	Fri,  1 Nov 2024 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475904;
	bh=t1pJkvv5ArO95EBUpDZbdsLDepiY0M1etPEVdzcYgMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVs0UfvSjddoObL1YP4TcTpN6+JMKTAlMOtHqoNu/N5W++S8ZoFPFicaoCsigBZWY
	 tzsC/HX9IzAFBDK7yJ0jUUgykge+QshPJphUaXyfeUUF+JuEpS/o/COytqjHhw6bfk
	 Puqx0C4Dn8D1jyyOrR697msu4an59gWO287LimKF2sfZWd8QG8Johu2Ruz2CxZ96Mr
	 96oWxW1+Q0h3FQJIq3Euy8DNRcTjyRLRpuV3HXN/mRruETfNZ8TVV/wuABpuviyGn+
	 5gMXDGfb2eU9CbNsoC5MxD6+lYem2NKv3+WKaecfvPJz1LBb1ZEvgNrUSeIb6LtuMV
	 +upizTDVi/RKg==
Date: Fri, 1 Nov 2024 15:44:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Mudit Sharma
 <muditsharma.info@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Anshul
 Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Dan Robertson <dan@dlrobertson.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit
 Ghosh <subhajit.ghosh@tweaklogic.com>, Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 06/15] iio: light: adux1020: write_event_config: use
 local variable for interrupt value
Message-ID: <20241101154451.227defba@jic23-huawei>
In-Reply-To: <ef4fe230-b7fb-4f7e-9173-ae85d305e9ae@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
	<ef4fe230-b7fb-4f7e-9173-ae85d305e9ae@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Oct 2024 11:27:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/31/24 10:27 AM, Julien Stephan wrote:
> > state parameter is currently an int, but it is actually a boolean.
> > iio_ev_state_store is actually using kstrtobool to check user input,
> > then gives the converted boolean value to write_event_config.  The code
> > in adux1020_write_event_config re-uses state parameter to store an
> > integer value. To prepare for updating the write_event_config signature
> > to use a boolean for state, introduce a new local int variable.
> >=20
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  drivers/iio/light/adux1020.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> > index 2e0170be077aef9aa194fab51afbb33aec02e513..db57d84da616b91add8c5d1=
aba08a73ce18c367e 100644
> > --- a/drivers/iio/light/adux1020.c
> > +++ b/drivers/iio/light/adux1020.c
> > @@ -505,7 +505,7 @@ static int adux1020_write_event_config(struct iio_d=
ev *indio_dev,
> >  				       enum iio_event_direction dir, int state)
> >  {
> >  	struct adux1020_data *data =3D iio_priv(indio_dev);
> > -	int ret, mask;
> > +	int ret, mask, val;
> > =20
> >  	mutex_lock(&data->lock);
> > =20
> > @@ -526,12 +526,12 @@ static int adux1020_write_event_config(struct iio=
_dev *indio_dev,
> >  			mask =3D ADUX1020_PROX_OFF1_INT;
> > =20
> >  		if (state)
> > -			state =3D 0;
> > +			val =3D 0;
> >  		else
> > -			state =3D mask;
> > +			val =3D mask;
> > =20
> >  		ret =3D regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
> > -					 mask, state);
> > +					 mask, val);
> >  		if (ret < 0)
> >  			goto fail;
> > =20
> >  =20
>=20
> Instead of introducing `val`, I would rewrite this as:
>=20
> 	if (state)
> 		ret =3D regmap_clear_bits(...);
> 	else
> 		ret =3D regmap_set_bits(...);
>=20
Good idea.  Rather than go around again and potentially stall the end of th=
is series.
I made that change whilst applying.  Shout if either of you doesn't
like the result. Diff doesn't do a perfect job on readability (it does
if I add a line break but then the code looks worse in the end!)

=46rom 06a1ca816450d1b5524f6010581a83ab9935d51b Mon Sep 17 00:00:00 2001
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:01 +0100
Subject: [PATCH] iio: light: adux1020: write_event_config: use local variab=
le
 for interrupt value

state parameter is currently an int, but it is actually a boolean.
iio_ev_state_store is actually using kstrtobool to check user input,
then gives the converted boolean value to write_event_config.  The code
in adux1020_write_event_config re-uses state parameter to store an
integer value. To prepare for updating the write_event_config signature
to use a boolean for state, introduce a new local int variable.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Link: https://patch.msgid.link/20241031-iio-fix-write-event-config-signatur=
e-v2-6-2bcacbb517a2@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/adux1020.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 2e0170be077a..06d5bc1d246c 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -526,12 +526,11 @@ static int adux1020_write_event_config(struct iio_dev=
 *indio_dev,
 			mask =3D ADUX1020_PROX_OFF1_INT;
=20
 		if (state)
-			state =3D 0;
+			ret =3D regmap_clear_bits(data->regmap,
+						ADUX1020_REG_INT_MASK, mask);
 		else
-			state =3D mask;
-
-		ret =3D regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
-					 mask, state);
+			ret =3D regmap_set_bits(data->regmap,
+					      ADUX1020_REG_INT_MASK, mask);
 		if (ret < 0)
 			goto fail;
=20
--=20
2.46.2



>=20
>=20


