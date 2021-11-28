Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31DD46094F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhK1T07 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:26:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47644 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353164AbhK1TY7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:24:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1058A6110F
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9EFC004E1;
        Sun, 28 Nov 2021 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127302;
        bh=eKs601GCnrrrOTv6gZpb7W7sw/H4yxOua9Hhkku9L+E=;
        h=From:To:Cc:Subject:Date:From;
        b=YuLcmA/AnfQUfP7OH64lbE2O6ZymudbybCSL1wjsdegaTZEEB2kGNEfOshvRwyFDs
         jSjqmUTnBoZe3nkgNkryCUh6bLNaIciISCWml/J3pNDwdvmTY5PAOZmW8r0QS2jdIW
         bGDU6FaQ+fbBYqszIt/1V6xoZGB750gu7fPb9vdB05whX4e7rih9EgtBs+dZlYBCWN
         kL32EB+xbY6Xa3yAH6GMc9iBBlT9OiRQCTI8sl854v20AeAAu8DoOPY6Z+P+2AxGzo
         3tVUPbIyhvucWYdRngvZ0hb6HCOqh6gLCP1Wfst8t9ikeMxnNRpAX/dEQ2q5nb0+3L
         +ZFSp0Zjmms1A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/12] IIO: Mroe of to generic fw conversions.
Date:   Sun, 28 Nov 2021 19:26:23 +0000
Message-Id: <20211128192635.2724359-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Nothing particularly special about this series, just a few
more drifvers converted and related header and Kconfig
dependency cleanups.

For now I'm focussing mostly on standalone parts rather than
those integrated in SoCs.

Any feedback welcome.

Thanks,

Jonathan

Jonathan Cameron (12):
  iio:dac:ad5755: Switch to generic firmware properties.
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

 drivers/iio/adc/Kconfig              |  6 ++--
 drivers/iio/adc/envelope-detector.c  |  3 +-
 drivers/iio/adc/max9611.c            | 20 ++++++------
 drivers/iio/adc/mcp3911.c            |  8 +++--
 drivers/iio/adc/ti-adc12138.c        |  9 ++----
 drivers/iio/adc/ti-ads124s08.c       |  3 +-
 drivers/iio/dac/Kconfig              |  1 -
 drivers/iio/dac/ad5755.c             | 47 ++++++++++------------------
 drivers/iio/dac/ad5758.c             |  3 +-
 drivers/iio/dac/dpot-dac.c           |  2 +-
 drivers/iio/dac/lpc18xx_dac.c        |  3 +-
 drivers/iio/light/cm3605.c           |  6 ++--
 drivers/iio/potentiometer/mcp41010.c |  6 ++--
 13 files changed, 47 insertions(+), 70 deletions(-)

-- 
2.34.1

