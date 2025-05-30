Return-Path: <linux-iio+bounces-20031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E305AC875E
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 06:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6E01BA5BCD
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB11DB95E;
	Fri, 30 May 2025 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxHur36q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5A4685;
	Fri, 30 May 2025 04:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580020; cv=none; b=Hu/9DN4JCtfrJ6kz8P62azKe7qpckL4/JabUXMne/5ZtGvs5xgqIwcu8tz0R3wtvj4z5xgyVIQWwA/xc1dtFRmBLUkpUTzqc3lDR1M3IIShbnsPADqDCUSCB1LFHtWJoQRrF1DqlM8Uw+pEgnkwxoPm5YybHr3W71UxEHdis1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580020; c=relaxed/simple;
	bh=tswNpo2MQRV8iZVc5uTtJMk25/mhQ6GNaxBR/5g5e8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iYwOR7mxU2/gVpSnDqCVb3EfMY5TndhAWpXpSrRevwzAqYwDkbSVTWEYjQrSnnlSR1vFWeaazQX3GMteJq/zAhldbVl96vAdIUQc4E3b0N40QYYaZG2vcvPElGAuxQ6uz8u1PddL/PquQDUgKEXeqrTJtTl6U/+NXNyb5bhpV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxHur36q; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54b0d638e86so2448256e87.1;
        Thu, 29 May 2025 21:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748580017; x=1749184817; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7jDRPsfJcmBmBsRRdllGyKMX+F8KKZ2LgksoyEvwJo=;
        b=cxHur36qjEJSNIMHs3D7hj8XyGjTgoyueqahlbIecO99RHcb7thMOyOHFUK3HJaOKI
         QDwfsKe4jcJVrCPMK1dwVmo0oXhN7dYhgH7EO1nirqEsxktxe6k1Sas8Cwfu5UxPZH7R
         wODlT+iPuQtAWzcai6pK8gPtW4vdESeOdprSjv6q64O9llBhd106zk311xHazx64jZUt
         nGK/+tXBjsS2Xzz6EZQvUPMb2xeUX/OIl10CSh9q3rqv325WCYKxT08/HyS43GoJXHtx
         07C9KkWjdPBfzOFr8fyHEX006+Zt5K5EwRde9MZVaJEgo3Oj8yHs/jVCiLJcvr7DSZjV
         Vs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580017; x=1749184817;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7jDRPsfJcmBmBsRRdllGyKMX+F8KKZ2LgksoyEvwJo=;
        b=IH4gzpiNoFDaENHPjzvBtTPMmmPgVaPFL//nxIYLB39IY7HY7ERYyLDBKN1zHU2NM7
         Ri7TC/8UaeW+434Q3Vn1T+Ixn7PhvE7vIvD/uH304tiS0mecK58qmX73VK5LH0ZbbO45
         Myh9jJlg8YTd09q8+0pUzZlazKrvVhmOTpIlvDLERpaNWAEilUK5KFi1SHBS8wb21w0K
         X/Adnpnilo4gdOfHrk1HCf4iqKlQTp6aet8Xmdq5zcPm3gv498V6H132b2Tqd5M5F+vH
         M8bOq1/5JTCF6tVHGnfxhuJ5f5LQCgLDAw3/Xk6ETU+clVqsDnkH7tyIKDgIGnk9zeL+
         I70g==
X-Forwarded-Encrypted: i=1; AJvYcCVa4pgDLYNdL1wFu/CAawpc/ZxWZu1wcrdh6focFg0YjnbfrsF0KbS1zjEqqUrOMryfg3Q+l/GKaw4=@vger.kernel.org, AJvYcCWW+pqXylgvNvkHfIxzTiFZBHZgfUP+KFU17PStC/7C/d8DmuGhLvbjgG6vvnCSmaP4D5x6SXlsGMPr6Hic@vger.kernel.org
X-Gm-Message-State: AOJu0YwPI789tqPe4FMA1+sEpkJjbNK13pCnRIZutN+n7CbsbK2fXiYz
	/Bn2y0Y2GfmxKQcZN93NpvUQGti+G4XzA6NIMvnG2zsT49514VDnXvlH
