Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41808226FA4
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 22:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgGTUW5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbgGTUWy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 16:22:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF6C061794;
        Mon, 20 Jul 2020 13:22:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so10832669pgm.11;
        Mon, 20 Jul 2020 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vb/s6eaRVOOXS2bQDo6HvuZPYU7xzzm5Qvi0rhYOi/A=;
        b=gOztGMeWodtIMuhefmbncov8BWaUFxhuOUu7ct4pkkZvSUgOk86YslH2wWoh5boGqe
         s91zbVBgl4K0h2fTdeb4Vn5mYPB9f1PxT7re09ZsAzFv1OPhyLmvp1T+AQaHlsNsPv76
         C5U4I8RUxXRjcskoQw9sOGJKZsPZtD4remMJ2DnRPBufe6txu/PHKHGIrrkklWcpfkD0
         a0fMFt5MMbYpcg57yAD6kr9iAktN+9fj+S3tDTtPzl22/qKNzAQNNK2PtEv/jpSbvx5G
         Mkc4XE2RyiWaFYQqheko5pJZL6wQtF8bM00HJxxZKcxswuPhKOP059rBnNYPoy1tNqma
         Lexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Vb/s6eaRVOOXS2bQDo6HvuZPYU7xzzm5Qvi0rhYOi/A=;
        b=ElPhaYhKwNGpOv2EaGhzzzAR7+CkOPiAvEJgQiLB22+12H05tQHpL9JzsoeNrMHe2X
         ft0Iq5+tngNgw1BIS+HEECKnESqB2q8frE0gkeWq8sqbxNq0z+fCSEZakTuNgiqYxuUB
         cH/kMtpqZxnPzfikl3azgl9uB++udB1M2dPjC6TuDqP1ukTcqgry/ooCOkHAnziQjFKE
         6BBq77TcNId+0LeykVWFPZ9vDgzE9MAg/FyCoE6LuA/HezHFcbjmTSwYbVLWk2/YBuQx
         OG3SrtKSOYo15D5D76PgAGD6NkFj7rjwJnGW6npEubPO9JxK4d1gPmO1DVBZbsLPC43d
         wjpQ==
X-Gm-Message-State: AOAM533HscMnNTlVAehccCrjXNINa+78Zpp3CLiLKEQyUG924O36swnK
        iuL5xw70ErqQmWbnETLSha0=
X-Google-Smtp-Source: ABdhPJzbGnL6J+t8kzDZtYPnexg7+vQHnuw9hhvFAa96MmipGdPcB6fbjyeV88GHNEhP2zP6VAmbbg==
X-Received: by 2002:a63:1c23:: with SMTP id c35mr19358566pgc.91.1595276573598;
        Mon, 20 Jul 2020 13:22:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j5sm17353700pfa.5.2020.07.20.13.22.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 13:22:53 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/4] platform/chrome: cros_ec_sysfs: Report range of error codes from EC
Date:   Mon, 20 Jul 2020 13:22:42 -0700
Message-Id: <20200720202243.180230-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720202243.180230-1-linux@roeck-us.net>
References: <20200720202243.180230-1-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since commit c5cd2b47b203 ("platform/chrome: cros_ec_proto: Report command
not supported") we can no longer assume that cros_ec_cmd_xfer_status()
reports -EPROTO for all errors returned by the EC itself. A follow-up
patch will change cros_ec_cmd_xfer_status() to report additional errors
reported by the EC as distinguished Linux error codes.

Prepare for this change by always reporting both the Linux error code
and the EC error code in sysfs attributes.

Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/platform/chrome/cros_ec_sysfs.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index d45ea5d5bfa4..9c1e0998a721 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -150,12 +150,10 @@ static ssize_t version_show(struct device *dev,
 	msg->command = EC_CMD_GET_BUILD_INFO + ec->cmd_offset;
 	msg->insize = EC_HOST_PARAM_SIZE;
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret == -EPROTO) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Build info:    EC error %d\n", msg->result);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Build info:    XFER ERROR %d\n", ret);
+				   "Build info:    XFER / EC ERROR %d / %d\n",
+				   ret, msg->result);
 	} else {
 		msg->data[EC_HOST_PARAM_SIZE - 1] = '\0';
 		count += scnprintf(buf + count, PAGE_SIZE - count,
@@ -166,12 +164,10 @@ static ssize_t version_show(struct device *dev,
 	msg->command = EC_CMD_GET_CHIP_INFO + ec->cmd_offset;
 	msg->insize = sizeof(*r_chip);
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret == -EPROTO) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Chip info:     EC error %d\n", msg->result);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Chip info:     XFER ERROR %d\n", ret);
+				   "Chip info:     XFER / EC ERROR %d / %d\n",
+				   ret, msg->result);
 	} else {
 		r_chip = (struct ec_response_get_chip_info *)msg->data;
 
@@ -190,12 +186,10 @@ static ssize_t version_show(struct device *dev,
 	msg->command = EC_CMD_GET_BOARD_VERSION + ec->cmd_offset;
 	msg->insize = sizeof(*r_board);
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret == -EPROTO) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Board version: EC error %d\n", msg->result);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Board version: XFER ERROR %d\n", ret);
+				   "Board version: XFER / EC ERROR %d / %d\n",
+				   ret, msg->result);
 	} else {
 		r_board = (struct ec_response_board_version *)msg->data;
 
-- 
2.17.1

