Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12901220BF
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 01:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfEQXjF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 May 2019 19:39:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37597 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfEQXjF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 May 2019 19:39:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so4407805pfi.4
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2019 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FB9+ZeIs7u0h7ohxBYUtuZDUDJZtp9kucwEKAmls48s=;
        b=LNss/SaqshaaNsFNCClCxWl2TznHGB9yXArqGD6pKCgMNGiaedx0lGdyUcKul/OcMn
         z5Q+fxQfM3OZ3btfbrfB+fClA+xxX6KXeijJcpFEZUjfQnL6GTesx9mW1lDOaxfkWSIQ
         WQOnB/CzMD611ZDSPKKWEMPwZzH8Ol2qFk1Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FB9+ZeIs7u0h7ohxBYUtuZDUDJZtp9kucwEKAmls48s=;
        b=qJVEj9pzIqBBlorH82s5ex0jPHnwTsu2vW1pgf0esu+CLQFVNFa8qE6SyVay7iEziG
         LxUYx1yYd1/3jglGzDe1h74g6EjrkwHOInCQBAHB2oU2+UPilOL5ni497VOLYJNEJRkR
         q9ksDR2VL7PyulduEMCt3gPxCqBv6AyYSvQU8k9FI/bLhYskGQWFIyNxQa22+WsKC3mT
         Qe710xeGq+RjL6JcTcuT5J9Pnmt4YXiPQy7SqXlIRjL2yfx3/CXfQsB3+C+6eS5GZREY
         bFqHo19WWSz5XvQNiiQfzS1kGwODClFgg9mlYwUMa3mxeB+tKMsO5v7GRsISdQ0/EgZ7
         l9Ug==
X-Gm-Message-State: APjAAAXNdf1H818EPlIx9FiODTXEF56+orD/yDeKrmNn/aru5CaOUrSJ
        M3SMML2JN05lMFxEZPLigrFOgA==
X-Google-Smtp-Source: APXvYqz36vT7rRSakd+rAKr68wnyAr1KKufkyiB6WmC1pIdfThuX84MlueZ+rFRhob79yUKzlj5L8w==
X-Received: by 2002:a63:78cf:: with SMTP id t198mr22782668pgc.82.1558136344159;
        Fri, 17 May 2019 16:39:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id f4sm11447716pfn.118.2019.05.17.16.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 16:39:03 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 1/2] mfd: cros_ec: Register cros_ec_lid_angle driver when presented
Date:   Fri, 17 May 2019 16:38:55 -0700
Message-Id: <20190517233856.155793-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190517233856.155793-1-gwendal@chromium.org>
References: <20190517233856.155793-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Register driver when EC indicates has precise lid angle calculation code
running.
Fix incorrect extra resource allocation in cros_ec_sensors_register().

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v7:
- Split patch in two: This is the MFD section.

 drivers/mfd/cros_ec_dev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 54a58df571b6..d992365472b8 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -297,13 +297,15 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 
 	resp = (struct ec_response_motion_sense *)msg->data;
 	sensor_num = resp->dump.sensor_count;
-	/* Allocate 1 extra sensors in FIFO are needed */
-	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
+	/*
+	 * Allocate 2 extra sensors if lid angle sensor and/or FIFO are needed.
+	 */
+	sensor_cells = kcalloc(sensor_num + 2, sizeof(struct mfd_cell),
 			       GFP_KERNEL);
 	if (sensor_cells == NULL)
 		goto error;
 
-	sensor_platforms = kcalloc(sensor_num + 1,
+	sensor_platforms = kcalloc(sensor_num,
 				   sizeof(struct cros_ec_sensor_platform),
 				   GFP_KERNEL);
 	if (sensor_platforms == NULL)
@@ -363,6 +365,11 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 		sensor_cells[id].name = "cros-ec-ring";
 		id++;
 	}
+	if (cros_ec_check_features(ec,
+				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
+		sensor_cells[id].name = "cros-ec-lid-angle";
+		id++;
+	}
 
 	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
 			      NULL, 0, NULL);
-- 
2.21.0.1020.gf2820cf01a-goog

