Return-Path: <linux-iio+bounces-24188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BFB5A38C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FE132472B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3352EB5B5;
	Tue, 16 Sep 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t+bv479J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D22E6CCE
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056640; cv=none; b=aJ0RRaLOX1PCeR30FHlShGVTm/vmYtboUPNAe9ITFeqtaLlTvYK/7MAd6s1jyvy9pnVKmpCqFCB/k81YMtXuxZ0QsIHWXEvwIm6nEzrnHf5AuEp9/YxvCwc5uRscAWuR2KMLult91U6RHYGf0X4YIgAxFqhfcyJadEH9maJAeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056640; c=relaxed/simple;
	bh=KaHoQw0mmyST/U0aIeT4Q9rI2vx9p1nFNJx02h4APhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leEXmpkXGkRdgGHFuAxFNC6DhQ7SdeGxIigMYpwz2Vvf6DL233DNnKrNpx6JCeR3uI0Opvf/JdmpJRWd9a1tYRCUKf1yE8HGf5Ds9oGUdauZdCoX4V36XFg/62JfwjK3FBHf3trOm6mW1862kwe8+XYNbouJa4eMO1liJqXWkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t+bv479J; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74ee68bd763so1814945a34.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056638; x=1758661438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JMI9MVOYcVBfLvH8OZk7vA1oBEfGyZCnmiKgJ+DDsE=;
        b=t+bv479JewxlE8dYVspxeFJz1C35aN97vwuza9gZuR23w7Cm0gokT207ebjlTggbIT
         XYVvMPViFDzWjB6PtZg9fbOfYaAyx+GyEYD6JPz6+ah6xCQ/MGLtAXQEhxxx6OZkL3U+
         qVTlulDAuVCEV2PESYDf8A0JQ6nxvSF9iPaiUBbjRhF+XhscVoBB+OF5GheG46AsaZQ2
         RCFcNrRKuMfgvEePgMm0jMa+Z5MS6DHLPSvICQTQfhhBk8vXK2aZ/QQPh5+iTToUCh7u
         naYbXNcCPQ1nGcY8H3u4va22osrcd6Dm2Pc/phcADvVv2gNp2hDS6HDbUv3pmllpqc5c
         aoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056638; x=1758661438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JMI9MVOYcVBfLvH8OZk7vA1oBEfGyZCnmiKgJ+DDsE=;
        b=QP90Xp4YCgDhXdH29phuBoJvPpRjFv0AVHLW5bsrKXXBvi/5tTX1TVdjb/kLQOgX1k
         5zcH39EMwNr+CpuKKCmTiUia4Q2w/0dG5en2oxC7TJN79MxyHzkUvMIFznZBGwqX+7h0
         wLe7KCCuU+LDRmJWg7gbxP8+rt4JzapPrXg2C4bkd6+18EPE2DnM8REQaT08ds5Re2Z4
         u+yVMEVBa8ZcZLdl2lnQIBaaoh9rfb7RsM+leM7bQHnl8S+uBUvemX9Qru017Om4QnoN
         eeQMAjqJuR/sIm2rrsVR9Eitl/DphnF2R5VpGQZnlfGSKJwyumGvfkAq4QrZxbiEfdmE
         YBaA==
X-Gm-Message-State: AOJu0YziL0h+rHVH1L5eHxunZvAhf0Ai+Ykom4sSahW7kbVe+uFNzx/K
	IrWCr7gJLRhRAx5Gx8TPVbzqzh1W5Il1Trn7inxdS8ZN7QlKCx0Xso0r6zJVskDXffI=
X-Gm-Gg: ASbGnctCXHHEy28xN9tQC+VgOhhq02vjf+/ozGSqYuWZxt1bl6EaazTcJusk8dQGbn0
	dNjzWSHRf5Iu1cOwr4Es+2X6KW8hXIQyKT8uWbiZ52/QxbgNGhGpGbMcX2HHlAkH+JFXgpYL+DL
	4ubDPfncXqTjaNc15RQ+wL5KuEi4LeyzfTzT77ljZrENz7TyP3y/QHsDH9Is5223tqIFH2RAzzI
	SoL0KlZGyIJxqQoj5BFSJjTd8++sQ7yena3QcjGjANtzGefHa19RE8uaOb8jwNQokSftmThbqAg
	1Ry9HjlcAKxb6MKDnXrNER/Xaf2YrcZu8ZBgIycGldNrDX1QmqwkeEeXI0IKFJ2aLRsFdQIcZd0
	bzu3YHRfZ/+zG19285Ye4XnVOtAoj
X-Google-Smtp-Source: AGHT+IGfNMNMW59wpHN4IoaXc/ymLE7uDVAYILCANvkVPKEkLuR0d/+yMizh+ypitx3t3N0ruACLYw==
X-Received: by 2002:a05:6808:1383:b0:43d:3a08:cdb1 with SMTP id 5614622812f47-43d3a08d14bmr2302437b6e.8.1758056638038;
        Tue, 16 Sep 2025 14:03:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:55 -0500
Subject: [PATCH v2 5/7] iio: buffer: document iio_push_to_buffers() calling
 context
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-5-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KaHoQw0mmyST/U0aIeT4Q9rI2vx9p1nFNJx02h4APhA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCg3jaFLRJJRgd3BvUDQI2kvqM2C2CvcyxqA
 PlfpJhkfuSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQoAAKCRDCzCAB/wGP
 wJlCB/9VAz3ZXDQfl8rv00JSMhrWpf2B27PnUQviEzTrWLlkx6Mf22xXfiUK5ZAjOXjz8Pb26mu
 0SeBpziJC+LZHgth2zDCOi1oDBDRG1uHU3M5pA1+rw0zkQ1zM9tY6STrkWIWnib5+kRYDGpQbVe
 tK3jXpe5ZeC5+clbHTdmS7jixV8PGoexoYTXN3igGri01mcoNppJk9sh3Lc/tsDipx5+3LgpVPB
 vAkdN5GzPZCg3682YkSj9MhplJyzM3wZYCy+ytMTrUQ0ZjrqUyI4oud/5SsYDJ/oRoAS2a7F0sL
 HdqDQY+n1ZWN1pYswQ5Fy3PTqTti8r/cz7hMXiaeJIAkDhn+
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document that iio_push_to_buffers() can be called from any context.

Also document the Return: value while here.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5599fa37b698dda6ff126496f62939331c12f524..f1448ae1b843fc577599fc1b9cf6d859bba226f1 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2372,6 +2372,9 @@ static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
  * iio_push_to_buffers() - push to a registered buffer.
  * @indio_dev:		iio_dev structure for device.
  * @data:		Full scan.
+ *
+ * Context: Any context.
+ * Return: 0 on success, negative error code on failure.
  */
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 {

-- 
2.43.0


