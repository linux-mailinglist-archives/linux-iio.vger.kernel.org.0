Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598A622410F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgGQQ5V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgGQQ4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75525C0619D2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so11893527wrw.5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gU9V9XkM8BF33+dessG5HjZWXsyJ+CY9nfoKsET9XrM=;
        b=y7RlUwAslcn20lp8Q6SpuGsHWuita63J2y2jjuB8dmc/mBaZ7SlPEDXR7fanf3VyzI
         1352ALTbrGTho7FXytizcfKFHDcO0FLAlvBNzGeleG9gw0gkAoh96E01Lxa+/j739tl2
         viGPbwRrL4WROvMh987Sw75+d8S9I/XomS4NeO2SA52GVt8FFh/zR0EFT+BNxgQDxFIo
         NN/FoAK5coZrft4UlsByb0qsDexRW2md4Ps9aCZnp3gI5VRHW7ABGsHKZH6y7r/FRche
         8VJYzki7ycyJTl/sQ63y5IqOaM4k6pUDy24kZX972b4M8MCml6LQUsTQXPr/qc7CUDBX
         Eb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gU9V9XkM8BF33+dessG5HjZWXsyJ+CY9nfoKsET9XrM=;
        b=Wx8hjvgyjOj48oBhmDBzuDwbTcwYLDSMzLMYJyRLhFNjd5H3bbLdXC1eRIElf0swGO
         KDoHKemjQMTP1X64wsA0uVfknaslJa9sX5fSxWFS2fLyM5ylGm1agLMkt6mw7KO7aVVk
         PsxW5Ktrk6UnS10O40yZB8ehHelcfgl+fe0FQpz+iy3kKO0f9fwMsW6O4e+OV8+rB6Hk
         YOhBtTKtAmcScZ2dvPjNPU3aHVxRDTwHxDCy1IeT+1mlk/mH1Mak9G+w/8cmvbTg5Npq
         GSHwdP2B4/pidGHisl73X858yDgb4EShw5yX5H5FsV8XH75GKaezD+onAiWyoYu3eY1H
         AC1Q==
X-Gm-Message-State: AOAM531BYod+/p6N9TGFHbQtap1BGN9JCVLV76AIRuPCfHOcqw7yy14Y
        Wv2cpBbyQFsy7WnS75hmh9k7xA==
X-Google-Smtp-Source: ABdhPJxjeIkO2njxZz5mp9JeV+CXLQhFTO2U0LCW9SQqZCLrasHLZto3lxVp/kjGWy/fZItglO6EnQ==
X-Received: by 2002:a5d:5441:: with SMTP id w1mr10743231wrv.381.1595004979124;
        Fri, 17 Jul 2020 09:56:19 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>
Subject: [PATCH 18/30] iio: gyro: fxas21002c: Move 'fxas21002c_reg_fields' to the only file its used
Date:   Fri, 17 Jul 2020 17:55:26 +0100
Message-Id: <20200717165538.3275050-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

