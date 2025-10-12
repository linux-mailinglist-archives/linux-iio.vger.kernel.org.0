Return-Path: <linux-iio+bounces-25011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F4BD0A63
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 21:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0710C1891DE2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C472EC55C;
	Sun, 12 Oct 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz2XUgfT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290D1FC0ED;
	Sun, 12 Oct 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760296080; cv=none; b=RKw2AGI2h5AtYViEbExJ4teQyZ9i4mNxlspGzcYJaIEjF/QIBFTvEpxVb0fN8VGl7fpOKJ54KCQa6hniNnDAjEkezBLzEZM8ySQfsEV4DehjT3byJLl4kWaqgXD+Izb7q3xZP7egRBm6KFeRFgdRIjWRqpenXAoVTkBGD6WrMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760296080; c=relaxed/simple;
	bh=BgkGPOSmpOseFVivt3bGQQp+/jvmcTLHOOQYbYf/O4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4jGxTylGR1DYfX2cWjNOhNGnNh+XAfj2KvM0v6ddQP1YR5VPXfMbfqg/ncMmEW9vULyoOMgawvKj29HMyKH7x0VNsdalQMtM7derf8nURxKwr7oD4+2aCxng25mWHsUObsW4iJ4BIi2/ByIqPHFrivUQQDgmb2B3jlrpHZRdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz2XUgfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CC9C4CEFE;
	Sun, 12 Oct 2025 19:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760296079;
	bh=BgkGPOSmpOseFVivt3bGQQp+/jvmcTLHOOQYbYf/O4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tz2XUgfTYj1Lrm1WOKffxF427uFwFKGspJG6Gv56YHsPWDV+mg1ZwVQCX45gu6BQ9
	 HlEvFCUVNdzjhDl+gn+hSdUzPnipyLQyM8wnCRcQHcGbqB4aN4nj1Dl7Dlnu4CcYDH
	 aYkshHpramSOLX/cV86ZpcFeqRkVPJtSppQXd7lU07DqBahNIsjkmekcaIII7a3LV9
	 SpyXoHzamjFoBwZ1lAi8TMaYeBXihk7Nb+H28pz9JuaDJpUWoefsIZu4FeuCkJH19x
	 df0VSG1gVCPQKrKzLP9pboIaugYm2G33tTVEa4KCFCuklgzGHSbs4kNRw1nUFj4eDQ
	 gznw25ZuuPr7A==
Date: Sun, 12 Oct 2025 20:07:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>
Subject: Re: [PATCH v2] iio: adc: ad7124: fix temperature channel
Message-ID: <20251012200750.059b9e77@jic23-huawei>
In-Reply-To: <l6bq6yqq6iqac3jlnwhzpymbne5e2ulkupl544qlyot3po546g@5seccwwkxrns>
References: <20251010-iio-adc-ad7124-fix-temperature-channel-v2-1-b51b411faf36@baylibre.com>
	<l6bq6yqq6iqac3jlnwhzpymbne5e2ulkupl544qlyot3po546g@5seccwwkxrns>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Oct 2025 14:47:13 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello David,
>=20
> On Fri, Oct 10, 2025 at 03:24:31PM -0500, David Lechner wrote:
> > Fix temperature channel not working due to gain and offset not being
> > initialized.  For channels other than the voltage ones calibration is
> > skipped (which is OK).  However that results in the calibration register
> > values tracked in st->channels[i].cfg all being zero.  These zeros are
> > later written to hardware before a measurement is made which caused the
> > raw temperature readings to be always 8388608 (0x800000).
> >=20
> > To fix it, we just make sure the gain and offset values are set to the
> > default values and still return early without doing an internal
> > calibration.
> >=20
> > While here, add a comment explaining why we don't bother calibrating
> > the temperature channel.
> >=20
> > Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration =
at probe time")
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > Changes in v2:
> > - Improved commit message.
> > - Expanded code comment. =20
>=20
> I like both improvements, thanks!
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Applied to the temporary branch I'm queuing fixes on until I can rebase on =
rc1.
+ marked for stable.

