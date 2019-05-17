Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0221596
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2019 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfEQIqZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 May 2019 04:46:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:63326 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfEQIqZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 May 2019 04:46:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 01:46:24 -0700
X-ExtLoop1: 1
Received: from shsensorbuild2.sh.intel.com ([10.239.133.151])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2019 01:46:22 -0700
From:   hongyan.song@intel.com
To:     jikos@kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     srinivas.pandruvada@intel.com, hdegoede@redhat.com,
        even.xu@intel.com
Subject: [PATCH] hid: remove NO_D3 flag for ish not CHV platform
Date:   Fri, 17 May 2019 16:46:22 +0800
Message-Id: <1558082782-29279-1-git-send-email-hongyan.song@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Song Hongyan <hongyan.song@intel.com>

NO_D3 flag is set for CHV and the older platforms, the other platform
suppose can enter D3, if have this NO_D3 flag set it can never enter D3

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index a6e1ee7..de1459b 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -154,7 +154,9 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* mapping IO device memory */
 	hw->mem_addr = pcim_iomap_table(pdev)[0];
 	ishtp->pdev = pdev;
-	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+	/*This NO_D3 flag is only for CHV and older platforms*/
+	if (pdev->device == CHV_DEVICE_ID)
+		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 
 	/* request and enable interrupt */
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-- 
2.7.4

