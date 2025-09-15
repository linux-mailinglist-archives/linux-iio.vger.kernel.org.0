Return-Path: <linux-iio+bounces-24104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC0B570F3
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 09:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041E5189CB84
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255E32D29C7;
	Mon, 15 Sep 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz6i/ODU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F12D24A4
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920385; cv=none; b=EG7XEUyqLd8Rm632iffsfKBxxtIYIbKMVtrYQ6VES5tnmvXpvVj9p7j3Fr0RutlQ61es9PYu3UyKQkycQPWhvXA2z6yXAp6Wsh8thmMPdbvQHCYlzgnYbTvOzNAikadthY8QIknFp9IQJV6CfbUsDNqddQ/bYbW68mWsUKM1dXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920385; c=relaxed/simple;
	bh=L+O8dP+NoaSvco/dHI8EdGARObzbo2tfHErlsbYjBq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw58okYRd8DqOjdtKIW99GOXAVrlrMSeRAfkar6QWz9mFbMAP+Sp4Gppu3LhIwzgTNUx1c0EnsZ79dqDaQijt/kiU2KeOQZehVAy8Lnjs9h3+oNBLL3vLjUIySMd7g42iwbRa53rqoSL8eQP3VSx016BK18AAU6jUDnxuzaMoGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz6i/ODU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3515a0bca13so25984041fa.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757920382; x=1758525182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nperUovJGBRN4p1U9Cqmddf2EFz0RAhcOgsrNCHsdsk=;
        b=Jz6i/ODUvyDGBmdjft2+KcZlVeVSM/Fc2Fc9PEsfaf6iS0fLt++ffCOdlAAfsU54MY
         w9P0jfPUzsIUOUwW4eeP0nCKUbrU3VNiHhpV/2FBDHfBppliQ2te2F7CugJAXnMhlasX
         SPVMQReN/ncArY0PG8Q9RKP+2r25AcEehn7ztMeW3KVjPQrgi8CZ70tniiWtTmCQC/kC
         SmVvvRht2Sga+vajuPtOrUwcVyTALbXNuse2s/dNsGK3xzSvJUZVdUzMlfL1sM7X56ZK
         O2UgzLszFH8hGsu7aNoVCsIjG4rXXh2a+nJSdJT13f8A0AVl+034PCztgLxyUKTxpSRW
         809g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920382; x=1758525182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nperUovJGBRN4p1U9Cqmddf2EFz0RAhcOgsrNCHsdsk=;
        b=J4QV4dvfTGoyKb3WgDv+/geZXoFDZru+DvzpvwgRVkbsRgpc858Vii1rvYADtyvRNu
         c7u8gkXrDEn4jld8d6u2jQgkirnUekd6eGjVtcZcj7FthuqY5GuwYDDhxl7q/acuuBuk
         3PNjiLcURGYPHJlHR2FGFQL28XpuM1HWFtOR6HV60z8eVlohesW9y1iEHg33/zm+GwBB
         dcdThlGp4YQkMQywkX6zFyCjPEtuuZf/8xIXxCJbRNKkndf0OaF4WlOdSFRKeyP1BIPs
         5j0Qzm4caWwg9w8EOAxa9zn6KbbAZDa40bTWmMAqgPzGvo+0JZNKQMm2D75E79I5QjGq
         0pEA==
X-Gm-Message-State: AOJu0YzfCLqt4W7xFPSFqEvEkoZEWpejn3NvWNW7hidNzsZ53YDYJv7u
	75JsHBPpcJfY18SDtpJfXZrSPxsZ+KTE3MrpmGxPoo8vgspA/XvADnJp
X-Gm-Gg: ASbGncsgkw+uIOxJ8saf7POXuumc8qGSUGWJmSSypILiqKxAGamI/kUDO41Am7CAq4N
	gjmRxPOUCkihdkym9aFrEZpv0RGKK7YmvSbaHiwBj8DCC96DQaead5WcQw9760LYyeLAjBlI+T6
	RZ8iPfQ5EM6qcluYiYjQ4AwUU2AQ1Hyd1LZkZgBgV2tVyYPP5lhXQ2mki6l6ou836OC5FhNqFF7
	wiaAEr2W5G1PEy6dnbiq3JwS+bcHoT/rkoAWY6CDYfgzsjTr8zEGuhI6LEfbARb70dn7HRGk+3w
	6yDq2/4EsiFUbkMQe8WUxKjszP1G8U7JYjP5ew/h0M/Xx4Hq7yWXRhjxYpoJKCq+GOCjHZQ8Qiv
	ncgk9/sh5YOMllfmLc5vTeLJp7w==
