Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E54A7286
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiBBOCR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiBBOCQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:16 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B279C06173B
        for <linux-iio@vger.kernel.org>; Wed,  2 Feb 2022 06:02:16 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1F1B020000C;
        Wed,  2 Feb 2022 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjqrs8lgm6stkpfbGv5AvGpuKA7eWv/k0sHN3EALNhs=;
        b=lt0Tmq8knonCseR/LFSxssuqI5+crEOaoV16a0QoLeDNJ6epAEby2qxgZhjTRns0dz9KzF
        ruFMuV6VpC2sH3BY6mP7OVDB5raxEvc1iRUrCepWYEotZF30gaWHpsgNl1O4t1WfyNbu5U
        VZ3KAzbYyQgnqIcfeP1ZIF2k1EnOuiFrGIbuhy6XeDeCwkXyrHrMdDkIzwSrdtSZmgT4gt
        f0G7yysty7OjKtbQf2qt8nAOvnSpLBzrdnRxPdbuAGGpP5syo5sMUeq/w7w9jT6/C+l63D
        7z6ZYX/e6pt2wD1mKSJqcPTYDZNpztyjLQw5KNr1YG0uxpS8kMJiMnO06Lh24Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 04/12] iio: st_sensors: Drop the protection on _avail functions
Date:   Wed,  2 Feb 2022 15:02:00 +0100
Message-Id: <20220202140208.391394-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

