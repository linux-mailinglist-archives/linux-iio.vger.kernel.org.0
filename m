Return-Path: <linux-iio+bounces-23656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171C8B40A16
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 18:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555D81BA0D67
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E72D5C8B;
	Tue,  2 Sep 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="cNBQSq6n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B5334386;
	Tue,  2 Sep 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828980; cv=none; b=avNIDnUKQLsyjtCFastchW6mhyM2fKhWoeD1QNmu0gsKCtEi6nBpjq9meeVPYhcHp3CnWLbBxfuYqGqN9Y2wrSnc9Di0CuBBHNHzmk+kUCZxvbRei7Tu8Z3Rg80+5Gkm5ogmH7CXVB3GZwse70xR7Bq8mViNJNe5p2gjUupfYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828980; c=relaxed/simple;
	bh=xDxcN3H+8kSCMm4mPqy0mSov03r9E9gWpP+uHpXvlhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqV+w8AOdgjaUL3jUoUgBORdrJVP9/3n36z43irt0/Z8vNAP6hUsuGalS3ergG3fC4Dp4aT+vSaBm7+nRYw8nPn4m3yxQKvkSNzx9KpyBmAAW6yrdXTNItH1rUliEkKF4Fb4TE3aX+JPxLwto2TO9ZgiuOMjmrX1vnvlrFcKT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=cNBQSq6n; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo (unknown [IPv6:2a02:2f0e:3503:4a00:883a:954a:4119:e1c2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2A655173BE2;
	Tue, 02 Sep 2025 19:02:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756828975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ljwpzP/FnYqP0+vPjueBPIIqlGbquyGsLPb4XlMHpE=;
	b=cNBQSq6nHCNRNdpnnHJIuMfzmOu6y5Kk+oRotZZta32pRoJcP7blIxinHeJGN9xz9xSOdq
	nBFYWuW/tsVtQobus6BY6aw8FGHCZT7XthoS1kXEiGlLgp8Bvb4syLFugOdDs76ZH+mveU
	4SyhxP1xCYYvF54wu9bMrgctISX1ZTDMij679ElYs7hCNq3lkp8jwMZgZ0Qp3caAC7iAM6
	B0YSbD8eaGvpZW7NHXNyI1vVZ7R0i7Ae8NjwvtMUP96StWFBhxBWGv7cAwU9TrUo+LIE5U
	PUF8FPONP0NOJFmxJjXrliJmjSwgRW7weE9GJSas2ydFtwa4mj5qYEkBjG0DfQ==
Date: Tue, 2 Sep 2025 19:02:51 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: iio: accel: bosch,BMA220 improvements
Message-ID: <aLcVK-YzlcqaKV_M@lipo>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-2-petre.rodan@subdimension.ro>
 <9b5bb45d-75ba-4674-9c4d-b04766496447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z5bPr+SRghAfH+B6"
Content-Disposition: inline
In-Reply-To: <9b5bb45d-75ba-4674-9c4d-b04766496447@kernel.org>


--Z5bPr+SRghAfH+B6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello,

On Tue, Sep 02, 2025 at 07:57:03AM +0200, Krzysztof Kozlowski wrote:
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.

I'm using the bleeding edge togreg branch of the iio tree, git pulled yeste=
rday.
I indeed missed devicetree@ while manually copy-pasting from get_maintainer=
=2Epl on the bindings patch. I wish that script would provide a valid rfc82=
2 email header instead of it's current verbose output.

> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.

the patch set had gone thru multiple static scans, unit tests, checkpatch.p=
l and the dt_binding_check on my end.
since devicetree@ is not emailed with driver code, I will still wait for an=
y feedback to the driver part of my submission, I guess.

> >  - fix title typo
> >  - add optional watchdog setting that recovers the sensor from a stuck-=
low
> >  SDA condition
> >  - set correct SPI phase and polarity
> >  - interrupt on rising edge. the level-based interrupt that is being
>=20
> Cleanup and new features must never be mixed together.

ok I will split up all the bindings changes in the next revision.

best regards.
peter

--Z5bPr+SRghAfH+B6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmi3FSsACgkQzyaZmYRO
fzCX+RAAmJ747MKAoFvhoHpuh1UnO0TMc4Pr+qAe2YQwgn51VZ/wJm/uZHWJ3Sj0
CTglPdv9J1MlXgPhrAMNCtVJBdsX2VqD6gkZOH+BmjxP1UhJTsdbfMon9wazGwz4
OQo4S3ige8zZ1hBjIp6MZYvnzxtGkaqT0lSBjarx3iGDVhUMxjC0IB8uHEnFHa/y
FPujR57o6429qnXOh66dq9pLKuuS6gsXAHiDJCnopWPzO4ieKQBaeb3/Ey50THMy
tTZDJmYaGs/wl6uQbcNUzsDTO5ic/PxVwq5ic8DWDNpi7Q/b6ohhsAJ3G8pbEO0l
ZBBc2TdjO6cLp0Xoy+9KpYw476BlEfhFydjrZcmRa16X16JQWF0KvyioGambC4Ix
5OdxPBOQUCyO0f0xBmxJQgghVezYm7dCkev+xrLhpKzU6zFNaX9nD7qnyjLR6msO
0tQ9h/W65VaGjsvIL9HMhp3SRijMHT6gpp6xXQ3Gqqy5fdYt4ezNJfBMIeu8QXjl
KRGyiI5C+lyuGhCdLZoP2DnOf2ZECr1/9YFHAHlEsHtGNgr0FSoaSKASv3CV6B3g
Ur5jwbyfLbL+Zc7l4tfBFSGN0jQPQ6xWJbNCD9lpGUh05xR78y6xln4eje6Gs43z
ClBZcT0Iplwclx3F/wkXbBNS1KDFwyokJ3OBW4c1kERNBCRXcpU=
=DaY4
-----END PGP SIGNATURE-----

--Z5bPr+SRghAfH+B6--

