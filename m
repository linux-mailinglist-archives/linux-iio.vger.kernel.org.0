Return-Path: <linux-iio+bounces-23379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3796B3BEF6
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF543BD916
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABBF322777;
	Fri, 29 Aug 2025 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhHRRbhI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB931E25F9;
	Fri, 29 Aug 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480433; cv=none; b=pJIXVCMiwSFBdbjunNmmX0KtFusj8IHQRkCgrHfHCkSxKXKGs5Xp4vaKb/of8JGHAx+84BHv9Q+oK9qh4rFuPOHA5II/haJF/XGmY4+J/iX5dwJTNEdXZb+f+wv0YOVlX2jso42flpmQTlRFby/eCz73H0+rfF6cu6cm7kaWfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480433; c=relaxed/simple;
	bh=M4ZFAtBXnhHid/kXClWiR6yLGswDzXLC71DhzzXbeR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEqLdd//HPDvNv+awn7iMF8M6j0uJr68u/XkaLuB3TBvnvBKvhP121bitVVpWMGQOkFhgOCW+Q+V+myrQDrIsjdP5bSQ6y/iO509nPv+nmhCQV2PI3bx6BuW47NDaSp3JnWOYRs1SK5tmDmjxCL4p6g5ZGI1oQ15dJdLq1k963o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhHRRbhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E72EC4CEF0;
	Fri, 29 Aug 2025 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756480432;
	bh=M4ZFAtBXnhHid/kXClWiR6yLGswDzXLC71DhzzXbeR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhHRRbhIXC9QLGd8swlqTnR3Ky+1cQZDs6bS3FcozvB3YpBzxB8PIrVRGEZjMpnBk
	 kNBpVO+cxJMdWeAHt5IlaClz8YAztIBKhmkljgRc/ZBT3+fDQhCYyL+9KBAXvydDnr
	 5EhCs3VseuCp8AonBfMm9QSN/8dK4ZjSnyqPn5FJ2TPE1pBW3O7lJTIkBaF94FMggY
	 4t5bsfEnrnEfCNzyajMqcmKsfv57cV9wSf7BTs7Ri8s41z72QJ4OIC2F9rFm/ToTDv
	 O/dBjjszzBxgHbm7SO6D3ij7dVuvoEAaqyYNzESXwYKRoEGLkwC+mTEXteUUfUBBGt
	 4J8S4Wtk29w+w==
Date: Fri, 29 Aug 2025 16:13:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/6] dt-bindings: iio: adc: add ade9000
Message-ID: <20250829-freckles-cytoplasm-81cedd872215@spud>
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
 <20250829115227.47712-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2IWGEOdF0WqegXag"
Content-Disposition: inline
In-Reply-To: <20250829115227.47712-4-antoniu.miclaus@analog.com>


--2IWGEOdF0WqegXag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--2IWGEOdF0WqegXag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLHDrAAKCRB4tDGHoIJi
0nCMAP4lOT4YeLX3fQZGEkaBE3vbt9fWSKxZa3W++z8Kk9cU8AEAsOT2PjPFR1fo
CCtIvQIzBHjqxU328vD5ojF5qg1x9Qs=
=WM/+
-----END PGP SIGNATURE-----

--2IWGEOdF0WqegXag--

