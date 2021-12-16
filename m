Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13487477BF5
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhLPSwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 13:52:25 -0500
Received: from www381.your-server.de ([78.46.137.84]:47624 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbhLPSwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=4kuUEpQU78qLO/yQEkNwNzCVPsFNFf8sfMxWcmFuQjQ=; b=YQc9Xgc5V2Lgzp7upm2tKDC29x
        FlUx93KB62UBcHeOdmNJ6j1bSQ6dNYrQC1u431LluJAh7H1kHxjX1beCi533K56wz2MkIeyhJEqd4
        Ljnvrx21wc5631RRPK8lmmtJHvPEFtCd47fzSMACFOklN26XTUOhtU4mve92o8CAe3qwerJV+Kd6P
        qXHOIuFQuJuhduGtrBrxtLFdRXYiNMPEFo09Oz55BWHd7G7x6+umsJJjXwfNzmcyLpdqk2M8J4fM8
        vy9vDYU+AJfhsM7w4a/uq+zrKxgXIdeK74mFdVicA8dRJRTz3D2YMCoaZhOtJCR0+jW4eU2g8NejF
        N/xjq+/w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000AS4-Lp; Thu, 16 Dec 2021 19:52:22 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000HSt-BE; Thu, 16 Dec 2021 19:52:22 +0100
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
Subject: [PATCH 03/13] iio: ad7192: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:07 +0100
Message-Id: <20211216185217.1054495-4-lars@metafoo.de>
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

Use sysfs_emit() to format the custom `ac_excication` and `bridge_swtich`
attributes of the ad7192 driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7192.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index cc990205f306..47d3f56edcbc 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -433,7 +433,7 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
+	return sysfs_emit(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
 }
 
 static ssize_t ad7192_show_bridge_switch(struct device *dev,
@@ -443,7 +443,7 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
+	return sysfs_emit(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
 }
 
 static ssize_t ad7192_set(struct device *dev,
-- 
2.30.2

