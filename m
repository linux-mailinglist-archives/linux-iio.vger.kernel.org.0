Return-Path: <linux-iio+bounces-5365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1A8D09EF
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F8B282A40
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057115FCF0;
	Mon, 27 May 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd8cAiml"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2D15EFC2;
	Mon, 27 May 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835098; cv=none; b=oPiIhmJNv09l3jlNZgmahhE3mSE8A7alfaxWm9W+ONloCKo7r8a6hRGYvJkgj4QntcWEUpgtQUSXI9MToKZupPWFQp4DQFfV9f6j4TwKgtFcUVa/MN4e0YlVHwjCmUxTG8N1TWUiXI0i/wtkw5ciyQqWS59jkn9spoGs+KhqWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835098; c=relaxed/simple;
	bh=Dljol5I7T/go7JkK7rwB5Fp4x25iV/GPuVNSd59Dbgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzdZRS0zzzVMoVPYyWXHg0tfeet7batk61K3K/M0wNLE5fgTCBjYDWmWxgj9oMuVxJ2fNK8p21TKHs1wOHuSmih7sbA5/zuGWgtogJfRug7gSBDtSeg8C04mbTikktb81G4kVM5DAMB5kyUm1AhLmo7H0HCMyk6IVSKpnsgh0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd8cAiml; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-523b017a5c6so82355e87.1;
        Mon, 27 May 2024 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835095; x=1717439895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dGq+BBpr+rlxUS0WQliGQuIKZph55HlIZAdnOOG0UE=;
        b=Wd8cAiml95tpFwcL5IxCAWceMiSMUGJ4ta5InHXwARhPS6psmtgoCWKQpX30odYHVs
         VmSFRfukvvXjm/gTE+57s6VgTeOIOTJK7iph0PZ25gH5p1Y/V6NDeVYCDohD5Vd1P1gs
         njEU5vk6k2bBdFHUmgT+H2WTmMsrXcu365y9F9vmalG3RUuwWHISQUIiwIQ/SFVc10Jq
         17JkeT83KnSCYz9RFMxaPcsmZdesDB88xcbDUUUbH92jaCNGc4H8OdLYve6cedKH0m5T
         nLv9DZMYXvqxqqSr4b0AQWrB1XoLQrRzS5CJS772inlzJ3sPMK0N4Cm1y29oeIYCvsGf
         K/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835095; x=1717439895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dGq+BBpr+rlxUS0WQliGQuIKZph55HlIZAdnOOG0UE=;
        b=UIwTRWFVHXUsMPDzglyw/cq/rMI2G9skap5kPlKg3A9C/U3TdSbD+Oz0T5gxnPcop1
         XDL6XLhoUC0fylaF4pgK2hu+rQA2mXPbKzl0hoenawSgQTc1sx68Fsm1nwsrmSz5vqdi
         EzepPMVFUWG5u7Ury6Pgir/YXz7vS8aTRgkIv2SK5bVxDHjKlrKC42Eqm4nZ+2RmWEZ8
         aVuvwtiGapkrc/LAg7U7TbUdhRhA2cJLzRwq9O/9brbv6JlNOCkSM+mV2fJOJd+rXNeJ
         gVPDrLJ+ipU/hXKYd8gUJ8B6dcoLd4V3eCvLRZa9TLNnB0EYt8DEKAQYVCrsGCTCVxgb
         8yxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEESuLjGbBt+QEmOi/9EWlXVzPtvJodOLAIMBIyJBV+GGN4y6NL/sBCARQsM3LCmz4GAAtFVZUX63YegO+9wNpCz8wpUqdR3kOixKBvNHICze256J5E4upv0H4mNiJ3+SfiyD9k0no
X-Gm-Message-State: AOJu0YzUDABX0joD1pH1UmGbVudWDRJlrZ36/nmS7ZENS3kjtlsu7AzB
	b6RaNIClccZzosYwsZ7FK5hGzMihGlx5T6WsXiUA7FsOao3Um2U5a58R0Q==
X-Google-Smtp-Source: AGHT+IE+pDvOblNnvWW0ebawVjlThI5+UY/fjba81lJiG2t/WWw7LdWqMqzP6CoT6aVtCklLygjnQA==
X-Received: by 2002:ac2:456e:0:b0:518:9ce1:a5bb with SMTP id 2adb3069b0e04-5296736bbe6mr7172162e87.54.1716835095131;
        Mon, 27 May 2024 11:38:15 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:14 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 02/17] iio: chemical: bme680: Fix calibration data variable
Date: Mon, 27 May 2024 20:37:50 +0200
Message-Id: <20240527183805.311501-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the BME68x Sensor API [1], the h6 calibration
data variable should be an unsigned integer of size 8.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L789
Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 2c40c13fe97a..812829841733 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -38,7 +38,7 @@ struct bme680_calib {
 	s8  par_h3;
 	s8  par_h4;
 	s8  par_h5;
-	s8  par_h6;
+	u8  par_h6;
 	s8  par_h7;
 	s8  par_gh1;
 	s16 par_gh2;
-- 
2.25.1


