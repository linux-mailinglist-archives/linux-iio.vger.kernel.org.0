Return-Path: <linux-iio+bounces-7344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A679286F3
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E651C22417
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7215149C41;
	Fri,  5 Jul 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkPR04q3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84723148848
	for <linux-iio@vger.kernel.org>; Fri,  5 Jul 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176061; cv=none; b=IVq1mfg+DMD05C9RiUmYCjDR4l99L83ecEDehuSgom+trDnt8EZcrWuJ/Q5eV+mmR3Cm0eS7AmMuz/IaW4YCqXJQFFN0qShwYSiqw+t8QSg4m3sEfInzk/u+abw3UEB7CNKoBPEoMlN0clK8Rk9naMf5xIo+Qp4GcpPUiRBKdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176061; c=relaxed/simple;
	bh=QARo7BUFibdiwmopTR5ANV4tiDr14JhYaFByIK5Byzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4qH9MuWh9Ub5zjRpj6Rx2YosJ2J6ft9hV0MsS1lSjDj1xxh9KoBo8hHhzsVlHk7DQpfzRL6dLUjs5UEVpIuOYWDiFaQ7ZvKRYEwBIDZjYZbh29CJ5+kBTpMB1yDI0N4VeqTI//HT+TbQ4NjceOGQvEZuu+dkXW0U8RBaj0u/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OkPR04q3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e9c55febcso1950419e87.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2024 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720176057; x=1720780857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eXR3A0Apjdz/ufMLdA1641K3n5tF+YJ5/SI81Vd25s=;
        b=OkPR04q3uzKpLOs1blTtyQ6XFY/LmLXMEOvahGuwDm8A7XlIyzjibpMQildKXWVIy0
         TMFG/L7V94LlFSoNkU4SU02dmn753XhqCnSAjx7ilmhbt1LFCrE4dyGanMB+mJq3cWz8
         ayGdqzfSuxipg2RUA75qr44z0U7J3MEVPhBIGD8O8Cwq43lV9RMVf+kGsvprzIGrQ5Pb
         OvNn6lYldJaQo0xAF/PFKaQ78ul8Zz+9xr23VeoXXLDdeLDa9jai7R2NJGsacepGGrG2
         p845++lBETRX7Dt5CLKCjMMTkwCVGEaOMJ26LHVMrXzQuepj70R5kfpkwYxB0IA3aq78
         onwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176057; x=1720780857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eXR3A0Apjdz/ufMLdA1641K3n5tF+YJ5/SI81Vd25s=;
        b=uP60NWSFbDDdrvsiJoQjk1m3iRc+jZ86RQZ1oZEtZ3dUEnLTzNtnPL92MaVFtH4Do0
         2oQ63MaC26TMfbMjerFS7st6czcp93VwCaAy228dwIOPkakMHQf7HkEY4Nyg2wcefc8N
         0ek0/LPfHknHxnUP0FBj6yExATf5EZ4/vxhqaFoxe2xbcia3n5a3L22PS3g6IzJcLYN7
         YCw/CDa3b3zdXDuAN5HF0SrUG1bqu8YLoyJwHS8Z5GgNulfnFt1L1Qt+J+oSh6hMZd1J
         BFZCfMHF4jJGCVAqyidAFZJdIPr2utEKalVrx07gvCL4xREhi9GnnZKxVeEbLOQWkr9c
         j+sg==
X-Gm-Message-State: AOJu0YzexoRWSA9/RvLfb38YS2D2yVYX03Vk/knSOrlH0U4o3QhkbHAT
	b2OvTnd+w6AKjohUaW07md+oxsp6d0IkHvX7Cy8ZtYB/0ojlQ2k8AUOqe1+XyW0=
X-Google-Smtp-Source: AGHT+IEuhBIHVHatXqi8z2wyYNIT9Lh+Ls2S9+zIz61+j9staS9hXEuX+FfBkFJ8fOmyILywkwPT4Q==
X-Received: by 2002:ac2:5e6a:0:b0:52e:9b92:4999 with SMTP id 2adb3069b0e04-52ea0636e2fmr2584439e87.2.1720176056640;
        Fri, 05 Jul 2024 03:40:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm8680446f8f.37.2024.07.05.03.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:40:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 12:40:45 +0200
Subject: [PATCH 2/6] iio: adc: ad7280a: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-cleanup-h-iio-v1-2-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
In-Reply-To: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
To: Dan Robertson <dan@dlrobertson.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=QARo7BUFibdiwmopTR5ANV4tiDr14JhYaFByIK5Byzw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh82uDOsWBkZE1MS94UeFMZdoWUjtORN8+1Oef
 iInuGL8Z3eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofNrgAKCRDBN2bmhouD
 11beD/98CTFr2lTq/EVP4vRTt2IiXlvOrBvBMcJmJPzXzLJ8bIkeaqjo06OJLaIDRQZYBNPnVuh
 iCB2ROEzC7zxYyVsUR/0PLtX3CUYblcKXaJRB2eUx5EnKv2muKesTT1f8imdJLzkdd+yt5A/pqZ
 ttpJvI70vmv7h0XO0Lu+kjHrXA3dtkGsRIfvIKaFNs261+GuLAKylmm89b7TraS72nPGqu103En
 iaTXldI75WXk97F7pU5M8adFpOoZ4BjRUtjgvY7nfQOzJ+dGhFcyLRPg187QTHs1SiYEaIIRZCl
 kozqwrmXIU3ST2+IfKoCE609dvgGWzi43Aq9g3nHvV3JmXdo9WjXbER/iQlSDIHx6L69gUYlD14
 WsrYJX3w8jqpNmeXQY6z2RBjMRMJu6lrrETwaTNlpbBp3bnXPyKqsuOAwSP9k8o/orNrGU1goof
 R7znoCoTfOU+/wFgaBKBWhvGMiTZhSiAJf8Ai0TQ04VuEBYYOUik4LBgaDyf5UziepsKEbPw2FP
 IrYwDIvRTRujbE096pInBQS5Qg9tu7N5ZYXPy8zFL/d+qotPVgUmSr1q3yH5a59Bid6jgB6hvmc
 6DsuaNdFpC1fBtjgUFZ9viCxxX80G7AFRkWHz1LEYU9RgLeQRecmLe9LBr4K6XyMoG2J0n+HOnv
 EtHG2o0AIPzSVRg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/ad7280a.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index d4a4e15c8244..7bfa090da4df 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -803,16 +804,16 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct ad7280_state *st = iio_priv(indio_dev);
-	unsigned int *channels;
 	int i, ret;
 
-	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
+	unsigned int *channels __free(kfree) = kcalloc(st->scan_cnt, sizeof(*channels),
+						       GFP_KERNEL);
 	if (!channels)
 		return IRQ_HANDLED;
 
 	ret = ad7280_read_all_channels(st, st->scan_cnt, channels);
 	if (ret < 0)
-		goto out;
+		return IRQ_HANDLED;
 
 	for (i = 0; i < st->scan_cnt; i++) {
 		unsigned int val;
@@ -852,9 +853,6 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		}
 	}
 
-out:
-	kfree(channels);
-
 	return IRQ_HANDLED;
 }
 

-- 
2.43.0


