Return-Path: <linux-iio+bounces-16696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6FDA5A457
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504EE189025F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9880D1D5CDB;
	Mon, 10 Mar 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/v8oSBx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D611CAA6E
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637075; cv=none; b=EITn7aRhGYQpMT6/YweActr8loT41Tf9wGsYGXng0cJlFsuwFH3lNTulrH9759w+SyKgdWt7nnigT5oqw0jmztmK16k3cno28Rt93/jXWo4UqDi/38tjSILaxdSm0JFWmtKpvolbt1mnMX1Ly9De3hg0egh+bBKXj5CAwroSglc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637075; c=relaxed/simple;
	bh=1S2hwOttf8VuijoguOdEeT5Z/x1HPcBUirBpIZq4IN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFUZGQOtlKaJb7ir5KBcyirsBYJCtCuw8OFZ2fm+afQxJ5OcP3XEgrsxMCu71TKb50DkJs7Ca/ernC38RFz3RTGExmlwkc7WeOwfXKYp9ItMWsEa1tPwZHVKBaP2OVrM7vl25y5YgztcSc9cm5scu4P3kneCdshNJPlYqwwdhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/v8oSBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FDAC4CEE5;
	Mon, 10 Mar 2025 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637074;
	bh=1S2hwOttf8VuijoguOdEeT5Z/x1HPcBUirBpIZq4IN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/v8oSBxuxR44qIRFPj2eRoSp5gXYsyZ3vILKXwco1+DUcS6luEXapP5pwxZ8DZRe
	 WM94YVBxom0/jVnyMCRTiH4VWALJYqWAXAFq01dCY+m8I3/BX5JOfJFf9lfGIc0uwI
	 JsqJ49c9qKt2InVYb1Dk8bgxM1YraicEEMUkWtg9xR8BOItEYnDjlnf/m2SNyFSMaZ
	 h/ZekIUzkW49SpcPhf5a1V2kWYBMKvarpxemzPXe/w6uzOfvpnQmnfqqxFCIKeWkI4
	 BYXNhjGr/FFLTESKfTZpdg+96JI5Mx+tZuRnEYgJWxtazvRjXKgEuCHYKYD/nDqCTW
	 TleA2W/zBxpeQ==
Date: Mon, 10 Mar 2025 20:04:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron  <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/16] iio: introduced iio_push_to_buffers_with_ts()
 that takes a total_len argument.
Message-ID: <20250310200427.634e9d2b@jic23-huawei>
In-Reply-To: <dce7a134576836f58c41d5a3cb3bf244f0f9c447.camel@gmail.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
	<20250309182100.1351128-2-jic23@kernel.org>
	<dce7a134576836f58c41d5a3cb3bf244f0f9c447.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Mar 2025 08:34:50 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2025-03-09 at 18:20 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Check that total_len argument against iio_dev->scan_bytes.
> >=20
> > The size needs to be at least as big as the scan. It can be larger,
> > which is typical if only part of fixed sized storage is used due to
> > a subset of channels being enabled.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > =C2=A0include/linux/iio/buffer.h | 13 +++++++++++++
> > =C2=A01 file changed, 13 insertions(+)
> >=20
> > diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> > index 3b8d618bb3df..75d5e58b646b 100644
> > --- a/include/linux/iio/buffer.h
> > +++ b/include/linux/iio/buffer.h
> > @@ -45,6 +45,19 @@ static inline int iio_push_to_buffers_with_timestamp=
(struct
> > iio_dev *indio_dev,
> > =C2=A0	return iio_push_to_buffers(indio_dev, data);
> > =C2=A0}
> > =C2=A0
> > +static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_de=
v,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data, size_t total_len,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t timestamp)
> > +{ =20
>=20
> Kind of a nitpick but what about data_len as the size relate to *data?
Maybe data_total_len? I kind of want to make people wonder what the total
is about and read the docs. Which I forgot to actually add :(
This has always been a quirky, non obvious interface.

>=20
> > +	if (total_len < indio_dev->scan_bytes) { =20
>=20
> Given this is to be called on a fastpath and that the above is clearly a =
bug,
> what do you think about unlikely(total_len < indio_dev->scan_bytes) for s=
ome
> micro optimization?

Fair point.  Probably never matters as any branch predictor ought to get th=
is
one quickly but it also acts as documentation so sure.

>=20
> Anyways, this looks like a nice API improvement to me!
>=20
> - Nuno S=C3=A1=20
> >  =20


