Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850E541FEA4
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 01:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhJBX3x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Oct 2021 19:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhJBX3x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Oct 2021 19:29:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094CC061714;
        Sat,  2 Oct 2021 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Ra/JlvMS1JTAccs5WeqBxECVBNLxUjnfS6eMMFq8SR4=; b=IoeFNrRPbNrh8XclSVUdSdSOzX
        KJR0ulX65E26sPA/oghxIxvU9PNKGpal9vdRcuv9Liq+1AB1KIOalEkNZtIjdgAtqQzMlNxMaoL/h
        Q/Uu7EX7xmRMYi36woWli6gILqsvpu7i6a0GLtT57xWhXm6aXmeVggFK0dOJiWP0UZBGheY2m+LIS
        8ryWDwFL+2/ilyUP4SxO2AHKCxbDn59vrgbfK1MG7wOZI41y0pWjENsI8giY+LkQ1WNEyinfI9Xcg
        27s/UgU3gPkgRIGAbggfqDj2E5tGaocCvdu9sGmwYEWah1PQQ5zBGUK8uMs85ym/nFSSHe0ozwi2d
        FJySkGlA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWoQG-002tT3-HK; Sat, 02 Oct 2021 23:28:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: chemical: SENSEAIR_SUNRISE_CO2 depends on I2C
Date:   Sat,  2 Oct 2021 16:28:03 -0700
Message-Id: <20211002232803.5108-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix kconfig symbol dependency warning:

WARNING: unmet direct dependencies detected for REGMAP_I2C
  Depends on [n]: I2C [=n]
  Selected by [y]:
  - SENSEAIR_SUNRISE_CO2 [=y] && IIO [=y]

Fixes: c3253a3fdc77 ("iio: chemical: Add Senseair Sunrise 006-0-007 drive")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jacopo Mondi <jacopo@jmondi.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/chemical/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211001.orig/drivers/iio/chemical/Kconfig
+++ linux-next-20211001/drivers/iio/chemical/Kconfig
@@ -172,6 +172,7 @@ config SPS30_SERIAL
 
 config SENSEAIR_SUNRISE_CO2
 	tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
+	depends on I2C
 	select REGMAP_I2C
 	help
 	  Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
