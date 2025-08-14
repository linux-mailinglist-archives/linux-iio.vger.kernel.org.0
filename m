Return-Path: <linux-iio+bounces-22717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04512B25EF8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 10:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3301D8807F7
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6207E2D63E0;
	Thu, 14 Aug 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqtSYFy9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826821255E;
	Thu, 14 Aug 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160521; cv=none; b=kKgVmSrI7mxK2Vy8k0VR7aYb6QuJ3a3kHvrUGWdDPP2LtTHrZto+T/lOnBNhYhwyDo3q2SW1NBiwSu5pEzMIUzJpjYYjyVrNXSCK8R+pP40MsTGhq6crM2Y2ZaxsKydWm9LlDQ+D4AIf5DKhHOlKxmu9+glKBB2yvzvp/kBO1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160521; c=relaxed/simple;
	bh=GrauMcqTptX20P3k/gQBfC4mz8ZlS1892uGLTze9knw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjV8XEN/sBlFNfocb0SssjdWCtqmE6S9ea9DxhDgZf2ETOiFDYjYyt9V3MFn6XpqYYYCx34wQnjaOIUbQa6e4JW3YF1fSFvPcOhDsEmukska8V9jS3blW5TCNUlrwD6DQ5nEjOs0ju1BNWMx5ULAY9WpU+bxF90SBkOZkp+Zl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqtSYFy9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce52807f8so630717e87.2;
        Thu, 14 Aug 2025 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160516; x=1755765316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ9vfZoIQnPu8V4AGCiAple7OJw+lWEZqoNWuIXlFQ8=;
        b=MqtSYFy9MOfg169gEp9C39Gne8lq5EF6HLksXbKAxhW/Ep46Et0zmH38jWtCwCpAC/
         wP5aU2DM4Ep8i4suoROGVnPhxyjGdLzwjAK6cQoNDFWjmvozOfYJKDHCExzCOY28A2/Z
         45kmP6wO1ey0291Lszy2DK+oVUaJ2u4mEHBCukTVdA54jNT4C3BDadnG+M9oxxr46dgp
         j3bJ7HK/L4SoGBX2YSBGVvvqIZVth3FHYlcHeXJddfrRlUSd0WWAbBf8QekNDBQY37iP
         DPjofjDVEP6MzKPvQAtQwmWZ9pSgyAs7/NQmRjXFP9CL8buSpHiebJxIB66kNvTGWDda
         f6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160516; x=1755765316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQ9vfZoIQnPu8V4AGCiAple7OJw+lWEZqoNWuIXlFQ8=;
        b=TzYJKOT7oORb3yqS0icgHwaPtaIqdP0hZuZYS8Hm5O+ERyvFn9DGVU3XatJgtFSOtd
         CViUlZ2mzp35vBMQ+GTwwwyw5LXHZlureZPuKWxiuJWIN1WMCzbkNI5jVhQNuOwvk++C
         H+3THR8KPFjFS2t7SK5paOl0n6sTA8dcpkJ31BkkgXRKNJLl4yc6gv/E2ueNuIsr49AC
         iAmGcTsg3fdaVF9W2QPqgGydhqknwtGym3BQFK+VHQaex7grFcbZnP3ems/huuk0YtFX
         trMzuHa5HgOr5Svs6XbpNfIC1L5LsUL6xFhxRh3RIyh7eVH79YvC0e6XUVsO3IXYL00o
         4RBw==
X-Forwarded-Encrypted: i=1; AJvYcCU+JS9fnJ2h11uwPAG5fCt5HJNuA0n9tlBFxGDViBP7LWfRFHQG8emCTCAlcAEEuJTdRiYsagv5u6vB@vger.kernel.org, AJvYcCV/Cs3XBszPPMp6FlRTSQofRieUGgcDqEHUhTlHl+hYJ3zbFotx5hR+KYiR9NF2i0zLnW/t6S0JwmocbPn5@vger.kernel.org, AJvYcCVb3T0ERu+s6GwPk96mT63E+65BfPkn6gbegZ/vQ44J6XSS7AuHDp8//9yPJbI8frOLnN/oyXjiw1zT@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+yoUqNXFB5iFAO+UCLw5JsaVWaJCY0uumr30pMbvEGHfnWrs
	9ot/Zj5OeGYwVyCuYlpgnB2gdPPPqi5SExda2OlbJ4oQVAacDXIsLqmU
