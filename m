Return-Path: <linux-iio+bounces-22903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3CBB29BBE
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2CD7B4E27
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16F2F1FD5;
	Mon, 18 Aug 2025 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3HY8D1h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13F28641B;
	Mon, 18 Aug 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504750; cv=none; b=S7dOnOnvCqBT69HQFiI89jXzE9vbmrylhPrOwJYXkNUIYMHZNYTv5o70H+tpq8sRTCr+kXv+LD1oLOebRlIj/CniRNm/0S55MZ1K5/GSIg4ONQw8XxP3BhTzKQUDbTCPxsOEA5GQyqTfSzAknODbB2YkKgrK3fx4bcOvzzaPc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504750; c=relaxed/simple;
	bh=4ABHj6VAXeSyXwZ+yP22j3tygSX4cygpeR/cL2IUG48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJah6NvpPBh8mJTYPtUk+GpvqD2f9+WDifORCIPeeRGXV6ArtaJ9RSqehT4MDgfOFV8Nhwu/9Tpvo+w9zuuKKzAp5MCurag4Dd9YeLbCq4acAD30rxMcQ7k1xV/F3Y6VF9VICWaxmJf2bu4KijoYlA9P2Pvd6Oj0kSBR2PsFuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3HY8D1h; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3352212fefdso3392611fa.3;
        Mon, 18 Aug 2025 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755504747; x=1756109547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQz57nvIkwA+D4BmZRYE4VBVr2zoK7JTVtvhkG580uU=;
        b=T3HY8D1hGP8cbixm7LPcfUgbaEv5YXRjsSNrs39vGGrPimaHzPg1iTbYzZYF5Y9KCf
         2U2+EhTnFfvYgJJAvXn/BS3BdEUVLiBNfWnO8xkKK4YS98k5x1778LdAmfaN506QQ3nR
         PUls333pSQa9am2odA2v/R+a3eP6znZitDIIuoWs8TNew+Gnuol+wmr0GQe/tIih6m+P
         0EzyAW3WhNv0lzytraJaoTTchgNrS8Mepwf68s8eSZC20p+HppM8Y/I/+Tx6Ccs8s7T5
         tPc+4sCfGhcZ2WuXczXpyRdzA/Z813JhSHXLxcV/jSz1PvdO48VzfTHXAL/tsq8MTGqZ
         jEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504747; x=1756109547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQz57nvIkwA+D4BmZRYE4VBVr2zoK7JTVtvhkG580uU=;
        b=hhbYZtr+1VGXjy0mLFP7NBF6lLlBR5rBOaHZ1HGm6t3RCNST80LEzNxbpebgseDfLP
         WTvvrLthzjrftTLKu/NRRMOKTigdWs+sgkNTSSseZtjdBh5Xm/mraJk4dP1M+Nbf39Hk
         4nFVJxEjKQiQbwI2m9yoCMl7k4ArRCLE4CcNo4hew0G3FkbBKR3V5ZrUbMgM8ox5lcBB
         anFKZaKSqxULIgqKm/2YHHapyccs+B9TtzA2M+T4MGgKTIIQ0jhiemI12rW2O58oT6hX
         Pn2KO4Knuzw/H6dWzYhJdPSX2dACcxDLWF1FupJEi864fL4ROXLaIr1zjKTPWEyHitUc
         S3KA==
X-Forwarded-Encrypted: i=1; AJvYcCUN1UnCiolfMg5+Z8SvtIrtaNlQFZDWU+HsXvUAvBxYYYVciFrMWW2e3v65/tOET/xX3qY3+ryP3y+G2S+v@vger.kernel.org, AJvYcCVZBEHm4GYxxfDaLHNfu2agua80w/jhVT2k7mZ9wI5sadcgyBtMIdq/fI/K1cRPbJHSXiwjuEJTZ5Y4@vger.kernel.org, AJvYcCVpet+ZEBZjk1ayjjE/AM594g5GkFwotIVjLqwlmXEiJHHp9ypC7y0u8pFMuAkgKKH3UOGro9e4TXzK@vger.kernel.org
X-Gm-Message-State: AOJu0YzeklAJPnrwj81pS7+zOATeLBYQsbvUVORYUdFDss3t8j+OiLE0
	UK1R5fykMMurbZMMJYIAHwxxhqHRw+4++c88NfOvbZ69I0DyMP4PgVR4+6JzBQ==
