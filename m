Return-Path: <linux-iio+bounces-23818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B061DB46882
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 04:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6EF7A94F8
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 02:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C17176ADE;
	Sat,  6 Sep 2025 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="CufvtUeI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75F315D3D;
	Sat,  6 Sep 2025 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757126792; cv=none; b=f3pRIgZbBSudmZHIADQPOXUWqFCskyAglpeP5Su6u6lhtbQjSevJLha34lTBMIpNGkISCiLii94BKT9pYz5ivN0pJgyK6rdTPebrJzvu3ipYe1JwKxsK7Yf1L2jZZTDaI6+M6AXqhRK9ki/6CJhZRSK7HlFee9cBPTYKgHAj+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757126792; c=relaxed/simple;
	bh=cuSltagikN408QYHgTooo1E013IEputmPRHwQWankWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXUPBw/0AzdSr9E1e9Gg62eOcvhAe2Y0OkgYxt00MGGbhxuoUbd77dd5zShRsaqNzOVMYouBdKggK1j/1/k7WKPf0YAVE0XEUP4cvxasZyl/OeFcMyXI3H9TSiXecnyaS2X/AxnyNXvV3wIenaZzw1AMD7itnQ9NSPpEHGFWckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=CufvtUeI; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 717B1173BE2;
	Sat, 06 Sep 2025 05:46:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757126780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ir5fLotwZ2l/CmwU600U+FfTQJnBZC4n4ZqVBgoFiWE=;
	b=CufvtUeIiv+3FiXH4jZQQDFHJO2syczrGAD5bkh8pB1/M/0ukulRih2Isj42BVwo1hwqOV
	ocM6RS+TfnjvlCDELUpAw95H/d/phrUfSvfyNc+l195FLSsGD/U3hL2dWeuexYv+d+hfkg
	zaVuGc5kTvGDILp8xo9xr+2tl6QNCvzAC8ILKS1tRWccCRDOmnhS2B7yniqQIQevdlAPVX
	2SVrJgxWjqAyS40AAorkFnRaBCW2OtzchNMAeW4aAyqoGk3qxYu0hiMnJ8KyHtwIAKyMh6
	u9QdF4n4NUzC2UAMeIVUMzOzoV7+teP7NyNii/XJCRJSt8F35g4gis3V6c4UJw==
Date: Sat, 6 Sep 2025 05:46:17 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, Nuno S?? <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: iio: accel: bosch,BMA220 improvements
Message-ID: <aLugeZiJjJhTpwUO@sunspire>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-2-petre.rodan@subdimension.ro>
 <210871b8-4967-40c9-bbaf-338d2d6d9c63@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <210871b8-4967-40c9-bbaf-338d2d6d9c63@baylibre.com>


Good morning.

Thank you for your feedback.

On Fri, Sep 05, 2025 at 03:15:55PM -0500, David Lechner wrote:
> On 9/1/25 2:47 PM, Petre Rodan wrote:
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.y=
aml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml

[..]

> > +  bosch,watchdog:
> > +    description:
> > +      In order to prevent the built-in I2C slave to lock-up the I2C bu=
s, a
> > +      watchdog timer is introduced. The WDT observes internal I2C sign=
als and
> > +      resets the I2C interface if the bus is locked-up by the BMA220.
> > +      0 - off
> > +      1 - 1ms
> > +      2 - 10ms
> > +    enum: [0, 1, 2]
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>=20
> Why should this depend on how the chip is wired up? Normally, we don't ha=
ve this
> sort of control in devicetree.

I was also unsure on how it would be best to implement the feature, bellow =
is my thought process.

The feature itself is definitely required for the i2c implementation of thi=
s chip. I have witnessed it pull sda low for no good reason twice over a 10=
0h period and this would render not only the chip but the entire bus unusab=
le until a power cycle.

I think from a driver perspective ideally WDT should be set very early - wi=
thin bma220_common_probe() would be ideal.

> E.g. if it is useful, why shouldn't drivers just always enable it?

The registers holding the watchdog are all zeroed out after power on which =
mean it's off. I think the driver should also default on this setting. In m=
y first implementation I had it hard-wired to 1ms, but I felt this would im=
pose my point of view on users and it would be nicer to give them control o=
ver it.

If you guys think that the devicetree is not the place where the WDT should=
 be set that is fine by me, would you recommend something like module_param=
() instead?

> If we can make the case that it belongs in the devicetree, it should use
> standard units, e.g. property should be watchdog-timeout-ms with enum: [1=
, 10].
> Maybe 0 for disabled is OK too - in that case should have default: 0.

Oh yes I can see it in bq256xx.yaml, to me this sounds absolutely perfect.


On a different note, from a reviewer's perspective would you prefer the nex=
t revision of this patch series to cover less ground? I was thinking about =
leaving everything event related for later since I might go past 15 separat=
e patches if I split every modification into it's own separate entry.

thank you again,
peter

--=20
petre rodan