'fxas21002c_reg_fields' is only used in '*core*', meaning that '*i2c*'
and '*spi*' complain of a defined but not used const variable.  Let's
move it into the source file.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/iio/gyro/fxas21002c_i2c.c:14:
 drivers/iio/gyro/fxas21002c.h:79:31: warning: ‘fxas21002c_reg_fields’ defined but not used [-Wunused-const-variable=]
 79 | static const struct reg_field fxas21002c_reg_fields[] = {
 | ^~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/iio/gyro/fxas21002c_spi.c:14:
 drivers/iio/gyro/fxas21002c.h:79:31: warning: ‘fxas21002c_reg_fields’ defined but not used [-Wunused-const-variable=]
 79 | static const struct reg_field fxas21002c_reg_fields[] = {
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/gyro/fxas21002c.h      | 66 ------------------------------
 drivers/iio/gyro/fxas21002c_core.c | 66 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c.h b/drivers/iio/gyro/fxas21002c.h
index 566d92de26763..c81cecee121cb 100644
--- a/drivers/iio/gyro/fxas21002c.h
+++ b/drivers/iio/gyro/fxas21002c.h
@@ -76,72 +76,6 @@ enum fxas21002c_fields {
 	F_MAX_FIELDS,
 };
 
-static const struct reg_field fxas21002c_reg_fields[] = {
-	[F_DR_STATUS]		= REG_FIELD(FXAS21002C_REG_STATUS, 0, 7),
-	[F_OUT_X_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_X_MSB, 0, 7),
-	[F_OUT_X_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_X_LSB, 0, 7),
-	[F_OUT_Y_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_Y_MSB, 0, 7),
-	[F_OUT_Y_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_Y_LSB, 0, 7),
-	[F_OUT_Z_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_Z_MSB, 0, 7),
-	[F_OUT_Z_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_Z_LSB, 0, 7),
-	[F_ZYX_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 7, 7),
-	[F_Z_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 6, 6),
-	[F_Y_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 5, 5),
-	[F_X_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 4, 4),
-	[F_ZYX_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 3, 3),
-	[F_Z_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 2, 2),
-	[F_Y_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 1, 1),
-	[F_X_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 0, 0),
-	[F_OVF]			= REG_FIELD(FXAS21002C_REG_F_STATUS, 7, 7),
-	[F_WMKF]		= REG_FIELD(FXAS21002C_REG_F_STATUS, 6, 6),
-	[F_CNT]			= REG_FIELD(FXAS21002C_REG_F_STATUS, 0, 5),
-	[F_MODE]		= REG_FIELD(FXAS21002C_REG_F_SETUP, 6, 7),
-	[F_WMRK]		= REG_FIELD(FXAS21002C_REG_F_SETUP, 0, 5),
-	[F_EVENT]		= REG_FIELD(FXAS21002C_REG_F_EVENT, 5, 5),
-	[FE_TIME]		= REG_FIELD(FXAS21002C_REG_F_EVENT, 0, 4),
-	[F_BOOTEND]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 3, 3),
-	[F_SRC_FIFO]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 2, 2),
-	[F_SRC_RT]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 1, 1),
-	[F_SRC_DRDY]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 0, 0),
-	[F_WHO_AM_I]		= REG_FIELD(FXAS21002C_REG_WHO_AM_I, 0, 7),
-	[F_BW]			= REG_FIELD(FXAS21002C_REG_CTRL0, 6, 7),
-	[F_SPIW]		= REG_FIELD(FXAS21002C_REG_CTRL0, 5, 5),
-	[F_SEL]			= REG_FIELD(FXAS21002C_REG_CTRL0, 3, 4),
-	[F_HPF_EN]		= REG_FIELD(FXAS21002C_REG_CTRL0, 2, 2),
-	[F_FS]			= REG_FIELD(FXAS21002C_REG_CTRL0, 0, 1),
-	[F_ELE]			= REG_FIELD(FXAS21002C_REG_RT_CFG, 3, 3),
-	[F_ZTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 2, 2),
-	[F_YTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 1, 1),
-	[F_XTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 0, 0),
-	[F_EA]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 6, 6),
-	[F_ZRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 5, 5),
-	[F_ZRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 4, 4),
-	[F_YRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 3, 3),
-	[F_YRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 2, 2),
-	[F_XRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 1, 1),
-	[F_XRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 0),
-	[F_DBCNTM]		= REG_FIELD(FXAS21002C_REG_RT_THS, 7, 7),
-	[F_THS]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 6),
-	[F_RT_COUNT]		= REG_FIELD(FXAS21002C_REG_RT_COUNT, 0, 7),
-	[F_TEMP]		= REG_FIELD(FXAS21002C_REG_TEMP, 0, 7),
-	[F_RST]			= REG_FIELD(FXAS21002C_REG_CTRL1, 6, 6),
-	[F_ST]			= REG_FIELD(FXAS21002C_REG_CTRL1, 5, 5),
-	[F_DR]			= REG_FIELD(FXAS21002C_REG_CTRL1, 2, 4),
-	[F_ACTIVE]		= REG_FIELD(FXAS21002C_REG_CTRL1, 1, 1),
-	[F_READY]		= REG_FIELD(FXAS21002C_REG_CTRL1, 0, 0),
-	[F_INT_CFG_FIFO]	= REG_FIELD(FXAS21002C_REG_CTRL2, 7, 7),
-	[F_INT_EN_FIFO]		= REG_FIELD(FXAS21002C_REG_CTRL2, 6, 6),
-	[F_INT_CFG_RT]		= REG_FIELD(FXAS21002C_REG_CTRL2, 5, 5),
-	[F_INT_EN_RT]		= REG_FIELD(FXAS21002C_REG_CTRL2, 4, 4),
-	[F_INT_CFG_DRDY]	= REG_FIELD(FXAS21002C_REG_CTRL2, 3, 3),
-	[F_INT_EN_DRDY]		= REG_FIELD(FXAS21002C_REG_CTRL2, 2, 2),
-	[F_IPOL]		= REG_FIELD(FXAS21002C_REG_CTRL2, 1, 1),
-	[F_PP_OD]		= REG_FIELD(FXAS21002C_REG_CTRL2, 0, 0),
-	[F_WRAPTOONE]		= REG_FIELD(FXAS21002C_REG_CTRL3, 3, 3),
-	[F_EXTCTRLEN]		= REG_FIELD(FXAS21002C_REG_CTRL3, 2, 2),
-	[F_FS_DOUBLE]		= REG_FIELD(FXAS21002C_REG_CTRL3, 0, 0),
-};
-
 extern const struct dev_pm_ops fxas21002c_pm_ops;
 
 int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 89d2bb2282eac..f20033afc714c 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -42,6 +42,72 @@ enum fxas21002c_mode_state {
 
 #define FXAS21002C_AXIS_TO_REG(axis) (FXAS21002C_REG_OUT_X_MSB + ((axis) * 2))
 
+static const struct reg_field fxas21002c_reg_fields[] = {
+	[F_DR_STATUS]		= REG_FIELD(FXAS21002C_REG_STATUS, 0, 7),
+	[F_OUT_X_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_X_MSB, 0, 7),
+	[F_OUT_X_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_X_LSB, 0, 7),
+	[F_OUT_Y_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_Y_MSB, 0, 7),
+	[F_OUT_Y_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_Y_LSB, 0, 7),
+	[F_OUT_Z_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_Z_MSB, 0, 7),
+	[F_OUT_Z_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_Z_LSB, 0, 7),
+	[F_ZYX_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 7, 7),
+	[F_Z_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 6, 6),
+	[F_Y_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 5, 5),
+	[F_X_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 4, 4),
+	[F_ZYX_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 3, 3),
+	[F_Z_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 2, 2),
+	[F_Y_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 1, 1),
+	[F_X_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 0, 0),
+	[F_OVF]			= REG_FIELD(FXAS21002C_REG_F_STATUS, 7, 7),
+	[F_WMKF]		= REG_FIELD(FXAS21002C_REG_F_STATUS, 6, 6),
+	[F_CNT]			= REG_FIELD(FXAS21002C_REG_F_STATUS, 0, 5),
+	[F_MODE]		= REG_FIELD(FXAS21002C_REG_F_SETUP, 6, 7),
+	[F_WMRK]		= REG_FIELD(FXAS21002C_REG_F_SETUP, 0, 5),
+	[F_EVENT]		= REG_FIELD(FXAS21002C_REG_F_EVENT, 5, 5),
+	[FE_TIME]		= REG_FIELD(FXAS21002C_REG_F_EVENT, 0, 4),
+	[F_BOOTEND]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 3, 3),
+	[F_SRC_FIFO]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 2, 2),
+	[F_SRC_RT]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 1, 1),
+	[F_SRC_DRDY]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 0, 0),
+	[F_WHO_AM_I]		= REG_FIELD(FXAS21002C_REG_WHO_AM_I, 0, 7),
+	[F_BW]			= REG_FIELD(FXAS21002C_REG_CTRL0, 6, 7),
+	[F_SPIW]		= REG_FIELD(FXAS21002C_REG_CTRL0, 5, 5),
+	[F_SEL]			= REG_FIELD(FXAS21002C_REG_CTRL0, 3, 4),
+	[F_HPF_EN]		= REG_FIELD(FXAS21002C_REG_CTRL0, 2, 2),
+	[F_FS]			= REG_FIELD(FXAS21002C_REG_CTRL0, 0, 1),
+	[F_ELE]			= REG_FIELD(FXAS21002C_REG_RT_CFG, 3, 3),
+	[F_ZTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 2, 2),
+	[F_YTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 1, 1),
+	[F_XTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 0, 0),
+	[F_EA]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 6, 6),
+	[F_ZRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 5, 5),
+	[F_ZRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 4, 4),
+	[F_YRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 3, 3),
+	[F_YRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 2, 2),
+	[F_XRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 1, 1),
+	[F_XRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 0),
+	[F_DBCNTM]		= REG_FIELD(FXAS21002C_REG_RT_THS, 7, 7),
+	[F_THS]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 6),
+	[F_RT_COUNT]		= REG_FIELD(FXAS21002C_REG_RT_COUNT, 0, 7),
+	[F_TEMP]		= REG_FIELD(FXAS21002C_REG_TEMP, 0, 7),
+	[F_RST]			= REG_FIELD(FXAS21002C_REG_CTRL1, 6, 6),
+	[F_ST]			= REG_FIELD(FXAS21002C_REG_CTRL1, 5, 5),
+	[F_DR]			= REG_FIELD(FXAS21002C_REG_CTRL1, 2, 4),
+	[F_ACTIVE]		= REG_FIELD(FXAS21002C_REG_CTRL1, 1, 1),
+	[F_READY]		= REG_FIELD(FXAS21002C_REG_CTRL1, 0, 0),
+	[F_INT_CFG_FIFO]	= REG_FIELD(FXAS21002C_REG_CTRL2, 7, 7),
+	[F_INT_EN_FIFO]		= REG_FIELD(FXAS21002C_REG_CTRL2, 6, 6),
+	[F_INT_CFG_RT]		= REG_FIELD(FXAS21002C_REG_CTRL2, 5, 5),
+	[F_INT_EN_RT]		= REG_FIELD(FXAS21002C_REG_CTRL2, 4, 4),
+	[F_INT_CFG_DRDY]	= REG_FIELD(FXAS21002C_REG_CTRL2, 3, 3),
+	[F_INT_EN_DRDY]		= REG_FIELD(FXAS21002C_REG_CTRL2, 2, 2),
+	[F_IPOL]		= REG_FIELD(FXAS21002C_REG_CTRL2, 1, 1),
+	[F_PP_OD]		= REG_FIELD(FXAS21002C_REG_CTRL2, 0, 0),
+	[F_WRAPTOONE]		= REG_FIELD(FXAS21002C_REG_CTRL3, 3, 3),
+	[F_EXTCTRLEN]		= REG_FIELD(FXAS21002C_REG_CTRL3, 2, 2),
+	[F_FS_DOUBLE]		= REG_FIELD(FXAS21002C_REG_CTRL3, 0, 0),
+};
+
 static const int fxas21002c_odr_values[] = {
 	800, 400, 200, 100, 50, 25, 12, 12
 };
-- 
2.25.1

