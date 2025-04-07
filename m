Return-Path: <linux-iio+bounces-17756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C036FA7DC68
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2077D18910EE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E123C8BB;
	Mon,  7 Apr 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BktBQZc3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BE238D27;
	Mon,  7 Apr 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025804; cv=none; b=rEunulxiQXgB9dJE4IPJ8c4vTqSvxBDdbx7icNDVD6OBw/TCAm23w8Io631N4cq9omGT1xx40SNK3PoWCSKe704UW+22ublp6eZcTFe/ytJtoNwzaDcVHVr7fhqQmZuK4Y2wZ+49Q7Ev5Y2XLYFRP+XaWuT9dxfzSP2Xs9KupsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025804; c=relaxed/simple;
	bh=OBb6yPw+qEBGKPSi4wctAZVMTzOzBeM49h5g17UI5OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzpHEQwyHvCLUkdVdOO4ADuQUKbfRgJsICpdf9HX4rL2aQWrq6/lZXMnY4x5ecWTqxUHKFCLXGw1LZ/DPSw1zdv/uuoIc6cqz0gi0sNRyXz1uLydTCu8EGxUA2RrMVsmroyIdfSHZfM40E8fAUE35NmTX3e1So+Q16Lg9r24MOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BktBQZc3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499c5d9691so4807412e87.2;
        Mon, 07 Apr 2025 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025801; x=1744630601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5WYMF9sR/AEB+gocgzCJwNMf68a65+bR/TxFPCym6o=;
        b=BktBQZc3C+sdQNFGygUuRZ9GP9IoTUKNj4mRbXko4J6GUiU7+V7H/SRUzwnPjHsF+R
         nl/X54pOGbBHpY5nmj6HKfLttuvSc2Pq0lbM+YxZBOY+BCixy1zj5G6Jkg3wrva7aANp
         d+wZmpFC9FcpQYWPHw03YJpeTWoBZQXq+AvaCBZuWbqFvTZQunym45uCrOnoSjnOFfOE
         VZB36KYEnxMsCaXh+5FVXyctgYO8f35BlOTCJ/3ur5VK50K8LPnpePQGoFlr/UnKUZkg
         wlPHf0ENgfvkoc768aJ8MhNKhIud7QT8JXAKLp4Kxp+rv/AckzrG0POXevVt+r50smuT
         f3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025801; x=1744630601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5WYMF9sR/AEB+gocgzCJwNMf68a65+bR/TxFPCym6o=;
        b=r5OvAqW+/Gn6TAcdcnNTBtoBj5ZA7N0t3qN95DykW0tw2nOJ6J1zUuhP7s8xFPnz/T
         /xs8z3y3BViGt/wLel6aQu71Pp8b86hdrgciTNWe3LTNKqDryRmFQEDZfuBOEL+i/AgQ
         W5W1vnga8LD5nbcCpApuWww7aW3xwo/kRKMTiVKeVXvGLkOmWH+6dd5AwaQFUGNYPTGH
         qYxCgFIGSSLrI7PndQm3sYynJPS53fFImm+sla/n996Lfft8CKi1HxuK43i7TtG91+db
         k3hW7FjdGhNLPf5Six6v5sx858+8ES1sQXLDObZvKSFVSouPF9eKUxBn4WIZ8tQCarrp
         s4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVdgYd2R1nRlZWXjQ7YEjw0SctQAI5AuwRnfNg5XsWzekQJ9YrneuQiPstAf5YNjYjklGAiGSyBQARP@vger.kernel.org, AJvYcCWct9jYMVCTAntklOZcHF5wu7o39YuG+JvOcL4wmXtFpMyvUoiGgqE/EHJtsyoD6PoMvo+WmI5FYm/L@vger.kernel.org, AJvYcCXnzdcgxI0lvSrKwLRHgGGKTQIR5L3Gr0JhXlij0Mm9KWpU/rnUItpEHwZIT9a60ytX+gKvqqhooA+Hql91@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZIUUn4iP5H5CspILESDQWcCTaQ+9pO75qukKHFjiHTVAgfY2
	RkPVuJHusqHw4ed4Sp+cqOo+AQ5Smllm8flCj0QsFY6ndXs2XtPU
