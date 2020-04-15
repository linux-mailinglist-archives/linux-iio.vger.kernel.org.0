Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB1C1AB353
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442377AbgDOVXS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 17:23:18 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36311 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438888AbgDOVXL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 17:23:11 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B9A22240003;
        Wed, 15 Apr 2020 21:23:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/3] iio: adc: ti-ads8344: improve the driver
Date:   Wed, 15 Apr 2020 23:22:54 +0200
Message-Id: <20200415212257.161238-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

This series improves the ads8344 driver.

The first patch is fix and can be backported.

The second patch removes the dubious ____cacheline_aligned

The last one is improving power consumption by shutting down the ADC
while it is not used.

Alexandre Belloni (3):
  iio: adc: ti-ads8344: properly byte swap value
  iio: adc: ti-ads8344: remove tx_buf from driver data
  iio: adc: ti-ads8344: optimize consumption

 drivers/iio/adc/ti-ads8344.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

-- 
2.25.2

