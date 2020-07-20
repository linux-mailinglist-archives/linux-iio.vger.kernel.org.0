Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE01226FA2
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgGTUWx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbgGTUWw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 16:22:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1861C061794;
        Mon, 20 Jul 2020 13:22:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so10832618pgm.11;
        Mon, 20 Jul 2020 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QJTwvF7OVB9geqL6s9YWUDhdihHDDKb0TP4SnK0503g=;
        b=PpL6hp0Kyy5Vti3RFDIa1oZdaF+I53/ZZ9MaDLCCbdadzd1CniORHUgk/yx/tK65gS
         EkKChg1g3psz9xvjN4sDrwuNEXR5qWjA5aVRl8hiOeJWJXt897hGgyBeVXMDK2QJYoLZ
         uTiBq3UQ5g7XK7RNp6BCFID5+HE204X5VrhtNY/5SNFwebeybOrq7SBpJUsQkfeHFMQ7
         n1xAINvOgS644K43yp3Vq4HHrK8JsR+E8wSs9TV4gvAHAQg6qY/26AWoNUE7/KHHfJwA
         LmBVGFNBKLUhaddjfSP9BJhGWu/gmoWRfae7V3VHlQa7IfPKmN45DzlBHA++17XYNGI7
         l9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=QJTwvF7OVB9geqL6s9YWUDhdihHDDKb0TP4SnK0503g=;
        b=nzQZLAmhNDN61uUYG5nLT/H92lN/2MzDVJ9hlHqzIMeAxHC+4J0NjOMs1NnLweg/dz
         npruW0DIpnASC8oxuEjefh85ldqoPxCt0TX9kiwbUtsdBF5z5MEf/lt+JAGP07l19jkX
         LojIrTsu8iSnzPwKEmRH/hilR+5T9Bjj1BK8z3opU/ljBnyL9RyVa7k5sOOfSAB4oMq/
         oqXBBwOr+1h8kQq152x2mEQyJI6JsxOzK3rrYENfdivSPTTHeEpxX04pCFOgAbEda1p6
         NCEzES4B+xS8QxqHiED/VChPRzUST/3490gVEvUiOEnmMf4EZVmMgo3yrZnt76UPum9W
         ccEg==
X-Gm-Message-State: AOAM530JECLaM5vJ+Hd8/FtgMQ9u0VhoZkNu1MnH4ZbkNNv1s5G3Jjxu
        4fFLt+G25yvzmVRTmtgKMbU=
X-Google-Smtp-Source: ABdhPJwJ/gJfWCV56yGpwx0FqjO9lqx+TL2whMK/Zd7R9FKJ8oiIsg0Q0R2go1M6gCLsc94/DVjDOQ==
X-Received: by 2002:a63:e00c:: with SMTP id e12mr20034050pgh.413.1595276571505;
        Mon, 20 Jul 2020 13:22:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18sm17302459pfi.141.2020.07.20.13.22.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 13:22:51 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/4] cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
Date:   Mon, 20 Jul 2020 13:22:41 -0700
Message-Id: <20200720202243.180230-3-linux@roeck-us.net>
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

Handle this change by no longer assuming that -EPROTO is used to report
all errors returned by the EC itself. Since errors reported by the EC are
already reported in text form through sysfs attributes, extend this form
of error reporting to all errors reported by cros_ec_cmd_xfer_status().

Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/platform/chrome/cros_ec_lightbar.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index b59180bff5a3..8445cda57927 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -117,7 +117,7 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
 	param = (struct ec_params_lightbar *)msg->data;
 	param->cmd = LIGHTBAR_CMD_VERSION;
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret < 0) {
+	if (ret < 0 && ret != -EINVAL) {
 		ret = 0;
 		goto exit;
 	}
@@ -298,11 +298,9 @@ static ssize_t sequence_show(struct device *dev,
 		goto exit;
 
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret == -EPROTO) {
-		ret = scnprintf(buf, PAGE_SIZE,
-				"ERROR: EC returned %d\n", msg->result);
-		goto exit;
-	} else if (ret < 0) {
+	if (ret < 0) {
+		ret = scnprintf(buf, PAGE_SIZE, "XFER / EC ERROR %d / %d\n",
+				ret, msg->result);
 		goto exit;
 	}
 
-- 
2.17.1

