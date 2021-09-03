Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865983FFB19
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbhICHae (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 03:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347932AbhICHad (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 03:30:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB12C061760
        for <linux-iio@vger.kernel.org>; Fri,  3 Sep 2021 00:29:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bt14so10192376ejb.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLNVH8XFndwKpvPMj1mgpvvZHBUNyj5D1E9ht5yoDp4=;
        b=io0DFqQyxa4evyztTcJaGZnx5fg5ZlUTzYhTS6zCTPK4GavCEQh+Z2CuBf+d7dgZrn
         BLqzaRUgDWMuTiTIT+oljXws+f01Av0fdFw7GVonAcgLVHKsZhw/LafdHbMPAEo3lmmM
         wJYf3ALSJoWUqvyke95ycPxVTk9702nd6SN/Qmv8uurhkOG3eczMO6Ozr1qUXvPr7Znq
         1dv1vlxeeSJgxjWXPlLN9471pU5md8+vbY9hk0nWqhV4zFRsxrta345cYGM3LJvdwGW/
         xcRVN/5LPPlcTNTJogYsqQy7NNYcDkFlDJ6wAAg2LL+qmdv/un8wCFk5/sVy7gmUPzhH
         JL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLNVH8XFndwKpvPMj1mgpvvZHBUNyj5D1E9ht5yoDp4=;
        b=VU3q+MHfPK7fGOkNHT/pA4+reu0z+HXupacwxShCXuxQKiRQVoafdlMacylGVh50Wq
         6ajYdIB262qjTBqyMT2pVF16uj2QEYD2+i+sdDBRtxZtKllgmCBAsPezjJq/LbylU9p+
         eQYP3hEw5N/Ar8Z4yMk/htDtcpFIJLoL9RstrugyrOdv4q1sF1a4+uLnKe2I+yn8GW0y
         XwAJ9bDehLrmOewoAgjgl831h5o74F2M773s+wPWTJckQmbzCjIhCe7p3vtic9A5pwr6
         x+MmVSKJniI5LJX2yrn74D1m7xIiFcPQqsCpcDLtRbrTIFsQbnNyspITBvoHhViRhOW5
         gjUA==
X-Gm-Message-State: AOAM530DwTg7EfRBEWAxej9wg75ZkfByNjV/PvqTAQoosUzXG5Dp/aOO
        8kujxtg1w1kjJ53xvQlZKeZcL3WyY6FWSA==
X-Google-Smtp-Source: ABdhPJxU58geUUDCfKwGaRmVcaG5WRWgIIaUROXzfl0bXPWrS2w+cP3ixgYEgi8wJPk8YTAH7A3LqQ==
X-Received: by 2002:a17:906:660f:: with SMTP id b15mr2568809ejp.491.1630654172607;
        Fri, 03 Sep 2021 00:29:32 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id a15sm2376969edr.2.2021.09.03.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:29:32 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     jic23@kernel.org, hdegoede@redhat.com, wens@csie.org,
        andriy.shevchenko@linux.intel.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/5] iio: adc: intel_mrfld_adc: convert probe to full device-managed
Date:   Fri,  3 Sep 2021 10:29:14 +0300
Message-Id: <20210903072917.45769-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903072917.45769-1-aardelean@deviqon.com>
References: <20210903072917.45769-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The only call in the remove hook is the iio_map_array_unregister() call.
Since we have a devm_iio_map_array_register() function now, we can use that
and remove the remove hook entirely.
The IIO device was registered with the devm_iio_device_register() prior to
this change.

Also, the platform_set_drvdata() can be removed now, since it was used only
in the remove hook.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/intel_mrfld_adc.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index 75394350eb4c..616de0c3a049 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -205,8 +205,6 @@ static int mrfld_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	indio_dev->name = pdev->name;
 
 	indio_dev->channels = mrfld_adc_channels;
@@ -214,28 +212,11 @@ static int mrfld_adc_probe(struct platform_device *pdev)
 	indio_dev->info = &mrfld_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_map_array_register(indio_dev, iio_maps);
+	ret = devm_iio_map_array_register(dev, indio_dev, iio_maps);
 	if (ret)
 		return ret;
 
-	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret < 0)
-		goto err_array_unregister;
-
-	return 0;
-
-err_array_unregister:
-	iio_map_array_unregister(indio_dev);
-	return ret;
-}
-
-static int mrfld_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_map_array_unregister(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id mrfld_adc_id_table[] = {
@@ -249,7 +230,6 @@ static struct platform_driver mrfld_adc_driver = {
 		.name = "mrfld_bcove_adc",
 	},
 	.probe = mrfld_adc_probe,
-	.remove = mrfld_adc_remove,
 	.id_table = mrfld_adc_id_table,
 };
 module_platform_driver(mrfld_adc_driver);
-- 
2.31.1

