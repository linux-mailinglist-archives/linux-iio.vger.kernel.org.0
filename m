Return-Path: <linux-iio+bounces-20497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44CAD62C4
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA17168BD0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9B22580D7;
	Wed, 11 Jun 2025 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zBF7WjZW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC312561C2
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681749; cv=none; b=KcdH29YdiuEhRk3qnkfqWT+x1Q0ozQ9NhkGhPKn9z796dkQfaMkuTk9IP1vnXCy/7gwhp8bfxYRVTLAJH+Y0D6EVyey88yIFZ8MqcylN5568tbHKdt+BANZU7M/EV9o8Gfx6KgwkZV4U4bWUHWP1r/8PPSgu1D8zXgVBWS/DT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681749; c=relaxed/simple;
	bh=J89vMIrnHas95b9IQRpMB3abmxVy58q4+X2PR5Kxrzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PLkdZLmmf5t4u+pVrxCdBLxBa0mNe8AGjelfJnGZ+ao5Ez2dcte/IzBuO2h45VNtiqkVwphX2b03vxkSlPVAl/HYEZC9MjfIg0rrLbr307CcuWPXVA64ChBY4uDhvdWz6JQo714QBrvN6OHhBHBK4zlwRnQ9YMClVG2ClJARIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zBF7WjZW; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-407a6c6a6d4so131044b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681747; x=1750286547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dxd93MXVamZ7ztUFC194OTJH1bC4/5rgbs/4bZ7YxEg=;
        b=zBF7WjZW9okCZurFgpnmDbHA4Lh7OROp35euRfL4OpcOCP1/FSrikoDzpU5jaSCcNN
         jtl3cu+p1r4+/5Iv0+MHdIpL3/ypG/hkX6x1AP32ytMkOGSw3Cl04ItDXTRb5V/6kFIc
         vbC2kN9CElgCJUnQG24kcw8oUBjMXfDJbssUEuTEKWPO8itR3WqQI+s8hcIIjRyfNfdM
         MxTGeX62miM8C8/TNpYHHkX3y9YUhMrWVYAJfw7ZXeFXu0Ok0b+nHlSOo/pZao4T5Vu3
         PtJukgmh+MnyLlsAewZUTNuFRUdxQoDW8UUOBdkELxCeTw4PXWGgrjjw9lozTfuHwPJy
         czng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681747; x=1750286547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxd93MXVamZ7ztUFC194OTJH1bC4/5rgbs/4bZ7YxEg=;
        b=OYDopoG65YhF6WHx/xZwoq07DFAB4R2pL50CW208PqxtZWaGZx764i6uCu0oufG7hb
         6+o9xIFq6rkvIb0g9Sm7B6jQnrPO3XS1oziGw1xXwlorq5zk7kqjDisqrelcZa1cDytH
         iTlcatR3qaeSEp4z4aYQBkIyVqSlgM9tcENZYEu4xYb9CQmTZ5YaVOsbGZVo/zgfcGXe
         qNKXw5LJ06HI/YBwPCND+8hmFYJfFIiUJRr+6l2rlF/a6cqF6QcrZpwvHKMHbDxFsc/k
         2ggedHGysyud1Vao2haOlzmJZ1O1M3o5ygp1moJVQBJ0gxfAmtFDmRaJ+sKdBGUQhPOx
         Nn6w==
X-Gm-Message-State: AOJu0YyJ7FtlgYdBSZdyvhRAJ9S5edIEtCA20Ujm4LCLU588ka1Xcq+3
	CAa2fuwv1QOyivjzrtoBtZ9Yw3OqjoBAnxGpQ50UzHIZr+w0WY98XW6Nk5h5er3Rcpg=
X-Gm-Gg: ASbGncsgAUpQFr6PYS9tq1crTpfUrSLgHgjkzESfZ60a27AjJ9vqOiW/0oflIioUhLM
	kQnVxIDacsnXC9MyH1Coe4qhUIII5SU10elSXwqxwQADSEu2rgaeNfmPhiq1659NMNn436CqTeG
	LSQn0QoahymTmmyTUA8XkmPyFZHMegNrK+l9pD/TYeDF1cG9yuKpfzl+yYH7Ivpcyo43pxTa4Tz
	wamv18/Pzh3ajnnOs6Ib6ORApdZt2JzR9D9nXaylJUxgiHdIx1uv/C7QlrKYzCfn+uF9FHM0mWL
	irz+aQpJ7OEESzvgwU6F6Ws2ZaenGhMhXiulERApGSFjPikOTNBcLEodcHhE+DL+cj83zItkqvZ
	+xyk=
X-Google-Smtp-Source: AGHT+IFQBThN9gqVMuv0yZV4fKxfsQN3C7pn2YLNqV1M+RISkP7nir8q7A3hG/2ChnbAzLdY1TtRyw==
X-Received: by 2002:a05:6808:6349:b0:402:1016:e9cf with SMTP id 5614622812f47-40a5d1640c9mr2811691b6e.34.1749681747387;
        Wed, 11 Jun 2025 15:42:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:38:58 -0500
Subject: [PATCH 06/28] iio: adc: rtq6056: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-6-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=J89vMIrnHas95b9IQRpMB3abmxVy58q4+X2PR5Kxrzs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgWrluEPstsE3vfOa2602G4vDUiURfJwcuPmj
 Ecdin91id+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoFqwAKCRDCzCAB/wGP
 wPDzB/0ezOPNIM1GcdwSJUtoBdBzF+of4mq74dFA0f4iCvbOvAC9fCmCzg5hxL69oaeNJIKLKNN
 hwYn4bwrsFDn7hpTk4oxy+0yhbNBF3FS9rqxNmkw5sq+imc+Bge3o9MlimTvdYjRFeWz1olLBsK
 RujuQh/8d+BqbeBkJy6HGkvMCcyYr4HMiR32pZxq3ktZX1yG2QbvAfaGvOtFKtCjsFCh+x/0Tk1
 JzzUKytVoQDoqN/jeT+fEIYsymB+ELqIGIQ5jEtG2AOnEQdDR4Q/i73QIQnRhDjaJw/RzxhYyeY
 LG1BSqJLLtf/Qqw+97BIE+EwDDmTTolk2qkEpoqaZjPnMzDK
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/rtq6056.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 6ff47415a2221436b1fd548aa0bc070ba5fbb774..ad9738228b7f2db3f3b6cfc01fd97e43b579b687 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -645,12 +645,10 @@ static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
 	struct {
 		u16 vals[RTQ6056_MAX_CHANNEL];
 		aligned_s64 timestamp;
-	} data;
+	} data = { };
 	unsigned int raw;
 	int i = 0, bit, ret;
 
-	memset(&data, 0, sizeof(data));
-
 	pm_runtime_get_sync(dev);
 
 	iio_for_each_active_channel(indio_dev, bit) {

-- 
2.43.0


