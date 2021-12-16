Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABDD477C4E
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 20:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbhLPTRB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 14:17:01 -0500
Received: from www381.your-server.de ([78.46.137.84]:41548 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhLPTRB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 14:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=zg3tGTdZa0eTLdicXi6mF8GgXF1bZQHxWij19C9BLPE=; b=Au2RVtCfOwh2qxG05Z4dN1qj7C
        WQikeeinV6eckyCCmWpb+OZI/+Oh6wmXqg0s8j1hbFXgok3EAdSvY+FEqdW0MStxl5CLlpvoVGgnj
        udLyyn90PhKwmzpwiQqhC2Z400Mnu36ENVK6pX7nr8UqVmLm83gO8SRf3ZeqvclkmbU6cHUEnEUzW
        eKk8TZ9oyNGiOKRHjtDB4N3OUzlhQ7C1lq7YcWCTT9jkZ8M+4wXcL1JBW/2e2yhNFzK9gs9j0SSQq
        rotllZATLg/KIR09+F6dgLPRU4OcgsMkpBdwE0JsoKC+dipRb2Y/peGVXbU8/ScZnpyBMnukcQMKw
        8iezThuA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrc-000ASO-2s; Thu, 16 Dec 2021 19:52:24 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000HSt-Nx; Thu, 16 Dec 2021 19:52:23 +0100
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
Subject: [PATCH 09/13] iio: max31865: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:13 +0100
Message-Id: <20211216185217.1054495-10-lars@metafoo.de>
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

Use sysfs_emit() to format the custom ``in_filter_notch_center_frequency`
and fault_ovuv` device attributes of the max31865 driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/temperature/max31865.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
index 4c8d6e6cf677..86c3f3509a26 100644
--- a/drivers/iio/temperature/max31865.c
+++ b/drivers/iio/temperature/max31865.c
@@ -208,7 +208,7 @@ static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
 
 	fault = data->buf[0] & faultbit;
 
-	return sprintf(buf, "%d\n", fault);
+	return sysfs_emit(buf, "%d\n", fault);
 }
 
 static ssize_t show_fault_ovuv(struct device *dev,
@@ -225,7 +225,7 @@ static ssize_t show_filter(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct max31865_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
+	return sysfs_emit(buf, "%d\n", data->filter_50hz ? 50 : 60);
 }
 
 static ssize_t set_filter(struct device *dev,
-- 
2.30.2

