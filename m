Return-Path: <linux-iio+bounces-24191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7EB5A392
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3157C7B4AC0
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982B2F9DBE;
	Tue, 16 Sep 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h5aOGJfg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A62F90D4
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056643; cv=none; b=kOCzD5Q1qm4Majon9Ni/L8pzXqIt+rKcUIMhiYIpipM6MjIWSVo83WY2eLxCsLXpaIa4p68Yvvr6d9OUn+AAntit70u4XV4F8a7TGLJALetLJiilPSNA+qWtS424iT9P86BzgniitsWhaCUCgHImCgEKkqcbSTEH7xAlBMsDvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056643; c=relaxed/simple;
	bh=6mdeYyd3hF07QuqGuLzQcOwjnfUK2lpqXDhP/AFlcKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOZTHBO4vfwraWIEwrWBCE0sV57dPkvk7c5yawTw0qbstJ0/0XZ5f+C9yUtvfpJTDOxp0ZDxS63478IsSNAzjlLX0WRGDFp7BcT49qUcqyYh4JIsM/LiF3XW3HFuT6isTPvWtZg6STAz4jMnec7v2X16jewM3UFolyFuCqys4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h5aOGJfg; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-746d3b0f7e5so5102627a34.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056641; x=1758661441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuUiBdYdOzhT/4QysYZeoKXL89SuD8knZroyb1BNveM=;
        b=h5aOGJfg4OJRznwjIgshyjYLaAF+hMYWs2h8rTC7TaDYdoJLUvFIiPKPDT1FnSk05W
         k5oScwJEiM7Hhh9DlpaP7oQ60kOBTD/4J5M544qgooZKiuninpTusKYOmodW2jOFFITx
         2niLX9GfAwrf+lZisftqj/Lj01B+eO0OtNHssh0dICPNs+N9F+oEZp+P2kV0VeTdUcMh
         FAvlGHxCy4vqZFfDxegAnAw+6NmM+JYLJ/SIF7LJQ0nQvK1Og57hW5yBFwVdhK0Zm6Z7
         hfm2AL7nMGa2qDAOUwYxfzXVtjCdVZUPmSwplDKvIhzPfeIhq3BH/ChRmbfXhCyMMaQv
         CWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056641; x=1758661441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuUiBdYdOzhT/4QysYZeoKXL89SuD8knZroyb1BNveM=;
        b=M9vwwWXzYJZbU58RaJSQlEvx53L8pb8DOWem1QbO0SK5EWj/IxRSPYuH/+fm75W1MW
         TVnCyvZKLciNPsdxNLKZjzr69VPDQr6+X//vz+kwnkCC52zyiEDB4omoP6MKOlAtXdCX
         mt7agUly2vmRAf4zVWWyuZ8jHL9JxgAvrd1T+vrNoXby9/ks9uQWicO2EQZwQ5cn0O6U
         xpuUClokv63IwJNNC3ILFtJmOYUKduhg9sSXQUYvkh5WRO82onfY5O/7wW8k89Byhazx
         IZzAH+uzVk+oaG3/TKSRGs/BOlMKlPUFzDuz3Ka5NSGVBZ9f8XgtZbhRCIsCXJWguyqt
         ngTQ==
X-Gm-Message-State: AOJu0YzhSrqnxdYZQI9mdyg466VcoI4fosYSAFa0YfaFImeg4oUrG1Os
	RcJT21wXLJc49LNgdURtDsxaO/LkjaReWVW3Sc8WbZ2EeoSQVwU0KWe+OtGoA2t/HO/90qGSGiQ
	Ujr4OcvE=
X-Gm-Gg: ASbGncttGiau8WsKfGNV7+BFkfTZWD5K4tHYStKORtlGIFH1LshlJjTmX4q1SsP00MK
	SD8Tk3pNpvvURTU62yvYS8IWU9ZAcH3rNyYUnE5VHh2ZqYOivxS1EIotlLdqOvSUzkiRVLR8Ltv
	Hmr3R/60DzHMB5CY6VyzT5xklYPwe8BCnOtEhx7/iy/1wUBQD2keKk5aGHFpdF1e9uMKGsWpEDl
	nc0uek9b2fDNJeXn+5CmWJxC4QrswTOv//VTr2mqzXBhqjSMmu/2xEQgpE2V8891fzSHhFfbOSw
	p4zs2+BulO916yOI6JXC5lP/aF9dupbry+H+Ri7dUJoqatiETrANHbGkb4uacpxXLlYZ4zPmnkq
	oTN7NhDcyA74HYNPeFqaETwiR8ErJ
X-Google-Smtp-Source: AGHT+IEThmTUM++mlzzS2GM17+096Q+59Aps0AMQsj3pnAzcqsCTdD0X+SDwFBXwlrpK1soPiyj0Ug==
X-Received: by 2002:a05:6808:1302:b0:438:3b69:ab91 with SMTP id 5614622812f47-43b8da9ed09mr8658219b6e.50.1758056641220;
        Tue, 16 Sep 2025 14:04:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:57 -0500
Subject: [PATCH v2 7/7] iio: buffer: document that buffer callback must be
 context safe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-7-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=6mdeYyd3hF07QuqGuLzQcOwjnfUK2lpqXDhP/AFlcKY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCttq6RvmTZHapP29zuCyinYPpvWDq5o1dGF
 29WTFK09xGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQrQAKCRDCzCAB/wGP
 wDLUB/92zOe0kO9ppzodI74aYR9FNSaUt/TvOjLFc1GmaR3PblmKWJ4ZOo/YbGDfD9p5xaD08wF
 mtmHDt5X+NYKOGKRIZa+qUXi3MXdQk2Ji9iu6q5zpAAz3+617cJwOX+ZcF4mN+kTotzHnrLQrQb
 FPoL6gIXPKfbYR1tYJ5Cg4eslkpn87OC2Er6I/yNsmKBxcN0lapsQhoddTxjRYDL6ljSJNhWThP
 Foh2qQEJQBHTr1s8Yi9obAjbTXSTwCFXiHRoVQ9DS8lFV8MbIoiGroLYqiDv+/EU6LCEsbVIHU6
 j4xDgvtpohHD2migse5WmWL950+x7kN6VmEHOKWtmlAkdujt
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document that the callback registered with iio_channel_get_all_cb()
must be safe to call from any context since it is called from by
iio_push_to_buffer() which can be called in any context.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 1 +
 include/linux/iio/consumer.h                | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 3e27385069edb5b717a4c56e72dff2c0a238fa07..f4ebff9684936365ec179489d9041d8bdbe58738 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -13,6 +13,7 @@
 
 struct iio_cb_buffer {
 	struct iio_buffer buffer;
+	/* Must be safe to call from any context (e.g. must not sleep). */
 	int (*cb)(const void *data, void *private);
 	void *private;
 	struct iio_channel *channels;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index a38b277c2c02cb85a766d645a046bdfa534db51a..5039558267e4c17b2e09246036d0df352e242d06 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -131,7 +131,8 @@ struct iio_cb_buffer;
 /**
  * iio_channel_get_all_cb() - register callback for triggered capture
  * @dev:		Pointer to client device.
- * @cb:			Callback function.
+ * @cb:			Callback function. Must be safe to call from any context
+ *			(e.g. must not sleep).
  * @private:		Private data passed to callback.
  *
  * NB right now we have no ability to mux data from multiple devices.

-- 
2.43.0


