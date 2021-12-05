Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD177468D3A
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhLEU0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhLEU0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:26:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD680C061751
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 12:22:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A9CEB80EE1
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3AAC341C6;
        Sun,  5 Dec 2021 20:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735764;
        bh=2Wzwb01ERCMy7uitkQ4YP1uBlPR8YbbuJAii0Jv3yfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULN3qRvQABNSuvuF7sDxDeGh53kPd2mnIAmnYDcdKj9Fcs8Ip2wK6L3GNXm0icA18
         fRQzpFPVXZVQKc83mdec02lzqrDgXBHPczUIGk43Po6DaECakPOuZaUmNOsD+oT7qw
         sDZ8mQz18UclhbBQ9leI2WVD3/BnFE7lHemrSmzwScTkOT+EZe0fiYrv6CKkhImpLg
         I7WmwEPQLtPMBLxJg6IDvaeTo8/pHGY2cs0Ldsp9PoefvmDgGH/vAWH0xk1M0JgPHI
         iRrkJp3WMUJFhgeUJpYCfZb28xocCZAuHQ6XIEzysJrqAJW68S0ffNXIKNsTO+TX/R
         JuUpgBmeMIP+g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 16/17] iio:adc:ad7280a: Document ABI for cell balance switches
Date:   Sun,  5 Dec 2021 20:27:09 +0000
Message-Id: <20211205202710.2847005-17-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very minimal ABI docs. This is unusual enough that I'd expect anyone
who actually wanted to touch them to go look at the datasheet.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
new file mode 100644
index 000000000000..83b7efe6aa07
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
@@ -0,0 +1,13 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_balance_switch_en
+KernelVersion:	5.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Used to enable an output for balancing cells for time
+		controlled via in_voltage_Y-voltageZ_balance_switch_timer.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_balance_switch_timer
+KernelVersion:	5.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Time in seconds for which balance switch will be turned on.
+		Multiple of 71.5 seconds.
-- 
2.34.1

