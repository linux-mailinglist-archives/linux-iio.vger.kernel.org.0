Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB6AB7F8
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 14:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfIFMR3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 08:17:29 -0400
Received: from first.geanix.com ([116.203.34.67]:41602 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391967AbfIFMR3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 08:17:29 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 8784B6394D;
        Fri,  6 Sep 2019 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567772232; bh=9qjvnJPLcDOtz/6E/HMVgj8uXG95p8EWMXHKlfVKugw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MmIIDjr08bnBCZmePM8zWc5wj5mbtgHc7CGTGdBQOQCNJZANR1wCmkAk7ie/c7Q5T
         QVLW90xaCv62zZwTNv8fvW3LB+SyE/haF3MigZS6j0eO1IHdvxB7eWLyvL4mp+Ofcd
         IC7b74CRhpi6PmnwZgClj+o2emtJ7wrCPpSOqcV26EIT3ob94dsKsagwmT/cL0QgyE
         mDIBzp0VVlh1/3EqLSAe3wyzBzOVD4qwT4q8zioxMXr2v/enAhddKjWCeyFMu7x3NT
         zey1DsRrHtm9FFeoIMdt3cpFluBEfNUjuSbm53ukc/+Da0VyyOOfBELxV0mfHk235G
         ha14J3aNB2LLA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v4 6/6] iio: imu: st_lsm6dsx: prohibit the use of events and buffered reads simultaneously
Date:   Fri,  6 Sep 2019 14:17:16 +0200
Message-Id: <20190906121716.66194-6-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906121716.66194-1-sean@geanix.com>
References: <20190906121716.66194-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When events and buffered reads is enabled simultaneously, and the first
event accours the interrupt pin stays high.

This can be reverted when we find a solution to allow events and
buffered reads simultaneously.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index ef579650fd52..94e8884a1db1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -601,6 +601,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int err;
 
+	if (hw->enable_event)
+		return -EBUSY;
+
 	mutex_lock(&hw->conf_lock);
 
 	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 470821b54933..fdc44ff9601b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1277,6 +1277,9 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
+		return -EBUSY;
+
 	if (state && hw->enable_event)
 		return 0;
 
-- 
2.23.0

