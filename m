Return-Path: <linux-iio+bounces-24190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB8CB5A390
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF83C32487F
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4F12F9D97;
	Tue, 16 Sep 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vsl8PvGM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D92E22AB
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056643; cv=none; b=B9PEPNotVt9UJ7elgIeU9vRAvUJwfHQQ56Uc3zKal7gfsJzFmJDew5dMDELjOiPaUgVCMt5uKk2lGEs7BVTuBFsJ0Ssg68NyO52GCUyb0vqtZ7bkVP/dQuOeHk45rl5qcC9wdIklqkOKVh6ENu5Y5/HPcuceL+L9Lm/FVMjx3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056643; c=relaxed/simple;
	bh=NX9OezBQmGZXkufSRLFKbb/lXUVLMybe7wJNl4d03V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9vr1B03ctYB++vH50HX1xbSBinqJFvzHlXGEvtFF8PKQj9p9KqTA+dZiCqf0AcCMXYUfHE2p6UsEKiJzc4xAsopt3Yb+04SOb3EpU0z9S+Lbjlc8j47UqBl7tWo3k2ukAI0NW7WYAu71RkMGp3mUL5zQ7sBtB/L6wnrgRR2F6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vsl8PvGM; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61e73b1544fso2298629eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056637; x=1758661437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMoYnKgqGeFb1dGTcjAO1AcVsxDcYWZJZnnQASzLGJU=;
        b=Vsl8PvGM03Chwtxna6j2qH6RkR23nLnYU+zFx3rKFZ9L3WXGrrQCELNL+4G8H3OuZ8
         BJ+ApNMbutBLdSNr+KuvJM0OVAqDeFcr/7uAy+vEmM9bG6Xw0ixhXlzwPQNz49MO3nh8
         et7sF4WTMaOABczI057TBKyMY0sytMskyiA/760d3Gd6GG6rdDKhARDxuigjQGbdqfb+
         zOxErhIy1chXVRSgh7URD3IxSBeG1wp6oUl4i3YqYB4bjJi/xIBc/gK/JjyNcF/taEyK
         9K4WWSS653MpdYBzHtyOBSvStRWzbitbKVgaQ07V98Xi9OCauRfUopVb4b65ANnltNyV
         MWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056637; x=1758661437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMoYnKgqGeFb1dGTcjAO1AcVsxDcYWZJZnnQASzLGJU=;
        b=OkvNP0iIGOHlnAhoLGsiojGHU2lNNM+AKdPkzIE99FGJBN9xzBW96jYHNmGDfGEcHJ
         NDFKxR8yFA+7S5AMQDMSKf1vfjw0XbxYyHYvZId6OuvwiCdiBxRPuO8oTe+ZiPgVkgeM
         JbdjsNLNxYe3zDfxC8tIX6t9ml36sFTOCb8S+Bcp6QZaF0KWuJSmVmphfUfQl0Kzu4SN
         7/qYgs7ctZL3LeCy3MyXWtXghan//rwZekhukMMl3HqVjRt7meRz7cz1f5cq8SkLvZj+
         WqIPYK86xJ3tAuHUDECGef6DEF2spaVI2ItbfYpWG6qn5XRqmXBk2SJWxZwmFgC2xuF8
         5QuQ==
X-Gm-Message-State: AOJu0Ywj0QRJ9Y4DjiWHai5fczKnhNLN5v4P+Hn6CxHyTQGO69RuDsNc
	Vqv7z9DWpMU8rxlPKQxMKyT+jvv7CYV487NomeC1+cJmDZFs20cA3r+Aep0zTkVtRThLhQoCmlE
	8NvVRwhw=
X-Gm-Gg: ASbGnctkJtOMbN/q54pIHk1VEBPN8vxrdQc9L9bUaHjGOzCDLLDaJkiIV/1RlOATVCp
	GfuOXF0PBP2Q9QH1HE8IXHNlQ0hc3djRHQ+bsetqmaSKBHXUNFOcvCJeCe3bFzFVb6uvrsbI4uY
	E23MeloEcX5viqJ8UbQCcsO5qwHKT1KtmcjX+YqXNwhSPCwad1+jbfkt6ZUxsbadxCUkerml7Ml
	MkkqX8tGeX+tbuqDtZVD8967MbxdfmACelNtO8cEuxjO58W+Kc9ySi2BhaP4yLGxiBUvqMfuYzf
	Jdy/chzdqVkjWRSB70niacRnRt+Oj2rN+i8pkpQ2oMsxCbM/lD5E9R6fH7PJ1TyakmKpKedo6eu
	jUImN7UWEGxSIH2dmA3HvpGIOBTB0
X-Google-Smtp-Source: AGHT+IF2UZuRgCTbOY2EweB2uXPjuhFlPoLc0/0+P1xi9jj3FxxW9uvqBvNoW6txEIxMyfLnPir3BA==
X-Received: by 2002:a05:6808:22a2:b0:438:3621:1ba9 with SMTP id 5614622812f47-43b8d8d163emr9448479b6e.14.1758056637294;
        Tue, 16 Sep 2025 14:03:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:54 -0500
Subject: [PATCH v2 4/7] iio: buffer: deprecated
 iio_push_to_buffers_with_timestamp()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-4-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NX9OezBQmGZXkufSRLFKbb/lXUVLMybe7wJNl4d03V8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCZe64xKzNtuiNqofBqBUVPbHen9ICcwq8S+
 x2aTZJ0UUqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQmQAKCRDCzCAB/wGP
 wCGUB/0Z4nAOtm5ZatkVKw76T/gLIiqplOGhAIebbo3rMCu2OqKdYuYsXRsoOuclW/JLJy/cIop
 1nNnWKxMXw9GYvHpWxoFVxZ5Qhurur4kn9gaKrwGKKySXnWsIjJgD5GkskYS12ijgs+rlGdUkLl
 Re1bDZQ654cuneyYHOM7F9DuUdsT9UXJGZoqqeyYBh5fKyajc9FW0A5+5al4/cmSzI5O0U8PQtm
 KNnu3JlM6DJs1YQ42EpLvhm4vcZf+fCeBEtcKhmQHaYE7cVANCGMtpCjZSXpsvUkU/vwziPjN33
 aAWapZb+N8G/MQvRKfMfkMZRk3rkh0UoIbbnH/Z5B7d2bRrZ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace the documentation of iio_push_to_buffers_with_timestamp() with
a deprecation notice pointing to the preferred alternative.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/buffer.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index e46b818981aaf473539de5adf4aafa7e7d675de6..d37f82678f716dabfd4eb3b87cd7bb00f146046d 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -26,11 +26,7 @@ int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
  * @data:		sample data
  * @timestamp:		timestamp for the sample data
  *
- * Pushes data to the IIO device's buffers. If timestamps are enabled for the
- * device the function will store the supplied timestamp as the last element in
- * the sample data buffer before pushing it to the device buffers. The sample
- * data buffer needs to be large enough to hold the additional timestamp
- * (usually the buffer should be indio->scan_bytes bytes large).
+ * DEPRECATED: Use iio_push_to_buffers_with_ts() instead.
  *
  * Returns 0 on success, a negative error code otherwise.
  */

-- 
2.43.0


