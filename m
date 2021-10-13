Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DAE42C3C2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhJMOpq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 10:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233744AbhJMOpq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Oct 2021 10:45:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 946D961166;
        Wed, 13 Oct 2021 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634136222;
        bh=WCBEv0rVg1t8NxfLzQI5AyH0vU8FITaub6xBor05cRM=;
        h=From:To:Cc:Subject:Date:From;
        b=TMFnOOkiDEDoma4gTjm08HzOkvkQjdUBIAMShJ4T6WPnB4vBPpb8fZQ7jIkufUZjq
         PbjPHPaSJQJkilsMcJ67ZvQwBBKg6mECMmyB8IDJw2TNHR4sTmDLIXat6Uf0y/sNaS
         cCVb8/6Njh6t6vCShpII1DkfKGiJmO+sT0r/K9Ob91z9P3UIj5MLrl0G5H9xOG78CB
         XQP4ylY36gUgm6f8OeFZ07tnzWFHdiiUoIJZ+e9uJrGvsJDc9W/Tam5QWTv3L6SoOM
         nv2uTDdc6F3c8M+T3eUdURon0C+gbgPNlTOAQboL1fLABbIIUn6xqs1c45mC01lYtr
         hJEIpDEa/PBpw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imx8qxp-adc: mark PM functions as __maybe_unused
Date:   Wed, 13 Oct 2021 16:43:26 +0200
Message-Id: <20211013144338.2261316-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_PM_SLEEP, the runtime suspend/resume functions
are unused, producing a warning:

drivers/iio/adc/imx8qxp-adc.c:433:12: error: 'imx8qxp_adc_runtime_resume' defined but not used [-Werror=unused-function]
  433 | static int imx8qxp_adc_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/adc/imx8qxp-adc.c:419:12: error: 'imx8qxp_adc_runtime_suspend' defined but not used [-Werror=unused-function]
  419 | static int imx8qxp_adc_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Mark them as __maybe_unused to shut up the compiler.

Fixes: 7bce634d02e6 ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/imx8qxp-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index 5030e0d8318d..901dd8e1b32f 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -416,7 +416,7 @@ static int imx8qxp_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx8qxp_adc_runtime_suspend(struct device *dev)
+static __maybe_unused int imx8qxp_adc_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct imx8qxp_adc *adc = iio_priv(indio_dev);
@@ -430,7 +430,7 @@ static int imx8qxp_adc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int imx8qxp_adc_runtime_resume(struct device *dev)
+static __maybe_unused int imx8qxp_adc_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct imx8qxp_adc *adc = iio_priv(indio_dev);
-- 
2.29.2

