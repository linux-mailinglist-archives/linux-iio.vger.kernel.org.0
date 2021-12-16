Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD4477C47
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 20:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhLPTPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 14:15:43 -0500
Received: from www381.your-server.de ([78.46.137.84]:39184 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhLPTPl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 14:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=NsESHsiHZuN8vLUVrZ63+kq3wwZwkkjh1Z2xl6xc0Zo=; b=KqZX4RrTQDu7lyOPI5q7LupG/S
        LVfLG7o1FU1XKLjEzT5qwDEuIb3r5hCR3TXu3I53XOVdfUVRtOnmoHWw3SV9yhs3J+181YcnEmgPp
        X8xn7G/WHJZJIWC17QzqMpOcp2vC7JlRiKFdS87NWcwAx3b4Gt9qrubxv5+V4vVq9/CLkvdlL0k89
        tU/HCbpZG82r853b3T1lYPOJE8Ci5VsLU59Xg8qQKy8vcoKydeEYFfHEEiC8tWue3x+lE+6fF1zdq
        3UWHgameegDizoDYVtruVcAtc1QE6s8eHNYkqyERZ5/76yYbDH1eUNpv+aaOWNmONXndIcSNl65fw
        ALi0Y6aQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvuk-000B4Y-5t; Thu, 16 Dec 2021 19:55:38 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000HSt-VI; Thu, 16 Dec 2021 19:52:23 +0100
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
Subject: [PATCH 10/13] iio: max9611: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:14 +0100
Message-Id: <20211216185217.1054495-11-lars@metafoo.de>
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

Use sysfs_emit() to format the custom `in_power_shunt_resistor` and
`in_current_shunt_resistor` device attributes of the max9611 driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 01a4275e9c46..f982f00303dc 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -429,7 +429,7 @@ static ssize_t max9611_shunt_resistor_show(struct device *dev,
 	i = max9611->shunt_resistor_uohm / 1000000;
 	r = max9611->shunt_resistor_uohm % 1000000;
 
-	return sprintf(buf, "%u.%06u\n", i, r);
+	return sysfs_emit(buf, "%u.%06u\n", i, r);
 }
 
 static IIO_DEVICE_ATTR(in_power_shunt_resistor, 0444,
-- 
2.30.2

