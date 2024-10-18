Return-Path: <linux-iio+bounces-10745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BA19A464A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 20:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F5F1F24445
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 18:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ECE2038C8;
	Fri, 18 Oct 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU13PlMM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63F20E319;
	Fri, 18 Oct 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277698; cv=none; b=qlvRUPyCwbgxvmCOl1ysHypP+nfwOsufyroT3oCx1WBzOFPnMH8Gxa61Ccy1MljAq+nBPqXd23vME7eqIlWUHICveCMzSGXAiibsXe3JqlYotpKFEuY2hsIzwJazYBrXoCUtear59TUrrainkiDGXNyYlmXc/4FIjYXERHhb670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277698; c=relaxed/simple;
	bh=odZmaSe2NUxwSwK+Ojy4z/lhi5LMpyFMzzCvQnjosyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JhyCqR4APR/BoAcnuMhiNGArVDF52WXcP+q9syDpAMJOsni6oWe2DGIf4sXyvFdVBmFNH8wYVwPNLEvO0ClXKWDNksom9+bJJo6j0sXEvC2oq0fQDlkyfJVv4BLcvmqep9oMytCtRPbcKTZScDXDLXSEf9pZEmRrLhkkYM54/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU13PlMM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1711980a12.0;
        Fri, 18 Oct 2024 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729277696; x=1729882496; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3AekqJ3EtBItCjGHNZ1BHmF2TjbYs3oRMAWzkxT8OY=;
        b=ZU13PlMMpEQ4o3v6mQ+Nk/OKwqz7dH9033nmqO3+LeHmH3MnFQHCldFjEenlzaLRd2
         CMrF5sBXHx+w1lHvVa/kIuTGZpDdkd0ZHvVlMbLQtzPdw7dq/Oyl9fxhqD25xBL3NNTO
         QxTMvS8DaXC8Dsibu/4pIHcQ9fKgjpWEl2IOMWOr0DOBPTgnsA/DE9ldGf0ScyxsmVWd
         YcoMPMckxhEqp8ktuSsoYp0qK88lBG9l89hhRuhP6e8GegwK1oZ+de7Xltuf6clEPmhN
         mNWZuCl4ac1UVnzGBcGghlVki1nk6tWaMxKf0C848Apd+YMrBHvLi8DGtRONTLGHxNor
         kcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729277696; x=1729882496;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3AekqJ3EtBItCjGHNZ1BHmF2TjbYs3oRMAWzkxT8OY=;
        b=aT7neEtfb0Nw/+bk5A+pvQtWtF86yltRrkoqwPwrDHiGRYVf0Z7yvQppH5a1927BB8
         l0ixB0rZ3l0JEqs494Uo1CmcQEHhQdCclPaeJ8bjcUQUk2DiwyKSG+b3QGmU34V2zyPM
         BT7pNtArjqDwrT4ABSp0juXr5W9czAaMLZhnCqFxpd8X5Goqa4OwxOBtRGelQyMlWC8A
         RaSXs7liCbsHeAFDsFgh3Q7g5BJeGSVOBrIctJyfbNV8gHLbLG5MdhEEqMFSCVZcl0yh
         1cFmuq2tOMBFA4Jf81IZA7/yIuTT7BUpmUNPfwYQXC1smJc8HAIQEPh7afj3I3mNdF2e
         KFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV52c++TMP/HmZUlAKCeAAgCLJU30km9wnBz0HqovID3nCblB+Yi+SKw6ENAfFKFDuXeo8XWuOyzk6KbYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXO/unWll6DZbr93KhmpdH2DdLpVEPxLwc5QA1ord3XsgkmTt/
	4yRpUC8jotbEYMG+OIf5SkITNgN6FaiJr88IfYg72Utjv0uF5XkI
X-Google-Smtp-Source: AGHT+IG9qhjRpw2G1khLgCJq922JNmq/QJWcNC0REKrzBbqXZgXzQLUmm2Ir8ZXq03ypsNTa1OCF7w==
X-Received: by 2002:a05:6300:44:b0:1d8:a759:525c with SMTP id adf61e73a8af0-1d92c572670mr4652797637.39.1729277695865;
        Fri, 18 Oct 2024 11:54:55 -0700 (PDT)
Received: from Emma ([2401:4900:1c97:c88d:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc23a42esm1719726a12.44.2024.10.18.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 11:54:55 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Fri, 18 Oct 2024 18:54:42 +0000
Subject: [PATCH] iio: chemical: sps30: Add Null pointer check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-cid1593398badshift-v1-1-11550a10ff25@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPGuEmcC/x3MQQqAIBBA0avErBMaTXC6SrQwnWo2FRoRSHdPW
 r7F/wUyJ+EMQ1Mg8S1Zjr0C2wbC5veVlcRq0J3usUOngkS0ZAy52ce8yXIpCha1NzPpSFDDM/E
 izz8dp/f9AASSchBkAAAA
To: Tomasz Duszynski <tduszyns@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghavi98@gmail.com>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729277691; l=1425;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=odZmaSe2NUxwSwK+Ojy4z/lhi5LMpyFMzzCvQnjosyE=;
 b=GbzYKIb7BZUyUqmmCxEbpouMabZsCp77rLR+fCU8qPizrvecasyOU3rrT1K8XWjC6ZLnZVeya
 uXWMjNKe1wZALbKoQQelE1o9aUANiAxDubn4jTyi8gRAcMRQfinL9js
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Add a Null pointer check before assigning and incrementing
the null pointer

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 drivers/iio/chemical/sps30_i2c.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index 1b21b6bcd0e7..d2142e4c748c 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -105,16 +105,18 @@ static int sps30_i2c_command(struct sps30_state *state, u16 cmd, void *arg, size
 		return ret;
 
 	/* validate received data and strip off crc bytes */
-	tmp = rsp;
-	for (i = 0; i < rsp_size; i += 3) {
-		crc = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
-		if (crc != buf[i + 2]) {
-			dev_err(state->dev, "data integrity check failed\n");
-			return -EIO;
+	if (rsp) {
+		tmp = rsp;
+		for (i = 0; i < rsp_size; i += 3) {
+			crc = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
+			if (crc != buf[i + 2]) {
+				dev_err(state->dev, "data integrity check failed\n");
+				return -EIO;
+			}
+
+			*tmp++ = buf[i];
+			*tmp++ = buf[i + 1];
 		}
-
-		*tmp++ = buf[i];
-		*tmp++ = buf[i + 1];
 	}
 
 	return 0;

---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241018-cid1593398badshift-9c512a3b92d9

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


