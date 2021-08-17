Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AF33EF0D0
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhHQRVr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 13:21:47 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:57576
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhHQRVr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 13:21:47 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9971F3F336;
        Tue, 17 Aug 2021 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629220872;
        bh=cnxPmKp+RyLu2md5DjVc5e+v+zyOhG6XgMhIx28x8+8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=mI1HRmsEIdO1o+FJEGWTJgzlDYOXxIgNwbxirg4xLBQEC5lb/NySOyoP/QaMg1gHN
         6+sU5JuAoFv7AzGU/sffv/y0y05EjeaDc35xz0v+Ekw2RucxNUNCcg+cXYFcQxhpwg
         DAIfb6pTTJkkcxRBx22stMj6dtWn57Feo0TtBpcdA5LvemVI99Z4ll8gRwUkY1Cp/T
         6q/ss3k7sXBHM59qBb4qmsYiFzMTS/XKRAxFt1r5++rat50pVBjMppcbMBh+Yr3OMk
         rGmtbkiJNO+4Gq52py3M7giZXPK3Upf8+n1A6qtyNyU98T2iCAHx9ldE3Nabw6ZE3+
         FwHRnun1FaylQ==
From:   Colin King <colin.king@canonical.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: Fix -EBUSY timeout error return
Date:   Tue, 17 Aug 2021 18:21:11 +0100
Message-Id: <20210817172111.495897-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when a timeout occurs in rzg2l_adc_hw_init the error -EBUSY is
assigned to ret but the error code is used as the function is hard-coded
to return 0.  The variable ret is 0 before entering the while-loop hence
the fix is just to return ret at the end of the function to return the
success 0 or -EBUSY return code.

Addresses-Coverity: ("Unused value")
Fixes: d484c21bacfa ("iio: adc: Add driver for Renesas RZ/G2L A/D converter")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/rzg2l_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 9996d5eef289..868b183e75ea 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -401,7 +401,7 @@ static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
 exit_hw_init:
 	clk_disable_unprepare(adc->pclk);
 
-	return 0;
+	return ret;
 }
 
 static void rzg2l_adc_pm_runtime_disable(void *data)
-- 
2.32.0

