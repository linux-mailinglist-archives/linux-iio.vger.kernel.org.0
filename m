Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1420C802
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgF1MjJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:09 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7279420885;
        Sun, 28 Jun 2020 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347949;
        bh=+8G+QHlUj4poyC0//Qc8XHw0PA41JydyQgUI33cR0hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X44Cco6crdT1NZ9SuHDVkLel0xXHzj88z97wJdUD33X4UTNqNXzfTaCZDim/tHqZy
         29HQq6dLP1QhoEArgg3n8kiavBxYF7AhJeKeHOhuhyCetfgpwGMEsKJXeFcHZTU2CJ
         mxuLtxwCjJFtVOs+3Fea1nf0zXRgF1P/lU39OCxk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 07/23] iio:adc:ltc2496: Drop of_match_ptr and use mod_devicetable.h
Date:   Sun, 28 Jun 2020 13:36:38 +0100
Message-Id: <20200628123654.32830-8-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The macro prevents use of driver with ACPI PRP0001 and
the of_match_id structure is defined in mod_devicetable.h so include
that directly rather than of.h.

Note this is mostly about removing something I don't want cut and
paste into new drivers rather than expectation that this particular
driver will be used on an ACPI platform.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/ltc2496.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index 88a30156a849..dd956a7c216e 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -14,7 +14,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 
 #include "ltc2497.h"
 
@@ -96,7 +96,7 @@ MODULE_DEVICE_TABLE(of, ltc2496_of_match);
 static struct spi_driver ltc2496_driver = {
 	.driver = {
 		.name = "ltc2496",
-		.of_match_table = of_match_ptr(ltc2496_of_match),
+		.of_match_table = ltc2496_of_match,
 	},
 	.probe = ltc2496_probe,
 	.remove = ltc2496_remove,
-- 
2.27.0