X-Gm-Gg: ASbGncvpYmh5jCqxNRs8/DV5YeWK+8qxOzV3oCz22kduwfdeK10Bxv8yMYHS0RdMtee
	/YTK/bm+IF+z+4fs8vY+Dg8UTOJxiPDWLBNs8WZL8XmhYQhctuAVlmS6i6K2TyeOVTJaDkBu0mJ
	T/PdhboMIlIzncT3Jn2kHjOA5WNtsEwrvZmyxHWrxasEY+0trEVs09+sQ1RJNV6DW8rNFRHz3Bn
	WuSgjjsHK13znIpC+BF2TbZPQ2Vyn30f1Ik9Wg+VmhxvxGGVuUK5NT76DzPhkn5uT+b0X8E2AE7
	eprTsMWxK8uyoQGFo/z/TtlgKhMuZ/UttKW2mREyLCLdWWEgQ3Q=
X-Google-Smtp-Source: AGHT+IGWymGKOu6AZA9EMBC8ePoYK0OBTREO6kFiVCpG5la6qLD3EgSFy/3XPagXuN5bVvUi0MeXnA==
X-Received: by 2002:a05:6512:39c7:b0:545:76e:31a with SMTP id 2adb3069b0e04-54c227678e5mr3453707e87.11.1744025800582;
        Mon, 07 Apr 2025 04:36:40 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e635c25sm1213461e87.115.2025.04.07.04.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:36:39 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:36:35 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] iio: adc: ti-adc128s052: Simplify using guard(mutex)
Message-ID: <c4262cbf55748d505a74249d2bf46d7c3594d838.1744022065.git.mazziesaccount@gmail.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qoq6psZAdITW0+6Z"
Content-Disposition: inline
In-Reply-To: <cover.1744022065.git.mazziesaccount@gmail.com>


--qoq6psZAdITW0+6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Error path in ADC reading function can be slighly simplified using the
guard(mutex).

Use guard(mutex) and document the mutex purpose.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v2 =3D>
 - No changes
v1 =3D> v2:
 - Protect the shared message data
 - Add message data protection to the mutex doc
 - Reword the commit message
---
 drivers/iio/adc/ti-adc128s052.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index d90a5caa028f..fa0099356be7 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -9,6 +9,7 @@
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
  */
=20
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/iio/iio.h>
 #include <linux/mod_devicetable.h>
@@ -26,6 +27,10 @@ struct adc128 {
 	struct spi_device *spi;
=20
 	struct regulator *reg;
+	/*
+	 * Serialize the SPI 'write-channel + read data' accesses and protect
+	 * the shared buffer.
+	 */
 	struct mutex lock;
=20
 	union {
@@ -38,19 +43,16 @@ static int adc128_adc_conversion(struct adc128 *adc, u8=
 channel)
 {
 	int ret;
=20
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
=20
 	adc->buffer[0] =3D channel << 3;
 	adc->buffer[1] =3D 0;
=20
 	ret =3D spi_write(adc->spi, &adc->buffer, sizeof(adc->buffer));
-	if (ret < 0) {
-		mutex_unlock(&adc->lock);
+	if (ret < 0)
 		return ret;
-	}
=20
 	ret =3D spi_read(adc->spi, &adc->buffer16, sizeof(adc->buffer16));
-	mutex_unlock(&adc->lock);
 	if (ret < 0)
 		return ret;
=20
--=20
2.49.0


--qoq6psZAdITW0+6Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzuMMACgkQeFA3/03a
ocVzrQf/WF4HoK5anyTwz/muitsdxazNn1tN91lO4/3HvHqTlCsctGJ8MAR6+/Sz
aoRiyl/TlL8TYf0KwdwXCkmZA6MnPkP31fKI1uuo07F68S/bgszDn6UR8luIN+tK
Is4jgaOya113r6o2Mm0LfT3sFY5tnJPTY7pEmyj9QDW6XjKoLAZCajVmiEVKPxI1
L3okxSKQdmPPFbnZ+mmlwivlPOT0tl0cH6bBZTPh6TH2wzIQ2WuI6nyjKXUm+1O0
MTMsYaq6PVrRicgTBl72FuPM5/mChK4YQpRrAns4VqbrrN04XudR7CjHxlcR1pQ7
a3Fgm+lWxyMHYZ70g0OUY6pulRT8fA==
=i9Ov
-----END PGP SIGNATURE-----

--qoq6psZAdITW0+6Z--

