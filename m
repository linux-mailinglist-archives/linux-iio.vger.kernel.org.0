Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775F233A6FB
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhCNQtU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhCNQtL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3C564EC8;
        Sun, 14 Mar 2021 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740551;
        bh=8JsrY2BUysqfPfQl7OW7Lhc1wiK4ZaL+AshW1qQrgEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/mpBFAkOBjAQIrKUYRHlQkMOFdFxZyQRgiGDiIN+yD9/KP93TsXqeNJn/4FSfACQ
         ETRPphokx/SPwvhb7hIaGQBZ/uWvVz0s3WPOdePhjnFFXovt3i/azo0ugYSpfTJJDo
         V71mcsQN80BKdNgDqQ4gOEpLNy8Zyspw5n9TrJqyBYomt9ORgcdqbUitiKNQwzIYgF
         MrhNZ8C1RUD2QtalXSLrJ/9CamdC1N4DoINdIVOJCWLviqC3Zhnl4WEOzkNG0s8VZT
         pItdSgPWdDFZX0tu9iAWKfoquqtKcThSbU9FmPaFSuOgOBCMMp5gbPILaNRMwGMz69
         yqk3ssUrCNFLw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/8] iio: adc: cpcap-adc: kernel-doc fix - that should be _ in structure name
Date:   Sun, 14 Mar 2021 16:46:52 +0000
Message-Id: <20210314164655.408461-6-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
References: <20210314164655.408461-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fixes a W=1 warning.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/iio/adc/cpcap-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index f19c9aa93f17..40e59f4c95bc 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -100,7 +100,7 @@ struct cpcap_adc_ato {
 };
 
 /**
- * struct cpcap-adc - cpcap adc device driver data
+ * struct cpcap_adc - cpcap adc device driver data
  * @reg: cpcap regmap
  * @dev: struct device
  * @vendor: cpcap vendor
-- 
2.30.2