X-Gm-Gg: ASbGncvMKdB2KNe7ZjNyB5PvhRvTnsejkFGoJpIpdc12O640tuE4Yzz0QhAo0wvg/RH
	li0WW/ItFb1uPSGpwPyx3sMNe6KsI5884ui4PnwOPetCK/fOOyFTpfCJjvzQ7mfsrHi0UKDr2/c
	u0LNJ1FPvs2c7RnVD3o0DOMx5QQmvOL5mn5GkkTmqxFsR2H8ZtnyWSL7cXxaHzUL5U2796ttsi+
	FTj/WCpRW1pWvu3SRJL34TrhODVQhh8wO7P7rQ3U+Zuo8un9wNvYFkTaqXKvAS+aWsRRxBJZBXi
	YLqWQXrpk2u6CXozGBP5jgw3QO23rZCTN3uajHAFFvSr1DseGaKyDCdgIqsCUSET3lfIQjxOuMS
	jIktyAkpdXd2EdNv+ogyLKdUyS+/1Dfxnoa3u2zs=
X-Google-Smtp-Source: AGHT+IFVxpIxMEFJpF/C0VDQ7Afg+kD72Xwu6itr+8x+RXWXXZZ5OvEf6ZJPbr0LHy9S5hUPxEx53A==
X-Received: by 2002:a05:6512:2c8a:b0:55c:da6f:82c1 with SMTP id 2adb3069b0e04-55ceebadf33mr3173643e87.56.1755504746839;
        Mon, 18 Aug 2025 01:12:26 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef368eb8sm1552230e87.59.2025.08.18.01.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:12:25 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:12:22 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: Add BD7910[0,1,2,3]
Message-ID: <0874c5933cf56430b9440d19ff46f746e4897952.1755504346.git.mazziesaccount@gmail.com>
References: <cover.1755504346.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4UlmBtt+ITE11agR"
Content-Disposition: inline
In-Reply-To: <cover.1755504346.git.mazziesaccount@gmail.com>


--4UlmBtt+ITE11agR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
and, based on the data sheets, they seem identical from the software
point-of-view.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> v2:
 - Drop unnecessary "items"
 - Fix the order of fallback compatible for the bd79103
---
 .../devicetree/bindings/iio/adc/rohm,bd79104.yaml      | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
index f0a1347ba4db..d5192ec58f59 100644
--- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
@@ -14,7 +14,15 @@ description: |
=20
 properties:
   compatible:
-    const: rohm,bd79104
+    oneOf:
+      - enum:
+          - rohm,bd79100
+          - rohm,bd79101
+          - rohm,bd79102
+          - rohm,bd79104
+      - items:
+          - const: rohm,bd79103
+          - const: rohm,bd79104
=20
   reg:
     maxItems: 1
--=20
2.50.1


--4UlmBtt+ITE11agR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmii4GYACgkQeFA3/03a
ocW4mQf+JsnQolDCptpk6B0bcDya2MS1WrYYI7nq4SbhFeLx3ehQvx7sS6lcOgmx
Wtgcf8XrpLUS0SPdmEBzE1xUk1KBmtV9ch297a62XDifeYmhaCWY3eMYJWsD68OD
Nh6YORFjXBNR8knV0Oe6eDYBsoExwUNBTYnMUSxVwnUQifvYc26aft/7fDCfEu57
FGw/a3j06DhaFKTu+ZjIHRs5UTrDKVYHkKgRQt8xhd1HkoIJWxWtCnjWFlvAYjnO
JYOL/W8lePkhhI85LS9y1dwJ80oOy9lOL0r8LOAa6rcr9c0kWiPArLkwCdWG5Pbm
vyCigxBRQZKS8Yu4IXxdeV2k7ounvw==
=dDZ1
-----END PGP SIGNATURE-----

--4UlmBtt+ITE11agR--

