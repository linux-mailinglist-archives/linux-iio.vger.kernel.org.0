Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1C342C18
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCTLYs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhCTLYd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:24:33 -0400
Received: from www381.your-server.de (www381.your-server.de [IPv6:2a01:4f8:d0a:52ac::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A8C0613AD
        for <linux-iio@vger.kernel.org>; Sat, 20 Mar 2021 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=mYeow4bcgCq7cGgp/4kEENozuGELxK37Bmg9oDW9jaQ=; b=YCNYE3tCwmxofK+XoHuLm1fS9t
        LCI8w6doCQC1rVeXjcKgAbN5CuFx01BSRjDpKwzSAPI/+XgArB8uAU6Ezwuf1nuQnnLOpxW03JHXt
        xc7qqhM0VCko3Nu543hQ+R9hpbHkuYvZiAMSMr83GTkdSI3v8K1WnIkoyK/wwfX0BvXWffrBOX4gm
        nV3ITp+LoYia+bIzJZje1IBwIMgqJhFWOKhujxg8uNOOxOkPK0rQkxGm+3VmN1/EFqRSAEIWwMal5
        eCHTBk4c8DKP/gWPCXfPdNB51YhbUEgDI1LbAJvss4R7ABYAHUF+UM5E+c9a50DmLgIBqkelxqvlw
        RQKEeDuQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNVok-000AyR-3m; Sat, 20 Mar 2021 08:14:38 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNVoj-000Vc8-VK; Sat, 20 Mar 2021 08:14:37 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] iio: __iio_format_value(): Convert to sysfs_emit_at()
Date:   Sat, 20 Mar 2021 08:14:04 +0100
Message-Id: <20210320071405.9347-4-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210320071405.9347-1-lars@metafoo.de>
References: <20210320071405.9347-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26114/Sat Mar 20 04:43:32 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
knows about the sysfs buffer specifics and has some built-in sanity checks.

Convert __iio_format_value() and related functions to use this new
interface.

This conversion involves changing the signature of __iio_format_value() so
that it similar to sysfs_emit_at() and takes the buffers start address and
an offset where to write within the buffer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e0fdf9141e09..d92c58a94fe4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -623,7 +623,7 @@ int iio_read_mount_matrix(struct device *dev, const char *propname,
 }
 EXPORT_SYMBOL(iio_read_mount_matrix);
 
-static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
+static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 				  int size, const int *vals)
 {
 	int tmp0, tmp1;
@@ -632,52 +632,53 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 
 	switch (type) {
 	case IIO_VAL_INT:
-		return scnprintf(buf, len, "%d", vals[0]);
+		return sysfs_emit_at(buf, offset, "%d", vals[0]);
 	case IIO_VAL_INT_PLUS_MICRO_DB:
 		scale_db = true;
 		fallthrough;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (vals[1] < 0)
-			return scnprintf(buf, len, "-%d.%06u%s", abs(vals[0]),
-					-vals[1], scale_db ? " dB" : "");
+			return sysfs_emit_at(buf, offset, "-%d.%06u%s",
+					     abs(vals[0]), -vals[1],
+					     scale_db ? " dB" : "");
 		else
-			return scnprintf(buf, len, "%d.%06u%s", vals[0], vals[1],
-					scale_db ? " dB" : "");
+			return sysfs_emit_at(buf, offset, "%d.%06u%s", vals[0],
+					     vals[1], scale_db ? " dB" : "");
 	case IIO_VAL_INT_PLUS_NANO:
 		if (vals[1] < 0)
-			return scnprintf(buf, len, "-%d.%09u", abs(vals[0]),
-					-vals[1]);
+			return sysfs_emit_at(buf, offset, "-%d.%09u",
+					     abs(vals[0]), -vals[1]);
 		else
-			return scnprintf(buf, len, "%d.%09u", vals[0], vals[1]);
+			return sysfs_emit_at(buf, offset, "%d.%09u", vals[0],
+					     vals[1]);
 	case IIO_VAL_FRACTIONAL:
 		tmp2 = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp1 = vals[1];
 		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
 		if ((tmp2 < 0) && (tmp0 == 0))
-			return snprintf(buf, len, "-0.%09u", abs(tmp1));
+			return sysfs_emit_at(buf, offset, "-0.%09u", abs(tmp1));
 		else
-			return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+			return sysfs_emit_at(buf, offset, "%d.%09u", tmp0,
+					     abs(tmp1));
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp2 = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp0 = (int)div_s64_rem(tmp2, 1000000000LL, &tmp1);
 		if (tmp0 == 0 && tmp2 < 0)
-			return snprintf(buf, len, "-0.%09u", abs(tmp1));
+			return sysfs_emit_at(buf, offset, "-0.%09u", abs(tmp1));
 		else
-			return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+			return sysfs_emit_at(buf, offset, "%d.%09u", tmp0,
+					     abs(tmp1));
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
 		int l = 0;
 
-		for (i = 0; i < size; ++i) {
-			l += scnprintf(&buf[l], len - l, "%d ", vals[i]);
-			if (l >= len)
-				break;
-		}
+		for (i = 0; i < size; ++i)
+			l += sysfs_emit_at(buf, offset + l, "%d ", vals[i]);
 		return l;
 	}
 	case IIO_VAL_CHAR:
-		return scnprintf(buf, len, "%c", (char)vals[0]);
+		return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
 	default:
 		return 0;
 	}
@@ -701,11 +702,11 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 {
 	ssize_t len;
 
-	len = __iio_format_value(buf, PAGE_SIZE, type, size, vals);
+	len = __iio_format_value(buf, 0, type, size, vals);
 	if (len >= PAGE_SIZE - 1)
 		return -EFBIG;
 
-	return len + sprintf(buf + len, "\n");
+	return len + sysfs_emit_at(buf, len, "\n");
 }
 EXPORT_SYMBOL_GPL(iio_format_value);
 
@@ -763,22 +764,21 @@ static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
 		break;
 	}
 
-	len = scnprintf(buf, PAGE_SIZE, prefix);
+	len = sysfs_emit(buf, prefix);
 
 	for (i = 0; i <= length - stride; i += stride) {
 		if (i != 0) {
-			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
+			len += sysfs_emit_at(buf, len, " ");
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
 		}
 
-		len += __iio_format_value(buf + len, PAGE_SIZE - len, type,
-					  stride, &vals[i]);
+		len += __iio_format_value(buf, len, type, stride, &vals[i]);
 		if (len >= PAGE_SIZE)
 			return -EFBIG;
 	}
 
-	len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n", suffix);
+	len += sysfs_emit_at(buf, len, "%s\n", suffix);
 
 	return len;
 }
-- 
2.20.1

