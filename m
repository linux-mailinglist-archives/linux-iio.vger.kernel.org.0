Return-Path: <linux-iio+bounces-24220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E08B80C02
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6E17BE2D6
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A5341372;
	Wed, 17 Sep 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E0DV8B4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F27341352;
	Wed, 17 Sep 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124272; cv=none; b=PkrYLDgWZVlB/ZhZyu8XtH+kyYn7nqnXVdKuHwKzoxamMm49RYXDfVnayPJV/9xbaneu1HEI80T/YbW9ZPuk1WmgZptGBRcRxjhXWQg1zZSwupEpGJcobWHueu7DbFFI/dAMtvfNM20Pz3zGGBsCCzpd8zTUJIbKbazhyAkFMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124272; c=relaxed/simple;
	bh=najpjZb1c8KxKCDHMDrrfxyuWSzUEpLP6UkAhnhEuwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1nQczvnKUA0XMiNjJXrWrbqogZCMJNRMREDA6isiIlLnGOXXhc8mCgnoT76Admhr/No9qj86VnghkjDaWHU9HD5ysS7zxWMoyCvI6pZ6a1SGwRNRnExPYUzeGsX+KRH8dqPJOVn/enPW7/QTKK5zG6JzsLTlp9kVn/WR+lWvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E0DV8B4D; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1C7843A63;
	Wed, 17 Sep 2025 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758124266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1c79sUNcMVeE8q34apk1GvyhbBN1jZ6cmstvanDQC4=;
	b=E0DV8B4D2a78odu/FKSlKYCGr7gdoXX7ABRE3ycoFBNQ4obfZNRRWWlERiRmdsdvr8aFNn
	ydIkF+d33eaQ8jgDL88ExAsSE9U0RE60sDGdV+NjicQlG2rv+8Hb26akHE2ZvuDhXYy7xQ
	x2flQhxaozQRNRS2b7fxhQkzfMBXl8PQWdqNF4n54dYz+frLGHrxH3S+RV3Mx56DrS4koT
	qQ1IBMUL6zLVB2i1PmyhqomvDm9BlFyhuvtDUl8oSJnbZdbFzGbSVo22hGKc6iVvmD9708
	93JhsesBGtxW6eZsIAmKvGt+c1nsDIBXsWxfrYS12jpRKHacFm/uk4rgQt3TUQ==
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
Date: Wed, 17 Sep 2025 17:51:05 +0200
Message-ID: <5135820.31r3eYUQgx@fw-rgant>
In-Reply-To: <936e16dd-d11f-4452-8942-64366f173d6f@baylibre.com>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-1-fd4e781d33b9@bootlin.com>
 <936e16dd-d11f-4452-8942-64366f173d6f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4774077.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvr
 hhnvghlrdhorhhgpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhunhhordhsrgesrghnrghlohhgrdgtohhmpdhrtghpthhtoheprghnugihsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart4774077.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 17 Sep 2025 17:51:05 +0200
Message-ID: <5135820.31r3eYUQgx@fw-rgant>
In-Reply-To: <936e16dd-d11f-4452-8942-64366f173d6f@baylibre.com>
MIME-Version: 1.0

On Tuesday, 16 September 2025 21:24:42 CEST David Lechner wrote:
> On 9/16/25 5:24 AM, Romain Gantois wrote:
> > The Linear Technology LTM8054 is a Buck-Boost voltage regulator with an
> > input range of 5V to 36V and an output range of 1.2V to 36V.
...
> > +  The output current of the LTM8054 can be limited by tying the Iout pin
> > to a +  current sense resistor. This limit can be further lowered by
> > applying a +  voltage below 1.2V to the CTL pin.
> > +
> > +allOf:
> > +  - $ref: /schemas/regulator/regulator.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: lltc,ltm8054
> 
> Looks like they got bought by Analog Devices Inc., so adi,ltm8054.
> 

Ah yes, I'll also change the Kconfig and driver descriptions in that case. I'd 
like to keep the lltc,fb-voltage-divider property name though, since that's 
already used in an identical way by two other regulator bindings.

...
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    / {
> 
> Examples usually don't have a root node. Probably explains
> the bot errors. (but you should have seen the same errors
> locally with make dt_binding_check.)
> 

I didn't see the errors but I'm guessing that's due to an out-of-date dtschema
dependency on my system, thanks for pointing it out.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart4774077.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjK2OkACgkQKCYAIARz
eA6jKw//RMj5RRwagLh2PF9GStE9vCC5p4+y4Eg0rXPlUlnUwWlVa7/7Lxo5iqGz
INOVs4kGtJDjAgj39G1b3xf+fD2BBQ83kJBJpwqq9q7Qd/GXykUeeAJn2aro8Ben
C3+uvKfkmYVseDEEmrve/AZ4q7SlbIGKfC/BuCOifh6DAmgXxeLLBuLjTV8DRGBR
jQQplTyW/08LX8IGIv+n4A7nvboH+dkQgfyLz3TOwXOA56frqh607OQTxvfe0xq0
rjR7hlQYI5F31Ta9uuYwp7ZYyGeEePyE+q2Ea1/Hu9yP+w6QWSQith3RGZ/u/cmS
Z60FXYyHJ5PAkIoyo9yLiCX5VID5mDkpapL9/jEMd+VMkq+HWthpoq5+aAUrhqTz
XZYyo+KS1gqZQO0Du70qvxUhodOjpsJYCt0JXnY4MYAkrAjREdTkDfjFQhkmtlG3
0HoSLJtN+ZO2JjdmdfdgYHcuDPunS4oUvaMBt467d0MxqD8OZYYTwmiRvLOY9QF1
hlW5VjT2w5V8Eb/wEFofbXfLJeO8tEblfLzUkM/YcgU9o9u0owheqd7xs9w2U5IH
LC+bN/2ZziX1tz02PTOvgGyrMsRjcYIW2s8qIw8WALy003I1TBmf2vjmnxcOQYh2
1o9aFwYvItHUzndWLCjmu7i0BEBX4NObUjgV23C3ZC1aBVvOxm0=
=Ccw5
-----END PGP SIGNATURE-----

--nextPart4774077.LvFx2qVVIh--