X-Google-Smtp-Source: AGHT+IFtHLrp6nDSFIjlQ8dE2HKGNN3wt0ejQZEvh9/tOfDi0dZB1430X3qA0RvmHQEWq0Llk7+qyg==
X-Received: by 2002:a05:651c:b08:b0:336:b891:18db with SMTP id 38308e7fff4ca-3511487945dmr38768791fa.2.1757920382159;
        Mon, 15 Sep 2025 00:13:02 -0700 (PDT)
Received: from mva-rohm ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f401bsm26932681fa.19.2025.09.15.00.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 00:13:01 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:12:57 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v5 3/3] MAINTAINERS: Support ROHM BD79112 ADC
Message-ID: <20250915-bd79112-v5-3-a74e011a0560@gmail.com>
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XriNK4zL7+BKWUIz"
Content-Disposition: inline
In-Reply-To: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=834;
 i=mazziesaccount@gmail.com; h=from:subject:message-id;
 bh=rWC+YvC4JADy5afIx4GhMrizCQAlp5Zfa8zbihvqrIk=;
 b=owEBbQGS/pANAwAKAXhQN/9N2qHFAcsmYgBox7tkfo4fS+eVy4+fm0x4lni07xLl1ttSIfNcY
 1wz2X0eTTqJATMEAAEKAB0WIQQjH5/zBlvbx8soSFN4UDf/TdqhxQUCaMe7ZAAKCRB4UDf/Tdqh
 xUQiCACf3Q3fYUvZjJpHNsGrzfMpdlThHm0cZH+rHmuosrtAO7JJwN11DjrDxFYjYZdf435yWIg
 kj4pYcGCHfxuvJeUOsFWyOrvgh6e8LEDNM7iQImwSceBTfOZLrf+5AA1dy5Htd1QmLVcdkSK7Ay
 pRwG426FpwEgXmG+6cz1fPwl8QyufgeJ35fxtCPINDyHNrmGTvB2P73ei4gGX7MC+N8tQlhH7x9
 I6ZCH4mOp0cb8fexzFZsKF8Uz2RRov8ioqDEaUn3IZPNSOFZDPzSWIC0QFzLsjfghdKAdapMNZK
 zADdXITkPVmYNOexupeOcT9B7Stf3qgVR1kF12xi5yNc426f
X-Developer-Key: i=mazziesaccount@gmail.com; a=openpgp;
 fpr=83351EE69759B11AF0A3107B40497F0C4693EF47


--XriNK4zL7+BKWUIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the ROHM BD79112 ADC in the list of the BD791xx ADC drivers
which are maintained by undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> :
 - no changes
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af1c8d2bfb3deb870d8df44b8bae22e7cffb5aca..8e78a1168c17d8c2c7056e99e19=
1d542ef0b95a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21864,9 +21864,10 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
-ROHM BD79124 ADC / GPO IC
+ROHM BD791xx ADC / GPO IC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
+F:	drivers/iio/adc/rohm-bd79112.c
 F:	drivers/iio/adc/rohm-bd79124.c
=20
 ROHM BH1745 COLOUR SENSOR

--=20
2.51.0


--XriNK4zL7+BKWUIz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjHvHkACgkQeFA3/03a
ocWGkQf7BApMorYRm2N9zKifAYTH7Y1kBZcVOy+cQU2kCWn9rHtkbmiv4lXOlCdW
ijLitSt/W+g2gO4DxPFasUjMIexvrSK1e0YpEW9qr+p3ZrB3sRyRP0Dapt/QmaFH
BmuO2kDObyfTS6yxKP0zk3TGVOY/AbJVpYVa2X3p7DRw3yQJfOx9F3VrETy4wkVb
oZfz+pHgv3QdVaYdUVGpe1lmBuIF0xBtZkKi00TO/r9rsbON5k4mxxThdHzALTKK
2ckqzJIYRIOKXFmVlGdLjTSgn1DmURKzeSkwKP+JpCQApC31mSRZqppLufa5nyBd
1KyizdZHf1C0XaChOVGsKrPPzOdNXA==
=KpM/
-----END PGP SIGNATURE-----

--XriNK4zL7+BKWUIz--

