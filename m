Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60893468C31
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhLERAH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40778 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbhLERAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F780B80DBD
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7F6C00446;
        Sun,  5 Dec 2021 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723396;
        bh=odAFx++bTlfInhVtS65AQV7FzjWeMF6BfNn2jjeMNj8=;
        h=From:To:Cc:Subject:Date:From;
        b=bjzSV7hD33j/a7az4MktasT2fbv6Cyu77Bx7ZNCBoLCbkNnipBIpQzhHIKhuvU+YZ
         vovsdYYWPr6sb5x3sz3jLdwTKX9+3Q1BXwijI3moktcgjwKs00NdCYTLO2CdSeh8Ox
         DmFBfOpPCLhGIEnio8BNqYG+3ls/Gpxj+Q95/37VKIhmSGcLEjQplA0QzaXNdBuw/y
         qW/kOVH5bP9BPuk3U2eaywLJa/oL1ooF/bU6weEeO++TgllD5eM4FHFfQmpvwEquCU
         8oL6k68fWTPcUc210z6dj1LxK+1A7lD7IuWKLqk2wY9uiKa5QLPuvl14nAwunIcdVh
         79BSetx7WdAMw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 00/12] IIO: More of to generic fw conversions.
Date:   Sun,  5 Dec 2021 17:01:28 +0000
Message-Id: <20211205170140.2783914-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

v3: Thanks to Andy Shevchenko for review + added tags.

patch 1: Moved the dev_fwnode() check into the ad5755_parse_fw() function
which simplifies the handling where it is calls. Also added blank line.
patch 8: Dropped the struct device pointer being passed to mcp3911_config()
as it is available as adc->spi->dev.
patch 9: drop the of_match_pttr()
patch 12: Clarify that the OF dependencies being removed in this patch
were never needed for these drivers.

v2: Drop platform data from ad5755 as suggested by Lars.
    Collect tags.

I'm being naughty because I have a busy week ahead and not sure
when I'll get back to this series.  So whilst I'd normally say leave
a series for other reviews for at least a few days here they are, one
day later :)

Nothing particularly special about this series, just a few
more drifvers converted and related header and Kconfig
dependency cleanups.

For now I'm focussing mostly on standalone parts rather than
those integrated in SoCs.

Any feedback welcome.



Jonathan Cameron (12):
  iio:dac:ad5755: Switch to generic firmware properties and drop pdata
  iio:dac:ad5758: Drop unused of specific headers.
  iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
  iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
  iio:pot:mcp41010: Switch to generic firmware properties.
  iio:light:cm3605: Switch to generic firmware properties.
  iio:adc:max9611: Switch to generic firmware properties.
  iio:adc:mcp3911: Switch to generic firmware properties.
  iio:adc:ti-adc12138: Switch to generic firmware properties and drop
    of_match_ptr
  iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
  iio:adc:ti-ads124s08: Drop dependency on OF.
  iio:adc/dac:Kconfig: Update to drop OF dependencies.

 drivers/iio/adc/Kconfig              |   6 +-
 drivers/iio/adc/envelope-detector.c  |   3 +-
 drivers/iio/adc/max9611.c            |  20 ++--
 drivers/iio/adc/mcp3911.c            |   9 +-
 drivers/iio/adc/ti-adc12138.c        |  11 +-
 drivers/iio/adc/ti-ads124s08.c       |   3 +-
 drivers/iio/dac/Kconfig              |   1 -
 drivers/iio/dac/ad5755.c             | 152 ++++++++++++++++++++-------
 drivers/iio/dac/ad5758.c             |   3 +-
 drivers/iio/dac/dpot-dac.c           |   2 +-
 drivers/iio/dac/lpc18xx_dac.c        |   3 +-
 drivers/iio/light/cm3605.c           |   6 +-
 drivers/iio/potentiometer/mcp41010.c |   6 +-
 include/linux/platform_data/ad5755.h | 102 ------------------
 14 files changed, 149 insertions(+), 178 deletions(-)
 delete mode 100644 include/linux/platform_data/ad5755.h

-- 
2.34.1

