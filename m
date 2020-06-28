Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307C020C809
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgF1MjU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgF1MjT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C606020738;
        Sun, 28 Jun 2020 12:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347959;
        bh=S1hmZJVxqLKT2wWmJdk3O13MSrEdDy7XW3sSEJzPfOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJVr79UvhhfZhreQOPMsB2+XmU1WRP+cHFxqQQHrjQWdEWsasEKP6YylveoKZXsS8
         GcKvuL2lIep4kzbVec05QmwJk94qtCkMqO/RXBmfowSfCbw3vKs1kVrSbJ+8drzYUL
         l7wWt0QSHnb48EM7Gd/npMw6jmSTv3eWeuv6zNn8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 14/23] iio:adc:sd_adc_modulator: Drop of_match_ptr and tweak includes
Date:   Sun, 28 Jun 2020 13:36:45 +0100
Message-Id: <20200628123654.32830-15-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Dropping of_match_ptr allows this driver to be used with ACPI.
The header includes are adjusted to include platform_device.h
and mod_devicetable.h instead of OF specific header as nothing
from that header itself is actually used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/iio/adc/sd_adc_modulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 1d6c246609c8..327cc2097f6c 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -9,7 +9,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 static const struct iio_info iio_sd_mod_iio_info;
 
@@ -54,7 +55,7 @@ MODULE_DEVICE_TABLE(of, sd_adc_of_match);
 static struct platform_driver iio_sd_mod_adc = {
 	.driver = {
 		.name = "iio_sd_adc_mod",
-		.of_match_table = of_match_ptr(sd_adc_of_match),
+		.of_match_table = sd_adc_of_match,
 	},
 	.probe = iio_sd_mod_probe,
 };
-- 
2.27.0

