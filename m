Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0211AFB88
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgDSPEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgDSPET (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:04:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0F7214D8;
        Sun, 19 Apr 2020 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308658;
        bh=djR/VLWyP7zdgVr+FGTd2bCSkxkBIxmLj0ILOltk8Ek=;
        h=From:To:Cc:Subject:Date:From;
        b=d5fteiHw7NSmCRKYdV7mIa6R7wFcyAvuYf/t3baaRh30vT5v/AU1AnxFey3oUdShc
         fSwdsxV/Vp0qdl6rF39fm7s0+/egvAmjuJgLFCDRSuhQHvdB2CCP0AWDzkr+Lvc37Q
         k//FTzDM+9lY1XLP8FPpgEFS+QWLpBu0TwDoGq60=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/7] iio: light: clean out of_match_ptr and tidy headers
Date:   Sun, 19 Apr 2020 16:01:59 +0100
Message-Id: <20200419150206.43033-1-jic23@kernel.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi All,

Given we keep having to explain to people that of_match_ptr is less
than ideal now we have the option of ACPI DSDT using PRP0001 and
the compatible, it seems sensible to reduce the number of instances
that people might copy for a new driver.

Added theoretical benefit is that we can probe all these drivers from
appropriate DSDT (though I doubt anyone will).

I'm sending this first set out to see if anyone has strong views against
doing this for at least the simple drivers that have no other device
tree dependence.  Obviously more work would be needed to remove
use of of_match_ptr from IIO completely.

Light sensors picked as a starting point as they tend to be simple.

I may do follow ups in larger blocks to avoid so many small patches
(or indeed flatten these into one when applying)

Thanks

Jonathan

Jonathan Cameron (7):
  iio: light: bh1780: use mod_devicetable.h and drop of_match_ptr macro
  iio: light: cm32181: Add mod_devicetable.h and remove of_match_ptr
  iio: light: cm3232: Add mod_devicetable.h include and drop
    of_match_ptr
  iio: light: gp2ap020a00f: Swap of.h for mod_devicetable.h + drop
    of_match_ptr
  iio: light: opt3001: Add mod_devicetable.h and drop use of
    of_match_ptr
  iio: light: st_uvis25: Add mod_devicetable.h and drop of_match_ptr
  iio: light: vl6180: swap of.h for mod_devicetable.h and drop
    of_match_ptr

 drivers/iio/light/bh1780.c        | 6 ++----
 drivers/iio/light/cm32181.c       | 3 ++-
 drivers/iio/light/cm3232.c        | 3 ++-
 drivers/iio/light/gp2ap020a00f.c  | 6 ++----
 drivers/iio/light/opt3001.c       | 3 ++-
 drivers/iio/light/st_uvis25_i2c.c | 3 ++-
 drivers/iio/light/st_uvis25_spi.c | 3 ++-
 drivers/iio/light/vl6180.c        | 2 +-
 8 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.26.1

