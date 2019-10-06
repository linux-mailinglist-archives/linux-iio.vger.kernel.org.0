Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3546ACD21D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfJFNWr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:47 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B9920684;
        Sun,  6 Oct 2019 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368167;
        bh=ToihDePn9t+T//wYe2kgzJ0PK3Wvt/BsjHbN9WgnTVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nk5QbgL6lri1jbeFq6AmI6u2vePq+ZiIjy/XfKqe/H34CrFN1Q7moFQNxlcA4mYHH
         28fcYoqDrD9isioYYSopLZpykLYj6kOhWLPCQrKDegO1q3dIp7+/IT+RGajaJldYSq
         4LTVygZcVLxuyQGjPa5XiGG6QTguMoE2fFLthtOo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 11/13] iio: imu: st_lsm6dsx: add missing kernel documenation
Date:   Sun,  6 Oct 2019 15:22:05 +0200
Message-Id: <08d98185ff40de1b2183446d6da61fffcafb9b7f.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing kernel doc for st_lsm6dsx_hw data structure

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5692ea695f04..40532f99ba4b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -345,6 +345,9 @@ struct st_lsm6dsx_sensor {
  * @ts_sip: Total number of timestamp samples in a given pattern.
  * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
  * @buff: Device read buffer.
+ * @irq_routing: pointer to interrupt routing configuration.
+ * @event_threshold: wakeup event threshold.
+ * @enable_event: enabled event bitmask.
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
  */
-- 
2.21.0

