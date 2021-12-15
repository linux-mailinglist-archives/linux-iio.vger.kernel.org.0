Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB9475B94
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbhLOPNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:48 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:60965 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbhLOPNs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:48 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B2CBD200013;
        Wed, 15 Dec 2021 15:13:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 02/10] iio: core: Enhance the kernel doc of modes and currentmodes iio_dev entries
Date:   Wed, 15 Dec 2021 16:13:36 +0100
Message-Id: <20211215151344.163036-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Let's provide more details about these two variables because their
understanding may not be straightforward for someone not used to the IIO
subsystem internal logic. The different modes will soon be also be more
documented for the same reason.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/iio/iio.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 06433c2c2968..0312da2e83f8 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -487,8 +487,14 @@ struct iio_buffer_setup_ops {
 
 /**
  * struct iio_dev - industrial I/O device
- * @modes:		[DRIVER] operating modes supported by device
- * @currentmode:	[INTERN] current operating mode
+ * @modes:		[DRIVER] list of operating modes supported by the IIO
+ *			device, this list should be initialized before
+ *			registering the IIO device and can be filed up by the
+ *			IIO core depending on the features advertised by the
+ *			driver during other steps of the registration
+ * @currentmode:	[INTERN] operating mode currently in use, may be
+ *			eventually checked by device drivers but should be
+ *			considered read-only as this is a core internal bit
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
  * @buffer:		[DRIVER] any buffer present
-- 
2.27.0

