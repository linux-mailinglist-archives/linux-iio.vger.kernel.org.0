Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0D84AC214
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbiBGO46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiBGOiv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:38:51 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C09C0401C1
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:38:49 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 22974100015;
        Mon,  7 Feb 2022 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjqrs8lgm6stkpfbGv5AvGpuKA7eWv/k0sHN3EALNhs=;
        b=ciNsZnlwWLC03//wFPeoQ/WUvWoPXXIfcdNBQHopVYQSiSqupMu8BWC48v8bR9TJZyGuwU
        XiU8aGqtn44QmCNXWrdSU7avPbEJIkhtIuKCVj8s0Yxs8KEL6anLluFU6/KG/tv5GxMC4g
        Httj9zsIkZOtY4L65b4OyAvsl4nP+rXkn3DemCOwDIbGlAMIPClgxtd6pg5PqE/ONV0QGh
        vmiL3sXPPUaYyl3A0QHp/Rxn9viFuXxW2tAGDb7UaQ26Jk7ODBaKbiRIFy9m9z4IMPY4oY
        h5VTEI0C9y7L8sUS0pGB5VfIojtx0zQzjnFeaW+RDv5yDp4skBUUGoKdy3k1Ww==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v3 05/13] iio: st_sensors: Drop the protection on _avail functions
Date:   Mon,  7 Feb 2022 15:38:32 +0100
Message-Id: <20220207143840.707510-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220207143840.707510-1-miquel.raynal@bootlin.com>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The use of a lock there seems pointless. Besides preventing to read
these information from userspace while buffers are enabled (which is not
supposed to happen), it only protect read accesses over static const
values, which are never supposed to be written anyway.

Drop these lock calls.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index eb452d0c423c..6c027150a5a4 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -641,7 +641,6 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
 	for (i = 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
 		if (sdata->sensor_settings->odr.odr_avl[i].hz == 0)
 			break;
@@ -649,7 +648,6 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
 				sdata->sensor_settings->odr.odr_avl[i].hz);
 	}
-	mutex_unlock(&indio_dev->mlock);
 	buf[len - 1] = '\n';
 
 	return len;
@@ -663,7 +661,6 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
 	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
 		if (sdata->sensor_settings->fs.fs_avl[i].num == 0)
 			break;
@@ -673,7 +670,6 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ", q, r);
 	}
-	mutex_unlock(&indio_dev->mlock);
 	buf[len - 1] = '\n';
 
 	return len;
-- 
2.27.0

