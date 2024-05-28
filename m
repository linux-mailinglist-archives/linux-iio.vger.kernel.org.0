Return-Path: <linux-iio+bounces-5406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD3F8D1FB6
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 17:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4682855E0
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57D171676;
	Tue, 28 May 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIRb0w2l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56106171668;
	Tue, 28 May 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908730; cv=none; b=fFiRnIXjgoulC66NgJlLmnGgpX5R27qX9o+K0s5UcRxGkSST6maaqVJboSdFsXatKhfAW1267vUJO3c23apulxoXSfpdK/BLuMJiXnPLrPQqkgNXKTouehHKM4CK0S4FGa3COghN9R9tqu7cK0gWQ+QTdrlu31CXQKLBec3nPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908730; c=relaxed/simple;
	bh=JyPHNVFfMJ3/sD2IJSFnsp89QQ/y7TlvIIZG6NVwyy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNEgCsFtxgtHy9v2rg44vyEvxpw/3HWeK5uUs/2zcV+L7UGJhM37PzMD8HTLxtoB92msHlX0MrANPFfTbDovcr2+TtXhs/Qa3MDP4wLxsE74i/9nSm81fi1ZJePviwo4we2Tl6HtNE6Zp1ZXNz+YeX67X6dWLfzwVgFuLMHc8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIRb0w2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED1C3277B;
	Tue, 28 May 2024 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716908729;
	bh=JyPHNVFfMJ3/sD2IJSFnsp89QQ/y7TlvIIZG6NVwyy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIRb0w2lz96WwnDPeSfTComNhIpo6QEFqPMa12leJDspZh8/sDKluPR1gber8HbuI
	 0u87WLZ7hwoDsJKhmSpIMK4juAzAuuGs9/KtIsqg87CNax7SGbNp5X/g/iSGB5WQ1o
	 zcj1cREQVDGywyVRkDPDJpsv8jbCnUsd3hpfM+PcYSvjXO0EXIcClj9oVMswp9GXQh
	 SR3eQrS/c5k3J0kRJqAC1+0ggWco520tjze4SJ6AZty3+k3wmB+5l1TsTUPN5loFn/
	 rnw65xsTkJQBeOT9nByYTSkDYpBAZLRQyVf0+vBGUX4DdWAl18iGb7UE6LLioxNjRm
	 3uMQmex5bjtlg==
Date: Tue, 28 May 2024 16:05:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, corbet@lwn.net, conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
	Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: iio: imu: Add ADIS16545/47
 compatibles
Message-ID: <20240528-backlands-landmine-3eccb5b48c43@spud>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
 <20240528142409.239187-4-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K8etPs/NXvyXmZTN"
Content-Disposition: inline
In-Reply-To: <20240528142409.239187-4-ramona.gradinariu@analog.com>


--K8etPs/NXvyXmZTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 05:24:06PM +0300, Ramona Gradinariu wrote:
> Add ADIS16545/47 compatibles. Each newly added device has a different
> angular velocity/linear acceleration scale combination, as follows:
> Accel dynamic range:
> - 8g: ADIS16545
> - 40g: ADIS16547
> Gyro dynamic range:
> - 125 deg/sec: ADIS1545-1, ADIS16547-1
> - 450 deg/sec: ADIS1545-2, ADIS16547-2
> - 2000 deg/sec: ADIS1545-3, ADIS16547-3
>=20
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--K8etPs/NXvyXmZTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlXytQAKCRB4tDGHoIJi
0vdOAP4vdykq60JRPTiFmg++dtqwnYZyhuK6tgGNSxhukdO97wEAsnqqw6t3dkeg
3V/N6e9PMEGxVRRUrgWKlka5edtLKAY=
=1IPI
-----END PGP SIGNATURE-----

--K8etPs/NXvyXmZTN--

