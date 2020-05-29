Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109D1E891B
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 22:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgE2Up5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 16:45:57 -0400
Received: from myself5.de ([5.230.26.43]:48400 "EHLO myself5.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgE2Up5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 16:45:57 -0400
X-Greylist: delayed 2346 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 16:45:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=myself5.de; s=mail;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=iZ1nU2Th/78kpVP/x2Kp7M+JS1r1Au1YceHQ2YXu6h8=;
        b=WbTVhuq2UGLuVX2ir0f8NOCO7jy7Q70dFtbWqnuCVXzBbCMT6O2EQipB4IVfsOHZKF9Olzo2hP14wq0ncQX2JF5sXYDj9JqZgptd/cHvQLYlSaNXetgFUQj/+iXribwfXW4jYR8T6MjbuQvVxnkAHQQOgshtlQrXoskaHQ4DysbNRfc4q4IwMkKZqX4Ir5VC8uorlXTn8MQId/UieA1niwVO8E48umO7RCKutOCZwThO9dEl9qWKwkBdKZvokC2zRqy3YOE/K3INV2ZbsmyUwWJbQL6xHp9sP4Awey9EobYJUdaBTaxc5U4yh3IKCNT5Z/ypGbJlw00WfqjNpXgdaw==;
Received: from hsi-kbw-085-216-061-247.hsi.kabelbw.de ([85.216.61.247] helo=M5TR.fritz.box)
        by myself5.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <me@myself5.de>)
        id 1jelGz-0003rj-FV; Fri, 29 May 2020 22:06:33 +0200
From:   Christian Oder <me@myself5.de>
Cc:     myself5@carbonrom.org, Christian Oder <me@myself5.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: mxc4005: add support for mxc6655
Date:   Fri, 29 May 2020 22:05:49 +0200
Message-Id: <20200529200550.357118-1-me@myself5.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The mxc6655 is fully working with the existing mxc4005 driver.
Add support for it.

Signed-off-by: Christian Oder <me@myself5.de>
---
 drivers/iio/accel/mxc4005.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 3d5bea651923..3b8614352cb4 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -474,12 +474,14 @@ static int mxc4005_probe(struct i2c_client *client,
 
 static const struct acpi_device_id mxc4005_acpi_match[] = {
 	{"MXC4005",	0},
+	{"MXC6655",	0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
 
 static const struct i2c_device_id mxc4005_id[] = {
 	{"mxc4005",	0},
+	{"mxc6655",	0},
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, mxc4005_id);
-- 
2.26.2

