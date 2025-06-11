Return-Path: <linux-iio+bounces-20503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CC3AD62D7
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B9F1BC1E59
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77625D535;
	Wed, 11 Jun 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SsOefWXt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261A25CC61
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681764; cv=none; b=opOlrJFavJXD93dZ9da8lvLaNkRnb4AEZMWYVMzJEbejBgz+ObhwGaoNKNOZKlOotIlSU5l9SAnRMYgbY8cLUlSIV/46k2lncFBHH/bVO/Jl/Hm5b1lf83IQsUGu+4YHVBCOnwJeV6YdCV5CmQx+qc7/jkOlg9Pp2Mst4aQZiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681764; c=relaxed/simple;
	bh=w6sewnHJwVlZtUZ1XCEB4lsBcr4uySr0t3enC0nXMgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2tp8KGsB9SX9z5SFTlZaLmEkr1uoqqiD4Da7XRGdK19xQoLLzpnDK/Z0qdgq/htL3yDUW6hyJrNgDu2Tv1D30IOAT5P1Yq18703lzC9qdau5+jyGrBQ/Xy4Dnn56q+I96NjTKKoDLlInO6CIs+d8J7a+yeKN04MJOhnfglKh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SsOefWXt; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-407a3c0654aso185459b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681762; x=1750286562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+AXM43LJmcTiZ4+XLqifo1WeAnz6FejMu0e+/VkXQ4=;
        b=SsOefWXtrms4NznSIcRfSkLaBy82PIQP0FU67RK0TLT11w2pk51VhvDcpLLOn7HGGH
         XG2xSOKh/YpeZUwtFdqim7jCbI4L5QG11roTx2bdc7JsJvlwHqNcQ/8HOyMjjrKAscuK
         U61F4KWdDSC9VuKUHwVD2Kpbh0+koy+Rpv6GKu15wPsrvcWpb5HISRkEQLNEIus2Wv0/
         8LGGZSaoAfmh65u/RDyJclLeBRtuWku494GIVH/taYyHHgl0SDsxvo9Lnk4iDT3MJqfj
         wfAs6QhCK5Ug1emw3Fhs2VnRW5O89kyVS31A3w4LlJx8L1v1ZTX+yqoyKczMlJ2xNYPr
         jiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681762; x=1750286562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+AXM43LJmcTiZ4+XLqifo1WeAnz6FejMu0e+/VkXQ4=;
        b=GyDwxxNWalg3uguI3VWQaFIBb15p3FJuqCPJDtqNWPj/pQrJ0u+uzPb7WNSudXruGU
         ESzaxuMskN3fUG2UEDyoCsS4WqbKBBQJAvfKf0fC7Z6iMAO6iudqf4DctfnU0wYarGyP
         FKDJ9mSazKsBGN1v/4vkM6GurQ+vR3mEnH29e5UzhOmWMKIQfPid5fFvc9qXUbX6ezPI
         aT9qQB2wY/oOFzSSbNK8gjbxhVyNRFCq5CjUES3PblaOf0j7AuMCspLi4qzZLdc4zPHa
         VrqsgiIyoiiQpVFwhrTh0fIw8imi3X0FPTZ/sWej/3cCVgYvc+QrmBumug3hfAoAVUsw
         LSIg==
X-Gm-Message-State: AOJu0YzFJhkHhFahBMwpNsn2K8dmCwVpN+lf/hFlv0+tA9ZJmdIX7JR1
	IZgyLQnzCG6doLORxf5TcZ1JTHFl0cZABSWpWsMydU2dfmdqFJu2W2UG6zNB5nT2/i8=
X-Gm-Gg: ASbGncvjn+IG84ZxQBfFWXcIvWQ3jc2Exprisuukyng8c6MVGSORG9FG9ja29WrI2Y2
	I38LKVJj4UkJlPcChDFvaR0+y+BuqE/Ps1LilI3u5iLK5EfZiaJoyo2xQ+xmwtkO7tF++MMoG52
	ivwhzHeYqVHDkSzDLUSmexjQkA+GRMOg0n9qQzsYRjjmkmFVh1cXlxbn0O+MKaqFVkmmU88nznP
	9usbUFhd7+V1jM0eTFnv4uqfy3hKzLJCqBABzT32rWwSStTE46KNSbPXi3+rRRyOr3K8MU4NQV+
	WZzt6jR4A9j/wetzisO21yvd3iEJYgmYDg7+2eOZ+FACQqeGZ6T0tVyZvEMIF3mRJIQa
X-Google-Smtp-Source: AGHT+IFMMzvtGjq/XF9sKG5BGljgdifNq6jOybNnZI2VIWkdnxiv1hDecZPrcYLXm/jeBNerhjgiZw==
X-Received: by 2002:a05:6808:144f:b0:406:39b4:2232 with SMTP id 5614622812f47-40a5d053e13mr3229763b6e.3.1749681761758;
        Wed, 11 Jun 2025 15:42:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:04 -0500
Subject: [PATCH 12/28] iio: chemical: scd4x: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-12-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=w6sewnHJwVlZtUZ1XCEB4lsBcr4uySr0t3enC0nXMgo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgXTO0fwqvdhMYlsTHXtIYGob2RsszuHsUyLs
 SfL1LagKj+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoF0wAKCRDCzCAB/wGP
 wPZeCACIJ32MRJGFXAWVkUo7XJ8IPrL0OrDOVi8YV9Bz71zO9E1Xbt2tdxaHIRCxRXTjHv0+zxe
 w/o0PiRItwBJgVkYx0LCNcV0wRJiX/3SOXvkNIYHEjW/6bG5mIuft2mWy9pOWtFB1hHlRO5OHW0
 HRZV2jH97fcqcIdH9wSd/O5uzb2vY2Mv537m9vzG3NCE1EZ6ni5m4frRR2Ju3EquwZ5eFRMUZDk
 6TffT8htFYg5wCw+GGZ+kUM+ESDQvMFNiOZTKVDPOJtDl6Lepqk3gBrXVA5n8ijfXQPulfkc44L
 Ad5/aXu1TD4BBvsWqxbL+8KuoPFw5kwu1Q/N4uflwEd9cOV+
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/chemical/scd4x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 2463149519b6d82caede9c9b253942fa421fdd3c..8859f89fb2a942d940b1ba7adf202977df7b4ad6 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -665,10 +665,9 @@ static irqreturn_t scd4x_trigger_handler(int irq, void *p)
 	struct {
 		uint16_t data[3];
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int ret;
 
-	memset(&scan, 0, sizeof(scan));
 	mutex_lock(&state->lock);
 	ret = scd4x_read_poll(state, scan.data);
 	mutex_unlock(&state->lock);

-- 
2.43.0


