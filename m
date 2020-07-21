Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D20228717
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgGURQx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 13:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbgGURQt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jul 2020 13:16:49 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E01B2065D;
        Tue, 21 Jul 2020 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595351809;
        bh=MfPdozOyemA99HJNgFz0+GO6Fu/S01G7kgq4oq0GAEw=;
        h=From:To:Cc:Subject:Date:From;
        b=jwDcuJZyb7UzKoML6d9iqod6+iiLg4e3baCO9lkBSxEQZt8i+prkdVgtGBgln+5Gy
         4iIcKkwIwvkAK13ff426eZwgFi2Onluaz+Dbn7zeCVjayXQTp5ofUJ/9QBC2BVEY0X
         dAESqdp5zfgyfkpwznR/s2Cw55yf03Tpr4UmuIVs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/5] iio:adc more of_match_ptr and similar removal
Date:   Tue, 21 Jul 2020 18:14:39 +0100
Message-Id: <20200721171444.825099-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Remaining set from v1 + one additional patch from comments in that
series.

Changes since V1.

* Most patches now merged this is cleaning up the leftovers.
* Rephrase commit messages for cases where there is an ACPI ID.
* Add a patch to drop the unlikely explicit ACPI support in adc081c.
* Avoid the casting away of const in axp20x by keeping it const throughout.
* bcm_adc add a kconfig protection to limit driver to being built when
  CONFIG_OF enabled, or COMPILE_TEST for build tests.
  
Continuation of slow process to try and remove use of of_match_ptr
to supress asignment of the of_device_id table when !CONFIG_OF.

Usual argument that it prevents ACPI being used with these drivers
via PRP0001 in DSDT.  Perhaps more usefully we are cutting down on the
number of places it can be cut and paste from into new drivers.

This is just the low hanging fruit.  I'm not yet sure if it makes
sense to expend the effort to use generic firmware properties etc
for some of the remaining drivers as it is unlikely they'll ever
be used with anything other than device tree. There are 4 current
ADC drivers in this more complex category.

Jonathan Cameron (5):
  iio:adc:axp20x: Convert from OF to generic fw / device properties
  iio:adc:ti-adc081c: Drop ACPI ids that seem very unlikely to be
    official.
  iio:adc:ti-adc108s102: Drop CONFIG_OF and of_match_ptr protections
  iio:adc:ti-adc128s052: drop of_match_ptr protection
  iio:adc:bcm_iproc: Drop of_match_ptr protection and switch to
    mod_devicetable.h

 drivers/iio/adc/Kconfig         |  2 +-
 drivers/iio/adc/axp20x_adc.c    | 14 +++++++-------
 drivers/iio/adc/bcm_iproc_adc.c |  4 ++--
 drivers/iio/adc/ti-adc081c.c    | 24 +-----------------------
 drivers/iio/adc/ti-adc108s102.c |  5 ++---
 drivers/iio/adc/ti-adc128s052.c |  3 ++-
 6 files changed, 15 insertions(+), 37 deletions(-)

-- 
2.27.0

