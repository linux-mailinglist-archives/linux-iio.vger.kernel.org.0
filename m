Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA891AD18B
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 22:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgDPUyd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 16:54:33 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37049 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDPUyd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 16:54:33 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D6FAFFF804;
        Thu, 16 Apr 2020 20:54:30 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/2] iio: adc: ti-ads8344: driver improvements
Date:   Thu, 16 Apr 2020 22:54:26 +0200
Message-Id: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hello,

This series improves the ads8344 driver.

The first patch is a fix and can be backported.

The last one is improving power consumption by shutting down the ADC
while it is not used.

Changes in v2:
 - keep the SPI buffer in the driver data structure as suggested by Lars.

Alexandre Belloni (2):
  iio: adc: ti-ads8344: properly byte swap value
  iio: adc: ti-ads8344: optimize consumption

 drivers/iio/adc/ti-ads8344.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.25.2

