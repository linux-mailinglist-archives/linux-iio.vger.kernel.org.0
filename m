Return-Path: <linux-iio+bounces-9447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ABB975AB8
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 21:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6241C21A95
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABDA1B9B47;
	Wed, 11 Sep 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+oqQtNu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06B1B1D53;
	Wed, 11 Sep 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081977; cv=none; b=X+4LmAvuEMs+ZDL31zf6X1R1SxuUXjMJ+HmJri+6L2ZzRLQncjA8Ll5HmTXaWvNh1/jjo9RZToDb9m6I4EkJpMM99aNb+ZlYJXPe+q8uvi/WEYDlKD5RXJ0vjZ6Tq7Ih6w/QeYeIKFipH1ysc9Jf7LspBsh1jZZQRgLHzEgliKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081977; c=relaxed/simple;
	bh=6a4hc9aWv1YiaHMYn7m1GwNtCFl+AUMEaP4xnDmR/U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX7EgLu36N6ySxPd9KU2jjyr/wlzgdaAPmp0Bo0n9IUac+3YcDqca1SvgjR+JShbYwPyTph3WikrWWT6GGgpl/gYzLgDYAuKf6aV1WuaiykilQqi9jglAldtk093S/Tk7vWCTpQ1ikrqYXce6BYlgATLpLTKjvc1g2VJHi3usE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+oqQtNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEFCC4CEC0;
	Wed, 11 Sep 2024 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726081977;
	bh=6a4hc9aWv1YiaHMYn7m1GwNtCFl+AUMEaP4xnDmR/U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+oqQtNu8MHsW+4lDH5CczAZ04A/VXuFdbTm1HfARCFfFhpfWChx24WuCz3ymakAs
	 r9B/yp7tAqTJY8hqFgFgVO/DUtpChYGoXrWNY+kkhxCr4kxKjUWosiQeN0xtyWfdwa
	 OmvtFpyeIFLuMnzv4celKXK8mbMhNWRS8qr0DBUfybrbbrdRQHPm8NRdCl5a8tS0BJ
	 UIQOiJk1I96ZzzdzQVrkqMRZBFgG5ZYQXxPFLs2oT/DteOMcWpO9F7103houFDP9ue
	 A3iI0IuNTgCGI6OyYyB9wbzBZRX02osDkurQlG9gp78EUjX+/AEba+dxOCpGYmOXC6
	 wyMm44IrZJ7hA==
Date: Wed, 11 Sep 2024 20:12:52 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Auchter <michael.auchter@ni.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad56xx: Fix duplicate
 compatible strings
Message-ID: <20240911-ruined-embellish-07ca645075b2@spud>
References: <20240910234440.1045098-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hxIJYbNzdbJjsrRN"
Content-Disposition: inline
In-Reply-To: <20240910234440.1045098-1-robh@kernel.org>


--hxIJYbNzdbJjsrRN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 06:44:39PM -0500, Rob Herring (Arm) wrote:
> adi,ad5686.yaml and adi,ad5696.yaml duplicate all the I2C device
> compatible strings with the exception of "adi,ad5337r". Since
> adi,ad5686.yaml references spi-peripheral-props.yaml, drop the I2C
> devices from it making it only SPI devices. Update the titles to make
> the distinction clear.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--hxIJYbNzdbJjsrRN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHrtAAKCRB4tDGHoIJi
0slYAP4426dhakOXo0ghGVRtf5Ey0VLk30rAY5BPl1zAHVIroAEAuVvfZmHVZz8h
hXNgs47Ldw0d6Cd/U3w+EcuA9+0cZQI=
=xVmK
-----END PGP SIGNATURE-----

--hxIJYbNzdbJjsrRN--

