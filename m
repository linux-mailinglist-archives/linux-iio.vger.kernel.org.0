Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210AC477BF6
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhLPSw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 13:52:26 -0500
Received: from www381.your-server.de ([78.46.137.84]:47620 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhLPSwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=nJGvWbNUcwqrAcL+2UrBy97HSgqPc1NpffgPID/0Ow4=; b=jj1EjfKegetCxKd1AyWrjTO9cn
        bbIW1YZWJHmWKScx97HfvBCw3Sj+vAdJgHUWRMgmT+70/b1vyzhevGhTNgfv+i4qffwA6DUGI2YyI
        c/Ih0WZAnDiLkeFWcxmL3pY2GF99atS8dk0mW3kIPQHsf5++hpVHXoQOTISRPE60bFcq3GOjAjehW
        8jMJdqnsqpUkx3bw4I4NcBQuNZiS60Wn5Zu5YmeEH6mvNlHUcTxHOS77HbEOmXWIZ23BaAHu+L/nD
        MG51qDVt5ZrQzoWK+K2iLMcBEp5Mrr7w+/znG5GbhamK9WZj6QqO7DfVW8DzM1Ndnrs10Wc2BxwrH
        sMKARj9g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000ASC-3V; Thu, 16 Dec 2021 19:52:23 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000HSt-Py; Thu, 16 Dec 2021 19:52:22 +0100
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
Subject: [PATCH 05/13] iio: as3935: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:09 +0100
Message-Id: <20211216185217.1054495-6-lars@metafoo.de>
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

Use sysfs_emit() to format the custom `noise_level_tripped` device
attribute of the as3935 driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/proximity/as3935.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index d62766b6b39e..3eb40aa0b1e0 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -122,7 +122,7 @@ static ssize_t as3935_sensor_sensitivity_show(struct device *dev,
 		return ret;
 	val = (val & AS3935_AFE_MASK) >> 1;
 
-	return sprintf(buf, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t as3935_sensor_sensitivity_store(struct device *dev,
@@ -153,7 +153,7 @@ static ssize_t as3935_noise_level_tripped_show(struct device *dev,
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sprintf(buf, "%d\n", !time_after(jiffies, st->noise_tripped + HZ));
+	ret = sysfs_emit(buf, "%d\n", !time_after(jiffies, st->noise_tripped + HZ));
 	mutex_unlock(&st->lock);
 
 	return ret;
-- 
2.30.2

