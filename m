Return-Path: <linux-iio+bounces-16451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2499A5426E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 06:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4007F166250
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC419AD48;
	Thu,  6 Mar 2025 05:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeqFgw69"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597781990AB;
	Thu,  6 Mar 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240158; cv=none; b=sKToG4H1FNu7wJ640DahSEjSYkloO0ME5sEGcmzJUOZ8zpxXNOpG47y6UczhnFSOPmVbiOshAI/gWDTP3xf3VwMv6OwHaEC6Op3XZ8dglSOFAFKok7YzdLGHr/aiEhKbfEm+jQwrS+1C0J9MUnzMHj6NO7BL0T8sEUPcuIHJqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240158; c=relaxed/simple;
	bh=BSqTHd4IyO4Os53hX91Rm7M9G3KnhQxpq4axd31S4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBO9z5F2/L0BQOL7Wz56KxwlhKd9V9TIirL/LLI40lljC5CbbA5WRIPXTHk+yK/gT1KL2G+kGTQBpXmcQeTVByTcaovl2+xQCasINtWCIBQ5MlONijUBfUFDqhlY5SvLDj8kdaqMHouCQzttKFB4IZVHF9hBTlHZYzeiXyBGL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeqFgw69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A9DC4CEE4;
	Thu,  6 Mar 2025 05:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741240157;
	bh=BSqTHd4IyO4Os53hX91Rm7M9G3KnhQxpq4axd31S4As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeqFgw69dpZB2r8LmAfIpzgWEe03sSj6A6R6egiaKribwDXO+9vB8fuvZOrGUI3EA
	 qK+RfD1v6NLIHJTtmmhITmzDRPynxq2HI3zvT6mCjSoB9SbOivdQ/x+LX8pPcp5R7w
	 R6TQtgldruTav5B9Dx6wbZuUMOYC2o4n0nH7VlGqNZKz72PLj5t41LZx+vmadt+bPe
	 ieX2fVJ1pt/HknLAc0+h/JJsDQqStsqKTZ21O6ZfhOCHxRc6vb9X7APR1w7HU5lA0s
	 Po1EUvWacQ37ZXv0ghd5tyeir836k2MisNDtZTL0PXVu2qjbnz+0/k/VQOZKblo/nN
	 hcONpNUjCPOHg==
Date: Thu, 6 Mar 2025 14:49:14 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v7 1/2] counter: microchip-tcb-capture: Add IRQ handling
Message-ID: <Z8k3WlJHCrYPdW4j@ishi>
References: <20250304155156.374150-1-csokas.bence@prolan.hu>
 <20250304155156.374150-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fW4fCf+MWkpAn/Ne"
Content-Disposition: inline
In-Reply-To: <20250304155156.374150-2-csokas.bence@prolan.hu>


--fW4fCf+MWkpAn/Ne
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 04:51:51PM +0100, Bence Cs=F3k=E1s wrote:
> Add interrupt servicing to allow userspace to wait for the following:
> * Change-of-state caused by external trigger
> * Capture of timer value into RA/RB
> * Compare to RC register
> * Overflow
>=20
> Signed-off-by: Bence Cs=F3k=E1s <csokas.bence@prolan.hu>

Hi Bence,

I'm mostly statisfied with this patch now, but I have one minor
suggestion below.

> @@ -27,6 +33,7 @@ struct mchp_tc_data {
>  	int qdec_mode;
>  	int num_channels;
>  	int channel[2];
> +	int irq;

We don't use the irq member during the driver operation, so I don't
think this value needs to be saved here with the driver data. It seems
to only be needed in mchp_tc_irq_enable() for devm_request_irq().
Perhaps you can pass the irq value as a parameter to
mchp_tc_irq_enable() instead.

With that change made, I think I'll be ready to pick up this patchset
and merge it into counter-next.

William Breathitt Gray

--fW4fCf+MWkpAn/Ne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8k3WgAKCRC1SFbKvhIj
K2i2AQCYb0T6OBjNZqGb0NMlg9KvEEx6c/RvhpeYlzQmHuWYYAD+PuWjwZ3KnEkr
hOZ7IMtE7r1qcqDFU0m9GwWw0dL+bwc=
=pVll
-----END PGP SIGNATURE-----

--fW4fCf+MWkpAn/Ne--

