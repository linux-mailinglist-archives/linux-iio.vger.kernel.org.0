Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD51447D59
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 11:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhKHKPC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 05:15:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237761AbhKHKPA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:00 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5951B1EC04EE;
        Mon,  8 Nov 2021 11:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5VjFGofRpfW/M3GJSnJSs8mCf9EpIZn8Ox7wnRL5gBs=;
        b=FdHeGQk9yAoS+fFUllEcBXQ5Tz4h9+saH7MAvBFyDjO0UA+pxqVSKyWKIVxOyu9TQpl9S8
        sQxKQ3ngxNIcRHJeFuxeUn0G+qI0O1Ko4KIF63vG4XPeHkTQ0ZdAYFFlEbLxxkD5M3Q370
        ETTEpRFK8AgwwDA2xUjxOSBbgWxC83g=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH v0 09/42] iio: proximity: cros_ec: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:24 +0100
Message-Id: <20211108101157.15189-10-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/proximity/cros_ec_mkbp_proximity.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index 8213b0081713..e9536de8dd8a 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -234,7 +234,8 @@ static int cros_ec_mkbp_proximity_probe(struct platform_device *pdev)
 		return ret;
 
 	data->notifier.notifier_call = cros_ec_mkbp_proximity_notify;
-	blocking_notifier_chain_register(&ec->event_notifier, &data->notifier);
+	if (blocking_notifier_chain_register(&ec->event_notifier, &data->notifier))
+		pr_warn("cros-ec proximity notifier already registered\n");
 
 	return 0;
 }
-- 
2.29.2

