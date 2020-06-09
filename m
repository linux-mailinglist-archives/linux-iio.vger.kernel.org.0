Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6C1F4746
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jun 2020 21:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFITl4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jun 2020 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389381AbgFITlo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jun 2020 15:41:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1BC05BD1E
        for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2020 12:41:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o6so10763032pgh.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2020 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IE8CNMcewVtSsQj1yITcU7rdFKTtb3zAy4M9NZpbSE=;
        b=FQ3YMpSsYuscNY4nPozg9IBTdd3wuk4ZbxdemKrbXRfy1b661Vn9PCh98SeWVhb5nl
         NNmGd7mYf0ointwOg71+f+LdlbzPnYorVxbv2qhpFPZLGmBGnDji8kinvACeVWafPM6z
         dsCNGY+6Ky3IT/pjSFWV0TR2qpIOqCPS8k7fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IE8CNMcewVtSsQj1yITcU7rdFKTtb3zAy4M9NZpbSE=;
        b=bk+S5aIWUeKOOrSPhTThEdWApTJJ2BzynsoXwwluZg4afgjIqlySkbWQ6Hu7NvS6GS
         Lrr3v3+va4EDV9L09guuYM3hbi3DILEPj6d/1kOuOfWunT5NC+fz0B6upn4Es+C1n/e+
         6/SgwPcSg689CDeZba6x1ud0L1wwatNbQV4nXCcIJkXiV8laBMcwZVJ48W0879hyQzNJ
         mGU/Oi4lLxU3IXUXcSgY4Eo/SSYpMjbIX4EPhxhZu5tmeQsUwCPZBv1XtChzsAKHRX3Q
         lVqG8z81OGPyfwVL/jYciVqGo9+2TVq6iC+1Vibbix27Zjjr/yoe7r8Dq+8IAjH6FYBD
         YmDw==
X-Gm-Message-State: AOAM531cxGKQn2hwLhXyz8bSQAtQ/L7NLFwX02XYpR6GbptxBcFRwd4C
        LK8zl6KHg7i5AtO8ll4aj5olAw==
X-Google-Smtp-Source: ABdhPJyp8IR9XUq/fzGvU6NwbCOue/TbsqeAOl7EOzzvAx/ioafvvepXC3g0wMgroNVWeRoU+PyUMA==
X-Received: by 2002:a63:545a:: with SMTP id e26mr25192493pgm.4.1591731700894;
        Tue, 09 Jun 2020 12:41:40 -0700 (PDT)
Received: from ubuntu.Home (anon-42-81.vpn.ipredator.se. [46.246.42.81])
        by smtp.gmail.com with ESMTPSA id z85sm10563627pfc.66.2020.06.09.12.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:41:40 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 1/3] iio: add IIO_MOD_O2 modifier
Date:   Tue,  9 Jun 2020 12:41:15 -0700
Message-Id: <20200609194117.5837-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609194117.5837-1-matt.ranostay@konsulko.com>
References: <20200609194117.5837-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add modifier IIO_MOD_O2 for O2 concentration reporting

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d3e53a6d8331..5166d905a830 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1564,6 +1564,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ethanol_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_h2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_h2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_o2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_o2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
 KernelVersion:	4.3
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1527f01a44f1..983dba7725a4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -130,6 +130,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM2P5] = "pm2p5",
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
+	[IIO_MOD_O2] = "o2",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index fdd81affca4b..48c13147c0a8 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -94,6 +94,7 @@ enum iio_modifier {
 	IIO_MOD_PM10,
 	IIO_MOD_ETHANOL,
 	IIO_MOD_H2,
+	IIO_MOD_O2,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index f115d166c985..bb03859db89d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -119,6 +119,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM2P5] = "pm2p5",
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
+	[IIO_MOD_O2] = "o2",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -211,6 +212,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_PM2P5:
 	case IIO_MOD_PM4:
 	case IIO_MOD_PM10:
+	case IIO_MOD_O2:
 		break;
 	default:
 		return false;
-- 
2.25.1

