Return-Path: <linux-iio+bounces-24427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C35B9DED6
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A061C1BC30DA
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 07:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EBB2652AF;
	Thu, 25 Sep 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dAMtEwG+"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F710A1E;
	Thu, 25 Sep 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786872; cv=none; b=VVBYnsepXn0hXhC1f2+M/td1I/B8cnSUFypDu6Vym5GYLwRAXeLifJZyIqTomiL8KS3QPNBNRWo5GMF2dTITXzBI91Thi1qBhd4eXr4lnIZf3QN3nzmJG+bTeQT2yKMItFlUdYUHaQcEPi4MvFXeV366pd1uac4KMrb+0+2BNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786872; c=relaxed/simple;
	bh=wNrIs/KMRNT0S70Q52NO7ztxcCDaM4WDIdSvpz8vEAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaqM4IinbUiL5Uvxnt6kUEevOeY/qVpLEhAOnR5txfOVjHcE9e/3vSszXRGF0SJq5tFDFHjkE5rE+61ZC1/MsAg0OUEd8s7iuiAlrFV41JacM/+v7redBWZRiZ7apvakqvT5Jm0gRe2ldlVHQGqzDf53DchnVIB5pW87hHTEjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dAMtEwG+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4AE81FD45;
	Thu, 25 Sep 2025 07:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758786860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0yQO/AB1frPLT9/UjMZgXQd7K0oFinoOZukSkiIkvU=;
	b=dAMtEwG+F2+E9ANALyZUDw8Yv1pyBMIrps8I1f5UxSgSGoRXv4FjKfIuLD8+6tGz0cKv+g
	cywSsi91XdS5qFAJ97pZFRv7PD48EHm6+EbN2IFcvkx1V0JV1xn8ug1GgNVUTnP+Y7ZO8N
	eDP5t9ZVuA/2zlCjtAs3RLT7kQ7UlPj4EoqzlB3oWfCd84AmePLJNmcGMfT4P7fhhPf7lE
	nxY9IZjgRHbLvWBGUuBIldIN2az5SN2DQeeJCPwfvewX/6U4I47jUnAX4Pw6yyAFFXe863
	4jTXNZmmBHdp78CFPdCNsP2s+CiYO2Y08rxmMrjPspyRyI9LiFnEA+TwFpB6SA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject:
 Re: [PATCH 4/4] regulator: ltm8054: Support output current limit control
Date: Thu, 25 Sep 2025 09:54:19 +0200
Message-ID: <2800270.mvXUDI8C0e@fw-rgant>
In-Reply-To: <8772650.T7Z3S40VBb@fw-rgant>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <aMlj1OcfH8r9Zz6x@smile.fi.intel.com> <8772650.T7Z3S40VBb@fw-rgant>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12748939.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhri
 ihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart12748939.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Thu, 25 Sep 2025 09:54:19 +0200
Message-ID: <2800270.mvXUDI8C0e@fw-rgant>
In-Reply-To: <8772650.T7Z3S40VBb@fw-rgant>
MIME-Version: 1.0

On Tuesday, 16 September 2025 16:27:25 CEST Romain Gantois wrote:
> On Tuesday, 16 September 2025 15:19:16 CEST Andy Shevchenko wrote:
> > On Tue, Sep 16, 2025 at 12:24:09PM +0200, Romain Gantois wrote:
...
> > > CTL pin voltage */ +	vdac_uV = (u64)min_uA * LTM8054_MAX_CTL_V;
> > > +	do_div(vdac_uV, priv->max_uA);
> > > +
> > > +	dev_dbg(&rdev->dev,
> > > +		"Setting current limit to %duA, CTL pin to %duV\n", min_uA,
> > > (int)vdac_uV);
> > 
> > Why casting?
> 
> This one is indeed unnecessary.

My mistake, this cast is required to avoid a compiler warning;

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart12748939.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjU9SsACgkQKCYAIARz
eA45Pg//e+RNIVNH123KKvWSDgP/4K9vIfxKQHteDzWnbdc/DAJYmcztCg0sSO2h
KGsZZ71OoXBoGhArjD8Fo34eIXXAjz2jfstWmo1LdkggibiPFzphGUl8yFz00dVc
Bxq432+1pyWZQf7ebJYthZItWYASHncO2hObvCXaQH+eATZaaXpBaYs12GeVO+Pc
Uhy5as0lV4y2V0Zx6VXrER/N76f6TPkZieFoy8w0izbRLb1ECDgkK+mPK1B0heq6
esjvYWVk97HKedVOSCq/ZHMGCaoNHFumLCjGuLH897hClVRBfvjNjxg+XkXr8QAo
SuQmYmGZofuEeVAV5ORIaoXB72cPbxiMvgoKjEYqzT4NgNhFep1bHYRYbVLwTEjT
/Mhl8ulFstcdLX9l/G2uoATXT+GLjlkxMS0AKL7GQ7hFLNDxTpOSc/LBQYQEHbVa
az5Z+5DIM4PZs2O3RRun7WAyEBEpTGAVJ3a4JjvqjYXDAoI4CneXueamV8zyU4v5
QPEPgAvST6JUv/mj8IKRfyFgW/gNNemg0krG/INhDBYZYhO+x00wbxUnSLsawxcR
XIIVFj0APWQrXUzVrmiB2ceo7TsHzGaSIaV3pVt2pJUFglzTNBr1T7wWMk1JyKC5
qecn9T8O+qBIm9LWvUNpe7WEk8pHxbq+4JSGnTh2Eg7fKL9MyI4=
=ltTp
-----END PGP SIGNATURE-----

--nextPart12748939.O9o76ZdvQC--




