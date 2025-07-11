Return-Path: <linux-iio+bounces-21573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F77B02137
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA145822C6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F62EF288;
	Fri, 11 Jul 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PpNzLt7M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD417A2EB
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250051; cv=none; b=hNbTSKxjwRks5qBbD8Ibp7e9upuRHEfavypNUL5/M5X4UUvbP9+5NE5ijK9QwOb28k9GF93eCjjtiTfQAJomrV7VBGF5djKokjNUmaOydxf/CWF95YDAgly3E0Ujqj1vwFXQaJLXurFPy0NyHbNp/nbUy993MkIIXA4suOP35fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250051; c=relaxed/simple;
	bh=AtegTTEJzrAxrni6NqpMzSIP8qbPAdGPQbVzQxxkFDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LhombgmuykcMSrCQF+JlLRbYsy8TODW39z2ankAfLmUB/1GP1d4zPJEqNdf0dwwWn0FfZyizOcHPceLuU9QVjvXXmNuLvvqAHMDK3iHLlx65ubC226JVE9Cnknmrwk2LuVS8I5aMbF+p/+GzepX58VOmhlFcyAG/gTPID55eS1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PpNzLt7M; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40ba3c10b3bso759675b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752250048; x=1752854848; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0x68b2GGiwLnHgZ6EfXJA1q/WBDFGvRVX99Xs2juek=;
        b=PpNzLt7MN0699T9mOdhGfM2iozgeZnzbkJYu6YVPXQ4noVn3I+GDKnm5aR12cK6v8y
         rsnprd5fh+mPidvmI7AkBQ46UI+zR6mwpbABHtH1iCMlmcJ+w8ZAjXax2TlyueJu2/GZ
         a4ZvqxMN22GGytpUEbNgtgpNjE2wxd0lo49pmLKiqxqqUiEa9rbrJlqrBPIWI+wCD6Tj
         xMJkPrAv0Xdnxw/FMJFG8m4Ty6WPPf0G22jkf+CDe7qNi7EPdDgMZbYoequ/aaCZUZwK
         60/QdZAZP3yaQooRiJicJUItAfyw6yirljVXWvnPpSUtCkETWn9+0obh+magLcFeVlE6
         VSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250048; x=1752854848;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0x68b2GGiwLnHgZ6EfXJA1q/WBDFGvRVX99Xs2juek=;
        b=wOu5s1dRONNihT8Zs//rzqBDBc3lVz657+PA5VEN3yfk6E9L5NWV7blZmTAM3KNBuP
         42GiCIzvYcoh6og2SAYHZa8rLmZLEQ7FYVNTq32OiIzKp00AldA3bMwo1eNMY7zAK30C
         3NaqkfxVHU6fy7HNSnVy7NQ8KWIv2zLow9RC99DoBoLHBrZOMBTVaOCKe3u9dyAyOZbq
         EDZvDun8BpLtwuWL2FZjLHtOczDFxWTEKtNtbrNxou9W5vYFu+HwUK/caYdzTfwEEVw2
         ZlW4dg8z+iI8RBtAESXlOx7vESp5GNSUkWJ80hJPoSSE1aLGiNZVPKqKeop8dvuc3J4h
         It6A==
X-Gm-Message-State: AOJu0YxaPdSAOCxDMzlTo93FF8aDuEtvybn+VIahXDrGmjjMJl1zcmqD
	n3U/n5E0BR+hIpb0uLxS/t2oGMmOZX7iQJRNTIWCktrt7z/Bp0fcWuYw0CsGnyvM+sg=
X-Gm-Gg: ASbGncs5IEguJ7/MXV00WIEo8mNlueQLEuXrYhifyu0cu11CVmEPtMpZteycHom8B4a
	mzv5x3BWDxeJVBI9M9ABPMC3QORYDPsd4afa7TGc1t1btuErdVGflZe1Hxc1jLneMGaH478cCfN
	Dpfj8RLSIfz3lKazTitcrSGza2Mn0LP+Ex4lGdziYsoiD/4zBlXiEdfmqga8bOmlZ+qYQSTjgka
	Rivvce+WKezIRyz2D81hQrAa64d74u+jTI9OFSLDXkcbEvLGPEqUvkvo4AOMYLR1VzOMJgo3Ml1
	PT4F2ogjFGjxXy2Yfru0aKsgXrbWeOfaB4608SJmjDdT4WH9GZpcKR+iuycRFJpC52G1R6FQN18
	4peOIOyuU3m2QeUQfvcT8mQ751+kv/ZJvgiJj9+A=
