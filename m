Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784191FBCEF
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jun 2020 19:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgFPR3V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jun 2020 13:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgFPR3U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jun 2020 13:29:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421C4C061573;
        Tue, 16 Jun 2020 10:29:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 4CE612A2C75
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
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
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        kernel@collabora.com
Subject: [PATCH] Input: document inhibiting
Date:   Tue, 16 Jun 2020 19:29:09 +0200
Message-Id: <20200616172909.21625-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <40988408-8f36-3a52-6439-34084de6b129@redhat.com>
References: <40988408-8f36-3a52-6439-34084de6b129@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document inhibiting input devices and its relation to being
a wakeup source.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---

@Hans, @Dmitry,

My fist attempt at documenting inhibiting. Kindly look at it to see if I haven't got anything
wrong.

Andrzej

 Documentation/input/input-programming.rst | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/input/input-programming.rst b/Documentation/input/input-programming.rst
index 45a4c6e05e39..0cd1ad4504fb 100644
--- a/Documentation/input/input-programming.rst
+++ b/Documentation/input/input-programming.rst
@@ -164,6 +164,42 @@ disconnects. Calls to both callbacks are serialized.
 The open() callback should return a 0 in case of success or any nonzero value
 in case of failure. The close() callback (which is void) must always succeed.
 
+Inhibiting input devices
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Inhibiting a device means ignoring input events from it. As such it is about maintaining
+relationships with input handlers - either an already existing relationships, or
+relationships to be established while the device is in inhibited state.
+
+If a device is inhibited, no input handler will receive events from it.
+
+The fact that nobody wants events from the device is exploited further, by calling device's
+close() (if there are users) and open() (if there are users) on inhibit and uninhibit
+operations, respectively. Indeed, the meaning of close() is to stop providing events
+to the input core and that of open() is to start providing events to the input core.
+
+Inhibiting and uninhibiting is orthogonal to opening and closing the device by input
+handlers. Userspace might want to inhibit a device in anticipation before any handler is
+positively matched against it.
+
+Inhibiting and uninhibiting is orthogonal to device's being a wakeup source, too. Being a
+wakeup source plays a role when the system is sleeping, not when the system is operating.
+How drivers should program their interaction between inhibiting, sleeping and being a wakeup
+source is driver-specific.
+
+Taking the analogy with the network devices - bringing a network interface down doesn't mean
+that it should be impossible to be wake the system up on LAN through this interface. So, there
+may be input drivers which should be considered wakeup sources even when inhibited. Actually,
+in many i2c input devices their interrupt is declared a wakeup interrupt and its handling
+happens in driver's core, which is not aware of input-specific inhibit (nor should it be).
+Composite devices containing several interfaces can be inhibited on a per-interface basis and
+e.g. inhibiting one interface shouldn't affect the device's capability of being a wakeup source.
+
+If a device is to be considered a wakeup source while inhibited, special care must be taken when
+programming its suspend(), as it might need to call device's open(). Depending on what close()
+means for the device in question not opening() it before going to sleep might make it impossible
+to provide any wakeup events. The device is going to sleep anyway.
+
 Basic event types
 ~~~~~~~~~~~~~~~~~
 
-- 
2.17.1

