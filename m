Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250A5411505
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbhITMzf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 08:55:35 -0400
Received: from smtp1.axis.com ([195.60.68.17]:33532 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238846AbhITMze (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Sep 2021 08:55:34 -0400
From:   Jiri Valek - 2N <valek@2n.cz>
To:     <jic23@kernel.org>
CC:     Jiri Valek - 2N <valek@2n.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: light: opt3001: Fixed timeout error when 0 lux
Date:   Mon, 20 Sep 2021 14:53:48 +0200
Message-ID: <20210920125351.6569-1-valek@2n.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail06w.axis.com (10.20.40.12) To se-mail03w.axis.com
 (10.20.40.9)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reading from sensor returned timeout error under
zero light conditions.

Signed-off-by: Jiri Valek - 2N <valek@2n.cz>
---
 drivers/iio/light/opt3001.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 52963da401a7..1880bd5bb258 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -276,6 +276,8 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 		ret = wait_event_timeout(opt->result_ready_queue,
 				opt->result_ready,
 				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
+		if (ret == 0)
+			return -ETIMEDOUT;
 	} else {
 		/* Sleep for result ready time */
 		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
@@ -312,9 +314,7 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 		/* Disallow IRQ to access the device while lock is active */
 		opt->ok_to_ignore_lock = false;
 
-	if (ret == 0)
-		return -ETIMEDOUT;
-	else if (ret < 0)
+	if (ret < 0)
 		return ret;
 
 	if (opt->use_irq) {
-- 
2.20.1

