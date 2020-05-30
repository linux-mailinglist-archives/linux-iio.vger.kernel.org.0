Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190731E9348
	for <lists+linux-iio@lfdr.de>; Sat, 30 May 2020 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgE3TKw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 30 May 2020 15:10:52 -0400
Received: from sender4-op-o17.zoho.com ([136.143.188.17]:17719 "EHLO
        sender4-op-o17.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgE3TKv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 May 2020 15:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590865831; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=M9pWnIoUfEghEeHUR6FIZisGxebCPU60sYhrK0VuBUQQZkfmq7SOXxim9EU/2fdo4WGZ/bxeaDVGYpFAfQcevVDiY7/W9uiiDCOaZ2Y9NOjwXVFNkAK+QrYvpQRW2YTnlIS+ckqCoqVX8aTZ2I3sI4Au4A9RvwKy+1QdGd6YA7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1590865831; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=iPAIl7tCXnreZWEaDV+FpNdf6Ncz3qXnr2sQfFskJL0=; 
        b=cAGCaZWgaYmFaXNW+a8eCXq5CLf/a1OfF+OIV+UXiFOIdQde8Z1aa/cjQO3SauWh/Tg2NUIOOcYyBF8CUZnwB+cYqQnTRDNyEV8CuSOfkY2mqg5nFiyGNJ7x9EhDw5FsIKUJ7mKgxx/omsSkxGXiM0G6rM4XhSekuxucrXDBwJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-108-48-181-150.washdc.fios.verizon.net [108.48.181.150]) by mx.zohomail.com
        with SMTPS id 159086582875744.724389599249776; Sat, 30 May 2020 12:10:28 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20200530191010.4302-1-dan@dlrobertson.com>
Subject: [PATCH v2 0/1] iio: accel: bma400: add support for bma400 spi
Date:   Sat, 30 May 2020 19:10:09 +0000
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Bosch Sensortec BMA400 3-axes ultra-low power supports a 4 wire
SPI ditital interface. This patch adds support for the device when
configured for SPI instead of I2C.

Cheers,

 - Dan

Changes in v2

 - Addressed code review comments
 - Fixed bad Kconfig selects
 - Fixed comments

Dan Robertson (1):
  iio: accel: bma400: add support for bma400 spi

 drivers/iio/accel/Kconfig      |   8 ++-
 drivers/iio/accel/Makefile     |   1 +
 drivers/iio/accel/bma400_spi.c | 120 +++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/accel/bma400_spi.c


