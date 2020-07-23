Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309D922A8FE
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 08:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGWG3u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 02:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWG3u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 02:29:50 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A520C0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 23:29:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so420703edv.13
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 23:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDs0zCZM+B5tbC0Z03ibEwdhGnrGYty6w4AaVIm8tns=;
        b=DfXWRTBjFVpC0EJpXnnSNKHvRNdwks2jt3ae2IPedNYS4KeI4LkIVZKG0DXxJDKrkz
         ss3lbwi2xaW5dGT4dWy7gQXUPuScnqzPLFaqGyWWnfaI9sVd2sgwn9znuH49bk2EKeLx
         wOpdwDFtN3L6LxyNsiq7n2PKLQO0DYmaHBj4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDs0zCZM+B5tbC0Z03ibEwdhGnrGYty6w4AaVIm8tns=;
        b=Kh7UwQQzOu4X8lcVGQlOQXjXd/9KGQxsY2WKleSbQm9eiNesg4tEVEI4PQ80GhOXSn
         CYGvgCHI2LODcKPJc/8RSADGlOtwRnjN4CNPF6+Rys7/CHGm8sjvAwyFdlHGnd5syMKz
         9wwPdHDD2ZHwP+B5jLZrYSrhktccuAkcAH/8gUQg4SUYGDqJgpvUs2R6h0rQRngCXKYQ
         gCg2VR3TltcL/lr4FYXUPVdtYQwaPb3x0/sw9hyn4JdQr76QcI2b/LeUCJdgWh+d3YgJ
         gvCwXcGwokkPMlP5AjRwDQi86udnWQqL8Rdf42G6IqcnxNPcBhGkMeC9PRLhe1r4jV9o
         X9nw==
X-Gm-Message-State: AOAM533ZMHJUB/iyMEykqHq2ukeELhTPrENPXm4eUW5mlAkDFu3NZz6+
        CkpGZToiEF/YnqbnBNb0KPubfA==
X-Google-Smtp-Source: ABdhPJwELjZRU2v4tb9WoPzVIe8WABwKKQauXcDkWJFjUks5T+Zt0dHKDOU3mZvx0jBiciE6YWa7+Q==
X-Received: by 2002:a05:6402:b6c:: with SMTP id cb12mr2841791edb.116.1595485788898;
        Wed, 22 Jul 2020 23:29:48 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id bq8sm1358866ejb.103.2020.07.22.23.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 23:29:48 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 1/2] iio: add IIO_MOD_O2 modifier
Date:   Thu, 23 Jul 2020 09:29:43 +0300
Message-Id: <20200723062944.11438-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200723062944.11438-1-matt.ranostay@konsulko.com>
References: <20200723062944.11438-1-matt.ranostay@konsulko.com>
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
index 5c62bfb0f3f5..405181fde40a 100644
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
index 606d5e61c575..59003dc44e60 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -133,6 +133,7 @@ static const char * const iio_modifier_names[] = {
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
2.20.1

