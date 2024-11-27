Return-Path: <linux-iio+bounces-12753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB1E9DAE85
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 21:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41099B21504
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF9202F68;
	Wed, 27 Nov 2024 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMxOjQFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E62CCC0;
	Wed, 27 Nov 2024 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739206; cv=none; b=Lk5wfJHApimFWvwsh8p1OcujoBKuKvw/JmZi3UsAwF4hRNo4dKwCfg6r7WYEEks/pwnKP2IxzbIR44cWwr7bV2fcMRzmiiTVfUpNTRFTxhzBgBnT7ZLA3IOz6iKTSG/apUfO19eg4jexlxCA3mbj3sFrAe3bXxbGUfGWM1RuC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739206; c=relaxed/simple;
	bh=LNDY5ueeEYALxnNozlJJO/E0J742FYFNLyMMZaYyLtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+kXqK8xhKpj+BxPrwN2pOfvNWrIWbBf+pDJ7zfkxko/gOAsAm+BZOudoHdGmA1DjmQOfGzmIdfy9tVhLJBi+xPVaFqwuDGCaeJ73NSBY07Nx8kkpMCo2cgSI5vzriLGoB/5L9JWODcxbEkSD02O5DILvPJsuS0KYjU+al8NI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMxOjQFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F58C4CECC;
	Wed, 27 Nov 2024 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732739206;
	bh=LNDY5ueeEYALxnNozlJJO/E0J742FYFNLyMMZaYyLtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMxOjQFvuHtW7B26ceigTz0G6N711UUNMZ8bzv2xy+BgWadbBPZSwMcLhM/LM0Wap
	 EGHddOMYJTwGAzsntkzRuEiJVFitmodkIFChHjE4OM2ts3gdL1WWKszAHk+JJXQIcz
	 r6gquls0ucKxTSmb9RKubNX4Kt2A6p6pRyonr/neykGPBBtEsbDd3TANgbNKdLRhue
	 HbSAtrW+pnJbWiN3wib6MkZBXZ8P6+yfKQZEIfxPgCiNRTT5wWzhxUrYYuMfo3slYe
	 GkXnXueYWLHn6xC0pvAihFUWl3vtw9pFfUwg8aTEhyG00d+m0WP4YDEvbOpEt5yurg
	 J3sO1/imhozsw==
Date: Thu, 28 Nov 2024 05:26:43 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: david@lechnology.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] counter: add COUNTER_FUNCTION_DISABLE for energy saving
Message-ID: <Z0eAg9HRlYlCy25H@ishi>
References: <20241125230220.9994-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enD/eqU8NFepVRPA"
Content-Disposition: inline
In-Reply-To: <20241125230220.9994-1-rafael.v.volkmer@gmail.com>


--enD/eqU8NFepVRPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 08:02:20PM -0300, Rafael V. Volkmer wrote:
> Add `COUNTER_FUNCTION_DISABLE` to the `counter_function` enum in the
> counter API. This allows file operations to signal other drivers to
> disable hardware resources, reducing energy consumption in
> power-sensitive scenarios.
>=20
> Previously, tests with Texas Instruments' eQEP modules revealed that
> hardware resources remained active unless the driver was removed,
> offering no user command to stop the count. This approach exposed the
> fragility of these resources.
>=20
> To address this, introduce a new enum option in the counter API to
> receive commands for disabling the hardware. This ensures the hardware
> enters an idle, power-saving state when not in use.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>

Hello Rafael,

I wonder whether a new enum option is actually needed in this case.
Wouldn't the Count "enable" extension already provide a way for users to
stop the counting? I imagine the driver would determine implicitly that
the device can enter a power-saving state in that scenario when counting
has been disabled by the user.

William Breathitt Gray

--enD/eqU8NFepVRPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ0eAgwAKCRC1SFbKvhIj
KySVAQCpfa71177/rYkjGQNbgXl4JINaxZYMsNIOdV0N7cFZtAEA6UH55z1OO9ti
wmY86PhVbmoqsHJ1OMRItDsWgZu0dQI=
=h+Dv
-----END PGP SIGNATURE-----

--enD/eqU8NFepVRPA--

