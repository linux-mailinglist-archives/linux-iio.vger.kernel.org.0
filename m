Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0911225816
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGTHDp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 03:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgGTHDo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 03:03:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD34CC0619D2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:03:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so9853171pge.12
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMPFF5ZX+ECoryjfj/273iw7Fp6u0lS+4MPrerem2k0=;
        b=GOYSo6893phi2CTvlcgC6spagnXPSlROhirRCZ4Zw9TOrfHOeDKPS1/9Ha82aNG6/p
         cRToca+B833vAW9ogDpmCq+D77bmbd3E5znAJyNUeF1v+qYxZMNjQ3Gqu6iLH37jo8J+
         lSUylxEJrbWMOfSgF5hwkGN4j383kjpy3fuik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMPFF5ZX+ECoryjfj/273iw7Fp6u0lS+4MPrerem2k0=;
        b=R4IUW+aq1nw1vQPtDgIxGPNBOe7c/HpxkeQBXd/YGcQ0Nl1AfxgcNllV43tDDiuv/6
         GWmLxMvN+he6EGvKfcIuamy6yh5Ndr3e7mOqUu6NCH48EEgx5BltpuhJDl8ABHGccpVA
         VOS+IU3jbbqgoX/qrhPlrW0DkgMzBS4wVqpD7HZYNH7BqSdIM94DBxn4ZqlgMb27VYkr
         tYoVyWvgquF4k9tiEe/MbsD6PC2fvtsaP75KEGQV/mv5L3UzUpDRj/DEJMHVb1KZrPTN
         TFwAqsAlbPjQDQ3RCVtDthG8y7hX7q+hRfiD0DNb9ceFRwvJAUZTQM31UMUzqhbg6jw5
         fDGg==
X-Gm-Message-State: AOAM531GTHy7URh1UrdzUQHb5quVwPpcwTMYjEO1+tQVNvFlsCP5Ohie
        T5Moj+ib3lqOUTRrruUjcUT1RNBwolgKQQ==
X-Google-Smtp-Source: ABdhPJyKPEdY7B90kaF/AvRTjCt/oNsdUbB3rTTtOiGtRarP3DxWaBRZ7I50S/BTmkvvjsQZozt6Tw==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr18139172pgh.32.1595228624002;
        Mon, 20 Jul 2020 00:03:44 -0700 (PDT)
Received: from ubuntu.Home (anon-62-111.vpn.ipredator.se. [46.246.62.111])
        by smtp.gmail.com with ESMTPSA id gn5sm10613862pjb.23.2020.07.20.00.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:03:43 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 1/3] iio: add IIO_MOD_O2 modifier
Date:   Mon, 20 Jul 2020 00:03:28 -0700
Message-Id: <20200720070330.259954-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720070330.259954-1-matt.ranostay@konsulko.com>
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
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
index 352533342702..b25c5af148de 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -132,6 +132,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM10] = "pm10",
 	[IIO_MOD_ETHANOL] = "ethanol",
 	[IIO_MOD_H2] = "h2",
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
2.27.0

