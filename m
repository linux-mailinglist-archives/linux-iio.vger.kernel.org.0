Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A90191C50
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgCXVx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 17:53:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46406 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbgCXVx0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 17:53:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id q5so68064lfb.13
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZPRr/IJw8nWPwSD3L0UnUU6C7HW6U72pxzfNJb/YDs=;
        b=pEnqXeG9sY0ydbsYFmYJh+kXQfEQzFQYIiRxICdJlR0yZIW9HFVjZjTCnQL7p/ly/b
         860qkZfD9rYpc1Ep8ZDX+2dvqbcj5WHtwQW26ilAZM/vyaImNzGM11C9TjTmeVGBHdkz
         B52Pr+ZihEfT2NCDZZxoyAfllappLUZoaXP5WpBxyzrjt2ZlEMpagi+CXGVYuMbL2+QN
         aDVRKIGGfmdHFArg15hT9lU2WKG4jHvZezNF+hSIAv1vEzd6V+QDDy0LJUMo8Z4RlDQz
         5nCOJt46Ecy+UFqaulMXu+HjAHeORLDQJqJmGDA8V3Mzfd2e3RU2cXLF6r7cMA2Lw2PE
         QGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZPRr/IJw8nWPwSD3L0UnUU6C7HW6U72pxzfNJb/YDs=;
        b=KwLFsJYnCpC2vq5FW/uSkIHdMmXZw8Ecg75vW00e56Vcf2BmXGPoFghWjQOkBjdabO
         2FNrgyLrhc9wfrs0PVvHhxNr3eYq64WmpwNud0s/aO23urClh9ASFGPLvsHFm/kxbwxC
         B67dgxJEX8rh4HnHxaSEnp9nr/n9Sv5cLYkh/5pWJgCFW8UvjK6m9kO4RgUAvkp81lDn
         QcOWUNxuZjFmkwwP2tAjUah/gBvsNLypgWoWueIXB4wzjYYP3kKOo6JFol/3zifrpZQQ
         P8M0PV4l/4r2ycfsIWEj+a9qLrG2PzuAYH3bLmI3AWP0hhexXCyWOVuvrwyz6qmke0Fm
         23TA==
X-Gm-Message-State: ANhLgQ22ZdTg9CnjwsrSIiMPbFfjyuYw+qK3hwp3OTsNG05aW77r5dhX
        htwRjUx0xCBeWjdy9uF+s7jjiW79
X-Google-Smtp-Source: ADFU+vueqFf1kTznEvtq0Kg3SgTJ069geNJEDOGDKQI+Z5Kz076Pew0ARe79DOJFlLc2FLa4ne8rUA==
X-Received: by 2002:ac2:5e38:: with SMTP id o24mr86790lfg.139.1585086804999;
        Tue, 24 Mar 2020 14:53:24 -0700 (PDT)
Received: from localhost.localdomain (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b3sm10556518ljj.46.2020.03.24.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 14:53:24 -0700 (PDT)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: Add sensor hub device LIS3MDL
Date:   Tue, 24 Mar 2020 22:52:26 +0100
Message-Id: <20200324215226.1711659-2-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324215226.1711659-1-jimmyassarsson@gmail.com>
References: <20200324215226.1711659-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add LIS3MDL register map to sensor hub device table.
Tested with LSM6DSM.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 63 ++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 95ddd19d1aa7..20fdef7a6ea2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -88,6 +88,69 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 			.len = 6,
 		},
 	},
+	/* LIS3MDL */
+	{
+		.i2c_addr = { 0x1e },
+		.wai = {
+			.addr = 0x0f,
+			.val = 0x3d,
+		},
+		.id = ST_LSM6DSX_ID_MAGN,
+		.odr_table = {
+			.reg = {
+				.addr = 0x20,
+				.mask = GENMASK(4, 2),
+			},
+			.odr_avl[0] = {  1000, 0x0 },
+			.odr_avl[1] = {  2000, 0x1 },
+			.odr_avl[2] = {  3000, 0x2 },
+			.odr_avl[3] = {  5000, 0x3 },
+			.odr_avl[4] = { 10000, 0x4 },
+			.odr_avl[5] = { 20000, 0x5 },
+			.odr_avl[6] = { 40000, 0x6 },
+			.odr_avl[7] = { 80000, 0x7 },
+			.odr_len = 8,
+		},
+		.fs_table = {
+			.reg = {
+				.addr = 0x21,
+				.mask = GENMASK(6, 5),
+			},
+			.fs_avl[0] = {
+				.gain = 146,
+				.val = 0x00,
+			}, /* 4000 uG/LSB */
+			.fs_avl[1] = {
+				.gain = 292,
+				.val = 0x01,
+			}, /* 8000 uG/LSB */
+			.fs_avl[2] = {
+				.gain = 438,
+				.val = 0x02,
+			}, /* 12000 uG/LSB */
+			.fs_avl[3] = {
+				.gain = 584,
+				.val = 0x03,
+			}, /* 16000 uG/LSB */
+			.fs_len = 4,
+		},
+		.pwr_table = {
+			.reg = {
+				.addr = 0x22,
+				.mask = GENMASK(1, 0),
+			},
+			.off_val = 0x2,
+			.on_val = 0x0,
+		},
+		.bdu = {
+			.addr = 0x24,
+			.mask = BIT(6),
+		},
+		.out = {
+			.addr = 0x28,
+			.len = 6,
+		},
+	},
 };
 
 static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
-- 
2.25.0

