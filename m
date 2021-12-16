Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF91477BF7
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhLPSw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 13:52:26 -0500
Received: from www381.your-server.de ([78.46.137.84]:47636 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbhLPSwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=BCf6rL7suy31qtSRmW0qJcAFOKEchD2zVJwybYzJx8A=; b=ltUcjVN689OMn6JFtiV4KH7mdE
        ZZ5Wk+U4r7JYgfdnbUuy4IefAyMB7YYesMDKhCfe/b+6uWVKV6h9ukxN3ei3vvUAFmVJzKONXPMEU
        BdXd9NRvMy33MXiIibkZuyiOwxxxZD7I+5TI7aOVU3K7x0w+UY0lwhUwWkDG2WWn8qXt+q0ODU9fB
        3mSficbg+EkoA0lD9CMxblghyi+Tt/QMczqc8nwIB6buGb0tO08FDc8H4b2f/GLS54vIprlC72vzA
        beEeCIvZmyZupSbb4CaIzz2Y8YRfwFaJ85JxspvddvW2JOae1iwVerh+f00VpJj5gs4TBBdkuAllP
        R0xJ4Rtw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000ASJ-J4; Thu, 16 Dec 2021 19:52:23 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000HSt-9B; Thu, 16 Dec 2021 19:52:23 +0100
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
Subject: [PATCH 07/13] iio: lm3533: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:11 +0100
Message-Id: <20211216185217.1054495-8-lars@metafoo.de>
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

Use sysfs_emit() to format the custom device attributes of the lm3533
driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/light/lm3533-als.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 8a621244dd01..827bc25269e9 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -417,7 +417,7 @@ static ssize_t show_thresh_either_en(struct device *dev,
 		enable = 0;
 	}
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", enable);
+	return sysfs_emit(buf, "%u\n", enable);
 }
 
 static ssize_t store_thresh_either_en(struct device *dev,
@@ -474,7 +474,7 @@ static ssize_t show_zone(struct device *dev,
 	if (ret)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", zone);
+	return sysfs_emit(buf, "%u\n", zone);
 }
 
 enum lm3533_als_attribute_type {
@@ -530,7 +530,7 @@ static ssize_t show_als_attr(struct device *dev,
 	if (ret)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t store_als_attr(struct device *dev,
-- 
2.30.2

