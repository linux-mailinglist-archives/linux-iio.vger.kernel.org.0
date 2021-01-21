Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BA52FEF2E
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 16:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbhAUPlf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbhAUPkn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 10:40:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9CC0613D6
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 07:40:01 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l2c3r-0002eX-4q; Thu, 21 Jan 2021 16:39:51 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l2c3q-0003nw-7j; Thu, 21 Jan 2021 16:39:50 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: st_sensors: fix typo in comment
Date:   Thu, 21 Jan 2021 16:39:44 +0100
Message-Id: <20210121153945.5499-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

s/timetamping/timestamping/

Cc: trivial@kernel.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index eee30130ae23..802f9ae04cf4 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -57,7 +57,7 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	s64 timestamp;
 
 	/*
-	 * If we do timetamping here, do it before reading the values, because
+	 * If we do timestamping here, do it before reading the values, because
 	 * once we've read the values, new interrupts can occur (when using
 	 * the hardware trigger) and the hw_timestamp may get updated.
 	 * By storing it in a local variable first, we are safe.
-- 
2.30.0

