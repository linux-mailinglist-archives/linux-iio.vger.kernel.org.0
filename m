Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F335C342C16
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhCTLYs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCTLYd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:24:33 -0400
Received: from www381.your-server.de (www381.your-server.de [IPv6:2a01:4f8:d0a:52ac::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3951AC0613AC
        for <linux-iio@vger.kernel.org>; Sat, 20 Mar 2021 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=7DISj2JMXOTkeZNyqhwtWoeYPCY7mWqhQZeSaoXXZ10=; b=H2fkM/SP2KRGsd0Oi/mOhfHGgx
        0gsaDhA7JOiv4NzWtLE7GAJAcCcP4fZiBB+yiq4CuLx2JMbcIiaNjP+CNPwVX1DUBb/oHJn1XPSeM
        XpfIqZPkmVZHeXEEd/ClLlRJCQJtg0z3NSN4KHsOe9eer6Mkavaa2CNyxpZmCLVF+ui5U2WSmYvRc
        iCip0G6u+F58jUcZ95KkHHSmgRRbGVEEkVaBwF0sUaY+Y3KQLkMdshQSptOdxICAvJAVIJbC4BOEs
        EzG6Uh4RdWoh60YSmpypMU7T3RFNpBAz03AZwRLkxu5FxJEp0Mo4YHOINFUcXs1OWaBo4fbteEkhY
        063V/+4A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNVok-000AyM-1v; Sat, 20 Mar 2021 08:14:38 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNVoj-000Vc8-TS; Sat, 20 Mar 2021 08:14:37 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] iio: iio_enum_available_read(): Convert to sysfs_emit_at()
Date:   Sat, 20 Mar 2021 08:14:03 +0100
Message-Id: <20210320071405.9347-3-lars@metafoo.de>
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

Convert the iio_enum_available_read() function to use sysfs_emit_at()
instead of scnprintf().

The conversion is straight forward, the only difference is that
sysfs_emit_at() takes the buffers start address and an offset as parameters
and already knows about the buffer's size limit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 058874af1242..e0fdf9141e09 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -504,7 +504,7 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
 	for (i = 0; i < e->num_items; ++i) {
 		if (!e->items[i])
 			continue;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
+		len += sysfs_emit_at(buf, len, "%s ", e->items[i]);
 	}
 
 	/* replace last space with a newline */
-- 
2.20.1

