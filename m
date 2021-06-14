Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99EE3A65C0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhFNLmG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236557AbhFNLjQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:39:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64DB9613DF;
        Mon, 14 Jun 2021 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670439;
        bh=0pcQ1EkU67/sAEQ1HZATJ0trgyQZCpmGY+zQNg7r4pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNQY0jnmC/RX94S2dP7NF6aZePEpobRuQx8bGtD2g8QKeW762Geook4SaWK2aSnJV
         yykGUmRtJ5537TBPcAngoxnaEhKQi/COw65qz7l5V2gGwuHpaPgjGzf0pcR4DQZa1v
         SLZ8C6L/0aFp1oN8m1A0sMIZaA42lw59WbLD5gGZQdf73BJIQUFzSvh/4oza+HJna5
         9ZH1zOMMccJOxc555TzCX619EUsdme62PzZs1xx0jutzID1AT09js+QEEuDYlR7xk9
         Ab0m40ECfInb1g0L2q9Cav5AQzW3O7S7J6O9vk4l774TLnhk+SYTHsOMFem/S9l4HR
         zC8nudlT0EXOA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 16/17] iio:adc:ad7280a: Document ABI for cell balance switches
Date:   Mon, 14 Jun 2021 12:35:06 +0100
Message-Id: <20210614113507.897732-17-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
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
 .../ABI/testing/sysfs-bus-iio-adc-ad7280a          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
new file mode 100644
index 000000000000..f51fc77b0143
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
@@ -0,0 +1,14 @@
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
+
-- 
2.32.0

