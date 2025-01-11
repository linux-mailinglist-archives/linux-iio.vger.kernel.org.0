Return-Path: <linux-iio+bounces-14122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F01A09F44
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 01:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824F7164A35
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 00:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB27B3E1;
	Sat, 11 Jan 2025 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N2WnwNIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63915383BF
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554954; cv=none; b=O6H52FfhxvT3X1Rdljj9wQCq7bVfcwmKnzA1ej1EAEecEFJPEXKISnrDEkEFesB7cJnxNckwfN6jg8wNwSm+sDs/uDCz2XGfiaPT4NYpmfFIswXpARRemw+fol5MvFiCKOsplQbi3eB+HuX/bIJ8G5XnAH7rB/K8kNCMj+uu3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554954; c=relaxed/simple;
	bh=Sm/vCJR0UNJ9M+n6RDDO/DQSL6/4GQ8GHSNkCxO+NJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1n6gT/1Nvz4U7dmCk4epvKeUYiJGlyNPI6u4Q3ltfOMqKSV8SRl+mi+U09cqZfUjuK1HewEtBfyZfykaZT4VgDFcPaUoRJDVW8JEleEmFMbAXx5ErJDEhBvZrCqxh4eLj0n0f0Jl7LknhKx8et4tzOwLfSwKA18A+XmPW9lqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N2WnwNIq; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e287897ceso1676409a34.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 16:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736554951; x=1737159751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxjqlH5d2yGAK7gT8nLx4cF++/77RWW2OaRQuEiqFjw=;
        b=N2WnwNIqW6xBuT2dPG9H/8Ndlu1l3xAddnhmjhAkW2pLdijwEupBRamnJ0P0rsbGJ0
         aXsycM+Gv831XXVtN3D2yg0zjIyiKN54fuEwzo71Q1j3KzVMCOM10KGGeB5KM7/j08+O
         l8/wR3VSAXBW9SJeZamSeAlQUNyqMuRaO2PlPE8O3nsIB4PsCoI5EJ4qiYPJZWMXvnyv
         A8zRZ1iS63VzpLLPOv5gAIfRBqyDQvNFtykImJcrBSRoI7wpy2NktJVg6aEFbSBZbzLR
         MMltMUy4wkf7C9FkiP36Nhlio8nRg3XfxPKvzL86zkZOAsHC69vpzysLnx/L5Bnuyq3M
         pC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736554951; x=1737159751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxjqlH5d2yGAK7gT8nLx4cF++/77RWW2OaRQuEiqFjw=;
        b=JX/kBk1pC9nKEEyGDkaoNoFfM/K+dB7sXXW+6WIFsbXxQghf2fVtrrJSrw1W/C+gQH
         emahIEdovsUiavfBK3eJPPb0ce3Lv9gufCg0epbWDZLPEJQHHZ77Pd8NZT45OkG9u/29
         3mvqKwyNaemgC/7SJN2xpui5mJnF+NTa75FJQtlz+MnEGwY/6balSc7BhBcRGzXsGbsN
         vmQQ4nGuV3yHRMXTwfEoZkbJ30evhHwhiUL+xls5lR6WIFnIvaZH3HOU/ElkiLUHflcO
         sxLYfDn2IGZG1141zBaLcAQNEsek+ob42QQcOJAWV/5r4azXLXN6B+FYHiK4bVNBtNof
         ou7g==
X-Forwarded-Encrypted: i=1; AJvYcCUPfsy7EH0uEfAqTZmPcpgkdIKd2uX4Hze1/tyVzPxMYOKGv1R435A16hxZ78csEinSNSHknpGu+Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1P7mV2YnZXx+FGaGapXdpN/KQfVrOnvXDLpN12muJvex4YshK
	yhbORm3peZnxx9WIqHnUnLSHHIDXS0THNZTKDBNVz/Ak0IhU35Ts2OA638Xnmb8=
X-Gm-Gg: ASbGnctJ8jL3ujSvVhBtWw7Pe2Srb/Qpjy7cbgyep2RJ4lzcBbBHgJRPgLkbEQg93q+
	oDiQzEzuloL2vXFzsCWb3pOyBKMTYg/m+SQhXGsg91JIt2MgXLUihXHhJiIn/nyg4KQMpmkxl4T
	TiFb9Ev7nEzd3EuyQWJU6cAzxpzcowaOI231zBc09qmJ1wZRsTKJooHyyKawXJ3tTDGL31f+9zw
	t0W3ooPFqqe5nsVJuHu599acE/bzmv45IDQc397XCGJk1f4My0FcLhdfZfDcQLbJyx7BJuBHXxy
	RzvNoshVidbj
