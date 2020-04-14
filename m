Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8891A8A23
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504394AbgDNStr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504372AbgDNStm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:49:42 -0400
Received: from localhost.localdomain (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47202074D;
        Tue, 14 Apr 2020 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586890182;
        bh=xKFvKcGgSXkz6RyHFm/5YR5OI28iwBFM98iGSOEIRBI=;
        h=From:To:Cc:Subject:Date:From;
        b=ARBAlnGwlvZR5S1DixT7TbdBDsKezWaRNHuuug95Dn4KzOuYd+xJ91Q/YbVpEd9wo
         GQies1ooLoQaBGo0oMJfW0UXyJIH0mw0F8/ShuxDKF7+9+Ed+L/s3UZNioSQA+8ASk
         NiWE9t4/uJoEEUX+hcpOxxy3BECqxhPW5DPSPNG4=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [RESEND PATCH v3 0/3] Add Reset and Wakeup support for CCS811
Date:   Wed, 15 Apr 2020 00:19:27 +0530
Message-Id: <20200414184930.5576-1-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Hello,

This patchset adds external reset and wakeup support for CCS811 VOC
gas sensor. The nRESET and nWAKE pins available on the device are
utilised to provide these functionalities.

The patchset has been validated using CCS811 connected to STM32MP1 based
board over I2C.

While at it, the devicetree yaml binding and OF match table for this sensor
are also added.

Thanks,
Mani

Changes in v3:

* Added ccs811_set_wake(false) to all error paths before calling it actually
* Added Andy's reviewed-by tag
* Added comment for reset procedure and dropped error print for gpio request

Changes in v2:

* Fixed DT binding schema and switched to dual license (GPL/BSD)
* Returned actual error code from devm_gpiod_get_optional()
* Dropped of.h include and of_match_ptr()

Manivannan Sadhasivam (3):
  dt-bindings: iio: chemical: Add binding for CCS811 VOC sensor
  iio: chemical: Add support for external Reset and Wakeup in CCS811
  iio: chemical: Add OF match table for CCS811 VOC sensor

 .../bindings/iio/chemical/ams,ccs811.yaml     |  51 ++++++++
 drivers/iio/chemical/ccs811.c                 | 112 ++++++++++++++++--
 2 files changed, 152 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml

-- 
2.17.1

