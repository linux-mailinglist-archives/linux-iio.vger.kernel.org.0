Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF7F468D33
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbhLEUZ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbhLEUZ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:25:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57231C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 12:22:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 224FFB80EE0
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732B3C00446;
        Sun,  5 Dec 2021 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735747;
        bh=o8Fc8ml/ohNm60JeA0uRxdEFA722yidnfKiCnzbBjs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JeAk3kMzd9Uhk+M0QpWP46D7yaADsRM5m35ipxUAGpPo3TUSWJwhkBaB1XIRLn63S
         8e2oIz3afhjR5zwSZ0twOKMgVgEtZXuPWHYLo1L0OXjWz/Uk5PbGVIj9U+MCEVjAaA
         2KWJF/AtpJYOagWsO4jvTr0EFQJki8W2j9Z24oYxb8r1ZFtmFHwQs69YAvIofQkWT0
         ZCsuxgUw5kHh3W6iON8vF2V+gSQy0UnYZXDvxiTCDbABtkbIK60TjbO5OngqVvfnVY
         aGjmTLW3KZIDuVyWiMceCTjx+8/9UPXiy39XPkaproFYASfS7Cuz8pm93P9sX0yq6A
         G2kMCT4FROdvA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 09/17] staging:iio:adc:ad7280a: Trivial comment formatting cleanup
Date:   Sun,  5 Dec 2021 20:27:02 +0000
Message-Id: <20211205202710.2847005-10-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

IIO uses the
/*
 * stuff
 * more stuff
 */

multi-line style, so use that here as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58bddd07df0c..b186dda03432 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -139,9 +139,10 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
 	       ((addr & 0x10) >> 4);
 }
 
-/* During a read a valid write is mandatory.
- * So writing to the highest available address (Address 0x1F)
- * and setting the address all parts bit to 0 is recommended
+/*
+ * During a read a valid write is mandatory.
+ * So writing to the highest available address (Address 0x1F) and setting the
+ * address all parts bit to 0 is recommended.
  * So the TXVAL is AD7280A_DEVADDR_ALL + CRC
  */
 #define AD7280A_READ_TXVAL	0xF800030A
@@ -180,7 +181,7 @@ static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
 	crc = crc_tab[val >> 16 & 0xFF];
 	crc = crc_tab[crc ^ (val >> 8 & 0xFF)];
 
-	return  crc ^ (val & 0xFF);
+	return crc ^ (val & 0xFF);
 }
 
 static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
@@ -193,12 +194,12 @@ static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
 	return 0;
 }
 
-/* After initiating a conversion sequence we need to wait until the
- * conversion is done. The delay is typically in the range of 15..30 us
- * however depending an the number of devices in the daisy chain and the
- * number of averages taken, conversion delays and acquisition time options
- * it may take up to 250us, in this case we better sleep instead of busy
- * wait.
+/*
+ * After initiating a conversion sequence we need to wait until the conversion
+ * is done. The delay is typically in the range of 15..30us however depending on
+ * the number of devices in the daisy chain, the number of averages taken,
+ * conversion delays and acquisition time options it may take up to 250us, in
+ * this case we better sleep instead of busy wait.
  */
 
 static void ad7280_delay(struct ad7280_state *st)
-- 
2.34.1

