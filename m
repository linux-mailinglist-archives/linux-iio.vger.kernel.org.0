Return-Path: <linux-iio+bounces-20511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4ADAD62E6
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D511886994
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6628D8C2;
	Wed, 11 Jun 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WQf4qrRO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B568286D6F
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681778; cv=none; b=an1muKpfOq3ZSZqgvFxHhyhrNAWOa3iinNz348TbIETPQo6yq4H1PQdPWaMvmeuQ7i1xZV+v1Lt5blr4m12ayor3uSgAt1ajPQZLQKsoWe4XOEEaG7IInE/1imZBAwa0hCpZQ+d+w5+7zDeySbdmwhyUh2G/gj2m2/xshzpZHeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681778; c=relaxed/simple;
	bh=u68bZZMO/JKUz2mz6KZxBlhHkEylsEbUz83VhCyRYl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIM1w7UV4MG3S3Wl9Ac1HvbBzc0hrfl6xeYxXwU401PKSnBjgB7yrhMK7gY0pLVst+EXQr8OgQ678huIaNRfpv897Slm+abmPfYiQWg4LIKAcOaJ4mWZqSrnlQq4uQ1uxGfgDtgaMfm+qKaBOl3kJkex87BNIPwolmsqj0tKAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WQf4qrRO; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-408d7e2ad03so219730b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681776; x=1750286576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O49HniDCuoXMC9eMwPqBiAeGw4w5v2Vl7zSDG8FL1hA=;
        b=WQf4qrROSO+28EkD5sVWXmK8z2KWV3zG/57mCtH9YdQfzke019dM2V2+sEbj0F/Ig+
         z4B4S2ut3ED1wHJx/tYaJXbTDxodlkry9AyIs2aV9hngcH0/1GdjppurqeU0dnEZeDeL
         IW6aBmkvRZMahgHQWqM8mCJTXt5rrNyYy2goz5SoeJBJc8i1unqRtQ0w77w6GWv5GADI
         HzpEYKyyaCdFrmXiEEZgZzOoeM8wlruPEn4mK0SFK0h2PRq3YvoJnkzFrrITb9AJWh39
         ccls/fJrWUEMmrZW2Bl9oTdf0UV9r7597UmwlHvoc9OCKT+NxKjCB07VpgJVmj1lJzyh
         GIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681776; x=1750286576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O49HniDCuoXMC9eMwPqBiAeGw4w5v2Vl7zSDG8FL1hA=;
        b=HEcY/VEDuJyRRRtamUtHMah9lsjGEMO8qamG43jEwRLcXao2YSELwT2bWAuxGGibaf
         xPaGKq9Ozkva9bRQQtG+SJxLEXc3YPoYzhlWY64OIydIrQKV9bUDRocl0szI+r9fy17x
         qcS2I7gQzasmGpVCySh3VhuUHPlAeH/rnNcpggdae/xulYGKz9Lv+fnNljskEUQM93Bt
         9OdiuS59yUHTzEH8z2Nc2uDokAWfKsTa3QiN9PYAZ9UOpbvGUy+33X8d7RNy1rTSfqVE
         CiaNMtSPZWPxfROdsN5ji7PWppSpJBfgvf2qxpHfcI00UrRdT9jwKBq02buAcyz5nX1o
         bvWA==
X-Gm-Message-State: AOJu0YyQ8IUakBMmb3zI1NSCk97j6FtEo+LCC9YOAfGMZMhQIdUnXRXO
	BX8b9L8hMVJxfxd7U5etY+ZP0CXVVCmwx2p2eS04CZE52m52gYJdghmKefKLE3dxu+Q=
X-Gm-Gg: ASbGnctwkBqdqVcrLzH3N9LSrADYj4LYtUxJMDfr076NCF4nGRYwCwO7EE9hdvXkADD
	TR1lT/CgY8v+q+fbAht4GGSZrJf0YuQ0uEL6tMJh+zh/PSQAmzrLWERUhyPuRpBVQxDuBuSxiy7
	IcNLViCIABX4Xm3whtHtR9O37R8s7Uf9aGF0fyD+zlKMj4o/74uGU4Y46accmqc6HuMdmhmBI5W
	wvVMfPtkK2VjTYBth3LpUP6dIvtvAmhf0i5KB/RQ70odnt5aZFHrLtxr0zCT1sIOwFZuxB6+lhx
	SHHCQbUKdwjGLugN5H8+vESuqs2buPkvqu60pdgsa+mglKIsc9AsJez54LsiCXQnF8Vb
X-Google-Smtp-Source: AGHT+IEdXlTs5BQlKqDRA2XR9le0U//SvE0Qifl3mfGztXMmWUlblRQ96qzrlkvIsB1m096LadrsCQ==
X-Received: by 2002:a05:6808:180c:b0:409:f8e:7282 with SMTP id 5614622812f47-40a65f87782mr956229b6e.5.1749681776215;
        Wed, 11 Jun 2025 15:42:56 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:12 -0500
Subject: [PATCH 20/28] iio: light: opt4060: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-20-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=u68bZZMO/JKUz2mz6KZxBlhHkEylsEbUz83VhCyRYl4=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDK82DgYtDNtb2gx3z7l0jyT+eHvDe25Ny/eC02uWrn1Y
 Ct3oj9PJ6MxCwMjF4OsmCLLG4mb85L4mq/NuZExA2YQKxPYFC5OAZjIHWH2f3bdcxonrJAMav7A
 XffFu02lOFatYYFB7CF7t92HHtwV1csJuGihoZXQqzjn9qFVwQ9lw6WjTz/KejJDP9U9zPVrSVd
 FI6OcwCrLffXZi7bwHns3aafaxnuO18SbZz42r7q3SNX/4t5VaVwdlmdCG1e/YlOZNq/SJHTm1b
 6D+oXG06fdm+A7z+KTCU+oXc0f3u8ab+avuiHZGW8WcF/yQc2Kvd6bNgqbneTXPqugcUbhajePp
 EmfdwGzmsgpxSwm/ZdqT8JD1yvJaf4XW2u/8qFBW/Mx9Tn3HWZaHeLU2JRZ4bDydVbTlvcc7xlc
 pgl9PKq54uvTWCH/WaeKFt2rffq43yDVPalMb2os24pjAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/opt4060.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index f4085020e03ebadb2b91db3212449db82d738ebd..3c927149bd256b392ed8d1bfa9847788981ef2f0 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -1083,7 +1083,7 @@ static irqreturn_t opt4060_trigger_handler(int irq, void *p)
 	struct  {
 		u32 chan[OPT4060_NUM_CHANS];
 		aligned_s64 ts;
-	} raw;
+	} raw = { };
 	int i = 0;
 	int chan, ret;
 
@@ -1091,8 +1091,6 @@ static irqreturn_t opt4060_trigger_handler(int irq, void *p)
 	if (iio_trigger_validate_own_device(idev->trig, idev))
 		opt4060_trigger_new_samples(idev);
 
-	memset(&raw, 0, sizeof(raw));
-
 	iio_for_each_active_channel(idev, chan) {
 		if (chan == OPT4060_ILLUM)
 			ret = opt4060_calc_illuminance(chip, &raw.chan[i++]);

-- 
2.43.0


