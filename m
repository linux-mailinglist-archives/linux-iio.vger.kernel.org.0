Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383BC19ED3F
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgDESFf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 14:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgDESFf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 14:05:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD0020678;
        Sun,  5 Apr 2020 18:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586109934;
        bh=QEwyKlToMH4yv+2edMTRN/gsQEgB3W8Ut+Jfr5ccoiA=;
        h=From:To:Cc:Subject:Date:From;
        b=dNQkbM4tn2s6nyvtzFlNRKsfnk9hkoAk3aE1pvZwY7UUvFKn4bb/tFsB7JC2sbUs6
         mzre01WgqgV3cMkkUiYCxpNcQXK1enQrHU+SP12vX3EJwOJ0eYg19/fu/OGAwT9nxK
         iqAInFILWW+9tjwXxxNrX9pBqHl3f/qUENBT4qJA=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/6] IIO: Tidy up parameters to regmap_bulk_* calls 
Date:   Sun,  5 Apr 2020 19:03:15 +0100
Message-Id: <20200405180321.1737310-1-jic23@kernel.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of Andy Shevchenko's recent patches tidied a case of this up
and a quick grep showed we had some more.

The main focus of this set is calls to regmap_bulk_read /
regmap_bulk_write.  Both are used with buffers of many and varied type,
but as they take a void * there is never any need to cast a pointer
to said buffers to anything explicitly.

Whilst I was here I used sizeof(buf) in various places to reduce
the use of explicit values when we could derive it from the source
/ destination buffer.

This isn't remotely urgent, but I'd like to clean these out to avoid
replication in future.  Not I didn't go after any other unnecessary
casts in the files because that would have take thought and its Sunday
evening and about time for a beer.

Jonathan Cameron (6):
  iio:accel:mxc4005: Drop unnecessary explicit casts in regmap_bulk_read
    calls
  iio:chemical:atlas-sensor: Drop unnecessary explicit casts in
    regmap_bulk_read calls
  iio:chemical:bme680: Tidy up parameters to regmap_bulk_read
  iio:imu:mpu6050: Tidy up parameters to regmap_bulk functions.
  iio:magn:mmc35240: Drop unnecessary casts of val parameter in
    regmap_bulk*
  iio:light:ltr501: Drop unnecessary cast of parameter in
    regmap_bulk_read

 drivers/iio/accel/mxc4005.c                |  4 +--
 drivers/iio/chemical/atlas-sensor.c        |  7 ++---
 drivers/iio/chemical/bme680_core.c         | 36 +++++++++++++---------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  4 +--
 drivers/iio/light/ltr501.c                 |  2 +-
 drivers/iio/magnetometer/mmc35240.c        |  4 +--
 6 files changed, 32 insertions(+), 25 deletions(-)

-- 
2.26.0

