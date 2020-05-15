Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC831D56A1
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgEOQwB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEOQwA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 12:52:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874CAC061A0C;
        Fri, 15 May 2020 09:52:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 67BB42A32FD
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 1/7] Input: add input_device_enabled()
Date:   Fri, 15 May 2020 18:51:51 +0200
Message-Id: <20200515165151.28670-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515164943.28480-1-andrzej.p@collabora.com>
References: <20200515164943.28480-1-andrzej.p@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A helper function for drivers to decide if the device is used or not.
A lockdep check is introduced as inspecting ->users should be done under
input device's mutex.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/input/input.c | 8 ++++++++
 include/linux/input.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3cfd2c18eebd..41377bfa142d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2127,6 +2127,14 @@ void input_enable_softrepeat(struct input_dev *dev, int delay, int period)
 }
 EXPORT_SYMBOL(input_enable_softrepeat);
 
+bool input_device_enabled(struct input_dev *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+
+	return dev->users > 0;
+}
+EXPORT_SYMBOL_GPL(input_device_enabled);
+
 /**
  * input_register_device - register device with input core
  * @dev: device to be registered
diff --git a/include/linux/input.h b/include/linux/input.h
index 56f2fd32e609..eda4587dba67 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -502,6 +502,8 @@ bool input_match_device_id(const struct input_dev *dev,
 
 void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
 
+bool input_device_enabled(struct input_dev *dev);
+
 extern struct class input_class;
 
 /**
-- 
2.17.1

