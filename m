Return-Path: <linux-iio+bounces-26841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B2CAABD7
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC3D304B01C
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571902BF013;
	Sat,  6 Dec 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uARSF4eq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AB248896;
	Sat,  6 Dec 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765044358; cv=none; b=krla5HobIhGz+oxkcmDchG67wBqJGTZ3BeSRnl8IQCEimrAfZT7IkKpTLrIwVIw0NAork6LfnW/Q9tdXBGmNr+CD64tbosQSuPQkcZd9wMjJbXI+oJX+4Et/dCjEvVf6Vw/mfCk7TxAO1k6K+4PlCbR5aAJROK87uEV04kiEouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765044358; c=relaxed/simple;
	bh=mcqqTpjMRL5EDmOhkps2FcESzpOjLPfEUL/3Vjyc4Og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0YwhgGAl0ttjti2v7sHIBgSuBxKyByTJzGty4cDNywEZj8pFWu1xWU52Ak+yNkBXhymSvMPMaPqU6j8mZ/nO5mQldY8ehpXVyQFSdd0nF3j20TfLJSFq2hDgcsK6nkLcfYvP0vK38BHCY+FHpWQV9UZd83yJnUbsV7mSggyPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uARSF4eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24715C4CEF5;
	Sat,  6 Dec 2025 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765044357;
	bh=mcqqTpjMRL5EDmOhkps2FcESzpOjLPfEUL/3Vjyc4Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uARSF4eqGQL2f38ci+1YBurowoJKSH7hJ3sQFwiP504X37u3TEn8fmCHmlAtmJyFi
	 5nrWgLjXDf9/ggyD9umFkLMTACxldt0SAUkrHulJzQsnWOwSo4lGcht8ior8RtxalX
	 yG9sHAInnRKmL+eGHmgKY1TmxNhhZLsCO8/yhCPyKYDIAD/cr/YZJgtOuE6DgSlSX3
	 vx7brcF4EdmB5xiGnmfajI/7MTFwjAGWi/MenTX+/nRz14UByIi5G4bnx4I3bAJQWO
	 D8RIvli49z5liBO5MXurDtIOp9Fa34I4ykCi8ZBj3aMif5cpKBWBaS/WnhDgzqSgud
	 9yRs2cTuZzqVA==
Date: Sat, 6 Dec 2025 18:05:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung
 <bleung@chromium.org>, Antoniu Miclaus	 <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck 
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH RFC 1/6] iio: core: Match iio_device_claim_*() return
 semantics
Message-ID: <20251206180546.2a8b8780@jic23-huawei>
In-Reply-To: <9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	<20251203-lock-impr-v1-1-b4a1fd639423@gmail.com>
	<9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Dec 2025 14:23:19 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
> > In order to improve API consistency with conditional locks, use
> > true/false return semantics in iio_device_claim_buffer_mode().
> >=20
> > This also matches iio_device_claim_direct() return semantics.
> >=20
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > --- =20
>=20
> Even if the rest gets a NACK, I think at least this patch makes sense. In=
 fact I
> would even extend it so that we have the same inline API with proper anno=
tations:
>=20
> https://elixir.bootlin.com/linux/v6.18/source/include/linux/iio/iio.h#L679
>=20
> So it really has the same semantics as iio_device_claim_direct()

Yeah. This was on my mental todo list. So great to see Kurt
dealing with it! :)  These calls are much rarer than the direct ones
so I wasn't so fussed about getting the sparse coverage. Makes
sense to do it just wasn't high priority.

