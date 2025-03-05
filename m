Return-Path: <linux-iio+bounces-16409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BEFA4FC4B
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 11:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB56C3AF618
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936A2080F2;
	Wed,  5 Mar 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge8yM9wJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92F207676;
	Wed,  5 Mar 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170690; cv=none; b=fHhWsV2CACK17mytPHIrywUEg32VZi5u0z5YxgUQzayIpFeRwELGNimemVUt4tU6eY6+FPp+rBTurpIIKqRbVCK2jePXiKZFz+xQH7pOEgvB2mIC2zCiiYS77WdHpgON5/+sxNVqSBTmF8UVU4NSwyTlghcJ4otPp8k2zjviJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170690; c=relaxed/simple;
	bh=1PHHIjKZHtToxm/thyNV4FJackLZax12wRG+bi6VJ+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkHCezkm4pd6CQ1cE67WF7gKx9/u4iaDoEI8j6ABrC8fzFXKhu6402ICbEUyG5vIPXRtW7IuQ8BT3Y8DD8P58jdjyyTt/x4uDoxGcgAx0pcdHWcv/wcFN3+7mJ+TfUTx5cnbgisfq43fEwJ6uXw2ieLfDRoDvkI+VNOoXFp2+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge8yM9wJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807E7C4CEE2;
	Wed,  5 Mar 2025 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741170690;
	bh=1PHHIjKZHtToxm/thyNV4FJackLZax12wRG+bi6VJ+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge8yM9wJBNgbZ+1QNXotg8b9WSfyESHAbsIwCuZwpniZ740iP8LUBXiIWwR1edV2O
	 PwKp97k55Oje422t60phP5I2ogchQlYsE3XNTtvNjCTc/pw4dht/2U1ZE/64KhfwVf
	 xfHsR/R8+HlCuRgYJqURFxf7FJehd3vv6tfmvorXWx6/vH1AoiPtLEhq6JFJf1L8qv
	 XuWW0zhhd9PwYffCw922OyD8FuBLdGW0shPQzO9nEFmqtenfRT/wqZuJSQma3l6RH8
	 i4tYC9kWqmTjVJyjqZvM2rmAP1cI+qi3s+IFQXN1oQhx0622mBsE3mIr8RASComzXF
	 huf7wMvketdvw==
Date: Wed, 5 Mar 2025 19:31:27 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix undefined counter
 channel state on probe
Message-ID: <Z8gn_4qxtEqbn20O@ishi>
References: <20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dPcNFR/ox0/r/xIu"
Content-Disposition: inline
In-Reply-To: <20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org>


--dPcNFR/ox0/r/xIu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 07:01:19PM +0900, William Breathitt Gray wrote:
> Hardware initialize of the timer counter channel does not occur on probe
> thus leaving the Count in an undefined state until the first
> function_write() callback is executed. Fix this by performing the proper
> hardware initialization during probe.
>=20
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Reported-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>
> Closes: https://lore.kernel.org/all/bfa70e78-3cc3-4295-820b-3925c26135cb@=
prolan.hu/
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> ---
> This should fix the issue where a user needs to set the count function
> before they can use the counter. I don't have this hardware in person,
> so please test this patch and let me know whether it works for you.

While developing this bug fix, I noticed the following code in the
mchp_tc_count_function_write() function:

	if (!priv->tc_cfg->has_gclk)
		cmr |=3D ATMEL_TC_TIMER_CLOCK2;
	else
		cmr |=3D ATMEL_TC_TIMER_CLOCK1;
	/* Setup the period capture mode */
	cmr |=3D  ATMEL_TC_CMR_MASK;
	cmr &=3D ~(ATMEL_TC_ABETRG | ATMEL_TC_XC0);

It looks like it's trying to choose the TCCLKS value by evaluating
has_gclk. However, a couple lines later the cmr value is masked by
ATMEL_TC_XC0 which will clobber the previous choice by resetting bit 0.

Is this a bug, or am I misunderstanding how the TCCLKS value is set by
these defines?

William Breathitt Gray

--dPcNFR/ox0/r/xIu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8gn/wAKCRC1SFbKvhIj
KxQeAQDGA5JfQLESH4QBAqulBaIKYPC1mduU3pyCbQQQP/9c/gD+NbXPM34DbK8Z
mIl2wzt1U8ZKDlQ5/4ZvRHv4BEqn/ws=
=SzRC
-----END PGP SIGNATURE-----

--dPcNFR/ox0/r/xIu--

