Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF018F306
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgCWKle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 06:41:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:23726 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgCWKld (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 06:41:33 -0400
IronPort-SDR: GgHL6ke/LQtjlccRSU7EFqJlfpAad7PXNbz6jEdFmkhiCowmG1Xg8T/2bp7hcMm2xDmAbAPJOw
 m7SDDoKLS26A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 03:41:33 -0700
IronPort-SDR: TtEnGwH/UA3Vf7/4HlJEFRubyr+LqCSrAKoPTLJGaJazfpU1P2p7MPlw+vJktAYqbNqrGI8X39
 xXSuNTREwfzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="246156415"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2020 03:41:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C3FF453; Mon, 23 Mar 2020 12:41:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/5] iio: pressure: bmp280: Join string literals back
Date:   Mon, 23 Mar 2020 12:41:29 +0200
Message-Id: <20200323104129.60466-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
References: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For easy grepping on debug purposes join string literals back in
the messages.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no change
 drivers/iio/pressure/bmp280-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 958d432d9c8f..a33048390118 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -943,8 +943,7 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
 	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
 	if (irq_trig != IRQF_TRIGGER_RISING) {
-		dev_err(dev, "non-rising trigger given for EOC interrupt, "
-			"trying to enforce it\n");
+		dev_err(dev, "non-rising trigger given for EOC interrupt, trying to enforce it\n");
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
 
-- 
2.25.1

