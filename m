Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEF02FF410
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 20:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbhAUTQX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 14:16:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58246 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbhAUTPm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 14:15:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10LJEXgM073446;
        Thu, 21 Jan 2021 13:14:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611256473;
        bh=c521nXnHmjfC1hi1EZOG5ZjLnL+1H9V1/vRn3/1k1u0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NlNgSnGQuBT1f3qrXkzBDyDnzGIfaHpd3IwZ3tBiNAZ9Mp6mZWU08yrDihnlOOT0J
         jZy8DuxaZRN8BSpu7XqwjdGhSgyF9VrPNAZgs/igqw59Ic80CTk2o2+ZvHJ0EtMNtS
         Vn4DOFeQnqJy7PkOpBV99j+/Tl506rHOwTMiKKfU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10LJEWNW094773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Jan 2021 13:14:33 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 Jan 2021 13:14:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 Jan 2021 13:14:32 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10LJEWtR054845;
        Thu, 21 Jan 2021 13:14:32 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] iio:adc:ti-ads124s08: Fix packet read from the ADC
Date:   Thu, 21 Jan 2021 13:14:31 -0600
Message-ID: <20210121191431.12057-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210121191431.12057-1-dmurphy@ti.com>
References: <20210121191431.12057-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the spi_transfer array in the reading of the data from the ADC.

Fixes: ("e717f8c6dfec iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/iio/adc/ti-ads124s08.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index f05d4e0e1c9d..023d81c7e8da 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -201,12 +201,10 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
 	struct spi_transfer t[] = {
 		{
 			.tx_buf = &priv->data[0],
-			.len = 4,
-			.cs_change = 1,
 		}, {
-			.tx_buf = &priv->data[1],
 			.rx_buf = &priv->data[1],
 			.len = 4,
+			.cs_change = 1,
 		},
 	};
 
-- 
2.29.2

