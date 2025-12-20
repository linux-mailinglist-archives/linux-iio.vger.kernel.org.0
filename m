Return-Path: <linux-iio+bounces-27259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24BCD2CB9
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B663010CD2
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230ED304BB4;
	Sat, 20 Dec 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="p7pUzw+I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573EB19E97B;
	Sat, 20 Dec 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766224766; cv=none; b=WSN7WZPp7+wLgfrxO7+t/ASQXO2LQbE6BHiTrDYVxQFVl6lcy2CKO/O1fD52x0DPuJnHvBKPEPLgJNPt5Vc88hE8P3oGPlz88PkOXEC8vQNG/IqkKteRQH56EmXfgMR7FrdMRKyB/qp/MNjyhpg22x9SCfC7+f7rDweq5DuUFt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766224766; c=relaxed/simple;
	bh=z4gVZtve8a6NLjtWjx82TwYn6cm5dgO8XqSs8x97slo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC2EUVleNkET5I1X36iINf/VwM6wu/uMbylQ27Kbmu6JQr3XAsg56+RHJGweKB3/Aho0ofQctghh1u3YsLdC4CGQKNR+MqzVM8apCSvmlqVJXquv+MtyIYvNpZB5NqTNxEBXKE9vqNIUk4gc9bp9/jxPpKp7yH82xzubfWTvzG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=p7pUzw+I; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id E5ED6160209;
	Sat, 20 Dec 2025 11:59:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766224761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4gVZtve8a6NLjtWjx82TwYn6cm5dgO8XqSs8x97slo=;
	b=p7pUzw+IFGB7vAoNH88owNd1RQe3hI45KSBadIOJFkUAknIa65c1bGPSEOQnb1HrawWc8z
	W/uhDbbqpl8L3uruYZiDjqpOtKbA8D+f8DLUryT9L6jqXp34ZW3/2lN8R1JFhMO8av6EcG
	7dX7cKYWjEvsSyNUwLdeOoxsIU/J/NNdnyLT7K9Q0vcp0G5cHt5wwoZw5oG14B+ndGF1g6
	Djs75l9gEU1JGsbFTpJbf95RTOp6MY8TKRRYlFwUXJd9CWvWaA5jssmOrBrcFX6W7bgLr5
	xQDEcBYsbtWHWGb5fzGzGaQNs/Nf9u48CwxlwSrNi19AwTjfn3toUWF6vEvQHw==
Date: Sat, 20 Dec 2025 11:59:17 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 07/14] iio: pressure: mprls0025pa: make ops->write
 function consistent
Message-ID: <aUZzdbBUJtf4mAjQ@sunspire.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-7-b36a170f1a5c@subdimension.ro>
 <aUYq2tpt45cTjKIv@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IQIJuRd5cTAWZ+09"
Content-Disposition: inline
In-Reply-To: <aUYq2tpt45cTjKIv@debian-BULLSEYE-live-builder-AMD64>


--IQIJuRd5cTAWZ+09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

On Sat, Dec 20, 2025 at 01:49:30AM -0300, Marcelo Schmitt wrote:
> On 12/18, Petre Rodan wrote:
> > Make the i2c bus write operation more consistent with the rest of the
> > driver.
> That's not the most appealing reason for updating driver code. Is the upd=
ate
> meaningful for a different purpose? Consider squashing that with another =
patch
> that makes better use of the updated function.=20

I see your point.

I wanted to have device specific logic in _core instead of one of the bus d=
rivers,
but if I'm the only one upset about it then I will skip this change.

best regards,
peter

--=20
petre rodan

--IQIJuRd5cTAWZ+09
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmlGc3IACgkQdCsnp2M6
SWP8HBAAmRIYKUk0TOlOjygG7RPvU7BSzqdcH375GKPSBuV2JPzjFOz2CiICAWgb
YNFaa3LuIhN/+L7QXBt5XYtbQqvtb5kA+fjCNN7vgYItqzq/rvqmNmZMoPWn0Q9k
9DmO2/f14wDUlOqYdF/qwrjwpD3GJGYiH3FBdtvAjag2mljw/pwF6jJI5pw6hxrQ
FxPXrwyO3bBC3q422yA/Nu6fWUn5g6jNjeV3fai8NSC3DpWxu50eTpDTs4J/+Y1y
Dl0FoANrlzWxY0+5o7MO0ckNe7e0GmVapm5etyCeeCs8GgsNHdQH2aj2ie0xZ+ao
378Ou0iPuDZbbPSu03zWEgoN9O6QPhEF4UvXf2BVKE9gNghvoF9hA/K0Uhg2PjLw
S8CsXHMeEMg1O3V/dYw+uSiXzQC/N+T5vcT4/jMDqW5+bXdkp57eXEnYIciGK6uM
P/XDO7Po5zTbohPck8TgULvur0ucqxmRFduVGmRbeaq3uEq6ZyurXjI5UlyulKG3
sfwbyHLZB/NeZVamrsW0oTmKNeVKluPm8JzwVgxL5RtgI9vrFUV+bEvCVlqhyHsv
I5BtuqN1JNDyyJmFlX5ykgbgNfiz7q+Q7bnn9Lds/j1sent5kIBFCIxd8wJOkcB5
3lT3JHbhXRNM+A2sNDvndhCI0u9KMsTkboDKsVlQEDrb3ZXZzIE=
=k0Sp
-----END PGP SIGNATURE-----

--IQIJuRd5cTAWZ+09--

