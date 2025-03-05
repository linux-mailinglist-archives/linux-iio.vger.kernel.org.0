Return-Path: <linux-iio+bounces-16412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E597A4FD0D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 12:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC72F1890E10
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13E422D79C;
	Wed,  5 Mar 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxtHUvNh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7C1F55FA;
	Wed,  5 Mar 2025 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172540; cv=none; b=gJs8XZ2mJnAyj2aoZojfEndl2E86CtopL/xxY/9kXccvllSXc69RMRMJoWbldWiqwmgsxoJmU2/GR7+9exkP3W3J2DIa0HU5bbKleyRgvOg+rN5GqaRMp41oEYltlfZBgUzCR1i4Hk4SWh2s2W3OF6zOPi3SZ3gbubT1IVHFrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172540; c=relaxed/simple;
	bh=yTpT/u9tOJzbuDrIadcgJIx+4mrWB9CtBxj4SvKyNVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orU7YF6jW4kCEW2M+F9JzmFzFpisydVQW8twCJHzmyxD4zYPrm02NUO9fnFtPytJv1rzYfkhCq0hAkBLnlenZw/Ra7r/xJo5hl+rBlcGfjOLr7sIAzzx02N4mXU/8TTnmaXX7GIswgONTVZ6mPNH0AkBm4I2PDuKre/5uYI1/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxtHUvNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DB4C4CEE8;
	Wed,  5 Mar 2025 11:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172539;
	bh=yTpT/u9tOJzbuDrIadcgJIx+4mrWB9CtBxj4SvKyNVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxtHUvNhQeoGIAQx62mLp1ON9SskQGRYRGf+ejfCPoQ3Y2s9L3dc2OBP6vcFOXXgx
	 pFwpLVhkPhWYWX9jCff69oXdzxx7Okvcdmv9iqrr0L2g8YWKm0E0P8K/68X+gUhPAG
	 5nCax0DIjz+w0yQpABLStA3AJ1T2hLmZx3VCk4eSeQah8YcBHFU32sFXST0sAw9JCy
	 AyI+3GXHX4wEYJQiSW/ZvHqITHjATYfGIxqg004eEqAxr40qUDjxo1ICG2j7BOfxR1
	 A4CT8lRjhjs+YUhrvZq+3r85Cfl5/zIFm+vixipZYY18eBUbuJe1WwMWIDLQCOUY/d
	 wVjSvqv34jxtA==
Date: Wed, 5 Mar 2025 20:02:15 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix undefined counter
 channel state on probe
Message-ID: <Z8gvN1CvcSV8nfVP@ishi>
References: <20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org>
 <93ce1511-53f6-42a3-b1a5-b6732105e87d@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pFddjXJg41wFrn79"
Content-Disposition: inline
In-Reply-To: <93ce1511-53f6-42a3-b1a5-b6732105e87d@prolan.hu>


--pFddjXJg41wFrn79
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 11:50:27AM +0100, Cs=F3k=E1s Bence wrote:
> This duplicates a lot of `mchp_tc_count_function_write()`. I'd much rather
> have this code in a separate function called something like
> `mchp_tc_setup_channels()`, that, depending on `priv->qdec_mode`, sets up
> the BMR, CCR and CMRs, and then have both probe() and function_write() ca=
ll
> it. Or alternatively, have probe() call function_write() at the end, but
> that's not as nice.

Hi Bence,

I agree, the mchp_tc_count_function_write() could be cleaned up and
divided into separate functions dedicated to configuring each mode
(perhaps regmap_update_bits() could be leveraged too), but that would be
a much more invasive update. For the sake of making backporting easy to
address this particular issue, I've kept the changes here localized to
just the probe() function. Once the fix is merged, someone can try
tackling a more proper refactor of the mchp_tc_count_function_write()
code.

William Breathitt Gray

--pFddjXJg41wFrn79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8gvNwAKCRC1SFbKvhIj
K0q6AQCykzFD3ZbJXRdRLZExpEPQHYVKRM2NITaUgXmy4R80pQD/fjGX1DSzN4Z0
gFKcYKH+sV0KGDTjDpoqS0rFmXIJjw0=
=sVWK
-----END PGP SIGNATURE-----

--pFddjXJg41wFrn79--

