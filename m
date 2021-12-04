Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D8468667
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355574AbhLDRLB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbhLDRLB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E385C061751
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 09:07:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D253E60ECE
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05B4C341C0;
        Sat,  4 Dec 2021 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637653;
        bh=5Pbqw/i1ihWXonAWH9uy7GYycvO7vYX2FTcxKugj9BY=;
        h=From:To:Cc:Subject:Date:From;
        b=PFc3tuxgwZS7+HPVIJOR34ZKRN72QIJKVSKQH7Xy3/xC1w21MdHM93Sts4f1x6Mu9
         Bb0fccgDf9K+ebLmmI47ZXXmLbsRGE6XiLY/Qvc1M7E8BOUMioBxKAKZYiLNGsMz9B
         HhcpRerjfO5bAnYz+EJpceWpuNkZk1PzU9PWbbi222zw0ZXV7knPM0FiFApnrAfNWm
         3oPgjPnOhJWsZCE3KNgQcL0e2wBXhiOqprTRnq+nauif0KwVHqsrHv6JtcV93VyJrP
         D1f0MAnx2e/9OXeBS5ai97Mt1PKQn+T9oMnib2ISmB66nJTvwXo3118N0xrlBd7xit
         GKGQghuRTNLLg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 00/12] IIO: More of to generic fw conversions.
Date:   Sat,  4 Dec 2021 17:12:25 +0000
Message-Id: <20211204171237.2769210-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

v2: Drop platform data from ad5755 as suggested by Lars.
    Collect tags.

Nothing particularly special about this series, just a few
more drifvers converted and related header and Kconfig
dependency cleanups.

For now I'm focussing mostly on standalone parts rather than
those integrated in SoCs.

Any feedback welcome.

Thanks,

Jonathan

Jonathan Cameron (12):
  iio:dac:ad5755: Switch to generic firmware properties and drop pdata
  iio:dac:ad5758: Drop unused of specific headers.
  iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
  iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
  iio:pot:mcp41010: Switch to generic firmware properties.
  iio:light:cm3605: Switch to generic firmware properties.
  iio:adc:max9611: Switch to generic firmware properties.
  iio:adc:mcp3911: Switch to generic firmware properties.
  iio:adc:ti-adc12138: Switch to generic firmware properties.
  iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
  iio:adc:ti-ads124s08: Drop dependency on OF.
  iio:adc/dac:Kconfig: Update to drop OF dependencies.

 drivers/iio/adc/Kconfig              |   6 +-
 drivers/iio/adc/envelope-detector.c  |   3 +-
 drivers/iio/adc/max9611.c            |  20 ++--
 drivers/iio/adc/mcp3911.c            |   8 +-
 drivers/iio/adc/ti-adc12138.c        |   9 +-
 drivers/iio/adc/ti-ads124s08.c       |   3 +-
 drivers/iio/dac/Kconfig              |   1 -
 drivers/iio/dac/ad5755.c             | 150 ++++++++++++++++++++-------
 drivers/iio/dac/ad5758.c             |   3 +-
 drivers/iio/dac/dpot-dac.c           |   2 +-
 drivers/iio/dac/lpc18xx_dac.c        |   3 +-
 drivers/iio/light/cm3605.c           |   6 +-
 drivers/iio/potentiometer/mcp41010.c |   6 +-
 include/linux/platform_data/ad5755.h | 102 ------------------
 14 files changed, 145 insertions(+), 177 deletions(-)
 delete mode 100644 include/linux/platform_data/ad5755.h

-- 
2.34.1