X-Gm-Gg: ASbGnctabZ+/+VTjelCzvpF2bSmj2loaK+/Nqcw9RN2BKyFWLclwAlREBZvd3efAypG
	RCCqNedHwn3XI3BjKfw8L2X59q+/e/0b0zS9Bs4bOnesLwazVwlzaVrKu5axT0LlT2/hnsJk6gI
	+7SJK+PH3yTBx3pYWLwZ7wAuDnF+2cfTz5SqXJvVR1dmTiJ16t4OE3lsnvT3CvaDQ7XYOEtLqKv
	RKcrduUGLpH8R8xPqJzG9+oKVwI09opdgurM9TlXyeqsIboxcjAFmyeNeRHesYHVO4uo508m2WF
	UHSSa9T4XOw8Z1DcoL07xaxlUzzXHcRqdEcn6IkQwXWZzzxPKQYdPcu3qg==
X-Google-Smtp-Source: AGHT+IHu9f/lZxhijaI0tk/8HTQACRU2iT+CPX1N5gLWM5rgUo4yJz2PEV6PyeZqnL1e5IHaDwG06A==
X-Received: by 2002:ac2:4c45:0:b0:553:358e:72a8 with SMTP id 2adb3069b0e04-5533d1aa8f5mr235349e87.38.1748580016329;
        Thu, 29 May 2025 21:40:16 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5533787d347sm570414e87.36.2025.05.29.21.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 21:40:15 -0700 (PDT)
Date: Fri, 30 May 2025 07:40:08 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7476: Support ROHM BU79100G
Message-ID: <aDk2qNE9LTVnfAFM@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5IHD3CUwPkLWn4dS"
Content-Disposition: inline


--5IHD3CUwPkLWn4dS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BU79100G is a 12-bit, single channel ADC. From the software point
of view it is identical to the TI's ADS7866. Support reading ADC
measurements using the ad7476.c

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---

Please, see the relevant discussion (as to why an ID for a fallback is
added) in:
https://lore.kernel.org/all/f8ec547a-5924-4563-aa1d-dde8227844fa@gmail.com/

This patch was based on v6.15-rc1. I can rebase if needed.

 drivers/iio/adc/ad7476.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 37b0515cf4fc..d48ee8f1d547 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -435,6 +435,13 @@ static const struct spi_device_id ad7476_id[] =3D {
 	{ "ads7866", ID_ADS7866 },
 	{ "ads7867", ID_ADS7867 },
 	{ "ads7868", ID_ADS7868 },
+	/*
+	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
+	 * point of view. The binding document mandates the ADS7866 to be
+	 * marked as a fallback for the BU79100G, but we still need the SPI ID
+	 * here to make the module loading work.
+	 */
+	{ "bu79100g", ID_ADS7866 },
 	{ "ltc2314-14", ID_LTC2314_14 },
 	{ }
 };
--=20
2.49.0


--5IHD3CUwPkLWn4dS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmg5NqQACgkQeFA3/03a
ocUt9gf+IQJ+h80DmDoTrIetVncPDukfz8CBkHPrb6XvFSz8GF9xLZufuKvmf5Os
QK40O74UtmuuRmliEzSdPefVEZOPgQzQenDwN1lnz2+YtUonn5VCIlvWc15yvwDD
hdsIVaqt7sJ8vNRu6EDZk2oviLmjH34hISXd5+WP7euLUvGIadj6XAWgNxOy4YKc
onMeGXtehcDjRfM8gEwgaDaU61f5rSuRvBho1aynIc/LRbmK/Z/F2tGtdywjRY2/
WzuWWWeaAMLqJYI/q/qIGCriorowALLkrxvtCQ3FTefv9f+/GPlXyepOYJXXsvaf
IdsE5DUIQsO9YP86jQuHHDYgKiD+bg==
=29ns
-----END PGP SIGNATURE-----

--5IHD3CUwPkLWn4dS--

