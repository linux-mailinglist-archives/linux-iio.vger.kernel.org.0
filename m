Return-Path: <linux-iio+bounces-24243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FBB8351E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 09:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0696B1882B70
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD62DF700;
	Thu, 18 Sep 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kGWXTilh"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD57189F5C;
	Thu, 18 Sep 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180651; cv=none; b=HK/LJJKXCZeHTxG7ezJrdgOncQh03yCTDmZwVaeYxbKDiHP2rtSV1+v1a4Yv9VT9Sr00iANYtWh+13Niq7JiP7NdvWd0UVI21Ze1AdPr8bW4q16mCR0IzZLj22oMZHNQ8QCzFYKx7qTeqh/ySVQVKLWpLuC8EzAN/eTKeGiDbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180651; c=relaxed/simple;
	bh=MHnx+O7UTUM0+Qgvg+zW8i93qn3/EnGXsPh4/sTxWdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZf/AGwCxP2Zt6jUApsGHjARkxr9xWMnQpH5cTHTflQGF822Yk6/wTo0n8o6IFoKuuZtkTBRQwv7yDJAdxDgcRdbvNLG1r3P6aEd5OIyW+m8H0zl9e2IgNbzgncAcst3+9qDSOWTLIMZ+eaYk2WkXMojkKyeco0hjl77bPBqD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kGWXTilh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7DF343A97;
	Thu, 18 Sep 2025 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758180643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4F/RbCRhR45zS5/1p8N4VggT1zjMH4kZIX9ts8WeRo=;
	b=kGWXTilhH4TtdjeVJJebweGHw8Tg2+1DIrRp63aiXH8qyX0SuDv0pkX5btEfORsJIlgGvW
	Wkd3vrCNoMcNGTEv5FiZa+ENW8TiYZNeaS4hlVLOq9BX02mlFbzrgWBDrKsZ8GjZYvG9k3
	0pQPYH53Zb0pFQix0LKlZvigdocLQs3VHFJCykV9pDZ1m1VtxbQoc6mfrYLx0RXiDue6DJ
	U1LATn9b7zvaLrsPCsIQNKGGMWwXVd4nUMmROjACPeY+P7QqlPYMEcDrockDcCge0Q9eOS
	7jLSTaJSq0eKdhuITHHykuP2CjBOnVHO+IFNAzQ7+qgpk7GvOuSzZux+6ZSaXQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject:
 Re: [PATCH 1/4] regulator: dt-bindings: Add Linear Technology LTM8054
 regulator
Date: Thu, 18 Sep 2025 09:30:37 +0200
Message-ID: <12743863.O9o76ZdvQC@fw-rgant>
In-Reply-To: <5135820.31r3eYUQgx@fw-rgant>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <936e16dd-d11f-4452-8942-64366f173d6f@baylibre.com>
 <5135820.31r3eYUQgx@fw-rgant>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5923224.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdegmeektdekvdemhegrtddumegrtdegvgemfhejieehmeelhegrmegufhekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdegmeektdekvdemhegrtddumegrtdegvgemfhejieehmeelhegrmegufhekiedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhunhhordhsrgesrghnrghlohhgrdgtohhmpdhrtghpthhtoheprghnugihsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart5923224.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 18 Sep 2025 09:30:37 +0200
Message-ID: <12743863.O9o76ZdvQC@fw-rgant>
In-Reply-To: <5135820.31r3eYUQgx@fw-rgant>
MIME-Version: 1.0

On Wednesday, 17 September 2025 17:51:05 CEST Romain Gantois wrote:
> On Tuesday, 16 September 2025 21:24:42 CEST David Lechner wrote:
> > On 9/16/25 5:24 AM, Romain Gantois wrote:
...
> > 
> > Examples usually don't have a root node. Probably explains
> > the bot errors. (but you should have seen the same errors
> > locally with make dt_binding_check.)
> 
> I didn't see the errors but I'm guessing that's due to an out-of-date
> dtschema dependency on my system, thanks for pointing it out.

Just a quick update: turns out this wasn't due to an out-of-date dependency, 
it was because I was missing "DT_CHECKER_FLAGS=-m"

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart5923224.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjLtR0ACgkQKCYAIARz
eA6zYg//SpcEEDWVYymOTmBH8skAMdw8D4lEZcgSxweNQSvdYJ64NcK5aJKHCqZX
Iz7Tx+EAaofDaokVQMVoY6E2OFwAhXvgUt/nAhp1mIYnuDDcRHHiP+APC/RqFfPG
zpabha7++EtNbd/UCzInFf7WcS1ZPKowf3KHm8aOMQWtO8YGSIBSDylp810XqmTy
/odm6s0RUvcPXSOoT9/jmf42DquFOLPb9qQxmOZulfWzTJqyf2HD9A1LcpnpAEK3
U0XpEN/p1xaqR+lu6zQwQdGdZvm+8WUnRHVbdQyqb+sDvN3PZxVh/mLlQrvBFN51
eZv1Wh4HTK2kVwAI+exFgX8eULJOgjFwcZ6GVv9z7E99xNwq8qS/6i3TZvw6VaSm
6hQ/UhIwqSUUQ1mEDChYkwc87su1Nk/Vg3G8cF6k9/GE/qWL7PCCw5+V1+fqiK56
nSbYQpPPrkyE5+tkj64Oheg8j+mcPPyXnbpJ6CgNGLK+qIFzjVn43GPkWrtxDj85
9HH1dmDa5KPrhX5KxmRPA377ERSJny8RCxotV+tHhXZdW+1u5I9w2YUfp77e6WcY
hlm127OoCDCfuTw5Y0oqYNP0QlEsg1ZnBzzIVtFu74/n824njqFwYV9g61BqyLB6
Sj0ytJPkJgHzTls8zcO9jhfMMKLmhppywrqiCQsyzvHeqMc0tRU=
=FJAI
-----END PGP SIGNATURE-----

--nextPart5923224.DvuYhMxLoT--




