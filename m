Return-Path: <linux-iio+bounces-15025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7BFA28001
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 01:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BF13A668E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95056376;
	Wed,  5 Feb 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8rXBf2j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB01163;
	Wed,  5 Feb 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714291; cv=none; b=Kf+EHpX92HVpCuF4N4veMxEjzExczLd7+0Fe3TeMehj4MsEv4tgyRYpGgff8XSVMZtyVr05sR5oARDkwvQhYVDMvnxdAN1qZXBezpNNMig6ztUnuuW9fopywxQjL4uFHIhQpOPpestbfFgUPI//8OJ5h6D5iGgajG+pL/118Elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714291; c=relaxed/simple;
	bh=zI0sTmEJ9TsR8yXL29aZxtEc9FgdgtkaVcTEpXxeYyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTD+I0n36wRBR3irak9IhbTvznLhyngCmP16Y97UYjIeebzj473t4Y3TN1FoTWGlTXZtija4gsZI6117sxYnutDIswNCp5QmQC8E/q6rZYW1ywo4sdzS2oAMplJU6oHde20DVzbguzIT9s++O+lSKLhxjw2QdknZ//yKgH6E68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8rXBf2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F4CC4CEE4;
	Wed,  5 Feb 2025 00:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738714290;
	bh=zI0sTmEJ9TsR8yXL29aZxtEc9FgdgtkaVcTEpXxeYyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8rXBf2jA29IML9QMwaRxwtYMXdZyvIP/7PhCn6zdVTrFV7WP5/Fh/xmgYyt56NXC
	 WgRD80QjCrDxIwMIBOAOuwbV8jjPIynSOeGypKle33Yh0gT7obi5YfYJ02njgQrvEf
	 PitphPmBmVY1HCVIy5tgE2Ar7Bf9Wc04dGIuuXkEUHM1M6YBhCcjJDHY0iWXfdbS7K
	 YEOKH1nd8155Uld0aW3/hfrAOu1O4XgPaXBouypI9GEJSD/bl0BEpImoHF2ua5iQfc
	 66gBLlMFlEJGUcGpCYjn9RSvlg6KyaEzlExI9ewDBqTWM0SqqV+UHZdJqR589Ue7EN
	 ewTr9NRea69vQ==
Date: Wed, 5 Feb 2025 09:11:26 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v2 2/2] counter: microchip-tcb-capture: Add capture
 extensions for registers RA-RC
Message-ID: <Z6KsrhUYoYF8n10J@ishi>
References: <20250203162955.102559-1-csokas.bence@prolan.hu>
 <20250203162955.102559-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a6voB7vV2r6plo90"
Content-Disposition: inline
In-Reply-To: <20250203162955.102559-2-csokas.bence@prolan.hu>


--a6voB7vV2r6plo90
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 05:29:53PM +0100, Bence Cs=F3k=E1s wrote:
> TCB hardware is capable of capturing the timer value to registers RA and
> RB. On top, it is capable of triggering on compare against a third
> register, RC. Add these registers as extensions.
>=20
> Signed-off-by: Bence Cs=F3k=E1s <csokas.bence@prolan.hu>

What is the difference between RA and RB (your code looks like they
represent two distinct event channels, so I want to confirm)? Is RC a
threshold value set by the user, or is it another captured timer value?
The capture extension represents Count value specifically, so I want to
make sure we're using the right extension for these components.

William Breathitt Gray

--a6voB7vV2r6plo90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ6KsrgAKCRC1SFbKvhIj
K6VNAQCk32TT8lWMH4Lv4X9PvkCeWYw6WUYjQPmRiEjrTjy5UQEAogdky3058O5y
SsjhwyTWpveB3B+stA0GPxnW7Z0WAAc=
=pptR
-----END PGP SIGNATURE-----

--a6voB7vV2r6plo90--

