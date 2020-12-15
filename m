Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4A2DB465
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 20:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgLOTTG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 14:19:06 -0500
Received: from www381.your-server.de ([78.46.137.84]:43388 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbgLOTTD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2020 14:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=sjY3ds+hi1cThHpkzshSqwhoo//I6mAJFhLBgpt5N94=; b=Pz1iLiJSdiNUkdneWoyCVxSASh
        egPTynjFXbJxmTa2GpVN9fWluzGz03k95DA9m4KoSrWLe2zsCIMLFrFvtYtnbRQjh7I4d9jEvMtvv
        AWvoGURA6BquxPuHwNkiEQvtp80uA1RbUvOFC2w8agMzfi9+tRZSHJDJd9SaEGUyvLImryX3aXaSl
        yux6AAEkkecZ6NpG+0jaF8i72tWQMODfpuwKONs4FMHsvRoIOh6CVfngKIpm2T1E7+Hm6XhTygtGC
        o7yF59N0ZoYS0nor2EYxC7hSTs3XRzaTXVkkAykmhRKUkr5fRqDwPPsA6jPZJS5gmpKat6dkC9q81
        GTf7oqhQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kpFps-000E1l-Ke; Tue, 15 Dec 2020 20:18:12 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kpFps-0002L1-H4; Tue, 15 Dec 2020 20:18:12 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio: iio_format_value(): Fix IIO_VAL_FRACTIONAL_LOG2 values between -1.0 and 0.0
Date:   Tue, 15 Dec 2020 20:17:42 +0100
Message-Id: <20201215191743.2725-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215191743.2725-1-lars@metafoo.de>
References: <20201215191743.2725-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26018/Tue Dec 15 15:37:09 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When formatting a value using IIO_VAL_FRACTIONAL_LOG2 and the values is
between -1 and 0 the sign is omitted.

We need the same trick as for IIO_VAL_FRACTIONAL to make sure this gets
formatted correctly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Found while writing a unit test for this.

Considering nobody complained we probably do not have an driver that will
run into this issue at the moment. So this doesn't need to got to stable.
---
 drivers/iio/industrialio-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d84b74cc544b..4b30c042e5f6 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -626,7 +626,10 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp2 = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp0 = (int)div_s64_rem(tmp2, 1000000000LL, &tmp1);
-		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		if (tmp0 == 0 && tmp2 < 0)
+			return snprintf(buf, len, "-0.%09u", abs(tmp1));
+		else
+			return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
-- 
2.20.1

