Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B029FF1CB3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 18:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfKFRo4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 12:44:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35089 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfKFRo4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 12:44:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13so19476244pfq.2
        for <linux-iio@vger.kernel.org>; Wed, 06 Nov 2019 09:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2G3uw7uJxPIHkS2QHH8Sn77q+V8Mto/k8eS7WiLxSfg=;
        b=QwnQbBIl+Nnl9/Tc+WltqbhrDcXBqci5HY/046ZVLxQ5HQdQUq2RmnK++IJKSNo4H9
         TLWz5HdytY/y90fEEn0P+tb5red2LZ14O/ZXSYS8bhiHW/vtNmTXj5y29XFtrpKN9jbL
         REEuu76h2PjkoNdTCE1SCPWhee5cV8rwWJIHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2G3uw7uJxPIHkS2QHH8Sn77q+V8Mto/k8eS7WiLxSfg=;
        b=WPNrDE0v/cT2XuoB2kE0umBANAxrraDLhBWY0D/FI22gYP/0RImg6f/JcHP6yvIjz5
         ratE9uARBayXwBFM0ImumzE3a+UPa29XhjR0a3K2hGxn2Kdvz7QTkpK3QqTQnRWY7z69
         n7CH89ozDpTy/4Tl2AsVmE94xIM/pEuBVG2trFrC1saiYSBDnAamTB2fkQCLh4IIPPYO
         ZbwHyADqT16PFzLalYEfegGR//hdQkQGCN2s19jQwhhoDbVt8QMNLHDP/z6O2ndVQ2KL
         3edM5oVgpszW/2Xhhupivp3IE25u8+TZ5WbtGCSUv9BXyMHRltXLSoTpS7uyw/IuCXI/
         aYZw==
X-Gm-Message-State: APjAAAVzLdaGl76UdQA/CO2211X9GgET7Cmp/ujQkqLuRuk0vOEK/Flv
        HcdBnSM1CSJptGpQRPtaAv8vjg==
X-Google-Smtp-Source: APXvYqwKAZvugO8FwKnXawyNYcqc8GklwPTvtjDYyCWZqJspAVnkApVhQTdjHz4VqLVGwG10tt30NQ==
X-Received: by 2002:aa7:8598:: with SMTP id w24mr4931958pfn.8.1573062295783;
        Wed, 06 Nov 2019 09:44:55 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id q73sm3439598pjc.22.2019.11.06.09.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:44:55 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     fabien.lahoudere@collabora.com, enric.balletbo@collabora.com,
        jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros_ec_baro: set info_mask_shared_by_all_available field
Date:   Wed,  6 Nov 2019 09:44:49 -0800
Message-Id: <20191106174449.48725-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Field was already set for light/proximity and
accelerometer/gyroscope/magnetometer sensors.

Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose
cros_ec_sensors frequency range via iio sysfs")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/pressure/cros_ec_baro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 2354302375de..7c6430ca87b7 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -149,6 +149,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_FREQUENCY);
+	channel->info_mask_shared_by_all_available =
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.shift = 0;
-- 
2.24.0.432.g9d3f5f5b63-goog

