Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB62B25E98E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIERti (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgIERth (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:49:37 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7BB420760;
        Sat,  5 Sep 2020 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599328176;
        bh=l0mdy6clGOUXEGqWb1QsHWlR6a21Twx0qC9528juNX8=;
        h=From:To:Cc:Subject:Date:From;
        b=mpqy7pe7gYAayh93kcAFf8Z3I+EwIaUWRJTu8vzeC3G57IZX/zQarlgAjuZwznDU+
         hKHK/ZPfEMvkF4jlNgd7wuWMI2aLRxCwB91V2ZdMZLmNBc5K1msI18ZF7X2ZiwFcVk
         e53Eqn6/mWr2RPwASAKEWYYWAQxRgQKC0RfZ52Rg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/4] staging: iio: Cleanup some docs in staging
Date:   Sat,  5 Sep 2020 18:47:17 +0100
Message-Id: <20200905174721.216452-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Some of these simply got left behind when drivers moved out of staging.
Others were improved upon no end by more recent documentation under
Documentation/ and are inaccurate or incomplete.

For now I've left a few files in the staging/iio/Documentation directory
* inkernel.txt:  We need an equivalent in the main IIO docs but more than
  a simple rst conversion and move is needed.
* sysfs-bus-iio-dds: DDS drivers are still in staging so let us keep this
  with them for now.
* sysfs-bus-iio-adc-ad7280a: The driver is still in staging, so we need
  to deal with that before moving or removing this one.

Comments on removing these of course welcome, but this is a rare occasion
when I'll probably just apply these whether or not anyone reviews the series.

Thanks,

Jonathan

Jonathan Cameron (4):
  staging:iio:dac:max517 remove documentation
  staging:iio:light: Move tsl2x7x ABI docs to correct location.
  staging:iio:light: drop stale ABI docs
  staging:iio:documentation: Drop most generic docs

 .../ABI/testing/sysfs-bus-iio-light-tsl2772   |  0
 drivers/staging/iio/Documentation/dac/max517  | 41 ----------
 drivers/staging/iio/Documentation/device.txt  | 74 -----------------
 .../staging/iio/Documentation/overview.txt    | 57 -------------
 drivers/staging/iio/Documentation/ring.txt    | 47 -----------
 .../iio/Documentation/sysfs-bus-iio-light     | 79 -------------------
 drivers/staging/iio/Documentation/trigger.txt | 31 --------
 7 files changed, 329 deletions(-)
 rename drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x => Documentation/ABI/testing/sysfs-bus-iio-light-tsl2772 (100%)
 delete mode 100644 drivers/staging/iio/Documentation/dac/max517
 delete mode 100644 drivers/staging/iio/Documentation/device.txt
 delete mode 100644 drivers/staging/iio/Documentation/overview.txt
 delete mode 100644 drivers/staging/iio/Documentation/ring.txt
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-light
 delete mode 100644 drivers/staging/iio/Documentation/trigger.txt

-- 
2.28.0

