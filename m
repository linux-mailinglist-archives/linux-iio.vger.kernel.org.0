Return-Path: <linux-iio+bounces-18585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2CFA9999C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 22:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6415A76BE
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B16262FF1;
	Wed, 23 Apr 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="W1SVrax/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE011A2389
	for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441209; cv=none; b=TChZcuY/ByfZe6jDSGUh3ovpJcLVA6m3r7y7u5ceqx0c+kEd1ykRx3cXpm3VVR0jxQIkQVFJxO2VzrJWaMEeKflubB/xJkZf4GgI6WgTof+K+tRRHCpP8RCLXwcNfd9UTnzZeRmO2nePK/NXR0gajCTuQUgMYOFqqnnz/ynCtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441209; c=relaxed/simple;
	bh=08K67GTjJJIyjoZCO+i8L+poLCnfjeATkMYeADJx9Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ReXGg80npJed2rcSIZKAD9lqZom1UINNC84ksHqgzm7VkoAgvZ812XFTnzsKNnMSt6dylSxivfKOz4T3i6ikfcHwhiZNyUDDfnTFNbQ0XPPM8myrz7s9sAqag4nWKs/4xEZ8/yn/nuw3o+J/TR7XTFwLYoXdstiqTw3P51j++Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=W1SVrax/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227b828de00so3122015ad.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1745441205; x=1746046005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQk5AFNYwc1uOZhSgxpRZBIFVIR3xEEQu2RmYI0k8l4=;
        b=W1SVrax/6nAkNqnzqzAuIPKpJlusOYffKMK/wboygz69CZMmmCZ8+yXq8TW0zw7D2Y
         T6qmc8crrM/4jgNmZJqAWhbOPCVVNM/nZ/nKAlsUzvAmn3riBFWL+ry760wFjZEcaoKg
         Ql8rykT5YIpO2lwhH3RYRWAgqFYLRzcQDU6hqbSrrfCyBhKO0q7SVIMjSTVopFyxxar3
         inPoctwBQ114lnPC8nniqhNSpxGX6Ur36uWPM6dyQ9r4vMswtbJ1yx5zIu3B3LIb7JT3
         nMrR5ycatlLJRFQIbGjvumnSRZEFOUS6K1jHL5IdHlPAgkUE7L+zxpv9ailQQ+84ifj5
         DlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441205; x=1746046005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQk5AFNYwc1uOZhSgxpRZBIFVIR3xEEQu2RmYI0k8l4=;
        b=ATuwchDiJh1uIZuC6qG5JtUlzC9Yt0CbrMDi/kUyhMwrU1JkliALIJ+t/po48x+cDt
         CPb3qEtmRpfoZjZ5X8vRicypvUC1pd+NnMDjcdVN6V0h3cGF0d6y00HTpP1TOUsie0Ys
         k4t7/hOuU2IZkHKwoTBB1IAtd1ezgtVqD/VlH8Y3sax6cSsL3hKaYCpT/H1myp+aRZ47
         /MeRe0t4W0Ebrczf+RzIx/QOiVcXToE4SxlS5neCy5C/e8lGIncBsgXDwltE7oUJA4hD
         MOgNOzHc6WVXiEjLf53jGAmAtNtayQJlfcS0snPaUICaEUwo2UkVu2ORGthYqltp+y+Q
         4BrQ==
X-Gm-Message-State: AOJu0YwyCf6yBXPSNNQ2+BGDX/s6mUUN4ajzQSB0PC1yLA+Ki1d6rqe4
	a+5p0SXr7XCcVnvbas9UhoKWxnoAQBYGI8Viiqxqu5ia7LljOUoWb66IXaj45Hc=
X-Gm-Gg: ASbGnctTBKD2wXZBkMlTD82SZZgZ0Gnz7sdmRsUVZpLBzR0Nr0ZzATe6GpKpPFd52Ca
	55gNmXx1qLHP3B60hCrfpE14PYa+1hAwRutoBqRS6S3xtCuCE3cogEdhaY2QXFRt/n8dmz9kwE8
	rdpLZiDpdvkAayN5tIOOd3chXjk8AiPH+tZgZM2DHjaQ9JeZYUzjj2wuC6ypYoebfKKSLI8vsLg
	EEpFJ0BplJVcYBufpRrfggt58eVAIdbQtGU0ZBfhQVakxt0f+7rj0QL0y/cMzKHkk0t0TiCM2Ta
	PFMUnfr194hikvYUSPGGRNg/qYCqcBFMI+fFvf7EM0jQbRY697Y=
X-Google-Smtp-Source: AGHT+IHIV7MQTJsAy3RQmKpSwqgZuFqta/zOBFtK6+z+wDFjeAXEtL9w3LcRsR4PfBPE3ly/7I19xw==
X-Received: by 2002:a17:902:cec9:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-22db1b38ff5mr10662865ad.42.1745441205582;
        Wed, 23 Apr 2025 13:46:45 -0700 (PDT)
