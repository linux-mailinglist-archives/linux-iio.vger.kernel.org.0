Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4E91211E7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLPRjC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 12:39:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:14035 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfLPRjB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 12:39:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:39:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="227187255"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Dec 2019 09:38:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 227193A0; Mon, 16 Dec 2019 19:38:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/9] iio: pressure: st_press: Mark default_press_pdata with __maybe_unused
Date:   Mon, 16 Dec 2019 19:38:50 +0200
Message-Id: <20191216173853.75797-6-andriy.shevchenko@linux.intel.com>
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

Mark default_press_pdata with __maybe_unused to calm a compiler down:

In file included from drivers/iio/pressure/st_pressure_spi.c:18:
drivers/iio/pressure/st_pressure.h:40:46: warning: ‘default_press_pdata’ defined but not used [-Wunused-const-variable=]
   40 | static const struct st_sensors_platform_data default_press_pdata = {
      |                                              ^~~~~~~~~~~~~~~~~~~
...

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/st_pressure.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index c2e47a6c3118..5c746ff6087e 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -37,7 +37,7 @@ enum st_press_type {
  * struct st_sensors_platform_data - default press platform data
  * @drdy_int_pin: default press DRDY is available on INT1 pin.
  */
-static const struct st_sensors_platform_data default_press_pdata = {
+static __maybe_unused const struct st_sensors_platform_data default_press_pdata = {
 	.drdy_int_pin = 1,
 };
 
-- 
2.24.0

