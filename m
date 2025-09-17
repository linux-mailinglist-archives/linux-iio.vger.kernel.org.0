Return-Path: <linux-iio+bounces-24219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E781B807DF
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2406F620EAE
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866F335948;
	Wed, 17 Sep 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N1UKVgw9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69954333AB3
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122562; cv=none; b=dsrb5MfrcOCFmDM0HiZXw5Vv3nKV1KX4UEPdP4T9q7DOnyBVoXUS7i41RfaTIm5C/WlqkwZlyHVf9/XKY8H/ZGQIF9E5QwV7Klu5F54gaZwaBCXWkp8SPT65xWvzY9H5zFmkVSR3VyKe/1BGsQfiWSBVci3LixajzMT0ieUWUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122562; c=relaxed/simple;
	bh=zQsz9BdqYptqLS1CMsswCBOUQ6lz2yV3McAsdB6NOOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WNT5mCbzkaCwT9nvaVe7N5MBCSuWDx8swzTDSg1kloAhOXzkkiE6z0aMGcul/R8n+s2ln8r0lR2yT8Jj3QYSVYsqSJ+2+TSasEsf2Y1ddzx0z9AiCMSyNBr/Ow5WhFqkrUa3RKQue9haN0PTalh2C1daT8nw7vGkaaIoqT7e7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N1UKVgw9; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-75731ec93bcso1199136a34.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758122559; x=1758727359; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JuqG0yxquK8kD4GeaITKrOy10EcGnmyS01S1D7HLSeg=;
        b=N1UKVgw9l9iUB7fQmMQdEi8hNISkqOSIfIvcyGR1KFvyjEFT/Ct8k6jPl/p2j/4OB2
         mEdLJ2sNWrtR8IRhhVdUmKUuJM39Ig3fbbr2FsH5RwtAGsOexcViIJK759aqyUaEv9ni
         S/iAn9MqjwDOSSd+m5IHPIohel0TDKnNdJaN80CS8mHtuiK9oMLrCFBUI9lIODT+QwRX
         +lzlUvPHk2jn0Xy554nW216wt/ri6CeItcg1m/u4vqh92YkuZ8WOkOXIgPxissV4pjeu
         ok5OaHHk6uNdClpZYE+6ZqEiVZolbxRi+lbG/2Cr7hJP7EAvznIcPwbprIGjrK5fEe5j
         v0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122559; x=1758727359;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuqG0yxquK8kD4GeaITKrOy10EcGnmyS01S1D7HLSeg=;
        b=gOBgC87kCwT3p7JEx6ei7g7RLtCCY9hoqomyWWeZpEDJTKwwgVzBs7wR4OWAlb56Gc
         F6LumJHyZsYTNcwP/pWbArSIwtWYQm0od78UtCTBY99qOMLP53hHAi2xgXkkEklHoroA
         NrsD+pkWvv/DJ+1nIG2YUreWasRkraJQ55zV3qX7OTyO8U8ZQc92ZFxlnQlulk9fjmgX
         AMnquAMDguj0JmBbx8TdfNtl33QPkb+UUOeVP9vQQaaW6CWk0HFf55raYZpkCXsptXrP
         CfymJzTaVEQSsWWNtR7jwGCVDNJSCVNbNZvi2O5he8nt26JWqp+0ffIsNU4hkC8+ZX4o
         B+5A==
X-Gm-Message-State: AOJu0YySX7yqEa6TpRN94XnGqJ7Ci4Ta/YS7mfLYB8ZkPhPHk53gvb+Z
	et4ooV6/ERsUjOf8UUN54q1KKCxuskdBnqaGZo0/VyNUIQPRWT2nT/c0UuewKo1bELc=