X-Google-Smtp-Source: AGHT+IF1c+ZliXJuhcHSKrpXBnYw8ejPWHsdb36/Pxj+4Gk9f8NaXMfIl2+Gr6DQISDAokbNcEV8gw==
X-Received: by 2002:a05:6830:911:b0:71e:72:3ab6 with SMTP id 46e09a7af769-721e2ef6454mr7121733a34.26.1736554951626;
        Fri, 10 Jan 2025 16:22:31 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723186280easm1228941a34.59.2025.01.10.16.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 16:22:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jan 2025 18:22:07 -0600
Subject: [PATCH v2 4/4] counter: ti-eqep: add direction support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter-ti-eqep-add-direction-support-v2-4-c6b6f96d2db9@baylibre.com>
References: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
In-Reply-To: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add support for reading the direction and for emitting direction change
events to the ti-eqep counter driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/counter/ti-eqep.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index bc586eff0daeb52857c10fc89e4f9c0262c3441b..d21c157e531a614215b50f2271f18c998413a572 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -107,6 +107,15 @@
 #define QCLR_PCE		BIT(1)
 #define QCLR_INT		BIT(0)
 
+#define QEPSTS_UPEVNT		BIT(7)
+#define QEPSTS_FDF		BIT(6)
+#define QEPSTS_QDF		BIT(5)
+#define QEPSTS_QDLF		BIT(4)
+#define QEPSTS_COEF		BIT(3)
+#define QEPSTS_CDEF		BIT(2)
+#define QEPSTS_FIMF		BIT(1)
+#define QEPSTS_PCEF		BIT(0)
+
 /* EQEP Inputs */
 enum {
 	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
@@ -286,6 +295,9 @@ static int ti_eqep_events_configure(struct counter_device *counter)
 		case COUNTER_EVENT_UNDERFLOW:
 			qeint |= QEINT_PCU;
 			break;
+		case COUNTER_EVENT_DIRECTION_CHANGE:
+			qeint |= QEINT_QDC;
+			break;
 		}
 	}
 
@@ -298,6 +310,7 @@ static int ti_eqep_watch_validate(struct counter_device *counter,
 	switch (watch->event) {
 	case COUNTER_EVENT_OVERFLOW:
 	case COUNTER_EVENT_UNDERFLOW:
+	case COUNTER_EVENT_DIRECTION_CHANGE:
 		if (watch->channel != 0)
 			return -EINVAL;
 
@@ -368,11 +381,27 @@ static int ti_eqep_position_enable_write(struct counter_device *counter,
 	return 0;
 }
 
+static int ti_eqep_direction_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  enum counter_count_direction *direction)
+{
+	struct ti_eqep_cnt *priv = counter_priv(counter);
+	u32 qepsts;
+
+	regmap_read(priv->regmap16, QEPSTS, &qepsts);
+
+	*direction = (qepsts & QEPSTS_QDF) ? COUNTER_COUNT_DIRECTION_FORWARD
+					   : COUNTER_COUNT_DIRECTION_BACKWARD;
+
+	return 0;
+}
+
 static struct counter_comp ti_eqep_position_ext[] = {
 	COUNTER_COMP_CEILING(ti_eqep_position_ceiling_read,
 			     ti_eqep_position_ceiling_write),
 	COUNTER_COMP_ENABLE(ti_eqep_position_enable_read,
 			    ti_eqep_position_enable_write),
+	COUNTER_COMP_DIRECTION(ti_eqep_direction_read),
 };
 
 static struct counter_signal ti_eqep_signals[] = {
@@ -439,6 +468,9 @@ static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
 	if (qflg & QFLG_PCU)
 		counter_push_event(counter, COUNTER_EVENT_UNDERFLOW, 0);
 
+	if (qflg & QFLG_QDC)
+		counter_push_event(counter, COUNTER_EVENT_DIRECTION_CHANGE, 0);
+
 	regmap_write(priv->regmap16, QCLR, qflg);
 
 	return IRQ_HANDLED;

-- 
2.43.0


