Return-Path: <linux-iio+bounces-16661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE4FA58FCC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95731188FC02
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A052248BE;
	Mon, 10 Mar 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISdDCx5v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E41C5F34;
	Mon, 10 Mar 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599316; cv=none; b=p8cIxcXiKIMKc4ZW61eMWBMI+VRukKkSRGIOYGCXeWWRQCRK/QTalmkym90DBMEFRm0CPq5og4c6jV504+5nPYluKgJzckE1Qpu4HbUvoj1dGDplqBsWa/G/z0gtBk1IMwGx08UlTH+iI8U1G5meI3ICvwMKXjOp1ReBjEtg6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599316; c=relaxed/simple;
	bh=PdC6VAzrMyH8O2VveH3lYcAbaxYezDUcJBl9fDQ8Dv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swfyyx+HJWFo2hZQE2PMDfxEWlq3X/1w7RuvNJcg0cZQKGttrxwvJEDj21iWZByeFw7s1H1dUFdvFsWdXUJBKSaU7pQu6x4c0UDeN59s92uFIPrhcxAJQs+y2naNP3grvK7k/7CvRDkNtKh9h4KbEyZjMZyQsyNuSFIV+1OYga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISdDCx5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B0AC4CEEC;
	Mon, 10 Mar 2025 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741599315;
	bh=PdC6VAzrMyH8O2VveH3lYcAbaxYezDUcJBl9fDQ8Dv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISdDCx5vZ2wsLplSu5yq2lU/hgfCUFTCUX9lm8nWppg61P0zsWqtKtduRwM65jj/P
	 QLS1smHqaPQodqDwLnvoCzmFwB2GmGrzVIpWa2G9yQi8gwSXe2AmicJVT/vnspfNjf
	 AkFVpj+JLrz09tCyWpnUhDjbGnMl6aojwuQT68vv78iYVcncrehPTMfE7pW4fbKja9
	 FO8ahUp7bk4A1DJDIeBq/3yK4T4dxW8tWK5n4XLfyVQJoEwtQ9HSG+TdMfQrJSAlK6
	 7vSNo5Q+sLEIIkrFE0yctMsleC2YnAilktzdg7eNrKOCfNYh+rAa8DdpzAUbfXHqei
	 v0YBSMYIPBIgg==
Date: Mon, 10 Mar 2025 18:35:11 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] counter: microchip-tcb-capture: Add support for RC
 Compare
Message-ID: <Z86yT0WoGbX7JXND@ishi>
References: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
 <20250306-introduce-compare-component-v1-2-93993b3dca9c@kernel.org>
 <790f00da-d66e-42bc-bae2-339144fbec95@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m0vFrlOyE6rOUs9t"
Content-Disposition: inline
In-Reply-To: <790f00da-d66e-42bc-bae2-339144fbec95@prolan.hu>


--m0vFrlOyE6rOUs9t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 09:38:13AM +0100, Cs=F3k=E1s Bence wrote:
> Hi,
>=20
> On 2025. 03. 06. 8:05, William Breathitt Gray wrote:
> > In Capture mode, the RC register serves as a compare register for the
> > Timer Counter Channel. When a the Counter Value reaches the RC value, a
> > RC Compare event occurs (COUNTER_EVENT_THRESHOLD). This patch exposes
> > the RC register to userspace as the 'compare' Count extension, thus
> > allowing users to configure the threshold condition for these events.
> >=20
> > Signed-off-by: William Breathitt Gray <wbg@kernel.org>
>=20
> I'm assuming you'll merge it with my capture extensions patch. Will this
> `compare` extension be carried over to 104-quad-8 as well? Otherwise:
>=20
> Acked-by: Bence Cs=F3k=E1s <csokas.bence@prolan.hu>
>=20
> Bence

Thank you for the Ack, I've merged this series now and pushed it to
counter-next.

The compare functionality is already exposed through the `preset`
component in the 104-quad-8 module, so I decided not to add a `compare`
because it felt redundant. However, I'm certain `compare` will be useful
in future drivers so that's why I want to get it merged with the rest of
the microchip-tcb-capture changes. :-)

Best regards,

William Breathitt Gray

--m0vFrlOyE6rOUs9t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ86yTwAKCRC1SFbKvhIj
KwWFAQCm5z3VyBDI0W1smBY+8YBSQ+c+bQHoNJ4rM5X3X4wq8gD/bAlld1d1zpIT
5aOtYyixrV+cI01SKHuAhr8txzb7nwg=
=q8uA
-----END PGP SIGNATURE-----

--m0vFrlOyE6rOUs9t--

