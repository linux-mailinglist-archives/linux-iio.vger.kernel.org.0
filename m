Return-Path: <linux-iio+bounces-22932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CCFB2AEF5
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 19:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C5D3B6EBF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4245532C31F;
	Mon, 18 Aug 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwM5xa7z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28732C301;
	Mon, 18 Aug 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536838; cv=none; b=NOItRsmTZrEDvmrhQyQj3mSVyj8F5NG3cHf8FovK+i6mql43I4Mmo5+cp9gM74p5SpcDrYotLVem+1XfEf71Jsu0Ef1ZJwOIkychmI3PmZKrCQwKDSY7rDcBTspL/LH+SqMAoqrcA+LLgSVeYyZa6OrFowxDtcundOyHLxUgeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536838; c=relaxed/simple;
	bh=DMFUlb0QbcQLyd+3fRBj3N8ZbxXoQvJ+x2MKjR6v/2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmCFFl53MqmF5eDOil8VskF6kEpIJkUAOV7qOsTcgYskM7ivB6F+uFH6hUX3n8WjsQokITvjU2BQCrq9cbK0P9VModRy5682vUVTfv/+dcWBoLYiRz0L43Owc+0JoN90eu6JwLxYLaf4EVMX5PpjzyU89Cemzm6IVI8il9Qq2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwM5xa7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E28C4CEEB;
	Mon, 18 Aug 2025 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536837;
	bh=DMFUlb0QbcQLyd+3fRBj3N8ZbxXoQvJ+x2MKjR6v/2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwM5xa7z1lCSpAC7sOsJnwOS7HEXLEvwpJV0kmILUVQHU31KsFea+9ZduqwwU+3XG
	 vz399FQbQ8AJE1ZpF3fMkmL2QgU2fbXmkbl63GaeThJlcq8gM10ZNrnaidWOyeB75I
	 4wKvNB2LahE6psq7poo7a5c1PBnv0uAv5yQqGiDzXjt0UP/ZZTZ0ffVUFC0OglVMq0
	 vTaBdc7QUkfo8tA07arSwpcEfZt/VAQnTIgdrsav8jjnCP2rV1E0g46R32U6igjWuc
	 s9NwLOWjftq3RTCXsyKq3uNlycVomptE+atbDILxzQ5rbOCBh+NFJrCeiy1CXuMMg0
	 DYy0DXkZCTkTA==
Date: Mon, 18 Aug 2025 18:07:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: Add BD7910[0,1,2,3]
Message-ID: <20250818-pulse-darkening-eda1dadc2f8e@spud>
References: <cover.1755504346.git.mazziesaccount@gmail.com>
 <0874c5933cf56430b9440d19ff46f746e4897952.1755504346.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EIcwQsLxqQAdvg5O"
Content-Disposition: inline
In-Reply-To: <0874c5933cf56430b9440d19ff46f746e4897952.1755504346.git.mazziesaccount@gmail.com>


--EIcwQsLxqQAdvg5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Acked-by: Conor Dooley <conor.dooley@microchip.com>

--EIcwQsLxqQAdvg5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKNdwAAKCRB4tDGHoIJi
0h2wAQDNYmOr07SJlFVPDcGE1wR6ocAcHd/C2AySNA851zMO4AEAnzYvR9Wpwdx0
MgbvHKfWfTYrbj4llYtrb5YyWwj3bww=
=qpyI
-----END PGP SIGNATURE-----

--EIcwQsLxqQAdvg5O--

