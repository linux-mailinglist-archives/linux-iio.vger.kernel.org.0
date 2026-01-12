Return-Path: <linux-iio+bounces-27649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40092D14921
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08B013026FC0
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7737BE6D;
	Mon, 12 Jan 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lr14sO/D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441A29BDAB
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240000; cv=none; b=OYib7RiCLXyzjKf8xE3oM4OpQvuKAr7WvPOK4kkd6wj/tFDysD2i+WjGXzCsw/Hs9fQYPyzzsGsYccWLzq6bYaOUNL7scNGQ3nvFJB0gH3BR9viTK+0+kD4W8mkYdI1/rIVHwc+Y3pDhrCOYT6fSAdMde/ab/+nGBv4H6vWHRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240000; c=relaxed/simple;
	bh=HF+bpVOoavKKEiID/RQ+Z83xMg2SKTxpfDjYlJ/W1Xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtcwqAPMyECGRkp5aDG7E1QCYDsHWLjGlCdQsSB1UIj3o/zKs+UUaBt82q8ZQFAaGNE4K71ByJG5hBGE7w7ffMK47MC7ykVYWBC2xQBtafIJ5FyqCy8yEAbGttzEa4tZxWYgUOgdH/KTYbBuzMMYh/cHmDhsSll0r2LXMgrcOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lr14sO/D; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e80c483a13so4097237fac.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239994; x=1768844794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ne4Oc3piCV35xap5V5Dxt0Rd9if75XR+emO/qCvC+Q0=;
        b=lr14sO/DNxBvd+3pW1ES/nqKjjwdvlyKr2qqaRzR459MxWY2gtVOvoLDUMrGkDOzYS
         39iTM26m22Ysp1WwNbhKAwwGIM68wYx9W4sho/rY9WZLRMGrJ2pprF+suYhwnItco84X
         NmjZfNOE9gw+JQG1zP2xjbRQr6bf6ayOeHQxLcMn3RfOBXyievgV693xD5QggHsZunaA
         VH2PNuUF+v8Ij7Z4t9E3u1Os20MLCkl2CqmNH8eiGmfLw3EUMAfDTRUfKvtN34QMyxVh
         JincLtd9juO70bkCHP+Z8RafkZ4JLjDBSwrQlNqGut0ay+UhJ3XefYEBBKQJCPoQcofV
         fcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239994; x=1768844794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ne4Oc3piCV35xap5V5Dxt0Rd9if75XR+emO/qCvC+Q0=;
        b=hm+jIuZM0xpDNzbBSkNCyg8VtIlhUPIrlhojdWmiC2JoUqjTZ6+OXmZVmQlWLffaGd
         IdCqr4UachltYABG1PKuXfYkf/cCJnWX7y7N4koKz+fH06+B85Wa7dynKdSNJkJgEjPT
         WDnlC1+g3TJps+g8usVZGZt4u4VR8nEOY97CT6M6mZtGw4mx3xF69OZce+HNmxksrQjk
         3ESZDyY63bK/exUByM45aKE6HdIfsOd4R8DIhh5F6cXOTdddU0JPfwCkwVzGSG9ZIVsj
         iX2pQGbTTtW+LC0BrvdwffjuyWtRfu0xgg4BDCdfUn8idX+SmmW1yoYWQGz0XBJDfDjS
         as7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2t9eMDewWXHTbwfIrpZyLtMUgfLJI3DHcNVmDn0/BUPOVk2Wfbr3HY7IZwOPSm+IH6teC8HnjNk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/yaao4o/aSrFAxVfek6sgGpyF5m1s5F12Xe18LYdRRSUETIW
	sZ6isA0hpg2AkxtAnuM+W9WVz9LqmLM6izO0ORdYFUMzTzEAIdkpz6wFsWZ9NUjRFzg=
