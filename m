Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9785F273D4
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 03:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfEWBKX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 May 2019 21:10:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:61521 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfEWBKX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 May 2019 21:10:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 18:10:22 -0700
X-ExtLoop1: 1
Received: from shsensorbuild2.sh.intel.com ([10.239.133.151])
  by FMSMGA003.fm.intel.com with ESMTP; 22 May 2019 18:10:21 -0700
From:   hongyan.song@intel.com
To:     jikos@kernel.org, srinivas.pandruvada@intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        hdegoede@redhat.com, jic23@kernel.org, even.xu@intel.com,
        hongyan.song@intel.com
Subject: [PATCH v2] hid: remove NO_D3 flag for non Cherry Trail(CHT)
Date:   Thu, 23 May 2019 09:10:20 +0800
Message-Id: <1558573820-31133-1-git-send-email-hongyan.song@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Song Hongyan <hongyan.song@intel.com>

The code base NO_D3 flag is especially set for CHT, which is a tablet
platform, it have PMC changes and do not need to enter D3.
The newer platforms, which need ISH to enter D3, if have this NO_D3
flag set they can never enter D3, so remove it.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
v2 changes: update the code comments format and patch header, patch comments.

 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index ac0a179..ea444e4 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -155,7 +155,10 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* mapping IO device memory */
 	hw->mem_addr = pcim_iomap_table(pdev)[0];
 	ishtp->pdev = pdev;
-	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+
+	/* This NO_D3 flag is only for CHV and older platforms */
+	if (pdev->device == CHV_DEVICE_ID)
+		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 
 	/* request and enable interrupt */
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-- 
2.7.4

