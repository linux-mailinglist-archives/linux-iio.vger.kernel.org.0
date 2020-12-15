Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA02DB464
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 20:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgLOTTD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 14:19:03 -0500
Received: from www381.your-server.de ([78.46.137.84]:43356 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbgLOTTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2020 14:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=xccQOSYQEyHPrPPKyeCeoL4dNFDuWyigmpZVpcXe9IY=; b=EB5Gm/bxi033T6dQIhUBmQEZkK
        vG3FsdoaGxRFxdOrMq2sfNTKzUxSvMm0eNZJjEuIVBxOcGsXyHFCoIF6Yzf8ISgl5pGDS3XS+8lva
        cgbaq0Nskwl0GCi3ga2klhiJqO4LPBvnZHBiMHDO4awxFcopDrf2WFxEMo4yvzMcPL8WGhUfge09J
        BlUiiHM1F56UhHec+M1WeZE8kiYc/9Kw3M9zlkSUJxoOfvSitXVLzf5EylFJzerRuzz2F/8peRk9h
        Thdt30TE/bwwAfMfGk16kVmgRBePQZP0ZeRGO8LOhdzPwqDYIMBvjGS0evYt/W0nWyvD0s15xYGMN
        t5TBt/ag==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kpFpq-000E1I-PR; Tue, 15 Dec 2020 20:18:10 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kpFpq-0002L1-Kz; Tue, 15 Dec 2020 20:18:10 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] iio: iio_format_value(): Use signed temporary for IIO_VAL_FRACTIONAL_LOG2
Date:   Tue, 15 Dec 2020 20:17:41 +0100
Message-Id: <20201215191743.2725-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26018/Tue Dec 15 15:37:09 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO_VAL_FRACTIONAL_LOG2 works with signed values, yet the temporary we use
is unsigned. This works at the moment because the variable is implicitly
cast to signed everywhere where it is used.

But it will certainly be cleaner to use a signed variable in the first
place.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c2e4c267c36b..d84b74cc544b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -592,7 +592,6 @@ EXPORT_SYMBOL(iio_read_mount_matrix);
 static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 				  int size, const int *vals)
 {
-	unsigned long long tmp;
 	int tmp0, tmp1;
 	s64 tmp2;
 	bool scale_db = false;
@@ -625,8 +624,8 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 		else
 			return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
-		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
+		tmp2 = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
+		tmp0 = (int)div_s64_rem(tmp2, 1000000000LL, &tmp1);
 		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_INT_MULTIPLE:
 	{
-- 
2.20.1

