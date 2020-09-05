Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2429825E98F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgIERti (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgIERti (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:49:38 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE2AE2078E;
        Sat,  5 Sep 2020 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599328177;
        bh=bi5VoD2qDuHExwuDHiGTm/wiz6ixriE+AEBv8NHcS4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtD8yXUAvX230mDD1ZJOg9h4wsysTg+2YuSoAfMtQFEN6ndxYrTOtSB9hToV3o0FQ
         jcaxzhVaawzLnAXw9A2AcuTsHxCXjwdGVU3S5y7G3qMK/NWEBM7iR0hbrcQ30pF23Y
         uAjbhvCg20GEjqVPefzcV7dCoFN3ymVn1FSKJmgg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Roland Stigge <stigge@antcom.de>
Subject: [PATCH 1/4] staging:iio:dac:max517 remove documentation
Date:   Sat,  5 Sep 2020 18:47:18 +0100
Message-Id: <20200905174721.216452-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905174721.216452-1-jic23@kernel.org>
References: <20200905174721.216452-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst there is some useful info in here, it can be easily
obtained from datasheets. Some of the info should perhaps
be incorporated into a device tree bindings doc.
As this didn't move out of staging with the driver, I'm suggesting
we just drop it.  We don't generally carry per driver documentation
with the exception of non standard ABI which is not the case here.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Roland Stigge <stigge@antcom.de>
---
 drivers/staging/iio/Documentation/dac/max517 | 41 --------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/staging/iio/Documentation/dac/max517 b/drivers/staging/iio/Documentation/dac/max517
deleted file mode 100644
index e60ec2f91a7a..000000000000
--- a/drivers/staging/iio/Documentation/dac/max517
+++ /dev/null
@@ -1,41 +0,0 @@
-Kernel driver max517
-====================
-
-Supported chips:
-  * Maxim MAX517, MAX518, MAX519
-    Prefix: 'max517'
-    Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/
-
-Author:
-        Roland Stigge <stigge@antcom.de>
-
-Description
------------
-
-The Maxim MAX517/518/519 is an 8-bit DAC on the I2C bus. The following table
-shows the different feature sets of the variants MAX517, MAX518 and MAX519:
-
-Feature                              MAX517 MAX518 MAX519
---------------------------------------------------------------------------
-One output channel                   X
-Two output channels                         X      X
-Simultaneous output updates                 X      X
-Supply voltage as reference                 X
-Separate reference input             X
-Reference input for each DAC                       X
-
-Via the iio sysfs interface, there are three attributes available: out1_raw,
-out2_raw and out12_raw. With out1_raw and out2_raw, the current output values
-(0..255) of the DACs can be written to the device. out12_raw can be used to set
-both output channel values simultaneously.
-
-With MAX517, only out1_raw is available.
-
-Via out1_scale (and where appropriate, out2_scale), the current scaling factor
-in mV can be read.
-
-When the operating system goes to a power down state, the Power Down function
-of the chip is activated, reducing the supply current to 4uA.
-
-On power-up, the device is in 0V-output state.
-- 
2.28.0

