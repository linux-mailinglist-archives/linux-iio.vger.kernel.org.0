Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F831B00B7
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 06:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDTE0x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 00:26:53 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:55008 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDTE0w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 00:26:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 3C0642027881;
        Mon, 20 Apr 2020 12:26:50 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5nqYrW7lTQwH; Mon, 20 Apr 2020 12:26:50 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1DDD520038D0;
        Mon, 20 Apr 2020 12:26:50 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 18C2BC01F9E;
        Mon, 20 Apr 2020 12:26:50 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 13055201602; Mon, 20 Apr 2020 12:26:50 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] iio: documentation ltc2632_chip_info add num_channels
Date:   Mon, 20 Apr 2020 12:26:06 +0800
Message-Id: <20200420042612.27752-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
References: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The documentation for ltc_2632_chip_info missed the desciption for the
num_channels. This trivial patch adds it.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>

Fixes: 9f15a4a0adc9 ("iio: dac: ltc2632: add support for LTC2636 family")
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v5:
tags added

v4:
Fix commit text.
 drivers/iio/dac/ltc2632.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 7adc91056aa1..2a84ea654645 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -24,6 +24,7 @@
 /**
  * struct ltc2632_chip_info - chip specific information
  * @channels:		channel spec for the DAC
+ * @num_channels:	DAC channel count of the chip
  * @vref_mv:		internal reference voltage
  */
 struct ltc2632_chip_info {
-- 
2.20.1

