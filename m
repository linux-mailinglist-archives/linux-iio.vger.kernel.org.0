Return-Path: <linux-iio+bounces-24552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F85BA8A59
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 11:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 825444E07F0
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D104F2882AA;
	Mon, 29 Sep 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzJGrBpb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81062253932;
	Mon, 29 Sep 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138459; cv=none; b=B8BJbl734id3d9fQwsGneg8pT70mt+dPiiDkLrFyMQlbfPQS6cqTduN6K6nYCgYdlSj9y7UOWOZG6vMv+5TpAAKaI/xzd/LcRowLof7Q/t05AywUBZnxdCZXTuImHsb83+b3q9E7A2PD4jt6fu7CcYjsMYOxcwNdecWc8GdTQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138459; c=relaxed/simple;
	bh=iPt2Ht57JYhHViCXg9IWHZJp2JJb4XjsbtJuCpxPlbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8YRSsZnzl1d/1GwuQPZAtOSSTLM8eYgZPUANolsfO08W8b17w2G2/4yh9pPBNO/lhpzz1m1XBWbSi2bAXYnxTNNKFW2rLyOXfD9/gTPWidrGVO4WIQqjSYM/XNrIApdlQ7TivpynSX0quSpV42ZH+8G9LFfKPNSRBIGRjDQQmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzJGrBpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43195C4CEF4;
	Mon, 29 Sep 2025 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759138459;
	bh=iPt2Ht57JYhHViCXg9IWHZJp2JJb4XjsbtJuCpxPlbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzJGrBpbmg6DGIBjZyae+223EWaZVBnHnSt5SjBfYr9g+4tsEiyOcfXUBTALhh+QJ
	 Ukf757akfNIHfqu0misdy0RjiGujCYsA3pyUfhOKUfMJDkmYKzNQd1xpuGafbQym53
	 8Ev+t0t/ZWnh58XtsFnRb0UXQW66gd5zQsUuOEc2NMtAoSOq4oXQ6RVOFwciwUTSl/
	 6SNUTCotlvmC72aCNCmCVe/HLck4E+KQ8/027nOwkYKYrkDW4TMlznxOEcTD6qBGdU
	 Ec0sEEfaKOgkma6DMuf9cdMSsb+sl7nuhzHqMe5ojjAsFzWeTCaf3F0f/AHHAggxWQ
	 ZjSoJhL6tVAcw==
Date: Mon, 29 Sep 2025 10:34:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, ahaslam@baylibre.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 0/1] Add SPI offload trigger offset
Message-ID: <914f7b14-8bae-4423-9d64-9ad2e351a764@sirena.org.uk>
References: <cover.1758913065.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IbggcYwEOXvH9JXj"
Content-Disposition: inline
In-Reply-To: <cover.1758913065.git.marcelo.schmitt@analog.com>
X-Cookie: Stay away from hurricanes for a while.


--IbggcYwEOXvH9JXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 04:00:40PM -0300, Marcelo Schmitt wrote:
> Add SPI offload offset parameter needed to achieve high sample rates with=
 ADCs
> that require some synchronization between a conversion start signal and t=
he issue
> of data transfers.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--IbggcYwEOXvH9JXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjaUo8ACgkQJNaLcl1U
h9CV0QgAhPZnO769ce96PomfzpOiyBpChG4jOdDOv5osElSidVTIt5yU5DBXNXRv
iROIwJZWKghp3JKtdPV8sCS8jD9RIw7udUskYGxx51gTUrV6L2zGTUyrWTFrn+bE
yI0WglcHw5AryIz0A8AF+3KuF2p6zf4CZdTJZBA5UKmUMVL5gHSw1tc2+jaiDUI7
BmAqq0XKnNfcwncctDrK2cD8j7a3LiKMLI60jNwgbjza1Su+3uPF/6ojTlIRi/Mj
mC3q0EGiMiG30rbFeYr44aj9whNAYOTyyWZlyDL7C6jxQq4+lN4xN8HkpGCV26Do
DpcV0DqOlY7JB0kEA1mvNQWAHJsytA==
=cdEe
-----END PGP SIGNATURE-----

--IbggcYwEOXvH9JXj--

