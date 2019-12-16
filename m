Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A355D1211E4
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfLPRi7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 12:38:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:35383 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfLPRi7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 12:38:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="416515648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2019 09:38:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1346C217; Mon, 16 Dec 2019 19:38:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/9] iio: accel: st_accel: Mark default_accel_pdata with __maybe_unused
Date:   Mon, 16 Dec 2019 19:38:49 +0200
Message-Id: <20191216173853.75797-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since we put static variable to a header file it's copied to each module
that includes the header. But not all of them are actually used it.

Mark default_accel_pdata with __maybe_unused to calm a compiler down:

In file included from drivers/iio/accel/st_accel_i2c.c:19:
drivers/iio/accel/st_accel.h:67:46: warning: ‘default_accel_pdata’ defined but not used [-Wunused-const-variable=]
   67 | static const struct st_sensors_platform_data default_accel_pdata = {
      |                                              ^~~~~~~~~~~~~~~~~~~
...

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index af09943f38c9..5b13e293cade 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -64,7 +64,7 @@ enum st_accel_type {
 * struct st_sensors_platform_data - default accel platform data
 * @drdy_int_pin: default accel DRDY is available on INT1 pin.
 */
-static const struct st_sensors_platform_data default_accel_pdata = {
+static __maybe_unused const struct st_sensors_platform_data default_accel_pdata = {
 	.drdy_int_pin = 1,
 };
 
-- 
2.24.0

