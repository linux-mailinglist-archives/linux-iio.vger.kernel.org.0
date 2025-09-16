Return-Path: <linux-iio+bounces-24179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0221B5A174
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB633BF85E
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3D279329;
	Tue, 16 Sep 2025 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViltXeTD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2624887E;
	Tue, 16 Sep 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051136; cv=none; b=FA5NLrq58f2uMIh6MJjnNrczRBnWcgmtDRLREf2eX4b+Kh1OSa1oiqQu905hKEwmAV3yH+0qaq0BoJfQnv7OtlUNQgRxaGdnJ6SKzUadMnFdrP64UYormKveOvUlWx5ZCSGPJiKQzPbxnInZJ/7y63GHm2r58rdJvndPQqUXXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051136; c=relaxed/simple;
	bh=nJUVQfDNWUN7WS8fn07Trv/k+0SzHN7/fXHW6s/Nm8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THI3RWWDijv942eotf7fUH6r19/zGiThXWmMYp05n1D26IOTrWhlz558tMQRoPbHP9MvTlC+q5yJKqa/uqXJuFrx0UU2GyLX5D40x91HYqifyKnExh5mPjF4HPzVX5RLQTSBsEuGwAgRsImalX5rZWtHOyVYZyexSWqQeJKq+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViltXeTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305B8C4CEEB;
	Tue, 16 Sep 2025 19:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758051135;
	bh=nJUVQfDNWUN7WS8fn07Trv/k+0SzHN7/fXHW6s/Nm8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViltXeTDs6AsUCALWrTaSqafUoDcDKRpGsmUxuWafRvBUZiYD4ZJb6TxLSK+WodJw
	 hr81nRPdC+/tTrPykzrkDDBdfMvHPGxNBwooorRm1prbnD5O1ZHHt4ar9Ba+jkn3Ze
	 ITQwEEqSCFXCkKyatMFbZt/WPq1U+yjZvftuytq0ODxYNi7+1OIHXYcn8gYfwiWkHt
	 xRIKs8QMYbjVwI7HvCo9DWzG9VYRI9oVV4eXlWPMi72qlB1TomVmSC16mkZlbFyhrn
	 NPgJEEGov7GHHvBlkMWSwPFgJbywSIj7IKddF2JQgvotNBy7iNF84Ymh0s27Rrf6Ao
	 txWIOUGcyD/+A==
Date: Tue, 16 Sep 2025 20:32:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dima.fedrau@gmail.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: imu: smi330: Add binding
Message-ID: <20250916-henna-rinsing-32a18a4d30b9@spud>
References: <20250915160934.89208-1-Jianping.Shen@de.bosch.com>
 <20250915160934.89208-2-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NDqmdNp0JilL81AM"
Content-Disposition: inline
In-Reply-To: <20250915160934.89208-2-Jianping.Shen@de.bosch.com>


--NDqmdNp0JilL81AM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--NDqmdNp0JilL81AM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMm7OgAKCRB4tDGHoIJi
0nbTAP4ydR+/8Y/udGCa6dMD9twR3ZH6U71sjhVJf2KSLvTWjgD/W7Nuo9fe0g4+
CKblP8Qbyho+rSArAU7cmx+FfN0oWw8=
=Qfln
-----END PGP SIGNATURE-----

--NDqmdNp0JilL81AM--

