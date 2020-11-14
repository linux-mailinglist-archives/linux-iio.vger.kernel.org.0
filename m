Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5A2B2CFA
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 13:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKNMAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 07:00:43 -0500
Received: from www381.your-server.de ([78.46.137.84]:42070 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgKNMAl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 07:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=5kK+1783SlDWf/fkMOQxeTFxpAiDIvdglROj0vxMIkQ=; b=eJAMevnXmKuJnV+r506x6ESQJO
        Hq9oktNL6j6NHBNJZq3C1ucpRx9E53bVdTixy6TlnyCZS5Ch/qXBX/nS5/Tyvu5bfp6TQMRRedcix
        EDjJ+5DQuHA7IBwtCpEhXwTMkB4YXwynQ8862h/awnm/y5NpqpMiCJn7pN2zd2joC5Ur6VwvsAG3X
        DrCD4B4jKNpsFMRi1i+v87JsAAknwAYMIbHaooRJGt7M3qifsWqEgzpeA8e0r7vWiW0shKGrCsr8y
        Si1HXUwpAzXfLRq89DHw94EinaoLxbNmS7JqcRa2bQ3aBBzwH/nVIhKIKXPcau1TUs1EoVTmpWGog
        cWuOw6vA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kduEO-0004vN-0D; Sat, 14 Nov 2020 13:00:36 +0100
Received: from [62.216.202.98] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kduEN-000PSw-SP; Sat, 14 Nov 2020 13:00:35 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: core: Consolidate iio_format_avail_{list,range}()
Date:   Sat, 14 Nov 2020 12:59:59 +0100
Message-Id: <20201114120000.6533-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25987/Fri Nov 13 14:19:33 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_format_avail_list() and iio_format_avail_range() functions are
almost identical. The only differences are that iio_format_avail_range()
expects a fixed amount of items and adds brackets "[ ]" around the output.

Refactor them into a common helper function. This improves the
maintainability of the code as it makes it easier to modify the
implementation of these functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 57 ++++++++-------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9955672fc16a..3e71fcab7cbd 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -698,11 +698,13 @@ static ssize_t iio_read_channel_info(struct device *dev,
 	return iio_format_value(buf, ret, val_len, vals);
 }
 
-static ssize_t iio_format_avail_list(char *buf, const int *vals,
-				     int type, int length)
+static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
+			       const char *prefix, const char *suffix)
 {
+	ssize_t len;
 	int i;
-	ssize_t len = 0;
+
+	len = scnprintf(buf, PAGE_SIZE, prefix);
 
 	switch (type) {
 	case IIO_VAL_INT:
@@ -716,7 +718,7 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
 						" ");
 			else
 				len += scnprintf(buf + len, PAGE_SIZE - len,
-						"\n");
+						"%s\n", suffix);
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
 		}
@@ -732,7 +734,7 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
 						" ");
 			else
 				len += scnprintf(buf + len, PAGE_SIZE - len,
-						"\n");
+						"%s\n", suffix);
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
 		}
@@ -741,47 +743,16 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
 	return len;
 }
 
-static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
+static ssize_t iio_format_avail_list(char *buf, const int *vals,
+				     int type, int length)
 {
-	int i;
-	ssize_t len;
 
-	len = snprintf(buf, PAGE_SIZE, "[");
-	switch (type) {
-	case IIO_VAL_INT:
-		for (i = 0; i < 3; i++) {
-			len += __iio_format_value(buf + len, PAGE_SIZE - len,
-						  type, 1, &vals[i]);
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-			if (i < 2)
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						" ");
-			else
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						"]\n");
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-		}
-		break;
-	default:
-		for (i = 0; i < 3; i++) {
-			len += __iio_format_value(buf + len, PAGE_SIZE - len,
-						  type, 2, &vals[i * 2]);
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-			if (i < 2)
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						" ");
-			else
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						"]\n");
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-		}
-	}
+	return iio_format_list(buf, vals, type, length, "", "");
+}
 
-	return len;
+static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
+{
+	return iio_format_list(buf, vals, type, 3, "[", "]");
 }
 
 static ssize_t iio_read_channel_info_avail(struct device *dev,
-- 
2.20.1

