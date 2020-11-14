Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC20E2B2CF9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 13:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKNMAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 07:00:43 -0500
Received: from www381.your-server.de ([78.46.137.84]:42074 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKNMAl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 07:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=URWnf3wWLbUsIpy77AQNyRRHom1BxDORUgdi/ZNWwRc=; b=BfxfmV/QinsaER40SgIVi3JT6F
        qxR26uGs65Vu3JW5hXXOA6eeyW6lU2StNnAWdBQ1WWIg9A/R8Cp2qDonOBAysiQ+Mem4mXnY9qlRC
        /2nC2ldfYOju5FHXAIgU8XdwgWW4m99ZILhegcOPffwBcn6C5uzaSW2jQR5sJFc27MOHX/MBGOW/4
        hMykBh3XX42yYQ95UPdrtt7mL0oasMLSRIMqjnQOmyCuw+d1v3w5UdXnIxz2+xOra09OclCx+zalZ
        gNkCuK8U+Hy6Lfm2Qg7RV1K38VQXWe2PKgwtYeipJTc+eNqD9HeQPuvpJkDuJYBIl0vguLu3xqCgr
        7iAWUKNA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kduEO-0004vO-1U; Sat, 14 Nov 2020 13:00:36 +0100
Received: from [62.216.202.98] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kduEN-000PSw-UH; Sat, 14 Nov 2020 13:00:35 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: core: Simplify iio_format_list()
Date:   Sat, 14 Nov 2020 13:00:00 +0100
Message-Id: <20201114120000.6533-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201114120000.6533-1-lars@metafoo.de>
References: <20201114120000.6533-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25987/Fri Nov 13 14:19:33 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

iio_format_list() has two branches in a switch statement that are almost
identical. They only differ in the stride that is used to iterate through
the item list.

Consolidate this into a common code path to simplify the code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 45 +++++++++++++--------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 3e71fcab7cbd..0a0d27a8d996 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -702,44 +702,35 @@ static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
 			       const char *prefix, const char *suffix)
 {
 	ssize_t len;
+	int stride;
 	int i;
 
-	len = scnprintf(buf, PAGE_SIZE, prefix);
-
 	switch (type) {
 	case IIO_VAL_INT:
-		for (i = 0; i < length; i++) {
-			len += __iio_format_value(buf + len, PAGE_SIZE - len,
-						  type, 1, &vals[i]);
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-			if (i < length - 1)
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						" ");
-			else
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						"%s\n", suffix);
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-		}
+		stride = 1;
 		break;
 	default:
-		for (i = 0; i < length / 2; i++) {
-			len += __iio_format_value(buf + len, PAGE_SIZE - len,
-						  type, 2, &vals[i * 2]);
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-			if (i < length / 2 - 1)
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						" ");
-			else
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						"%s\n", suffix);
+		stride = 2;
+		break;
+	}
+
+	len = scnprintf(buf, PAGE_SIZE, prefix);
+
+	for (i = 0; i <= length - stride; i += stride) {
+		if (i != 0) {
+			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
 		}
+
+		len += __iio_format_value(buf + len, PAGE_SIZE - len, type,
+					  stride, &vals[i]);
+		if (len >= PAGE_SIZE)
+			return -EFBIG;
 	}
 
+	len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n", suffix);
+
 	return len;
 }
 
-- 
2.20.1

