Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847883FC2FB
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 08:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhHaGuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 02:50:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22712 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbhHaGuQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 02:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630392561; x=1661928561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JTAKNwf9/VDIV8aG/1dqbq8tyWYJ42As+VykpPbner0=;
  b=XyrZnjMQ+emm2GbGyOxQQjMzFz6GIDsbPqLKL1h7RbpPi1X/PbYZi+2H
   RQ+h5fSLtTX2nVYdEZo6L06J6q/gU17TwB2nhIJ6UGdsqzOkQil9CbLDX
   DwA/WDFyJLw0252sty3YNWVt3DBFDyuo4xgcw35ZDzt9sLdgl6rmI7TU/
   qaUWLsTydsFmbQpRcpq8Y+hU/TAoWwOFApsZGhDYLXaIl0gCSLsr6bOW3
   7j8ZQlOg+BrNyB8nV4seeN+2D5ocLoLnTKl3PL8uQYWy5WOOSayTcyNUd
   RO0E6S7grJctpKAKfIPfwaBijp6ufrM8Bs8jIj1Y9WZH0WUMryfIT0JQd
   Q==;
IronPort-SDR: 8JOg7j2LcHXqiYgjLCi7asyQmhpshlu1XaIHM4LcWlsS1kyO5q7PikOs3TrNKXDMaYI9lV76TT
 fIXZPkF7KIQVswCUMzOo5C2wxSa1EPDErLl14vuKjT2ZEILk4ZKY0Z6ggDIanZxhy+DnRGnCLs
 0pThhaPMq0a+TaxVshGoXiTvUnft1qeSTEFKebcH7LpK8TLURRbR5GExqB4Np2m6f1gY+I9w0B
 PGYDBDI+e7cKpy6I8Vj8rQqjHfX1ztDa5pO6BbiikpQrydQvSvzejQzanFszf7Zg643iUSC/Fx
 tFdFPErVXKk4jwCsGiQK6FT/
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="134242849"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2021 23:49:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 30 Aug 2021 23:49:20 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 30 Aug 2021 23:49:16 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: adc: at91-sama5d2_adc: fix warning for uninitialized 'val' variable
Date:   Tue, 31 Aug 2021 09:48:00 +0300
Message-ID: <20210831064800.78979-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>> drivers/iio/adc/at91-sama5d2_adc.c:722:11: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           else if (reg == st->soc_info.platform->layout->YPOSR)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/at91-sama5d2_adc.c:725:7: note: uninitialized use occurs here
           if (!val)
                ^~~
   drivers/iio/adc/at91-sama5d2_adc.c:722:7: note: remove the 'if' if its condition is always true
           else if (reg == st->soc_info.platform->layout->YPOSR)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/at91-sama5d2_adc.c:711:9: note: initialize the variable 'val' to silence this warning
           u32 val;
                  ^
                   = 0
   1 warning generated.

Fixed by initializing 'val' variable.

Fixes: 29edec2b98ff ("iio: adc: at91-sama5d2_adc: convert to platform specific data structures")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

Hi Jonathan,

If you can still rebase your testing branch, maybe you can squash this into the
original patch, no need to make a separate commit I guess.
I fixed this as soon as the report came out from the 0day robot.

Thanks !
Eugen

 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 29c7441f9f27..f8a9ad50a00b 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -846,7 +846,7 @@ static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
 
 static u16 at91_adc_touch_pos(struct at91_adc_state *st, int reg)
 {
-	u32 val;
+	u32 val = 0;
 	u32 scale, result, pos;
 
 	/*
-- 
2.25.1

