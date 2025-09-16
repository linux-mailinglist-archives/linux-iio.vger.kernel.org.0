Return-Path: <linux-iio+bounces-24187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC4B5A389
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD77B3246C3
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A53B28B407;
	Tue, 16 Sep 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zt1PfwFy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907828C864
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056638; cv=none; b=k+QPdLJ7d+wq1SbPRrlKcHYAp4a3jEUNzd6HD8Ez+XRLVAUaR/3vSZffbdfml2M8UkXGrPAWYZHmf4fz4J9kQ1BIltQ7AZofDBuf7Vgf/Jq0dgzqjO8knxzJ3C4w49kPC1oHGu7LaN52eD0CBT9amE5Lbr693aKcDlrzseM7VNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056638; c=relaxed/simple;
	bh=wrVNbJ1w5ADuZq05WHhPjVQWTKjZ/mM3Cw1wzSvBZ8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NgBpGR97/I1+yq+4+RRbacUmFMePCcTZEtuZfVqz6keIcwvfORdNylbJ2uh10REFYkXRQBhnm0YHTrnbWortGuSpCuwHL+BIaqGZpw3pkPX5m08K0X2NlNy5fsPiv353XVAA9vxIHs3/eZLM0I672CksMKZfT/SLLsKEfMYrFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zt1PfwFy; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-43b40cc73f3so177681b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056635; x=1758661435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSp5lWtmE8MtdrqYa3CeAStdB6Jrz9HF786RtIfTBDo=;
        b=Zt1PfwFyfTqoOEN/GbUYvgszcjG9+5r2Xqe60ioIyOTOreegjb1XIl2LWgEamf/1F1
         pZ0qgpFon8QqRcClvb+PEH/eiBLtg1lasDmCR2Q17pPKaHmxVjP3McxFxPsNeYzhvOVk
         cGsIQ08X+4zDCh5StUE1saVJ+PF3Cwt3mwjV4sdzW3bNRjCMXxJOLGKb3QStjl+Mw2S4
         AWb8JZNHqLGIw63vBI8fSuIdNyoCfqiDE74WBy5i3abGPiGJPqSoTBpAVjq27D3os8+V
         jJPJUKAq/IYplW5lo2R2d8vytD8Uhncmr/2LdelBQCB2/XlS0wgDhsvvTk2qYOCeudU2
         WriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056635; x=1758661435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSp5lWtmE8MtdrqYa3CeAStdB6Jrz9HF786RtIfTBDo=;
        b=c/gvpR7jgZdicVUaE8tuEQuQTN/VoPOO1RDCZqyxSiVCifYQG+rThdEzn0puCBdqTk
         vZsuOPTZdaYL2L4qTDg8U/q/337WmligCT5Sln4AQESCT5EygZ1qjI8ddjjR0LL3RArG
         95G4D4a+24AoboLQCMXlo/xHWrbdPAXZwkFMfUIY66Du4GfuK6ZnVjEWtanoPvBq5MFi
         7n5LjEP15FX98zTO+1uxZyZMAu9/8QT7C1okQ6Ech6dWHKKzCGuCC2OUrHKVFHB/Z+vC
         hzHOdqovD1hdXoX8BDwgG5aViID535daKUbEtRwT1I+VxZ3IXDKbOJbKGTlsyaJ0hCN2
         elpQ==
X-Gm-Message-State: AOJu0YxI6bsY+Q+2vDqYLa0cZvJCzg67VwlRKQYC1f7N0UZUGj2wefHE
	X7mT4S06jBIkm+7vw6x0or1OAUGccaFqzuBN5hBACZyOTZcwqOHzAYvm5DwTiSrwx+A=
X-Gm-Gg: ASbGncthzgkOz3NneAh2CsTZnQu83K8tGiPK+9MGelCgQkvFSuBAm/M7Sl532U+0HxG
	4MneR4BGYj4IDbm7DdxEpwayD65QmRPcVKhFJSGnPIX3cB9EJ+TtihOyJZ0NnTTLsdp40+UuMQd
	p6WG7HbQ5Byezf1FH+UpQG6B6rl0xDp+wYM5MEooC6LNL1YCsprB6jYHNzHmzSUCE2XkIUzWdlU
	uoL4pp5IGjn2dQsW1ORIdNNoHGr+EDmvfNJ9G0klEMOA+3rc8b0Zy5IYucWmb3TQowU3IxY6jv8
	tkOXf98l3rMNOTXflPridcndvPcD6hJb+3DsDvP65+yHeMCcGAbrhvaK7cqc9DJYJFhDqIvX9q2
	AQhSK9x6jHUt0DGsFdICnpT1FASPM
X-Google-Smtp-Source: AGHT+IF+JaCGWDofOoORJQjBx+F4h83HBSDGXEndRlsTtYfZYNGTuP3yXZDOBRZvpzOA+qmrL8vr3g==
X-Received: by 2002:a05:6808:640e:b0:438:2278:937 with SMTP id 5614622812f47-43d3f31ca51mr1798292b6e.2.1758056635484;
        Tue, 16 Sep 2025 14:03:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:53 -0500
Subject: [PATCH v2 3/7] iio: buffer: document iio_push_to_buffers_with_ts()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-3-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=wrVNbJ1w5ADuZq05WHhPjVQWTKjZ/mM3Cw1wzSvBZ8s=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCTrhrgdvN6kn/QASoGZoLJLV5GCgWirprX9
 mLvT+KLZtiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQkwAKCRDCzCAB/wGP
 wB4gB/47StMliExN+2QUM+2gkzFSU+K6kLkNBV2sHi4PhyvML+kO/dwLtQmgt5ZraVKK8SunDW4
 wyX1Xgc9bWFbLyGtzoMvXCNysyIZRLWQQ2HFy6qBV4js/CA8KJN4aicjIxtN3osg0UvIpsZ9ec8
 sJuOo64VSs/O/PxQTt5puTpgaMnPL475s/0BCpQdGLTITqSPaLQkgrIcFBMv8XghlSN184jOKM+
 AjcB1NwUtCLJhfdcKdp5B8HoCc7h9rOfQiyF1Q7xg4uZqxUelTGgX+LJxcG/lc2zJ2HjSlKd4M3
 9kgwMHnGs/wcqUonN2bsqVPBLazZA0gHudKHVIB3VbC8FBEF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document the iio_push_to_buffers_with_ts() function.

This is copied and slightly cleaned up from
iio_push_to_buffers_with_timestamp().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/buffer.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 5c84ec4a981001dfba3b369f811368bab70a3117..e46b818981aaf473539de5adf4aafa7e7d675de6 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -45,6 +45,22 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	return iio_push_to_buffers(indio_dev, data);
 }
 
+/**
+ * iio_push_to_buffers_with_ts() - push data and timestamp to buffers
+ * @indio_dev:		iio_dev structure for device.
+ * @data:		Pointer to sample data buffer.
+ * @data_total_len:	The size of @data in bytes.
+ * @timestamp:		Timestamp for the sample data.
+ *
+ * Pushes data to the IIO device's buffers. If timestamps are enabled for the
+ * device the function will store the supplied timestamp as the last element in
+ * the sample data buffer before pushing it to the device buffers. The sample
+ * data buffer needs to be large enough to hold the additional timestamp
+ * (usually the buffer should be at least indio->scan_bytes bytes large).
+ *
+ * Context: Any context.
+ * Return: 0 on success, a negative error code otherwise.
+ */
 static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
 					      void *data, size_t data_total_len,
 					      s64 timestamp)

-- 
2.43.0


