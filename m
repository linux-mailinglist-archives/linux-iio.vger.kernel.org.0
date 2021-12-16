Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4D477C4A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 20:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhLPTQQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 14:16:16 -0500
Received: from www381.your-server.de ([78.46.137.84]:40196 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhLPTQQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 14:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=vdl9zE0bwtgAURW1zwHQzGevj3ka6TrGrNg4I0Y0ZSM=; b=Y7cISdTn6ydeFMLa25QmPtvXsW
        W55dXN3VA5WMMyR4MXLLKuohy4CbfQjMMg8lI44omJFtEkMHA/9mhAhTo4zcw5Qw7saOES83u0601
        NCRGdVMQFFY4TiCtm6QzSW+73+Iur2OyL25liRk9U2Gs5wdR+8C/ftX+/ndBbgINkVwF4HqeITgC2
        9HBqTFWKsYFd6sqe0MnhrR2AUlneeygBi0HoGJE4q21yoBaucMtEYwPyvm00fiNKtyA5m84o93sMw
        i6Q+Rq+/OUgSZWFsBZta3kne/MoL8zoQlyZHF6lZCnronweaxlJAlcryOB+H1SUjgJjbBunWF6L8P
        BA05jqog==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvuk-000B4m-T4; Thu, 16 Dec 2021 19:55:38 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrc-000HSt-6N; Thu, 16 Dec 2021 19:52:24 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/13] iio: ms_sensors: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:15 +0100
Message-Id: <20211216185217.1054495-12-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216185217.1054495-1-lars@metafoo.de>
References: <20211216185217.1054495-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26389/Thu Dec 16 07:02:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
knows about the sysfs buffer specifics and has some built-in checks for
size and alignment.

Use sysfs_emit() to format the custom `battery_low` and `heater_enable`
device attributes of the ms_sensors driver shared code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 16ea697e945c..3eb790aec4b2 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -324,7 +324,7 @@ ssize_t ms_sensors_show_battery_low(struct ms_ht_dev *dev_data,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", (config_reg & 0x40) >> 6);
+	return sysfs_emit(buf, "%d\n", (config_reg & 0x40) >> 6);
 }
 EXPORT_SYMBOL(ms_sensors_show_battery_low);
 
@@ -351,7 +351,7 @@ ssize_t ms_sensors_show_heater(struct ms_ht_dev *dev_data,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", (config_reg & 0x4) >> 2);
+	return sysfs_emit(buf, "%d\n", (config_reg & 0x4) >> 2);
 }
 EXPORT_SYMBOL(ms_sensors_show_heater);
 
-- 
2.30.2

