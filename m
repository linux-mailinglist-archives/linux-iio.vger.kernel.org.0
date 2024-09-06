Return-Path: <linux-iio+bounces-9236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575F996EECE
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C86F1F25CF7
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AF31C7B82;
	Fri,  6 Sep 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJDADl9a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CA14AD02;
	Fri,  6 Sep 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613626; cv=none; b=UOwmdqxWK7K+vE1kPmcAdFkLFnYv1b34RUELrQnrsZQcXsmMpCT5TXg9tYK/CLz5UH36Wm4F+vnC2r+K7VBBgsnibP7iH6COFKF6WRlmk2BBshj4zAZel58122fPdgeRcE5DfKPH/yiRFKIXXD1taDECFxRBK1I+wlqFIpGV1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613626; c=relaxed/simple;
	bh=XYZgVVnNOvCiYw6y6Fch74LcuqV0QWyKuy+W82nJ528=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od6Ht5+5ExDR02Gl3uKdaFykiMAYrKuOfpVkuBwOSY8NCAJ/0uqhROTULzn5sgOCoo9TSdq9/FkwVcZnruxTDgOZbnxy7Nr7oPTzVZCLYXAGyaYAvngGYQ4Es0/hkg/eTXbyVGydZdFqQkHMjd2+UnBvJxMu2bEVg/4En8uvX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJDADl9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9D1C4CEC4;
	Fri,  6 Sep 2024 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725613626;
	bh=XYZgVVnNOvCiYw6y6Fch74LcuqV0QWyKuy+W82nJ528=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJDADl9a1LE6KvofaMfzAR32taeUBUpwXW/yUVyDWy107WwQt7W69gQ9L9X7+jap6
	 C+gVTIl0t0ZFSVgjUPS1vgGGulEt3p4msxfGsCJ6pXx4B2WJcdfa+7u76/CHIp8Sc9
	 hUU030KEjhX8Iuq2ykw1kbomL77+Ke2fdiO/6ZKy7Z1U6cs8QETWmp3U3pZWw0sEFI
	 xD/DSI2qrFcFrDZ6G1cPx+XU+rRitH61/1Fd0SJeZ/AG2ZE/HQu/0W2ThcrJeKIh4U
	 HOL7HzcY+zlwS0DKKQ3bUFBHDIcZ+Wr+w/y4nsv8J0kzh0MJScZydBQnkKAmqku9HW
	 fu94pM0yTI8pw==
Date: Fri, 6 Sep 2024 10:07:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 0/9] iio: add support for the ad3552r AXI DAC IP
Message-ID: <20240906-unwatched-backshift-4782a627278f@squawk>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlM2KNEqHFuk9uo+"
Content-Disposition: inline
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>


--UlM2KNEqHFuk9uo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 05:17:30PM +0200, Angelo Dureghello wrote:
> The serie comes from the previously discussed RFC, that i
> converted to a normal patch from this v2.
>=20
> Purpose is to add ad3552r AXI DAC (fpga-based) support.
>=20
> The fpga DAC IP has been created to reach the maximum speed
> (33MUPS) supported from the ad3552r. To obtain the maximum
> transfer rate, the custom module has been implemented using
> the QSPI lines in DDR mode, using a dma buffer.
>=20
> The design is actually using the DAC backend since the register
> map is the same of the generic DAC IP, except for some customized
> bitfields. For this reason, a new "compatible" has been added
> in adi-axi-dac.c.
>=20
> Also, backend has been extended with all the needed functions
> needed for this use case, keeping the names gneric.
>=20
> Note: the following patch is actually for linux-iio/testing
> ---
> Changes in v2:=20
> - use unsigned int on bus_reg_read/write
> - add a compatible in axi-dac backend for the ad3552r DAC IP
> - minor code alignment fixes
> - fix a return value not checked
> - change devicetree structure setting ad3552r-axi as a backend
>   subnode
> - add synchronous_mode_available in the ABI doc

Please give reviewers a chance to response to in-progress discussion on
a version before sending a new one. I've left a couple of responses to
v1 that I only had a chance to reply to today due to travel.

--UlM2KNEqHFuk9uo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtrGNQAKCRB4tDGHoIJi
0gkMAP0fMg0kSNswaMghdEcuBcw2Nuuy0PrcdbmBi3hSWRepjAD/Yna42ttOZAgv
9CtceYoLMzW91fz4po7QVWBqeFC79gM=
=6QYg
-----END PGP SIGNATURE-----

--UlM2KNEqHFuk9uo+--

