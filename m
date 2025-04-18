Return-Path: <linux-iio+bounces-18252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990CA938D5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8688B8E0D75
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9577E1A8F68;
	Fri, 18 Apr 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0lo+pyc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEC8F49;
	Fri, 18 Apr 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987612; cv=none; b=RTQ4NrlY9Yl/GgBwoolfEtwUsXKPzZarRXwQmHisDoQwi+8CbBgxjbFYXo2qzLGk84loyWswlLrj9mXuVGpVijg7DjoZrkZKCLUhmT1e1WImk8q+TUDkKpAWHDK7sNwt1llM6yRDaWDschBBf2lBfEah38f7bfU+HNhAA9/sxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987612; c=relaxed/simple;
	bh=5a8es+dGqoWzvZRG72BP+Tii3vAYyV3WD+yVJH2N8VY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5EfmwuHE8eE6LLQnsg0SewoztCCCMnn++wdZOyGyWFJUP5KdZb80f2jEa4bWGbf3A6s4iqWU+EnoA0asu3fObYnSHK83QC9/GymJsZ/NL3SfovgOMzQ2iziw0SFtjRl7SWlO7eYw2gd0La/gkdVxb8OVjdzSEGQVEwjqKcXwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0lo+pyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF95C4CEE2;
	Fri, 18 Apr 2025 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744987611;
	bh=5a8es+dGqoWzvZRG72BP+Tii3vAYyV3WD+yVJH2N8VY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0lo+pyc59zklEQ1VhjL78cRV7IzRREb/PqeQuX7c7lN1UI0U6opronFmJqw03IFH
	 qhi8w8Su/KbAxKHSZSa0TpDLoOvOxJ+q+O903X156V/QOUV6EHHmknLm6gx9BdoxuS
	 ji+0epLMGJXSShNJPDKLkl5C1xs8gaMvEzQ0T5XXmdtMu16L6id8bUerk/6I1F3FuE
	 JiNdpRIth/fye2jEFhLedT419xj3EpRh6aLgzPLwemKjy4m0WNq9U8RPROR86x1hMu
	 8lAQbXPKqNGautan0WAWHrXvdxsYUwAXsiWLj+BOOS2Q50XhhrX7UBBT6dEjMsiqeH
	 puBa/EeMfdF/Q==
Date: Fri, 18 Apr 2025 15:46:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, Petre
 Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/8] iio: addac: ad74413r: use aligned_s64 for timestamp
Message-ID: <20250418154642.41cb9d80@jic23-huawei>
In-Reply-To: <057bec6375819c3a4cd227c20a60ec1dbb7405c3.camel@gmail.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-3-eafac1e22318@baylibre.com>
	<057bec6375819c3a4cd227c20a60ec1dbb7405c3.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 09:57:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> > Follow the pattern of other drivers and use aligned_s64 for the
> > timestamp. Technically there was no issue here since
> > AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX =3D=3D 16 and IIO_DMA_MINALI=
GN
> > is always a multiple of 8. But best to conform in case someone copies
> > this to new code and then tweaks something.
> >=20
> > Also move the unaligned.h header while touching this since it was the
> > only one not in alphabetical order.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.
>=20
> > =C2=A0drivers/iio/addac/ad74413r.c | 5 +++--
> > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> > index
> > f0929616ab899cb374f00869787321eed4ccde16..a0bb1dbcb7ad9d02337d0990e5a3f=
90be7eaa4ac
> > 100644
> > --- a/drivers/iio/addac/ad74413r.c
> > +++ b/drivers/iio/addac/ad74413r.c
> > @@ -4,7 +4,6 @@
> > =C2=A0 * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > =C2=A0 */
> > =C2=A0
> > -#include <linux/unaligned.h>
> > =C2=A0#include <linux/bitfield.h>
> > =C2=A0#include <linux/cleanup.h>
> > =C2=A0#include <linux/crc8.h>
> > @@ -24,6 +23,8 @@
> > =C2=A0#include <linux/regmap.h>
> > =C2=A0#include <linux/regulator/consumer.h>
> > =C2=A0#include <linux/spi/spi.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> > =C2=A0
> > =C2=A0#include <dt-bindings/iio/addac/adi,ad74413r.h>
> > =C2=A0
> > @@ -84,7 +85,7 @@ struct ad74413r_state {
> > =C2=A0	 */
> > =C2=A0	struct {
> > =C2=A0		u8 rx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
> > -		s64 timestamp;
> > +		aligned_s64 timestamp;
> > =C2=A0	} adc_samples_buf __aligned(IIO_DMA_MINALIGN);
> > =C2=A0
> > =C2=A0	u8	adc_samples_tx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX=
];
> >  =20
>=20


