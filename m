Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6AC477C49
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 20:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhLPTPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 14:15:52 -0500
Received: from www381.your-server.de ([78.46.137.84]:39588 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240854AbhLPTPw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 14:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=CDPvn8b31egAz1HKjY5jFWPvVQkT7kY/I/1pE5AWPbw=; b=CgDfkpvYA/7vMKh7ezOfBsbDgO
        11WAcKI6/vijaXY3k2zMZaS51GxqA8Hx38iewaaRIXUu5ECsmjHvNygHVZht3M89Etu5I9P/WrOvc
        HxK0Dm0UCuB8C2bEWXbd7YjZJOcEDXo1z5luQnokme3SziJbXfHx3YKy9byxC+gWFf7S9Jgbwag4m
        mnCmxp1Z259zeX65udaCJmaNBnVM6JssI9CoeVeZ6LpbsOIwcMhrU05RDx/RGmXIts12mcHEu615R
        p6v1EDiwAHOtwm4xQmtt+pN4JXQolUb2u83FQ7SBWjyjmEezt7fMI1sHima6tcGFjQYoS93F+9oXL
        gANwfjYA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvuk-000B4d-GL; Thu, 16 Dec 2021 19:55:38 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrc-000HSt-Lc; Thu, 16 Dec 2021 19:52:24 +0100
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
Subject: [PATCH 13/13] iio: sps30: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:17 +0100
Message-Id: <20211216185217.1054495-14-lars@metafoo.de>
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

Use sysfs_emit() to format the custom `cleaning_period` device attribute of
the sps30 driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/chemical/sps30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index d51314505115..abd67559e451 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -221,7 +221,7 @@ static ssize_t cleaning_period_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", be32_to_cpu(val));
+	return sysfs_emit(buf, "%d\n", be32_to_cpu(val));
 }
 
 static ssize_t cleaning_period_store(struct device *dev, struct device_attribute *attr,
-- 
2.30.2

