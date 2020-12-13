Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD442D8F15
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392611AbgLMRZs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389338AbgLMRZl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 12:25:41 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A74C0613D3;
        Sun, 13 Dec 2020 09:25:01 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v1so4941310pjr.2;
        Sun, 13 Dec 2020 09:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZEjkbNs5o3hl31jpkUzIeZpq5WCD8v6cbfTD/PNYOns=;
        b=Zq5WEjpUQVbnqcpI74+f0hBSwACFUWhrGc9AI/HcSJUZHJYhI9z4v9RwT3Tkdxawql
         i1a101pXrO+OKpNfz6HduRgl13FEoWrKEmyFTCyaZwe5Kjn1YtvEM7aqJZqEnHDfx+JX
         Hc72bt+4TYBo1SMbn5MTFPWsxFlYl21ZL+AuAG3OFBjXe5WdgpndsdqCxIsNaBhQ0xK/
         1OmOtZjtp3BwmSBnp12yna3vshJRlY1L9OWu7egnMCh5mh75seHMiIPcbmMmaa/5MgLw
         DcDKgDphLEsIZudlrO7Co4h4YIbQHiKDze4Y5/I0Ec2wTJgF+E5MWX/Q+HPGC+NhJbVb
         fCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZEjkbNs5o3hl31jpkUzIeZpq5WCD8v6cbfTD/PNYOns=;
        b=P4g4rB14E3OHz8VNZ0s4iyl2vK2VuH49Vp8uQCOuULtAUga/DIDvpaR0/EcpIElVMO
         OS7vyDCNSFV+l7SlOPJaIrOyKMv8gPhcXcNoJZqszoA8H1g9zkOT4hP2/uInXk30m9dV
         isBJV0pTth4xrr2o76FlUe3HnurWexcQo2lRBlqF/TsPyqBqOH2mfjPCsWVJ7llf1mfX
         CorkClkoQAVN5Tsyf66faHQXu4RjkwmZlb2ZWKfpTwAz+/airF5/UAYm0wSxrAMHakTJ
         VORnTR9X8xsms6Y0eDV6GLvOUNpSapFnIpuu2hlvQRPNqOGvYqRn6BT4XTVlCPGL9kiI
         rk9Q==
X-Gm-Message-State: AOAM533h5rG2zFfKDoE6kcSJ9KzVnZPhbHS6tFONO3L0DCZeh4jwAyaE
        pVDOt3Bh6K9F63r90NVnLUIErQuOoutnIFhE
X-Google-Smtp-Source: ABdhPJyRx+LCAnEJtYTEfWdozOdo48lOGD03/axUqIl2VVndUta2k6MBL/C2JBp4CM5V6p0RzD9m9Q==
X-Received: by 2002:a17:902:7b83:b029:db:d71b:2c4d with SMTP id w3-20020a1709027b83b02900dbd71b2c4dmr9895798pll.81.1607880300770;
        Sun, 13 Dec 2020 09:25:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4073:4d9c:e725:65e2:47cd:81e3:bc30])
        by smtp.gmail.com with ESMTPSA id y15sm15593863pju.13.2020.12.13.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 09:25:00 -0800 (PST)
From:   devajithvs <devajithvs@gmail.com>
Cc:     Devajith V S <devajithvs@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: accel: kxcjk1013: Add rudimentary regulator support
Date:   Sun, 13 Dec 2020 22:54:36 +0530
Message-Id: <20201213172437.2779-2-devajithvs@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213172437.2779-1-devajithvs@gmail.com>
References: <20201213172437.2779-1-devajithvs@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Devajith V S <devajithvs@gmail.com>

kxcjk1013 devices have VDD and VDDIO power lines. Need
to make sure the regulators are enabled before any
communication with kxcjk1013. This patch introduces
vdd/vddio regulators for kxcjk1013.

Signed-off-by: Devajith V S <devajithvs@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index e92c7e676..67d3d8270 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -133,6 +134,7 @@ enum kx_acpi_type {
 };
 
 struct kxcjk1013_data {
+	struct regulator_bulk_data regulators[2];
 	struct i2c_client *client;
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
@@ -1300,6 +1302,13 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 	return dev_name(dev);
 }
 
+static void kxcjk1013_disable_regulators(void *d)
+{
+	struct kxcjk1013_data *data = d;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
 static int kxcjk1013_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -1330,6 +1339,28 @@ static int kxcjk1013_probe(struct i2c_client *client,
 			return ret;
 	}
 
+	data->regulators[0].supply = "vdd";
+	data->regulators[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to get regulators\n");
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				    data->regulators);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev, kxcjk1013_disable_regulators, data);
+	if (ret)
+		return ret;
+
+	/*
+	 * A typical delay of 10ms is required for powering up
+	 * according to the data sheets of supported chips.
+	 */
+	msleep(20);
+
 	if (id) {
 		data->chipset = (enum kx_chipset)(id->driver_data);
 		name = id->name;
-- 
2.17.1

