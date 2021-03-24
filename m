Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B902E3478FD
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 13:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbhCXM4b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 08:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhCXM4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 08:56:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92663C0613DE
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x21so27501646eds.4
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjfeStBI2DcHZmjQrx+N+dsAxgF1a/tnl6rrv3SVE6Q=;
        b=tekIiAZWW3kwi3DlNvLmMjX9jCWj63bcKAuPkI/Q5kJI1jxRdebmh1n9A/tlN0QDix
         AhF96gOTxQDa/INulpZewfZFCBHRT32NBq4aN7Wt9iCdCk3hqwXQu0HoXJcnqap2l8rT
         hp892/IN6CoTYtv4sXGNN0pSbemNt7+zWkpKgHHWadomhZp399P88VkrOkkjNOLK/EO1
         7/wbr3XDjeBjDtw3cLPZB8UFskNHxNGG40xlP5icGyEQXICCz1O9EsMJb3DXQOXP3TOD
         Ci3Pr1aUf75aTPI9Grsc2yKD1Y1687FHnbcYBoFJve456VIQJ2f1B4xhuPoI55jOS2ev
         k91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjfeStBI2DcHZmjQrx+N+dsAxgF1a/tnl6rrv3SVE6Q=;
        b=Hav1ElwF9dr2Ss42i1EeSf/zEiR8BVlaawno8n0XG/GU98EZ2AUmpc4Mu3JNgn084G
         pvgCouCwEFDCCtGDaXsbpg88bmmZhNkpnsrmABWA0JLH9eDUE2izpe7GOnS9id/4XJbn
         WG1DEuYJh5QUEVbl32Bd2WSTMSy0nVfAGKapsNh16jF8vbw9AbsBwh19t3TQb1ikLL+O
         Wyz6e+L57SgpI4aMHh4TE0J0XlfavRPGXhHIqhm4Ke5Fc6k8kND2QgFGOeiOUhnOkdoS
         Rmi1OIXcjAjUh3LgwJ8oglNlkRo3oDn7sfYeg+J8T1H6plCHjPfB6ATiTWTSrsvOFun8
         nbKw==
X-Gm-Message-State: AOAM532ZkOPxdPcgF9fT44KXvPkfFydyLnarzQceCIOt+5wQIhKRO2ff
        idJmczFOOYIvu3jmiBWoXof55A==
X-Google-Smtp-Source: ABdhPJyE/+A23QNDkwguoiMrfXl+jMVy6xCycwVkij0rRzaeQOah7cxBFhnpOcFlsG90OWCUZmfHRg==
X-Received: by 2002:a05:6402:2076:: with SMTP id bd22mr3260352edb.378.1616590562364;
        Wed, 24 Mar 2021 05:56:02 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:02 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 02/10] platform/x86: toshiba_acpi: use devm_add_action_or_reset() for singleton clear
Date:   Wed, 24 Mar 2021 14:55:40 +0200
Message-Id: <20210324125548.45983-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The only reason to do this is to enforce the ordering of deinitialization,
when the conversion of the device-managed functions is done.

The singleton object should be cleared right before it is free'd.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 6d298810b7bf..c5284601bc2a 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2995,9 +2995,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 		rfkill_destroy(dev->wwan_rfk);
 	}
 
-	if (toshiba_acpi)
-		toshiba_acpi = NULL;
-
 	return 0;
 }
 
@@ -3012,6 +3009,11 @@ static const char *find_hci_method(acpi_handle handle)
 	return NULL;
 }
 
+static void toshiba_acpi_singleton_clear(void *data)
+{
+	toshiba_acpi = NULL;
+}
+
 static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 {
 	struct device *parent = &acpi_dev->dev;
@@ -3035,6 +3037,13 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	dev = devm_kzalloc(parent, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(parent,
+				       toshiba_acpi_singleton_clear,
+				       NULL);
+	if (ret)
+		return ret;
+
 	dev->acpi_dev = acpi_dev;
 	dev->method_hci = hci_method;
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
-- 
2.30.2