As Nuno, suggested though I would like the sparse support for these.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> > =C2=A0drivers/iio/adc/ade9000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> > =C2=A0drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 +--=
--
> > =C2=A0drivers/iio/health/max30100.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0drivers/iio/health/max30102.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
> > =C2=A0drivers/iio/light/opt4060.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 +-
> > =C2=A07 files changed, 10 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> > index 2de8a718d62a..b345c4d1ef24 100644
> > --- a/drivers/iio/adc/ade9000.c
> > +++ b/drivers/iio/adc/ade9000.c
> > @@ -964,7 +964,7 @@ static irqreturn_t ade9000_dready_thread(int irq, v=
oid *data)
> > =C2=A0	struct iio_dev *indio_dev =3D data;
> > =C2=A0
> > =C2=A0	/* Handle data ready interrupt from C4/EVENT/DREADY pin */
> > -	if (!iio_device_claim_buffer_mode(indio_dev)) {
> > +	if (iio_device_claim_buffer_mode(indio_dev)) {
> > =C2=A0		ade9000_iio_push_buffer(indio_dev);
> > =C2=A0		iio_device_release_buffer_mode(indio_dev);
> > =C2=A0	}
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 9ac80e4b7d75..8ed4b2e410c8 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -188,11 +188,8 @@ int cros_ec_sensors_push_data(struct iio_dev *indi=
o_dev,
> > =C2=A0	/*
> > =C2=A0	 * Ignore samples if the buffer is not set: it is needed if the =
ODR is
> > =C2=A0	 * set but the buffer is not enabled yet.
> > -	 *
> > -	 * Note: iio_device_claim_buffer_mode() returns -EBUSY if the buffer
> > -	 * is not enabled.
> > =C2=A0	 */
> > -	if (iio_device_claim_buffer_mode(indio_dev) < 0)
> > +	if (!iio_device_claim_buffer_mode(indio_dev))
> > =C2=A0		return 0;
> > =C2=A0
> > =C2=A0	out =3D (s16 *)st->samples;
> > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max3010=
0.c
> > index 3d441013893c..3f3680c4b42f 100644
> > --- a/drivers/iio/health/max30100.c
> > +++ b/drivers/iio/health/max30100.c
> > @@ -417,7 +417,7 @@ static int max30100_read_raw(struct iio_dev *indio_=
dev,
> > =C2=A0		 * Temperature reading can only be acquired while engine
> > =C2=A0		 * is running
> > =C2=A0		 */
> > -		if (iio_device_claim_buffer_mode(indio_dev)) {
> > +		if (!iio_device_claim_buffer_mode(indio_dev)) {
> > =C2=A0			/*
> > =C2=A0			 * Replacing -EBUSY or other error code
> > =C2=A0			 * returned by iio_device_claim_buffer_mode()
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max3010=
2.c
> > index a48c0881a4c7..288c2f37a4a2 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -476,7 +476,7 @@ static int max30102_read_raw(struct iio_dev *indio_=
dev,
> > =C2=A0		 * shutdown; leave shutdown briefly when buffer not running
> > =C2=A0		 */
> > =C2=A0any_mode_retry:
> > -		if (iio_device_claim_buffer_mode(indio_dev)) {
> > +		if (!iio_device_claim_buffer_mode(indio_dev)) {
> > =C2=A0			/*
> > =C2=A0			 * This one is a *bit* hacky. If we cannot claim buffer
> > =C2=A0			 * mode, then try direct mode so that we make sure
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index f69deefcfb6f..a10590ac4e17 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -2224,19 +2224,19 @@ EXPORT_SYMBOL_GPL(__iio_device_release_direct);
> > =C2=A0 *
> > =C2=A0 * Use with iio_device_release_buffer_mode().
> > =C2=A0 *
> > - * Returns: 0 on success, -EBUSY on failure.
> > + * Returns: true on success, false on failure.
> > =C2=A0 */
> > -int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> > +bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> > =C2=A0{
> > =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indi=
o_dev);
> > =C2=A0
> > =C2=A0	mutex_lock(&iio_dev_opaque->mlock);
> > =C2=A0
> > =C2=A0	if (iio_buffer_enabled(indio_dev))
> > -		return 0;
> > +		return true;
> > =C2=A0
> > =C2=A0	mutex_unlock(&iio_dev_opaque->mlock);
> > -	return -EBUSY;
> > +	return false;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
> > =C2=A0
> > diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> > index 981c704e7df5..8cb3fa38077e 100644
> > --- a/drivers/iio/light/opt4060.c
> > +++ b/drivers/iio/light/opt4060.c
> > @@ -304,7 +304,7 @@ static int opt4060_set_driver_state(struct iio_dev =
*indio_dev,
> > =C2=A0	struct opt4060_chip *chip =3D iio_priv(indio_dev);
> > =C2=A0	int ret =3D 0;
> > =C2=A0any_mode_retry:
> > -	if (iio_device_claim_buffer_mode(indio_dev)) {
> > +	if (!iio_device_claim_buffer_mode(indio_dev)) {
> > =C2=A0		/*
> > =C2=A0		 * This one is a *bit* hacky. If we cannot claim buffer mode,
> > =C2=A0		 * then try direct mode so that we make sure things cannot
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 872ebdf0dd77..bf7b7337ff1b 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -687,7 +687,7 @@ static inline void iio_device_release_direct(struct=
 iio_dev *indio_dev)
> > =C2=A0	__release(indio_dev);
> > =C2=A0}
> > =C2=A0
> > -int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> > +bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> > =C2=A0void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
> > =C2=A0
> > =C2=A0extern const struct bus_type iio_bus_type; =20