X-Gm-Gg: AY/fxX6OW1Aw564ULa7Mwrs0iC3Tlwg5x9aq2RMjg7T6qwczzZ6o62W03jM2UXBple+
	1KS0NQ36CamUQJZ1tCS7ExFxd4AMxYVG4jrVvwrouCKrqjOX3dtngMv3fDMI81H61UiIzNs0htw
	h8cWq6KbBmV4Vm+sVhZ7zZ3kVCHdng4DGTwViZYt0Q1XixYS0iKQCHkDkyzGsvHEh8r4STL5Iwx
	n2HOlD1VhfzzTMy3Pybgo+hIXrcjq5Ghz5FyuNWBrojUm3syu2t5/wse8B+3Pvf7iqRWdBQ8v4z
	cWrr5WZvHtbC3DJPXUv/uwCgPjtzaR/RiW8oDdWwnLbaFNwcoqPbTzBHe9fLLNRBo1WqNESYCsh
	3B21pmWVqPca67JTO8+aeIoATXaWWG7YCIRB2hykHUgI8gMHLeDPp2p1BP46LEMLxfW1xyBUxW/
	2v53OUIsESp7PzyymY8CG4SAFwPQ==
X-Google-Smtp-Source: AGHT+IFByKJyG/d5d4Pl79At+/4moJFdoo/+PNOzP5lXpwfeiLqeooV9dyhB4pCFEwEX8R3y0jxXeg==
X-Received: by 2002:a05:6871:c8e8:b0:3e8:9cd1:d626 with SMTP id 586e51a60fabf-3ffc0af6833mr10176141fac.32.1768239994478;
        Mon, 12 Jan 2026 09:46:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:33 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:22 -0600
Subject: [PATCH v5 4/9] spi: add multi_lane_mode field to struct
 spi_transfer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-4-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HF+bpVOoavKKEiID/RQ+Z83xMg2SKTxpfDjYlJ/W1Xc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTNL2kNENIiGziFk8m2inVQdpDGqRJV+Dh/eW
 cFD1KwQp2uJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzSwAKCRDCzCAB/wGP
 wFkaCACPQYpZt37VSu9PqAeAH8yolD2PDRc4ZdROBOIn2vjcl2HqsVV/SURn7IiN9iVtv0Fp1+/
 zW1YZrq20FqHqLen6Xli0vycxJigzKdbox/GYnp3QpN/y2CU02Uay2ds3r0hAII+2Uhg3xETQQT
 t2qpIPzR1T9dkOrGmWfzCMQvyF8+8jJMVgsVa59ZT11KWqPlgYnRhoOxYRfuSCAbcN3ZI+QncQv
 TU5KsoSf3KURnV5TmW8Qoixju/9QUIv76Ty/udKqoqC6hS+tgpqbvf5iJWAh/qFZp1TLR8JxQy8
 QKceW2BNrDWnWCMvwIAdYvaxHleLg6X3GlE4a0HLxsBieZoE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new multi_lane_mode field to struct spi_transfer to allow
peripherals that support multiple SPI lanes to be used with a single
SPI controller.

This requires both the peripheral and the controller to have multiple
serializers connected to separate data lanes. It could also be used with
a single controller and multiple peripherals that are functioning as a
single logical device (similar to parallel memories).

Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Shortened commit message (useful info will be in docs instead).
* Added whitespace to create clear grouping of macros and the field.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.
---
 include/linux/spi/spi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7aff60ab257e..eba7ae8466ac 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -981,6 +981,8 @@ struct spi_res {
  *      (SPI_NBITS_SINGLE) is used.
  * @rx_nbits: number of bits used for reading. If 0 the default
  *      (SPI_NBITS_SINGLE) is used.
+ * @multi_lane_mode: How to serialize data on multiple lanes. One of the
+ *      SPI_MULTI_LANE_MODE_* values.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -1117,6 +1119,12 @@ struct spi_transfer {
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:4;
 	unsigned	rx_nbits:4;
+
+#define SPI_MULTI_LANE_MODE_SINGLE	0 /* only use single lane */
+#define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
+#define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
+	unsigned	multi_lane_mode: 2;
+
 	unsigned	timestamped:1;
 	bool		dtr_mode;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */

-- 
2.43.0


