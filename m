Return-Path: <linux-iio+bounces-23808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD51B4632B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC443B1734
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85EC27814C;
	Fri,  5 Sep 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vPs6pL+I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB41B0437
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099204; cv=none; b=XqXQAsXFsHI+1+CJwaIrtrsbDe59bvOtzW/njlkp72jTokMd3sz/w5IEo7OMi3WY+Ew0SUOsxI9XrSrsF2bA6YGrTAyPQhEI2gW8dBitDBSfZd9Z+xgicCv9gXw5l8vYZGBCCQdRrsnihhO/dCsyhUTz5XdfukKFY5ZFVwzptnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099204; c=relaxed/simple;
	bh=93EhVVZhULK/BcUO7hlfIxF8zmoh1P/I2P3k3od0jQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWWGwHkWUthQcSbhg/1hawSP1kFofr8xifQ87cpTGWCjbCs4W6vJbLvGwS5QpNvk6gJ29OMloVsZnmjXiQEu2u1WcfNg3XxpkxlhTEBQdZ2pNvVBcZ7jKcnCK4fWXWTr+tcGT6OvF9bMnHnUEA6A9bYMXwxPBbTgge3pZIw2VHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vPs6pL+I; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-746d7c469a8so1247917a34.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757099202; x=1757704002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ix85II29/02WD0yF+tRgyZz0RHm97JrSD6a2ejVM9PE=;
        b=vPs6pL+I4G1LTewy/3zZL8g6/8fllXW0CeMng3vZao03+t5nAsD0vqHYtDmTTZI6Mt
         8ino+AKiiDUq9iKYoo+Qb4c5k/CZb/iTM+jt1jWietn/ypaHgq/t3OZaLwY6ZESB4eKf
         A3Qu/W69JbTPYxHVRBxRZmwfy2DbeF3SO0Vww4Bj5/PPxS4cYwHhdM4ndy6xi6pVCNY2
         FBu1bn7bZjLzx2JwwOTpMsvWHHJTkmsuXJ/uUq/3Q4ez51RuoA0Ytlyg6d5RtBTlxUZS
         eyoRkiZx32wsUmuyfxF+4maVpJu3sf4JGlFFGdloilVLvjop6RiFZUNEOrwDZfBnbDme
         PR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099202; x=1757704002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix85II29/02WD0yF+tRgyZz0RHm97JrSD6a2ejVM9PE=;
        b=v9m4Vd+ownFnNaNJ24Mf5e5QXYEz08C3i8uEY8bPGMGITEksvECkse/kuMyI5j5jvg
         149wzP22lmprAPmH5QfN2uIADie7ouar4wK64HGNuZpXVppSrEIPEajAOBjMnNe6w6Xs
         4QpBLMkiPrb/MWZagH47wmOBBuFm9w43lNm/cr2SDGtfTazFeV6tpfqdZx7enJSQrcYF
         U3hF6zTcTz8RGdLdEz9E7MfxiBNHZbIvoiZU+MN201cfp1xzoYLDaZLyOCDB/rrxuVXh
         zBmXhsL/zNQON78cimWuT7C2ry9Dy/QkERfrvKqZsW+BtPSf7DOGSlVyGcovASxpwoJT
         m0Ww==
X-Gm-Message-State: AOJu0YyrZ8uowOieBGHNMj9oeI4XMUTLR4gQAtj2TU0thmdJr9nnmFo6
	aKezjvjIcBloXGkvmecUloFK1CtAXlYS4OPsm9isOry4sxBdqHZifzlgGxwQw6NaKic=
X-Gm-Gg: ASbGncvlr2C8SVF4GfjLDKs8e85lsKdQghXGl8dMNnYVyuFfaCVohizzfOaf4fRN77B
	eYcXcqm5ksokfELwKiy7Z21Zgs/L8fI6RbeBgHl/9VbI5iKnp02sE2xV/6Esds8YxyevosXdMqC
	y7T5C1LXE+kLkNW9wid7aG71YRKAonvRpGwWpnf10dYxMTtV6U3k1wAlaHpdKtHK28Vm8aGFBYW
	jgGn/oYValbLW5g6xGZi9D5zpiG4gET1M/RKZtqs6U8cqd4K2ifYWTPKHq5oAzukzYUsXL/VW7I
	2j0bT3jwzapfXBd6nrXCE18frGtDBIVgSbVYokfG2xoVwlOA3isSmEh6DlBiPuhgyZMwAYgEnTk
	Jw+7NqaKLaBrboF29cHh/Ud5ABBo=
X-Google-Smtp-Source: AGHT+IGVCsDxDNnDhn8FwNhJe/a8kaDRYPwj+DLMUG8/cU+Qv9Z4lLedKV5/iJsKeG5KTqFexYt5Yg==
X-Received: by 2002:a05:6830:2112:b0:745:9907:3fed with SMTP id 46e09a7af769-745990753ddmr5884075a34.26.1757099201832;
        Fri, 05 Sep 2025 12:06:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743cdea4sm4474018a34.39.2025.09.05.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:06:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 14:06:20 -0500
Subject: [PATCH 2/2] media: pci: mg4b: use iio_push_to_buffers_with_ts()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-2-55996f077a02@baylibre.com>
References: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
In-Reply-To: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=93EhVVZhULK/BcUO7hlfIxF8zmoh1P/I2P3k3od0jQI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouzS54ZbdBdAErj/m3sxDyJNlAsjqtxUds2Xbw
 WzX6PxyBc+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLs0uQAKCRDCzCAB/wGP
 wDhhCACD/3CWrtFQQV/+Plk6nvOcCddSfGgN8Dtj+/aThu1vTXijwv0KLdDKuyLR0dnmRMxmuT2
 7Jl/W/e4ShE3P2J3EFc6W48Pm70FA4r7SBVXnjGR+guH6YESWIZZ5Rm6n3sWU9ZpTCMg5lTOQt+
 //mejAXwnqUL6qnuAzv0BZlg8/Xi6OGS9ghthpv/HYnfFS1aE4ZnETaUFj5pfJ3ap3QWZ8TOVY3
 Voq/4Nm9AxeZfouEG7qP5JWeWsG92T9vZZSrCMUhPXs6yiJeI2wEwHpKkixkagJAZU/OsMfonDV
 e6fiDAbR4kMc/bR1xald+GKugwmVXMBlmGoCvKAD+pqeMdQw
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(). This adds an extra argument with the
buffer size to ensure that we aren't writing past the end of the buffer.
No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20250724115610.011110fb@jic23-huawei/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
index bed8bbd4bc595d1d131b9919c6f3b705e43ba3c4..4f9a35904b4186618a554e3047d6b46ff7ed74be 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -97,7 +97,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
 	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
 	mgb4_write_reg(&st->mgbdev->video, 0xA0, scan.data);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	mgb4_write_reg(&st->mgbdev->video, 0xB4, 1U << 11);

-- 
2.43.0


