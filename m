Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961E93A44D9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 17:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFKP0V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 11:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhFKP0U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4D07613DE;
        Fri, 11 Jun 2021 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425062;
        bh=X0RgP0J30vQZb6J/CFFzai416GIShJeuxefxYh44suo=;
        h=From:To:Cc:Subject:Date:From;
        b=o8391QTCfkSbvioQMm4AT3iD6exaE4z268ETeyH2stH8JLo/MrZCixAMf+q6JvkZH
         VQfw45hkSOPBv3ZSAXNXT43wiu1Kx7gFkPS1q9F2UXxBuL9KLqPBlGlnrDKJtiM/Vp
         uhaxTVnHuPd+JvzXqHkZe9FgszV2WOMzoIIwB22GfmSekVbWh4VnBDE2CcSV3VQm49
         0ZtRC43SbLd3zjqmqX0rNQ2mPRRvZNWkB1gYLQ545w0NeVafCZIS+wprpl8wZWG7CJ
         h0cszKs6o6w+ZZ4Lq8H7j1fcYJq2E7rTptEr5PnEFCxsEdiBOHbcFp6mK264u8f6ZU
         Q+HEx+p8RCVwQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/7] staging:iio: Header cleanup
Date:   Fri, 11 Jun 2021 16:26:07 +0100
Message-Id: <20210611152614.109361-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

0-day recently started giving some reports from the include-what-you-use
tool (needs LLVM builds).

I was curious so decided to give it a spin.  It produces a wealth of
information, but the suggestions require a high degree of interpretation
and some choices are down to personal taste.

This set covers resulting changes that I think make sense for remaining
IIO drivers in staging (which I just noticed are all Analog devices ones :)

Jonathan Cameron (7):
  staging:iio:adc: Cleanup includes
  staging:iio:addac:adt7316: Cleanup includes
  staging:iio:cdc:ad7746: Cleanup includes
  staging:iio:frequency: Cleanup includes
  staging:iio:impedance-analyzer: Cleanup includes
  staging:iio:meter:ade7854: Cleanup includes
  staging:iio:resolver:ad2s1210: Cleanup includes

 drivers/staging/iio/adc/ad7280a.c               | 2 ++
 drivers/staging/iio/adc/ad7816.c                | 3 +--
 drivers/staging/iio/addac/adt7316.c             | 5 -----
 drivers/staging/iio/addac/adt7316.h             | 1 +
 drivers/staging/iio/cdc/ad7746.c                | 6 +++---
 drivers/staging/iio/frequency/ad9832.c          | 3 ++-
 drivers/staging/iio/frequency/ad9834.c          | 6 ++----
 drivers/staging/iio/impedance-analyzer/ad5933.c | 5 ++++-
 drivers/staging/iio/meter/ade7854-i2c.c         | 3 ++-
 drivers/staging/iio/meter/ade7854-spi.c         | 3 ++-
 drivers/staging/iio/meter/ade7854.c             | 4 ----
 drivers/staging/iio/meter/ade7854.h             | 5 +++++
 drivers/staging/iio/resolver/ad2s1210.c         | 5 +++--
 13 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.31.1

