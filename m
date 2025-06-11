Return-Path: <linux-iio+bounces-20509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5981AD62DD
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B671E106C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0E253925;
	Wed, 11 Jun 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2duUSU4J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA44262FE2
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681775; cv=none; b=aP0zKkDUD9wQKXrEH/WL1zW93ZolFWQcz38/f8JBWh1b5kpvl1j2FsSdAuHAszfRZQvfe64ABpU0bwqMJY88vdan+jvsTwnOrNo5xsEtmLPbBp6fCzef6I7/XJ0FET/7yQrvTia+j291WJsOlO2qA9hpSEpHrYBhx4c4ztOJSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681775; c=relaxed/simple;
	bh=1a1blIlRZxXXjSZuCkjoNDJp58C2THl7ge1s5EwPmWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhRZvK294v1fguFXfiejFFVl1oF3DmIdLhbwewept3QhUqgN5t53PF77+r5zjTRyvKQyrBTLmIGuORBjhBgUQvFjuXcLCUaRJdwAsLanvMr3UjtOVsdgQ0BoUzFEoqtW19XMEAUCBvFjlSM87jVkNkxGw0QDzE1hNsaO2DmZegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2duUSU4J; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-404e580bf09so95176b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681773; x=1750286573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmCWs2rPIbc+6BQsfR6o7xw9HuF4FDfGQAsK57gqrg8=;
        b=2duUSU4JFstodD1XC71U8Ejiwyxg6Y+rLJGxhPyJveFEXtyEPKt47/IY09jYQpW/4D
         GhhYCzjHyAxjiIX08M76rI1gX3B2G3hPk6rNL+7qcYIsuMBcuoA/wZdFDqzsSqFNvus4
         1Q4/39CQQxC39jm5hDuExWKF33VTg/yCkn3VDDdLycs0wKOPaXMlbGBFlAgHN0Cl3U7S
         O+L0JEaXKd2MzvTulPftaXrXpIHBGvX5OApUfPR/4yUIxAUOnKaCHxxkPM741NejN0ek
         l3y9z2uLd4qYkBGKDK/PIwqEiOYcX3Yn19a8okRpndzumEFb02r/OMW4yXI5IALNcwSV
         ie9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681773; x=1750286573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmCWs2rPIbc+6BQsfR6o7xw9HuF4FDfGQAsK57gqrg8=;
        b=C7wWzj7NAmieaGdUQlXUQT8mPu3MYPS0kQOWANPWsRxYLWvA/FtxaINftVRZDlig33
         869pI7U2hst3L2bjlWux4hSwNWB8T2+ibKrpQKg3Oxpgtrv/e6MFTrt798hwbaCrzHcZ
         yWfr7cJxOFg7LZ3W8LrkDAXEH489I3MbciIMi/0G0YOOZO0bdHf0NCifEuBRmTNtS8SP
         ut042AC21WOlVvXD3/r1Evlw/Szv1oC4yNsqKlzLY1EzEkI1mhOU9xL5dsYn2Qexy2jS
         QE173axydGAe3IDG7kJohdbn2Po5qABN6yd9Mz2iwfQmtJgShEhp2fzxJEv9XnTycuPN
         lDmA==
X-Gm-Message-State: AOJu0YwmR6udqGtrluEY3rT1NAfL06wgNmK9K9RQ+Eo1ayqVKjAwWJc7
	cDTAf+/wK2WZwa04NFKH4EIMJWqxJPtxCY+j6U3YmA0IyrjvOW/a3AvUbSN2AdZTWL8=
X-Gm-Gg: ASbGncvjjF2x034bXHBLZNE/AZdJba3f1B6dXrIumOLk7JqSAmQb9ieA9qpko0XKJ/m
	9Bkev/4Tn3uXSULeBVj7LgjfSfjaUzWouAacYIy1dZHbwGTlm0ZQxTffaytrcw4r5NV8Kwv5eBL
	MsGMo0ZuZBqpmG1TWenYsFvieWJFxfrI2PZsnoC+E+KtKG9YaRiwwN3kGNplnoHVDh0GsZCLk7c
	99bSIdCPZxiPfeFr7s9Mg/VngdhOLunNF5xgZsnV3Nlv95I4IuZJ02l1YzNW5TBKLrp/i30BXqj
	KAEQhcBaVDfd4Ulrtvlaz6FrepL17mWBhJKWiG+xLyil8b+lAn26nTLBbN/2aVDXBAdM
X-Google-Smtp-Source: AGHT+IHa8L4p8ghK5RcETbtRoE4Tgd0/CyY2JEUEIAGMkjSxYcjGiB/P1+veFGOZJrjbwtHUeltfLg==
X-Received: by 2002:a05:6808:2012:b0:402:b0f:4ccc with SMTP id 5614622812f47-40a65fefd04mr787770b6e.16.1749681772858;
        Wed, 11 Jun 2025 15:42:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:10 -0500
Subject: [PATCH 18/28] iio: light: bh1745: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-18-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1a1blIlRZxXXjSZuCkjoNDJp58C2THl7ge1s5EwPmWg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgX65p3M31ivm9edVoF5bPU2YQFaJOkLpO/9G
 NBCVXlam2GJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoF+gAKCRDCzCAB/wGP
 wKzJB/907gw1xbojUL7cRNV/Dvgd0LFSxeZkF4YblcJ1Yz+0c2MtUIyS92I6I5pOn/tKJvqNWm3
 OJOzaJPV5qKYrztW7M9TNbQF8w9s9S/NwhajVc2tfvREV9bUA9SsTt65nWfJsDEEMb5Tq5278q2
 viPYYE2utKUiiA9yuxNfadtti+HV121T5zIS21mLLJ7f4ljjG9JLUI5k982MU+LRZnDJv3R6wlu
 X0mnXF+c+v+zAcup7pDNFWHXfGocmoqTfVT0p82kir3SPpz+xWHvyBSjJQUCFWQzPq8AVKiHYjn
 TyEpUDtbkf/uLkdvNbw7yzOY0jwiJn6iUuvFkTVih0RpJrWB
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/bh1745.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 56ab5fe90ff9128035cf25948bba1589492e66e4..4e9bd8f831f7834dbcdbc5df4931f473d277d814 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -740,14 +740,12 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
 	struct {
 		u16 chans[4];
 		aligned_s64 timestamp;
-	} scan;
+	} scan = { };
 	u16 value;
 	int ret;
 	int i;
 	int j = 0;
 
-	memset(&scan, 0, sizeof(scan));
-
 	iio_for_each_active_channel(indio_dev, i) {
 		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i,
 				       &value, 2);

-- 
2.43.0


