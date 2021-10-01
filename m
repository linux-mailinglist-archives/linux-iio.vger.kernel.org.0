Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7577041ECC1
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 14:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354206AbhJAMCN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Oct 2021 08:02:13 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:59252
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354205AbhJAMCL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Oct 2021 08:02:11 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C559440186;
        Fri,  1 Oct 2021 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633089618;
        bh=xoVeBwEbq5yYbiC4MKK88HqPxlCFGkYEHA+6yK4TZTA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=p1BeaFQ3coUHtNeEOxSWXmLfJIOD2R8e8FtDlN3E4OAKig7Wd0rxW1Mhx1drNO9dX
         w2rjQ/A32OQpuUe9lrBVfHweu7KZpUGqXto90jf0HrDEWLwK2PamMgJ1ww2eWp6Yrb
         NK7ppO1l8n73F38kpKfYvqC7rBI/eqJgZFPFax2xWI+5ExE8KBYqQPIjLjhHezD17O
         deBMeiL8VLAygvegr/ER3nWo9st/BgZfYnDEpKly73jSCo2Fp/71ZhdWDnY1pA5Wqj
         V867cDEXBTLiDirFjE4hpUN8vmOrJymx7xtcpP3xL5Ir3mNRnV2SjLao5vHv2thlVc
         J8rTqh+z6BiZg==
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: aspeed: Fix spelling mistake "battey" -> "battery"
Date:   Fri,  1 Oct 2021 13:00:18 +0100
Message-Id: <20211001120018.17570-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/aspeed_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 3e9850a43372..a957cad1bfab 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -581,7 +581,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 			}
 		} else
 			dev_warn(&pdev->dev,
-				 "Failed to enable battey-sensing mode\n");
+				 "Failed to enable battery-sensing mode\n");
 	}
 
 	ret = clk_prepare_enable(data->clk_scaler->clk);
-- 
2.32.0

