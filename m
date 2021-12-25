Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687F647F3CA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhLYQLW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhLYQLU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A5C06175D
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008Do-NF; Sat, 25 Dec 2021 17:11:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-006ahT-Ax; Sat, 25 Dec 2021 17:11:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dT-0007h7-0c; Sat, 25 Dec 2021 17:11:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de, Felipe Balbi <balbi@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH v1 17/23] counter: intel-qep: Convert to new counter registration
Date:   Sat, 25 Dec 2021 17:10:50 +0100
Message-Id: <20211225161056.682797-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=xxaNj3Lr4F2nUU3L5jyLeMsoD9IgL3Fywde/z31RhRA=; m=3R8rN/LzNzQo1FXHZXjRMSNmOPiOoCX+fEd8aOKojqA=; p=PZNhgfrkhFxeqmpbLIe6pog2VoENjnSIHj4tDDoSTLs=; g=470d5595051e38ec00ec649e099aa79724b1deb2
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQm8ACgkQwfwUeK3K7Amm+Af/cSK Un7Yfo00MYF1bHfXHhZJL7JwHx6yyokjJw5vBimh+TOHlXorVahKIJkOGQcjd3ggZXmKwr9jyjghm CmCMGZrWE5+9pC8k/g9dEN1YU3wiEM7Hau15Rk8TPPl6WZh+RiXbYDdPCIMNzcEz0e4mwdHs/tzA7 OCIZOPngbilpVwoHVjqzlh1fJglhVGODb3Qj8DRwjn4LYaq8XspZ2NNe6gcjDME2o3Uun6Yq8zRhT kusF5Ep/N4IVp9zSXNP7i+U+E1yuZCZomy01WeWfL5Xc1terre5cq8TWX7UoGqZW9Iv+zpt8mU3Jr J53EVA9beN4SNjcnmNTqiPju8Z/M43A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This fixes device lifetime issues where it was possible to free a live
struct device.

Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder Peripheral")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/intel-qep.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 8f84a48508ac..47a6a9dfc9e8 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -63,7 +63,6 @@
 #define INTEL_QEP_CLK_PERIOD_NS		10
 
 struct intel_qep {
-	struct counter_device counter;
 	struct mutex lock;
 	struct device *dev;
 	void __iomem *regs;
@@ -392,14 +391,16 @@ static struct counter_count intel_qep_counter_count[] = {
 
 static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
+	struct counter_device *counter;
 	struct intel_qep *qep;
 	struct device *dev = &pci->dev;
 	void __iomem *regs;
 	int ret;
 
-	qep = devm_kzalloc(dev, sizeof(*qep), GFP_KERNEL);
-	if (!qep)
+	counter = devm_counter_alloc(dev, sizeof(*qep));
+	if (!counter)
 		return -ENOMEM;
+	qep = counter_priv(counter);
 
 	ret = pcim_enable_device(pci);
 	if (ret)
@@ -422,20 +423,23 @@ static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	intel_qep_init(qep);
 	pci_set_drvdata(pci, qep);
 
-	qep->counter.name = pci_name(pci);
-	qep->counter.parent = dev;
-	qep->counter.ops = &intel_qep_counter_ops;
-	qep->counter.counts = intel_qep_counter_count;
-	qep->counter.num_counts = ARRAY_SIZE(intel_qep_counter_count);
-	qep->counter.signals = intel_qep_signals;
-	qep->counter.num_signals = ARRAY_SIZE(intel_qep_signals);
-	qep->counter.priv = qep;
+	counter->name = pci_name(pci);
+	counter->parent = dev;
+	counter->ops = &intel_qep_counter_ops;
+	counter->counts = intel_qep_counter_count;
+	counter->num_counts = ARRAY_SIZE(intel_qep_counter_count);
+	counter->signals = intel_qep_signals;
+	counter->num_signals = ARRAY_SIZE(intel_qep_signals);
 	qep->enabled = false;
 
 	pm_runtime_put(dev);
 	pm_runtime_allow(dev);
 
-	return devm_counter_register(&pci->dev, &qep->counter);
+	ret = devm_counter_add(&pci->dev, counter);
+	if (ret < 0)
+		return dev_err_probe(&pci->dev, ret, "Failed to add counter\n");
+
+	return 0;
 }
 
 static void intel_qep_remove(struct pci_dev *pci)
-- 
2.33.0