Received: from gustavaz.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb48ebsm108690975ad.122.2025.04.23.13.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:46:45 -0700 (PDT)
From: Gustavo Vaz <gustavo.vaz@usp.br>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	gustavo.vaz@usp.br,
	franciscolealhenriques@usp.br
Subject: [PATCH v1] iio: accel: kxcjk-1013: Deduplicate setup interrupt functions
Date: Wed, 23 Apr 2025 17:46:31 -0300
Message-ID: <20250423204631.16460-1-gustavo.vaz@usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The contents of kxcjk1013_setup_any_motion_interrupt and
kxcj1013_setup_new_data_interrupt are very similar. Deduplicate these
functions by introducing a generic function named
kxcjk1013_setup_interrupt that has an additional flag indicating if
it's a new data interrupt.

Signed-off-by: Gustavo Vaz <gustavo.vaz@usp.br>
Co-developed-by: Francisco Henriques <franciscolealhenriques@usp.br>
Signed-off-by: Francisco Henriques <franciscolealhenriques@usp.br>
---
 drivers/iio/accel/kxcjk-1013.c | 87 +++++++---------------------------
 1 file changed, 17 insertions(+), 70 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 971b76c98606..910d7b5716e1 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -674,8 +674,8 @@ static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 	return 0;
 }
 
-static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
-						bool status)
+static int kxcjk1013_setup_interrupt(struct kxcjk1013_data *data,
+						bool status, bool is_new_data)
 {
 	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
@@ -690,69 +690,12 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = kxcjk1013_chip_update_thresholds(data);
-	if (ret < 0)
-		return ret;
-
-	ret = i2c_smbus_read_byte_data(data->client, regs->int_ctrl1);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
-		return ret;
-	}
-
-	if (status)
-		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEN;
-	else
-		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
-
-	ret = i2c_smbus_write_byte_data(data->client, regs->int_ctrl1, ret);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
-		return ret;
-	}
-
-	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
-		return ret;
-	}
-
-	if (status)
-		ret |= KXCJK1013_REG_CTRL1_BIT_WUFE;
-	else
-		ret &= ~KXCJK1013_REG_CTRL1_BIT_WUFE;
-
-	ret = i2c_smbus_write_byte_data(data->client, regs->ctrl1, ret);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
-		return ret;
-	}
-
-	if (store_mode == OPERATION) {
-		ret = kxcjk1013_set_mode(data, OPERATION);
+	if (is_new_data == true) {
+		ret = kxcjk1013_chip_update_thresholds(data);
 		if (ret < 0)
 			return ret;
 	}
 
-	return 0;
-}
-
-static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
-					      bool status)
-{
-	const struct kx_chipset_regs *regs = data->info->regs;
-	int ret;
-	enum kxcjk1013_mode store_mode;
-
-	ret = kxcjk1013_get_mode(data, &store_mode);
-	if (ret < 0)
-		return ret;
-
-	/* This is requirement by spec to change state to STANDBY */
-	ret = kxcjk1013_set_mode(data, STANDBY);
-	if (ret < 0)
-		return ret;
-
 	ret = i2c_smbus_read_byte_data(data->client, regs->int_ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
@@ -776,10 +719,17 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 		return ret;
 	}
 
-	if (status)
-		ret |= KXCJK1013_REG_CTRL1_BIT_DRDY;
-	else
-		ret &= ~KXCJK1013_REG_CTRL1_BIT_DRDY;
+	if (is_new_data) {
+		if (status)
+			ret |= KXCJK1013_REG_CTRL1_BIT_DRDY;
+		else
+			ret &= ~KXCJK1013_REG_CTRL1_BIT_DRDY;
+	} else {
+		if (status)
+			ret |= KXCJK1013_REG_CTRL1_BIT_WUFE;
+		else
+			ret &= ~KXCJK1013_REG_CTRL1_BIT_WUFE;
+	}
 
 	ret = i2c_smbus_write_byte_data(data->client, regs->ctrl1, ret);
 	if (ret < 0) {
@@ -1112,7 +1062,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 		return ret;
 	}
 
-	ret =  kxcjk1013_setup_any_motion_interrupt(data, state);
+	ret =  kxcjk1013_setup_interrupt(data, state, false);
 	if (ret < 0) {
 		kxcjk1013_set_power_state(data, false);
 		data->ev_enable_state = 0;
@@ -1293,10 +1243,7 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
-	if (data->motion_trig == trig)
-		ret = kxcjk1013_setup_any_motion_interrupt(data, state);
-	else
-		ret = kxcjk1013_setup_new_data_interrupt(data, state);
+	ret = kxcjk1013_setup_interrupt(data, state, data->motion_trig != trig);
 	if (ret < 0) {
 		kxcjk1013_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
-- 
2.43.0