X-Google-Smtp-Source: AGHT+IE86krQH6raJVmTbIjTjGy8p2SV1pmfS30yjq6wezMZ/Dowz7J//p8zsC5IgwSAIWI5N1WKKQ==
X-Received: by 2002:a05:6808:244d:b0:408:fbb6:f4cb with SMTP id 5614622812f47-4150d64510cmr2983584b6e.6.1752250048281;
        Fri, 11 Jul 2025 09:07:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f1a00dsm545823eaf.28.2025.07.11.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:07:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Jul 2025 11:07:20 -0500
Subject: [PATCH] iio: proximity: srf08: use stack allocated scan buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALc2cWgC/x3NQQrCMBBG4auUWTvQBFKtVxEJNfljB7SRSVuF0
 rsbXX6b9zYqUEGhc7ORYpUieaowh4bCOEx3sMRqsq117dEYFsm8FPAzK37wEeExKPxtSQnq3zK
 Pfi7ccZdSOKHvnbORau+lSPL5vy7Xff8CSrgzrnsAAAA=
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-6-6ffc8e99552d
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=AtegTTEJzrAxrni6NqpMzSIP8qbPAdGPQbVzQxxkFDo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocTa4Od6BGR1u6TBdJ9nIig191uAxwl3BzilOe
 AXzTP9eh+eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHE2uAAKCRDCzCAB/wGP
 wEzhB/wIU+f2hsEsAFIYBagsns3gi+SSkUNpgP2+xwjqz3FVAR4I4qhDEFryjEOUDY/Wp4tk6/4
 MSaZoQZ8nNcYR/fe6ohSIMMJz9l6y+XxZHF8vgqaY/34kZahIrsiCcxQry09an85oS2P2ZY6oux
 xYXgNhkPFniReIoMi/oqdjjGhzgnuLKyiE8evtvMltssm9QixSJaVWKtXTeVPBWsE+Ckj5cohUV
 MtLUOpJ7r1rgmHWcyyVTyOTrC0GTUruQ28eJttR3T4taXO8kEzl2zNFLfUOsdH/JxSwravcAnaw
 r56aBcl6Zeemhn2iTkd0TBBUsFva0Loyzz4SPy26Y4vYzefG
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a stack allocated scan struct in srf08_trigger_handler(). Since the
scan buffer isn't used outside of this function and doesn't need to be
DMA-safe, it doesn't need to be in struct srf08_data. We can also
eliminate an extra local variable for the return value of
srf08_read_ranging() by using scan.chan directly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/srf08.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 6e32fdfd161b93a5624f757d5b7de579415b1055..a28efcf324a844a6dca43dff69e71ca38a2ccc68 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -63,12 +63,6 @@ struct srf08_data {
 	int			range_mm;
 	struct mutex		lock;
 
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		s16 chan;
-		aligned_s64 timestamp;
-	} scan;
-
 	/* Sensor-Type */
 	enum srf08_sensor_type	sensor_type;
 
@@ -182,16 +176,18 @@ static irqreturn_t srf08_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct srf08_data *data = iio_priv(indio_dev);
-	s16 sensor_data;
+	struct {
+		s16 chan;
+		aligned_s64 timestamp;
+	} scan;
 
-	sensor_data = srf08_read_ranging(data);
-	if (sensor_data < 0)
+	scan.chan = srf08_read_ranging(data);
+	if (scan.chan < 0)
 		goto err;
 
 	mutex_lock(&data->lock);
 
-	data->scan.chan = sensor_data;
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    pf->timestamp);
 
 	mutex_unlock(&data->lock);

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-6-6ffc8e99552d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


