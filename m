Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457DF477C4C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 20:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbhLPTQp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 14:16:45 -0500
Received: from www381.your-server.de ([78.46.137.84]:41010 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhLPTQp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 14:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=X++iCdBS50OaaRw4Xu8ZE8fyHUbGoahACDxJ47nJRZw=; b=et2w3cXnSsk1wl+LgLzm4CnREg
        AXV7nbprNO2TnxFHeSoqZf42aar9e+rvayQ0erTwSftI552K9T6o/itqcS7Ey78avyPNuM+deM4Bl
        Cunyx0/jG7wfgGTO1zhTbaseLAJ/J8gnw9xoCY+0yZsvUkZuVccxo3V4qDczFbWOtSWEtwNpH1RTt
        b5CchIddW5Z0w/hb+8fKeOKjU3y9XqvdBI+75kTgKdCGOSm62viZ5OhHBmbhANf6CGKXeAP3jeQ7C
        mxWFKnBEz+SE1hyInfqgVjZAHRUQuaiKB7XjncC8xWPATSsThUjMaqCxRMnHrDupJypMn5XrHlK9f
        JPKTphiA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000ASL-Qg; Thu, 16 Dec 2021 19:52:23 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000HSt-Gc; Thu, 16 Dec 2021 19:52:23 +0100
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
Subject: [PATCH 08/13] iio: max31856: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:12 +0100
Message-Id: <20211216185217.1054495-9-lars@metafoo.de>
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

Use sysfs_emit() to format the custom `fault_ovuv`, `fault_oc` and
`in_temp_filter_notch_center_frequency` device attributes of the max31856
driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/temperature/max31856.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 1954322e43be..54840881259a 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -320,7 +320,7 @@ static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
 
 	fault = reg_val & faultbit;
 
-	return sprintf(buf, "%d\n", fault);
+	return sysfs_emit(buf, "%d\n", fault);
 }
 
 static ssize_t show_fault_ovuv(struct device *dev,
@@ -344,7 +344,7 @@ static ssize_t show_filter(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct max31856_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
+	return sysfs_emit(buf, "%d\n", data->filter_50hz ? 50 : 60);
 }
 
 static ssize_t set_filter(struct device *dev,
-- 
2.30.2

