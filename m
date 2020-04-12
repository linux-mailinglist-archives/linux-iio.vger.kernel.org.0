Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A381C1A5FDC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgDLShT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 14:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgDLShT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 14:37:19 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC29C0A3BF0;
        Sun, 12 Apr 2020 11:37:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [157.50.0.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B51E20692;
        Sun, 12 Apr 2020 18:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586716639;
        bh=xnkGinybgg2yZ4SKZkyQ3P43T2PMVaby5e/SCGUI9dg=;
        h=From:To:Cc:Subject:Date:From;
        b=qi3Oa1zHmPOPQlyXItww7qlttcSqRLtUjgUTHpS0+EMbCVt/7VcGybDmgi0IhieWj
         uW7YMqNljS1H0Mze5MiXNnQwRaK9mDCtlS9owibOyxTLs5p4RLlBF/HIA2dM2oVAQQ
         mBZ9GkuKlVomYoN/XAXk7NvaNEs8/U9kWaMD51Kg=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 0/3] Add Reset and Wakeup support for CCS811
Date:   Mon, 13 Apr 2020 00:06:55 +0530
Message-Id: <20200412183658.6755-1-mani@kernel.org>
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

Manivannan Sadhasivam (3):
  dt-bindings: iio: chemical: Add binding for CCS811 VOC sensor
  iio: chemical: Add support for external Reset and Wakeup in CCS811
  iio: chemical: Add OF match table for CCS811 VOC sensor

 .../bindings/iio/chemical/ams,ccs811.yaml     | 50 ++++++++++
 drivers/iio/chemical/ccs811.c                 | 96 +++++++++++++++++--
 2 files changed, 138 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml

-- 
2.17.1

