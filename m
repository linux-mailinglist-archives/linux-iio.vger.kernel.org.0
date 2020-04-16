Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5771AB560
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgDPBUd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 21:20:33 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:60992 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgDPBUc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 21:20:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id DA61C200D5EC;
        Thu, 16 Apr 2020 09:20:27 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1RMYHd_SB71H; Thu, 16 Apr 2020 09:20:27 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id BF2DA200D5DE;
        Thu, 16 Apr 2020 09:20:27 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id B65C4C019EC;
        Thu, 16 Apr 2020 09:20:27 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id B10AF201602; Thu, 16 Apr 2020 09:20:27 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     chris.ruehl@gtsys.com.hk
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] iio: documentation ltc2632_chip_info add num_channels
Date:   Thu, 16 Apr 2020 09:20:09 +0800
Message-Id: <20200416012016.21422-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200416012016.21422-1-chris.ruehl@gtsys.com.hk>
References: <20200416012016.21422-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The documentation for ltc_2632_chip_info missed the desciption for the
num_channels. This trivial patch adds it.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
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

