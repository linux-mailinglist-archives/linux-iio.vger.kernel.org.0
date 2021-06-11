Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209ED3A4184
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhFKL6J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 07:58:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:32139 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbhFKL6J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 07:58:09 -0400
IronPort-SDR: w2MpZ/rcBwzfM9Fz9dz9d9gld/ox8LDB/pczx1trAF3zOiy/sDy/eA2ikVKgGP3bcHcT8V2Bo6
 Erjz28VhDjJw==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="192823298"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="192823298"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 04:56:08 -0700
IronPort-SDR: VPOpU5DEXcJEQW3XshlW/2InqzDLI2AYsLzcgt2o6ssvnbd5iC10sjOWVr25M0taMfNbMnLiMa
 aSTMMWpmXkZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="486562681"
Received: from unknown (HELO mylly.fi.intel.com.) ([10.237.72.51])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2021 04:56:07 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] counter: intel-qep: Mark PM callbacks with __maybe_unused
Date:   Fri, 11 Jun 2021 14:55:57 +0300
Message-Id: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove CONFIG_PM ifdef and mark PM callbacks with __maybe_unused.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/counter/intel-qep.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index ab10ba33f46a..a8d3dccecc0f 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -473,8 +473,7 @@ static void intel_qep_remove(struct pci_dev *pci)
 	intel_qep_writel(qep, INTEL_QEPCON, 0);
 }
 
-#ifdef CONFIG_PM
-static int intel_qep_suspend(struct device *dev)
+static int __maybe_unused intel_qep_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
 	struct intel_qep *qep = pci_get_drvdata(pdev);
@@ -486,7 +485,7 @@ static int intel_qep_suspend(struct device *dev)
 	return 0;
 }
 
-static int intel_qep_resume(struct device *dev)
+static int __maybe_unused intel_qep_resume(struct device *dev)
 {
 	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
 	struct intel_qep *qep = pci_get_drvdata(pdev);
@@ -512,7 +511,6 @@ static int intel_qep_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static UNIVERSAL_DEV_PM_OPS(intel_qep_pm_ops,
 			    intel_qep_suspend, intel_qep_resume, NULL);
-- 
2.30.2

