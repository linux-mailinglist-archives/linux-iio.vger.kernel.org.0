Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737D43A4185
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFKL6K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 07:58:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:32139 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhFKL6J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 07:58:09 -0400
IronPort-SDR: SMrmgxTGDrhCn9QLC/czd68uhs1lzPfIhtPxqdnxO2a3rTXGWBDW2sYfQ+/ANzysNYum5ts12o
 XIRJ73D5zhzQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="192823301"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="192823301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 04:56:11 -0700
IronPort-SDR: /13fzcseaoVbxbqqBqSLflarZ+zSAvOULwGXbUf0LaVAj7NWpwhHqkmhMezGU2DB9NpWYOT9p1
 lAbRTZD2wcWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="486562692"
Received: from unknown (HELO mylly.fi.intel.com.) ([10.237.72.51])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2021 04:56:09 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] counter: intel-qep: Use to_pci_dev() helper
Date:   Fri, 11 Jun 2021 14:55:58 +0300
Message-Id: <20210611115558.796338-2-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use to_pci_dev() helper instead of container_of(d, struct pci_dev, dev);

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/counter/intel-qep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index a8d3dccecc0f..8d7ae28fbd67 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -475,7 +475,7 @@ static void intel_qep_remove(struct pci_dev *pci)
 
 static int __maybe_unused intel_qep_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct intel_qep *qep = pci_get_drvdata(pdev);
 
 	qep->qepcon = intel_qep_readl(qep, INTEL_QEPCON);
@@ -487,7 +487,7 @@ static int __maybe_unused intel_qep_suspend(struct device *dev)
 
 static int __maybe_unused intel_qep_resume(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct intel_qep *qep = pci_get_drvdata(pdev);
 
 	/*
-- 
2.30.2