X-Gm-Gg: ASbGncv3igbmi5o/rVxX4xBD5JxLHWsjtUbUFaUlbicbBAqyFFk+N0SVh/jjDa1DvEd
	rNBI1Yet9Dzd71d+oP6neprhEgA5Etq5IfCdlfEQQ/5LHRxfUlATub+9fXNmHzgBI9ZyQKExyQb
	Z4lfes7gf7vEWdGd/j1jIJw4Oh3ikrl7Ba6YkA0rU/t536kEtooKDcQMAKmUr7OjIQX/tYDPCT1
	RsyU8xvjXCx3a84iRC3j4AP5MWem7HJvKpfwMJDtYg0Bwhtonbf+BA3RnZgDMWiDpVeVOoYLSae
	RxWCyJ/6sSc6Mxz8UUsmNpDA5z8ylQ+SsU6z/uCfhyuffnE+y7bHHt3zAvNW13XQOKCb+ussN+/
	ZKsrmvSZRRvtNAJABFAOxD4Lu
X-Google-Smtp-Source: AGHT+IG0LqtwKE4lmtneN52Me6K3H+ZWEVkK8R3xRxq4Gb/UU3T4DZD6SkmnZS6pYKi8FhDm0mIceA==
X-Received: by 2002:a05:6512:b99:b0:55a:26ae:56e1 with SMTP id 2adb3069b0e04-55ce501a97cmr647024e87.27.1755160516077;
        Thu, 14 Aug 2025 01:35:16 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b9fd163dbsm4659496e87.156.2025.08.14.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:35:15 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:35:11 +0300
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
Subject: [PATCH 1/3] dt-bindings: iio: adc: Add BD7910[0,1,2,3]
Message-ID: <8ef78e3cffcfdf99153a3fcf57860771890f1632.1755159847.git.mazziesaccount@gmail.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gDcFeKkCusZoWwZZ"
Content-Disposition: inline
In-Reply-To: <cover.1755159847.git.mazziesaccount@gmail.com>


--gDcFeKkCusZoWwZZ
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
 .../devicetree/bindings/iio/adc/rohm,bd79104.yaml     | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
index f0a1347ba4db..6a6e6ab4aca3 100644
--- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
@@ -14,7 +14,16 @@ description: |
=20
 properties:
   compatible:
-    const: rohm,bd79104
+    oneOf:
+      - items:
+          - enum:
+              - rohm,bd79100
+              - rohm,bd79101
+              - rohm,bd79102
+              - rohm,bd79104
+      - items:
+          - const: rohm,bd79104
+          - const: rohm,bd79103
=20
   reg:
     maxItems: 1
--=20
2.50.1


--gDcFeKkCusZoWwZZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmidn78ACgkQeFA3/03a
ocUqWwf+MwpKHSS/SFqDncO5qLx8XUKgm8nVokZjUkPtDAqBgEDaCb1o5X9WkMMK
r+Y4sRNPeMghThcMxHc1xSx9eJ71JPVq7IXg+C4NiboTGw/HVMwP6COJMRSt4iiQ
/LFuteK4ZIaUOiyGcIbps7ZE7iVqUiHWH0XPdmpwKmhsmy3vXnDwpZV9GwAo26ny
Dz7xi0BL8IBLPCKkFGSRHZR7kOIKJtIYmIngwEFeQWhO4oywXSyyINwZDKNTFd8M
UsqMiRIEO7OQiwZNgZkrQoTxMUOliFBfhtgdRn5HW4DHetwT20X1wOIVDRlYRcb7
UClUzVOn84bbwqJlXFHzG3q3X2jADg==
=ivEM
-----END PGP SIGNATURE-----

--gDcFeKkCusZoWwZZ--

