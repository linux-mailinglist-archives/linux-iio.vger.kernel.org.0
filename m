Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3058F226FA6
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 22:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgGTUXA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbgGTUW4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 16:22:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47330C0619D2;
        Mon, 20 Jul 2020 13:22:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so10837845pgg.10;
        Mon, 20 Jul 2020 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+TorV6mA7rqY5GL2y/dxljOSmTJZvSpfXkQ2KHgU20=;
        b=QkKkAZeh/YLKhEcBiQ0hP9C1kiZimO2XCXZrKaFRwnG9cmuXG5afpjy1umjjc3G7sr
         bMR+JqyHma3BjXy6f7liB0y69JtB/3OfSRYqWEc450AEt8XHIgkb7oeoQdi5OeoJAJzw
         HDMWBTfpFyXgHyso9hFO2X1dsyqYGw2rM6JGoTP/JDDrfHkx8NaG9JdY6izoqN6OJQX8
         zAeCp7BvmPRv/0yQOztWmm60JPV2jgqiFN+WRVhywvNDZw+qkj+Qe18JfPbI4GR0KX8h
         KBIPu9gC/nnZjkIwO4SPJha4mcrdG+gGn/rm/L4jA3/9uuU6vl4NurT1AWU/ubmrCufY
         bcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=w+TorV6mA7rqY5GL2y/dxljOSmTJZvSpfXkQ2KHgU20=;
        b=hZsUStVVm1bg+I5bCZWwufyPUzudGGt6K+WAvPertSXfG1yZJyehetMWD2XfJmrkN7
         y8l6PSL9dSo0PHbeMzf/wcq3MZ7sf0ZabAX3MdDVqrc8b+ZBbt1+HpVO8Sn6S0GtQZTX
         skuWRjGRQqbKJLsHpZIdtCc/aIrIubQTWRayk7NPBB8yWf9Tsp7f/3CdV5i4poBkDVPa
         GKo7qd4L5V1kaAh9ovrj1LGopeLOXZPde4oSkituGtUOlSad1wnBqLPfYc3DirEs8aIA
         DLY5CiRIa91Sv57/+7jwlfLIIzMiPFlXzu2DKyf3UW9C8M0PLGORf1XaOaqnPn7cd8BP
         ktLg==
X-Gm-Message-State: AOAM530GSdbfnlpwzT7ti/ksW/hxwhIkmdVMrEWK6UqXeSyLt5OK0FWA
        WhW2mLTcZzcHbSrIcCOLS169qlmz
X-Google-Smtp-Source: ABdhPJxydgttZ8N8g+ET44350AvzkjYSZVQMiq06EJiaZfRwS+0ODGTp+WU3KLLSu6ZlrOXRKsSqqQ==
X-Received: by 2002:a63:3c2:: with SMTP id 185mr20442576pgd.46.1595276575799;
        Mon, 20 Jul 2020 13:22:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a68sm429122pje.35.2020.07.20.13.22.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 13:22:55 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 4/4] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Mon, 20 Jul 2020 13:22:43 -0700
Message-Id: <20200720202243.180230-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720202243.180230-1-linux@roeck-us.net>
References: <20200720202243.180230-1-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The EC reports a variety of error codes. Most of those, with the exception
of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
to Linux error codes to report a more meaningful error to the caller to aid
debugging.

Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

Notes:
    I would welcome feedback on the error code translations.
    Can we do better ?

    -ENOTSUPP is not a recommended error code, and checkpatch complains
    about it. It is used in existing code, so I did not change it, but it
    might be worthwhile exploring if we can find a better error code to
    report "version not supported". Possible candidates might be EPROTOTYPE,
    ENOPROTOOPT, EPROTONOSUPPORT, EPFNOSUPPORT, or EAFNOSUPPORT. I don't
    see a direct match, but NFS reports -EPROTONOSUPPORT for unsupported
    protocol versions.

 drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3e745e0fe092..10aa9e483d35 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
+static const int cros_ec_error_map[] = {
+	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
+	[EC_RES_ERROR] = -EIO,
+	[EC_RES_INVALID_PARAM] = -EINVAL,
+	[EC_RES_ACCESS_DENIED] = -EACCES,
+	[EC_RES_INVALID_RESPONSE] = -EPROTO,
+	[EC_RES_INVALID_VERSION] = -ENOTSUPP,
+	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
+	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
+	[EC_RES_UNAVAILABLE] = -ENODATA,
+	[EC_RES_TIMEOUT] = -ETIMEDOUT,
+	[EC_RES_OVERFLOW] = -EOVERFLOW,
+	[EC_RES_INVALID_HEADER] = -EBADR,
+	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
+	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
+	[EC_RES_BUS_ERROR] = -EFAULT,
+	[EC_RES_BUSY] = -EBUSY,
+	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
+	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
+	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
+	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
+};
+
 /**
  * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
  * @ec_dev: EC device.
@@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
  *
  * Return:
  * >=0 - The number of bytes transferred
- * -ENOTSUPP - Operation not supported
- * -EPROTO - Protocol error
+ * <0 - Linux error code
  */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
@@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0) {
 		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
-	} else if (msg->result == EC_RES_INVALID_VERSION) {
-		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
-			msg->result);
-		return -ENOTSUPP;
 	} else if (msg->result != EC_RES_SUCCESS) {
-		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
-		return -EPROTO;
+		if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
+			ret = cros_ec_error_map[msg->result];
+		else
+			ret = -EPROTO;
+		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n", msg->result, ret);
 	}
 
 	return ret;
-- 
2.17.1

