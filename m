Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC9E4DF2A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2019 04:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfFUClY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 22:41:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36309 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUClY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 22:41:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so2235789plt.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2019 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4U/TalAyus3IG6ROtWHCCgNAXb2Thd+9jHRPt+bTP8=;
        b=PvugaoLWn7IhNTr4FWIGwVx9bolz1tfh8Iq0wXs6/ntsU3H9HdO8oUv78CWoy8uYf9
         FoE3mwoyTPZbdFjzziA4+OoruonJvN28eDONrWODD0kaReUslFYhE/cn9YkUKY/F53yf
         D/VMDF3Vrb9BQSqZBbR2asDMvQgQn0149VD7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4U/TalAyus3IG6ROtWHCCgNAXb2Thd+9jHRPt+bTP8=;
        b=gyMclrkF67vcTqyLfaK6m1AnfTHVSTmsTdqMBWsfzgztdYNkvheHzF+3Ur82SrySS8
         NMNC6hkh1peiyC7PPQNojNuFqwMy7r6gK934HJdGFl8urpkM13pGCq7Ihvqkg/zcvt5k
         tLPWk5tiMSnZ7AMXM7RmQaHxVIv+cQx7dfpJD6Y60RTBFsaB4K10Ozqt1OQGykrJp65a
         E23+mrLBg2ZEt71MVnkHYNeFYuTZd9RIZOUCKN+hAQEXYP4/wVfzGSaeUhljDVCB0mfh
         1HCtNhMHVnF74ObeUS7f8vU5mHIl12di1HRE7+lckhrPlyZV5zut9F4ZjaAMMVRo/LWh
         Y2vQ==
X-Gm-Message-State: APjAAAXaglSSXbgVBH3i5AZHUklSP6TWlwS0hSeS+6BAVMVIr5nnalRD
        LmnxAUp7chs71Ggr9IdKk01Qgg==
X-Google-Smtp-Source: APXvYqxFcQ6ijcUQ4cX4euJ5Fg+S9ZOgH78P8RSwFk19ub8Wc0H1oCf7GFiXMcVU8DRQUEf+mb6BPQ==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr122110918plr.198.1561084883432;
        Thu, 20 Jun 2019 19:41:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id b37sm1081572pjc.15.2019.06.20.19.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 19:41:22 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
Date:   Thu, 20 Jun 2019 19:41:05 -0700
Message-Id: <20190621024106.158589-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190621024106.158589-1-gwendal@chromium.org>
References: <20190621024106.158589-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To allow cros_ec iio core library to be used with legacy device, add a
vector to rotate sensor data if necessary: legacy devices are not
reporting data in HTML5/Android sensor referential.

On veyron minnie, check chrome detect tablet mode and rotate
screen in tablet mode.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
 include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..e8a4d78659c8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -66,6 +66,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
+
+		/* Set sign vector, only used for backward compatibility. */
+		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
 	}
 
 	return 0;
@@ -254,6 +257,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
+		*data *= st->sign[i];
 		data++;
 	}
 
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index ce16445411ac..a1c85ad4df91 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -71,6 +71,7 @@ struct cros_ec_sensors_core_state {
 	enum motionsensor_location loc;
 
 	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
+	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
 
 	u8 samples[CROS_EC_SAMPLE_SIZE];
 
-- 
2.22.0.410.gd8fdbe21b5-goog

