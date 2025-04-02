Return-Path: <linux-iio+bounces-17530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A42A787DC
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4127A3E6B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F279230BEC;
	Wed,  2 Apr 2025 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBkT1tXJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22D136A;
	Wed,  2 Apr 2025 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574171; cv=none; b=qDiDzxdKNIxoV9AE/121ODcZzbiMppL6Dd+NdwJph6X8MzxCfcdokRTqWxgPhZiYdkvdWTdusNMCELvufFvdMdqazYCimXpLce78VEH1x1YUdrutW3DAFdvO5vnI9OHkWBVeigboW0cZWaUOBesOoXgm6QAnrs1iGdRAhvi123Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574171; c=relaxed/simple;
	bh=nQCP5rOUWWNuVPx7AP+DZdpf1O8Vu7cguRKHJly319o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDZKexnnaD/dJEf3pqb80QxZIdoIby514/g1yljR5/8jQtwtlyFlxKEsG9/vhU7fd9u+dzFB+P1cpK3V7g66ZjgWvq7H5onjk0HwsFFLAQwEtguZnSa3GRz5KEWUqsH8T18NoIpgugdDODZaRc/ew7lniqY152NJbQnCt920tV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBkT1tXJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54963160818so7009238e87.2;
        Tue, 01 Apr 2025 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574168; x=1744178968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zu//oB5ssYNQZ+B6FTpSmisOtA8ogv1o3avMrDXvoV8=;
        b=FBkT1tXJdSpu3t2nfUVvoL3mpwhfuk+mFGmJxdBL9/0ib9VEfB2lB01stwhnnARteK
         +DXNA5VQoWBAD0caTmwHeKhoaEPK0YIblXBl81OOa/Le5uP5dBWFp9fOl0iatH8ox+Uf
         j7ovZweILormgd0GNOHRDfDa/yxf1xU/4cFa+ZvagDbXhC+Mk6pPNel6OAVzAQc+oist
         QED1J9DYNzwUjwVyCuRQ77MYTAp53mM/YLelhTGhuO5MuvxGMLYFG+lynxRbBoQWegNW
         OpBIjFbur2Uly3pDQJaXzn4pumHnT2SWhW9h1NQAkeClOnRKNIR2h/AtKbGbZw3VE5r8
         7J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574168; x=1744178968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu//oB5ssYNQZ+B6FTpSmisOtA8ogv1o3avMrDXvoV8=;
        b=iZYfp8jwpXIXPpaOaaY05sTpLQL6F0MiVtF4oYWbjbJAObL2yDaOAeh9lxfwwsqclz
         cFObhKAn7GIbFjgrQi5tpEjQAYx10q2dlvSoE8aPriWDzhGivNS7GIcOd/arK/YSCFGG
         bEFRAaV1a4bXwtswEGpodvirz1WfBzj4Kv8hRkeZln2578Uta2x8nBJ8PDGKrNcv76YS
         hvn+s7inhUCLVkRSTlxjbudUqZzdDjXD6fg8RBMoOBfS9nIWx9zG24rhPwa8C7j5h90k
         U3yM2PGn6ernVe9JaVAbZMgZWYHyxGq5RbFnogtZw0IBxoj/9yqKdYrX6nDeIQFVHz4T
         yrkg==
X-Forwarded-Encrypted: i=1; AJvYcCVpo4IIUB+ZYwphITKRUGIp+o1n8webjfKU0CAqgkJp6XmVkUGE+Jvm9gW7bU7J6jj79X9/IxkoOtKfkQuu@vger.kernel.org, AJvYcCWXs52ndyAMNjqmr98LbyyTSVOUeSCOZ7SKz1IM45kic4x2jTPtEXErZzpEmb1treRC2yFIY6O7nX8A@vger.kernel.org, AJvYcCX8wy67OMCXUg200iBbt2Ugj4p4mQcm2obv5R3Cnqptr6mo4kAOaoKFWvuKdTRwRvSmkwqZCHSKV+wt@vger.kernel.org
X-Gm-Message-State: AOJu0YxppMGYxqUj6EaVHKy/merjKkK9idDxRSJhnjYuxvTqF6SjRc2m
	jeosu0Bym8ZutubHOMnNTyRA055FdgKCZljDHKiqtP0XixWmjLZD
