Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2734D9CD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFTSxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 14:53:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42291 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfFTSxL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 14:53:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so2029361pgh.9
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2019 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88jbRT+Qt3zbjlF2+8qrnSqMwRS9Jqm0TzjiaMFnxcM=;
        b=Mya9sJFCPfUduJyq+/pJSSDnlhPC8HnUp1yztBsJvQJiAsytcAyUDqSjtvPKH+hkyZ
         +ktqC6gIcH5RhNGHn60c0BmZpx5Y6+ooBVILw1VSjwTEo9WQj5daxFGPLPqb9+W1GZwD
         w4GPK46Rj8o6N0Z+Xvao5V2LWsVRMRj6hIHPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88jbRT+Qt3zbjlF2+8qrnSqMwRS9Jqm0TzjiaMFnxcM=;
        b=XXh0sIEZJySjkbigqELgMWZhRoe9kvGts4J4QXIVuLukuGT4/X70DHKPvSSu+AGTxX
         d9bHTTNp7YFN3VOEePS0j+87DYIIcOtDgIo74AqSbmyECZchw4Y46DLD1qBLqk3+YKWK
         TOwYxJ06igd6lljWsL1HdKY52EDOym27vx6rVuTyGhAzLAQLfxUZElk2BHlUblWh3R9a
         bcGca4zaJ24/xBHwNhVsVhRlkWnNWMPjVPbKPpsHeu9SzL+W5YzhKgrpIWhu3nECDB6x
         Tdmo16EjqTeMoF/Da8tmChjj1iXxxqRPjrnNSJvvyD0zYFLtrHSGCZZHYtmEjH6cb0Zi
         NBKQ==
X-Gm-Message-State: APjAAAVsdnW8uqBiMbO86x0EnjZrZLO2u6ZaVUvPMZwNdvdhYMMX9Bzl
        3CYqor0C9LYWcHXp+TgAIwBGJw==
X-Google-Smtp-Source: APXvYqzqkaVtKD/uD4uTOJdpJFjxCNuAD3OHXXXwqPl+jMcdMhUb4/s/xL4Ik1ayMgSjY0Qz+kJiWA==
X-Received: by 2002:a63:7d18:: with SMTP id y24mr9281112pgc.438.1561056790309;
        Thu, 20 Jun 2019 11:53:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h1sm243508pfg.55.2019.06.20.11.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 11:53:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
Date:   Thu, 20 Jun 2019 11:52:58 -0700
Message-Id: <20190620185259.142133-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190620185259.142133-1-gwendal@chromium.org>
References: <20190620185259.142133-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To allow cros_ec iio core library to be used with legacy device, add a
vector to rotate sensor data if necessary: legacy devices are not
reporting data in HTML5/Android sensor referential.

TEST=On veyron minnie, check chrome detect tablet mode and rotate
screen in tablet mode.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
 include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..1b2e7a8242ad 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -66,8 +66,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
-	}
 
+		/* Set sign vector, only used for backward compatibility. */
+		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
@@ -254,6 +256,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
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

