Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388002714AB
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgITNys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 09:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgITNys (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 09:54:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A8821531;
        Sun, 20 Sep 2020 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600610088;
        bh=T86JAw3R4aZZNRay0kr5XtMniE6KnC2qkg2s36rFsZE=;
        h=From:To:Cc:Subject:Date:From;
        b=OKbOOIIpVmmU0uf35MHaw3Vh4GiXU+HZ2YKgT0wnBtZsdbT/WeuPvn3y3aSz7DNi4
         okOw5fkcjj39mSsiVdIQw6FCTowJkeg7dOi+uBty/J2diw+L57eU7FS7CT5Szpbb3b
         lJf73dgimDtoEYo74TGnRq+Uqnt4rk2y8nbD65GA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 0/1] dt-bindings:iio:adc: Another set of yaml conversions.
Date:   Sun, 20 Sep 2020 14:54:35 +0100
Message-Id: <20200920135436.199003-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The only has a cover letter to match up with the earlier sets.
I wouldn't normally put one on a single patch!

Changes since v2:
* Apply all but one patch.
* amlogic,meson-saradc:
  - consistent capitalization
  - clock names etc all shared, only the number of them changed dependent
    on type.

Jonathan Cameron (1):
  dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion

 .../bindings/iio/adc/amlogic,meson-saradc.txt |  48 ------
 .../iio/adc/amlogic,meson-saradc.yaml         | 149 ++++++++++++++++++
 2 files changed, 149 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml

-- 
2.28.0