X-Gm-Gg: ASbGncta+91ICiqhW3wgCMoioPBNz4PA8O7H3AcvXYRVDXQoVN+vt+OktqI/1eDVb2t
	LSup+9DCPK+D9XM2dbwzfB6iqawHer8xeyRLQOKjXnoB2aXc/6fBJej1IfXewzdbaFz9p6eaevg
	2b+H1bF4nFkgN575pPQyiqHn6QoVUea18Tk+bw3MOnnIEhdFD6VTFiHnjk6gHXC411fNZHd50N5
	7hBPfziSp4nbZgwh/ax2jqVNVD7Iz4CcOXG2zZoZFSOA5ROpKyv8JfDbxPZuoq+ANHXWfCAOOE2
	zfWhztxFyKbeCGRzkpe1egvGbIgG4wagwjDULrMo9OiPnoe0/SP2QoUpnc8jbg==
X-Google-Smtp-Source: AGHT+IHyrepEC54mlqOD2w9Yu8EejPHoWKonDpQ9W2WdN0yBtM/KrTUZt1BucisZfMY9hd+kg0+9Fg==
X-Received: by 2002:a05:6512:ea1:b0:545:2f0c:a29c with SMTP id 2adb3069b0e04-54b111315b5mr5166693e87.36.1743574167549;
        Tue, 01 Apr 2025 23:09:27 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0957f9b7sm1568800e87.139.2025.04.01.23.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:09:26 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:09:23 +0300
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
Subject: [PATCH v2 3/7] iio: adc: ti-adc128s052: Be consistent with arrays
Message-ID: <2024394e033de7d0d1c92768de5e5de2273dce15.1743573284.git.mazziesaccount@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/YMla69EzJRrlXTe"
Content-Disposition: inline
In-Reply-To: <cover.1743573284.git.mazziesaccount@gmail.com>


--/YMla69EzJRrlXTe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ti-adc128s052 driver has NULL terminated ID arrays for the
of_device_id, spi_device_id and acpi_device_id. All of these are
terminated by having an empty string as the last member of an array.
Only the of_device_id array uses the /* sentinel */ comment.

It's better to be consistent.

This /* sentinel */ comment serves no real purpose these days as people
are used to seeing these ID lists terminated with an empty array
element.

Drop the /* sentinel */ from the of_device_id.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Drop the comma from the end of the of_device_id list.
---
 drivers/iio/adc/ti-adc128s052.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index 3e69a5fce010..861a35169196 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -186,7 +186,7 @@ static const struct of_device_id adc128_of_match[] =3D {
 	{ .compatible =3D "ti,adc124s021", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s051", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s101", .data =3D &adc128_config[2] },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
=20
--=20
2.49.0


--/YMla69EzJRrlXTe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs1JMACgkQeFA3/03a
ocVAOQgAlJ3+pnSGy2fbEJfHh7A3zLGHDx+Sa8GS/hSjQqBSXRDIVpQevtuc4GMY
Ha2oCMsMhh7qT593OOLI/P2D5dAww68DU0bqAtldPV/51VAnPEna9wSOuVlYWQ9P
CxwNXn2FQusPMz/lJdnRdv21HLmLJHcv1bl/cRldNtuGAnAWXiGg6VzZnXKW7zCU
CQkhml3CpXT72UFMgmerq8UFtx9XNJw7WVGdU7DxBfGuJ8JNI1cWjR59ubGMHcdU
B8fKyg94wQ1a/w8Ipzncgg64LtLWbyq9vvZtQgdCdnaBIW04Wfq7WLOFB4g3Tciy
fW+wGSftHzPhsrNjEfc3yPK91TFULw==
=yOkh
-----END PGP SIGNATURE-----

--/YMla69EzJRrlXTe--

