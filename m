Return-Path: <linux-iio+bounces-16287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DAFA4C1D0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC19F16E55A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C2212B21;
	Mon,  3 Mar 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="nDt6q4/K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788F1F17E5
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008167; cv=none; b=SMyVLVvoxcgkOfBZRd1G5Mgrexc+KOIWtrIW3tANpJ6Exl24wvPjtU9Ksb77M3iFjDgFPOtRvN00sTIdgf1xWeQfZp4g0oraXpNuxQxwZ8y/PxLQIqzL++WIHA47Bxq2ZFqS++5nMaQgUTpIDKjwPG0aU8pTCngGwmYYHml4csU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008167; c=relaxed/simple;
	bh=5i9uP2Ze50hwz43llaF1f86tTfk7p6fywziSf77roYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgaeOvATE1a8dFrC7UoDMTPUGVhaLAzXaQTUz/KEpN7dCR+6S7jGT4kmiPB0oLYf5/amPiKY/7uc+DK7MUve8bfaKuiTKkm+VOPSCpwAzqgIFYcEbf72ypTITAjARTas4ER/qSIe9gGDhrd8HYP9E14x49PEiMeVmY6DCTmMiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=nDt6q4/K; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390df942558so3499155f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741008162; x=1741612962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECd7n/EGUmOy5J+E/dKH2tzC4YWX/xlVp74bjlxoPQg=;
        b=nDt6q4/K0N8xzRqLxFMqd6p1ibGHiV7xxPWXT+usVbOPibIx5bWm7/n/dn9DYCj9hj
         c2H4VCsB/m13egqj5b5paRRnZK9yUobXj1xIDb7HDEuTJ6Dx51+xV7isuyfBODiDWnli
         NeDXt2m+BisCAEvycr6XqxaD/0VQu9tuMYZFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008162; x=1741612962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECd7n/EGUmOy5J+E/dKH2tzC4YWX/xlVp74bjlxoPQg=;
        b=r5DGjuz3yfiqk73qCHgzK4Qx6XPdaRaF1ss7sv5vTCd0rO7rjGsUgg3wmLi/iCjgth
         +oBgvtITbLYPa5TVyiaoV1y6f6kw0YzAg5SpHAiLQq5ijZh7JSpkCF3d3sqb0iCatkPQ
         vFwleX1puyBcAstnNLhzTpiz6kRtpx0sqwT09LuqjiV5QI6hgYsN9VAE8hOPu2FxKJs1
         g5IeX96E1CoOWGuV2O90KYZWzGe7cmRxFAeSaZzQ3GR0wG9bb/0z/suYG1T8KH9OpJfa
         B2B/roNbOCKHuuNk0wE2eGKmL69ZhSwP9ttDq+MxyffeVOIHVE5OL95tCrWsMJnpaOMl
         Q4bw==
X-Forwarded-Encrypted: i=1; AJvYcCWY9/vUnswt1j8++wmzvWXMkxsjOYreQ+F1nDQldsQtiX/54dlaCHPxFeDkjEaCDdG6Kx7MteO6dEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYClDPYlmjDlTRzzusXcq0f/0U25hseIPRuqHKcApOwK4FgPFC
	iF2J+j3FQD3ve59HuqWS4Mo2df39YMscUZx0JMiltz14uIkoAto/gDVWzjySYg==
X-Gm-Gg: ASbGncuGgGjMoa2fz8cbn7P6FfQn4pEnn1Bptk+odis3WDSB5jPfee9s7vX/zzVflco
	f5sHtEPD62cz2xvmUAGDwzH/qRLw7WuNNuK2tDjWdARDU8ctWw6e04n+Q+Bt/Mtc+0GnlrBEZ6A
	Gi+JzBkc2EncBahdwC2pawImOi3F4o5vp8+5mCmmpTXw+VyYmX2AIthMrWSitPLrJA70Dsc7RPo
	/zMp+noNmu944TkVykg2wqg8zfN9nAP/kmk+OXbCT6zrsU74oadwD7Pe1ExuUlAezk5qRvVbPql
	TVX0MSaLhvXEq9H/BI7EDNPEdRs0P1rnsT5SLXWxeOl7u+UWzvn39pSlgafaSZhzPwYD89Sqpqt
	f2r4cNnM=
X-Google-Smtp-Source: AGHT+IGakxsdP7cssVmEZsfodi7ojWu3CfAaSJKH4e/l+/9KTp9+UWQBz14kFBtrP7h34XIaqmym6w==
X-Received: by 2002:a05:6000:2a3:b0:390:f9d0:5ed with SMTP id ffacd0b85a97d-390f9d007fdmr4858802f8f.1.1741008161601;
        Mon, 03 Mar 2025 05:22:41 -0800 (PST)
Received: from marvin.localdomain (94-35-64-90.client-mvno.tiscali.it. [94.35.64.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f770asm166769265e9.6.2025.03.03.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:22:41 -0800 (PST)
From: Silvano Seva <s.seva@4sigma.it>
To: lorenzo@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:ST LSM6DSx IMU IIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
Date: Mon,  3 Mar 2025 14:21:25 +0100
Message-ID: <20250303132124.52811-2-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
from falling in an infinite loop in case pattern_len is equal to zero and
the device FIFO is not empty.

Signed-off-by: Silvano Seva <s.seva@4sigma.it>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..7f343614f8a5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -395,12 +395,17 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
+	if (!fifo_len)
+		return 0;
 
 	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
 	if (hw->iio_devs[ST_LSM6DSX_ID_EXT0])
 		ext_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0]);
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
 					    hw->buff, pattern_len,
@@ -623,6 +628,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
-- 
2.48.1


