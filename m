Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BE420F87F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 17:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbgF3Phg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbgF3Phf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 11:37:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415AAC061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 08:37:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so8619885plr.4
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVwKFGY0S8EipY5rid+bUgyZglGrZuX936xxiEoiovc=;
        b=M//b7Qg6jX41hBnkRlYqVXnCs5ejZlEO+fFbwbIftMJ44NhO/qzKdk0bTyoXUSTUP+
         e5a5g4LFbXuG3pWeobJG60ElNrbKaAMHTI5JzETbjihre/MLHSNYaH/QAj0NgOjHWg0F
         Ne8NHxyAse6csf87Qb2Es0+5JgIwgT/oa4tl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVwKFGY0S8EipY5rid+bUgyZglGrZuX936xxiEoiovc=;
        b=KUWRxbGtKWae0yQ0SZG1bdOO6Z/ItXEwSUIBxhlAjE2Ds9f3C63NLC/ikqzwfoBDD1
         mo5ojeny1H//CgjF5okq0aAv0l3HGn7X+aMExh8nLNx6diUPSteQWrVsa7cyTmTNCjGl
         LUznsFjzQUSrRhTmG0JIw513FaXOBpvBIK8MLYNYsN02Km/TaSEIEcncJDezycKeK6CJ
         r2TP07th/KnpgVBSMuV59cj959tTRGMwezy0ceOxJ61ui69X89OWR8sItE8/8BYm/Nzh
         4aCVh5VK8FDQbvI206gkm2pdIeFpLcxJGr8eyc/gFWuQPTjdhYuhyDHLAn65h3fLjONs
         wP1w==
X-Gm-Message-State: AOAM5333jwbVVtdnWVwW5vQ/MKNWWuKb5N3Crw8kZiQEw56eqbuigVG2
        zO7y0zZQz2qQdXS84ka3tOsjBw==
X-Google-Smtp-Source: ABdhPJwAa9Wl753BdUmcOqQRr4Znfcx6qRXR4SMhNS5k6Qqz2NOEB6bBw9LB2GCoXDEfGgoMEpdGiQ==
X-Received: by 2002:a17:902:704a:: with SMTP id h10mr17894655plt.85.1593531454713;
        Tue, 30 Jun 2020 08:37:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id h5sm3178079pfb.120.2020.06.30.08.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 08:37:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org, enric.balletbo@collabora.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros_ec: Use default frequencies when EC returns invalid information
Date:   Tue, 30 Jun 2020 08:37:30 -0700
Message-Id: <20200630153730.3302889-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minimal and maximal frequencies supported by a sensor is queried.
On some older machines, these frequencies are not returned properly and
the EC returns 0 instead.
When returned maximal frequency is 0, ignore the information and use
default frequencies instead.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- improve visibility by using new 100 character line length limit.

 .../cros_ec_sensors/cros_ec_sensors_core.c       | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 36e3f20891f05..b30fd6b56773f 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -289,7 +289,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
 	struct cros_ec_dev *ec = sensor_hub->ec;
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
-	u32 ver_mask;
+	u32 ver_mask, temp;
 	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
 	int ret, i;
 
@@ -345,10 +345,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 						 &frequencies[2],
 						 &state->fifo_max_event_count);
 		} else {
-			frequencies[1] = state->resp->info_3.min_frequency;
-			frequencies[2] = state->resp->info_3.max_frequency;
-			state->fifo_max_event_count =
-			    state->resp->info_3.fifo_max_event_count;
+			if (state->resp->info_3.max_frequency == 0) {
+				get_default_min_max_freq(state->resp->info.type,
+							 &frequencies[1],
+							 &frequencies[2],
+							 &temp);
+			} else {
+				frequencies[1] = state->resp->info_3.min_frequency;
+				frequencies[2] = state->resp->info_3.max_frequency;
+			}
+			state->fifo_max_event_count = state->resp->info_3.fifo_max_event_count;
 		}
 		for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
 			state->frequencies[2 * i] = frequencies[i] / 1000;
-- 
2.27.0.212.ge8ba1cc988-goog