X-Gm-Gg: ASbGncvfGhWd84qoDtbvKUHU8GUaSWHUDE9OxMkiMTMcmmw9BvXD/RrkCqJifRyMByc
	opX94jZkW6gU2ZwTj8bTPgoTr/PFrGIptld483X7E13Dj+PcjQTbIqUcBKw6EKqWKCmtwqWRKwb
	vY96WQmEeSppQEI794RzD2X6itu4K/oTv7bLm681O/igc0lWeRL8wVmpTCyjPb6jSJSbCruROQd
	DsJxbtcx4yVgO9sTiTNpCKLuH9LDfhzfUtAfTAr0nO6+EQYbUX5XWRnCYn33NJw0AnN2K/KmJrt
	phIbIirW5SY8yqkB5O1TakX5MtXOjYK3ny3DiJQ23sSJFNshSpzIZW5qzPcmsoHgRfCXmlUjLJE
	UrfsSRAWMLEwB7hKIBSFltyTkW4Q=
X-Google-Smtp-Source: AGHT+IGVA49Felbs27PadgaFXN++BYp8GHFxN2UZXDDxNeHRd4MCJpOkfBeMbxQ9o+r14RuVAakEUw==
X-Received: by 2002:a05:6808:1984:b0:43b:663e:270a with SMTP id 5614622812f47-43d50d72f39mr911532b6e.39.1758122559292;
        Wed, 17 Sep 2025 08:22:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986ca64sm5388388a34.14.2025.09.17.08.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:22:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Sep 2025 10:22:30 -0500
Subject: [PATCH] iio: adc: ad7124: use devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-iio-adc-ad7124-use-devm_mutex_init-v1-1-ff23fe3ad954@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADXSymgC/yWN0QqDMAxFf0XyvKItSqe/MkRqTV0e2m5tFUH89
 4X5EMK5CfeckDERZhiqExLulCkGBvmowL5NWFHQwgyqUV3TSy2IojCL5dFStWLLKBbc/eS3gsd
 EgYpoO6N6PUvnng646JPQ0fGXvMabE343dpU7hNlwjY3eUxkq/s51Qh/5WrOu5l0orDBe1w/7S
 OQ3sAAAAA==
X-Change-ID: 20250917-iio-adc-ad7124-use-devm_mutex_init-45a297b1ff8f
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=zQsz9BdqYptqLS1CMsswCBOUQ6lz2yV3McAsdB6NOOE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoytI3IQvdBP+yS597bPrqEJC0E63Fmq5HNfTed
 2UnEEDvaXiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMrSNwAKCRDCzCAB/wGP
 wHKIB/sEN4lqvOC9afRqIE/ulkwoktZ1q1wpR7WsLN8FSZH2EPNZRAJOd/rGsgs5wlyDicCwz87
 y2PSKodKgzBtH6qGPqa3HsiljxZ2cgP9HyOvLYHYTtEVa7c2RcwKeX/rZqqL3VOwr8TjaADfoKK
 3Il8XnzVjHZX9eW2A4NXPeD7fB9SJOnbWw3iI4NvNdlRJ9hAdcFa/YmaueJgvCL4q4cc9FOLvb+
 3QCb2QQQhKNzdrwkE3OZ0wN2rfRaNzuWaoH5G8xhln8MUvI9coVpMHtVFthPeRJ/YA2cQttan8K
 M3dItbxroFaw6qbHwFsc84lif24EWUkx6iLvdsvqkm3xcAAo
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use devm_mutex_init() to initialize the mutex to handle automatically
freeing in debug builds.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9ace3e0914f5acab695c0382df758f56f333ae72..9d9250274b9a02e2982e6ceda27009a84413dc2f 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1482,7 +1482,10 @@ static int ad7124_setup(struct ad7124_state *st)
 	st->adc_control &= ~AD7124_ADC_CONTROL_MODE;
 	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_MODE, AD_SD_MODE_IDLE);
 
-	mutex_init(&st->cfgs_lock);
+	ret = devm_mutex_init(dev, &st->cfgs_lock);
+	if (ret)
+		return ret;
+
 	INIT_KFIFO(st->live_cfgs_fifo);
 	for (i = 0; i < st->num_channels; i++) {
 		struct ad7124_channel_config *cfg = &st->channels[i].cfg;

---
base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
change-id: 20250917-iio-adc-ad7124-use-devm_mutex_init-45a297b1ff8f

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


