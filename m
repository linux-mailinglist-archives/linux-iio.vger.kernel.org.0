Return-Path: <linux-iio+bounces-20513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCEFAD62E2
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D311E11E0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95924BBF0;
	Wed, 11 Jun 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jAXhq/2F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA4253B67
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681782; cv=none; b=BCOpkbPWus/UJyzbMgWugt4Pxzep1k8jOX/V84XBqBfkyrlM+BFX5vDSvFimiY1IWvdZvxO/G3bHymx4OTP4TFMsZunOQwiGruFDaeN+DCS94AzD8w/uuiRD1/PNuINCYAMl8msu0mAyRQXNtpvwxou82blC3dPsfGTjd3ZApGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681782; c=relaxed/simple;
	bh=xfo+bLocNZ+ozgq43j0BzWHfY2nDbmMn7PxtgVZEL70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Btr4QQLHnSX9vlCQKRPawz3UTdER3dVEe0AZCXIHDkSOtY4lBwnX4DzW2FVh2m0q0LjA4mABX3UancWwaefJCFTsMPUr2CfmUod/vp5blREFH5MHbRBjvwHQ7IcOWTpkjw2rv30QHlD9NFwADoVwhq0l5tTVtrNCad2xFrCGBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jAXhq/2F; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-406e31162c6so124143b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681779; x=1750286579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PHi9Zj9Ui/Tog0J9ameekJ7BZTN9ebJ9txjTOhyyok=;
        b=jAXhq/2F9sbqOWQcpfUQ2au9SqYQmT1XF4A/IKcAL94dZ5TuV0V6MTn8Kcv7CicdXO
         qP+t5m4PXd5mck/aNCkxoXRrGgX8BBzLpbgVjKhmG1M9o8jUXtMQCK6n/yLWej2I/MI5
         C/QOsyhnz50FRULsy0CXyFhSM+HHaApKRO9F3P+Q0aeyVbIOoaJ7vnu5lqsu90NaXey5
         HZyL8GmPgF3YL0YWP76RwjBtQ1BCOSCjxkKkn/knRVVs9jNf4OALtySeNnIeMYEPrMfD
         WtgVFlTcMYc3gfo0CrbI7aZ5C6qjMft8p4iYsa4fbe3RZwbDzXR6NRELyppZx4h79jp/
         dTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681779; x=1750286579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PHi9Zj9Ui/Tog0J9ameekJ7BZTN9ebJ9txjTOhyyok=;
        b=f3s8JeR5OiWx7N/S9kvlQMALb3gfqr5aeoFHSQ/Sf7g/c9PL3SvEPr3kolMt0Li8Sq
         OcXdAw7ZueS8rwOTx5ROK768Zy/clGn/+B0rQRt+Sg5Xyl135ah0vqEVX7DiTsIW0kHr
         6skdoue0qveoawIqXgLNl5RABP//DOu7+LUrJ7wPhmaUX9ItWVvFRPjrptPnR+S0eB0q
         u4R6vNhnk2F7LmQRWwJxd7kF0xLG7ALu8m7+oPZ5/b2ENxXc78sXb8pPogH3W4Cofnvv
         hLtKI7qUH1KVeTDll55/kJCJRKbVl0ZQHfFdl7LI7CdqlkazmFLRDMjQRUgy7uXpSSx8
         ysjw==
X-Gm-Message-State: AOJu0Yxw0RjQxsw7nS476FWtzgeb1iEhRhBaKXu1BLPY6ESIJXbdYSNu
	CAq8WdAI7x3E88Ul9hjxjVL3+TCRRrv1I4fcXXmllwVeJ5ACBegk7tZw8s58u1T8dBE=
X-Gm-Gg: ASbGnct/OtZziFOm6qJWNsB77CEHakpDiejpaA97Xl3aOyNPasXrQn6TNyPuOf7/Dcu
	T9ApsBlbt/huyyEtuPQOLXOZuLoqFOOOvkGEPmfcWf65ROnyaW1hbOY0ZkFKkSAwDXG+cDQeq8t
	oyVv2hkymS8nkibqrU7DR45zTD1BwKxTvJX1CmwSP5OOrEbASuHocxs+T6Hz6uox6er/JUSWbpm
	99X1AGbdgLC1Ttw8WQT5jDkKSZn0H+oBwGOaXEgczvMYXwdW/6hWS7jEvP5kHnNqZs8aZvziWB1
	Y4EAVwq/R/DOxw94odHPjn4SMUsBt5QFLZxBVwCT45HD06k7XiZ7wFCbWeWZnUyafn88
X-Google-Smtp-Source: AGHT+IHKzyRz68sxYKViKX8XxVgxmO81ZgT2dv14jVru2VvIasYx7regY5fkOkngJzDhuEAN/YPCrQ==
X-Received: by 2002:a05:6808:23c3:b0:408:e68d:975a with SMTP id 5614622812f47-40a5d16d77fmr3602477b6e.39.1749681779529;
        Wed, 11 Jun 2025 15:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:14 -0500
Subject: [PATCH 22/28] iio: magnetometer: af8133j: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-22-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=xfo+bLocNZ+ozgq43j0BzWHfY2nDbmMn7PxtgVZEL70=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgYWPB3M7jW6HKeyERo49D2SpKAeHri46eI38
 JoL31MTT0qJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoGFgAKCRDCzCAB/wGP
 wPxgB/4grQvzDDyOnubC62RgBYgnw4jtW3rdAB2FG1+1ydj+0Kc43YVQztNQF+icooBBlvW5j6N
 FW4PY0Jeb0BTh9RBuXKyG7mMFgvtMx2dCggSrx6hB5UNgMYZODfVp8yw6VONYvXU+buhtXgt4D5
 qL/YfV2XT8KRBLCxk4K8o1NYevnW1tnYG/R126JosvMtbVgCNw/Dbk+m7jsH2CsB8vsr8KKQ478
 5DeyGyUBFsSiEiiP5NsqpdPDx4vcHq+LZBr9Fw0hANxaUoTgY5IhgMrcEJHSqPr5+gW9TzxR2uX
 6JcYo6fVBZyMpzSdbUsTuPWPLE/Fi7MLc5KlUVIbd9h5rmxW
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/magnetometer/af8133j.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
index 192ba2da94e299d9a223a33bf15f9d6e6c29f6c7..b1768c3aa8f33c6e95e770a27f55cb357e6ac6f4 100644
--- a/drivers/iio/magnetometer/af8133j.c
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -361,11 +361,9 @@ static irqreturn_t af8133j_trigger_handler(int irq, void *p)
 	struct {
 		__le16 values[3];
 		aligned_s64 timestamp;
-	} sample;
+	} sample = { };
 	int ret;
 
-	memset(&sample, 0, sizeof(sample));
-
 	ret = af8133j_read_measurement(data, sample.values);
 	if (ret)
 		goto out_done;

-- 
2.43.0


