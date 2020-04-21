Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576391B1AC8
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDUAbo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:20093 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgDUAbn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:43 -0400
IronPort-SDR: nVD3TA90F3be5FCUqcSBWEu3xgPSvq0aEGaQLxL6VJ+iWEDIoRILkLJsufAicDXM8y+QHLgKN5
 xGpOXJ6TfCxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:42 -0700
IronPort-SDR: IwmJ/v6ATFdORK3NQ+Bs2Wl+ntg8k5kXOeXmpMZFACWJ9t95s/1IHZewauu+/2bKm+GNfMoXCY
 HVPFomfUpOpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="255113840"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2020 17:31:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0B60B881; Tue, 21 Apr 2020 03:31:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v1 16/16] iio: st_sensors: Use get_unaligned_be24() and sign_extend32()
Date:   Tue, 21 Apr 2020 03:31:35 +0300
Message-Id: <20200421003135.23060-16-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use these functions instead of open-coding them.

Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 0e35ff06f9af..bfc39ef64718 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -20,11 +20,6 @@
 
 #include "st_sensors_core.h"
 
-static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
-{
-	return (s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8;
-}
-
 int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 				    u8 reg_addr, u8 mask, u8 data)
 {
@@ -545,7 +540,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	else if (byte_for_channel == 2)
 		*data = (s16)get_unaligned_le16(outdata);
 	else if (byte_for_channel == 3)
-		*data = (s32)st_sensors_get_unaligned_le24(outdata);
+		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
 
 st_sensors_free_memory:
 	kfree(outdata);
-- 
2.26.1

