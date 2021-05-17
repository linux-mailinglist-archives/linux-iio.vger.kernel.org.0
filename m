Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4204E38246F
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 08:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhEQGgw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 02:36:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:26155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhEQGgw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 02:36:52 -0400
IronPort-SDR: X7J+FDf9IVebI0tUqwLSyQD7cBzfz4Ks7+AAhoWQxmGbcAMif+q12l/d475pOboxvXkxlrYlNN
 G4oMK/HrNOBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197308894"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="197308894"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 23:35:36 -0700
IronPort-SDR: lAXmrOYT2oX1A2RdYUaSvrb0mGQQTKsYwRlGqIA+nrv+A5dhb9HdqI0K+Ov0CEhOqFqVRMUTP6
 MCcyt98Ao47g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="472256369"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga001.jf.intel.com with ESMTP; 16 May 2021 23:35:34 -0700
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH] HID: intel-ish-hid: ipc: Add Alder Lake device IDs
Date:   Mon, 17 May 2021 14:36:09 +0800
Message-Id: <20210517063609.23267-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Alder Lake PCI device IDs to the supported device list.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 2 ++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
index 21b87e4003af..07e3cbc86bef 100644
--- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
+++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
@@ -28,6 +28,8 @@
 #define EHL_Ax_DEVICE_ID	0x4BB3
 #define TGL_LP_DEVICE_ID	0xA0FC
 #define TGL_H_DEVICE_ID		0x43FC
+#define ADL_S_DEVICE_ID		0x7AF8
+#define ADL_P_DEVICE_ID		0x51FC
 
 #define	REVISION_ID_CHT_A0	0x6
 #define	REVISION_ID_CHT_Ax_SI	0x0
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 06081cf9b85a..a6d5173ac003 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -39,6 +39,8 @@ static const struct pci_device_id ish_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, EHL_Ax_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, TGL_LP_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, TGL_H_DEVICE_ID)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ADL_S_DEVICE_ID)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ADL_P_DEVICE_ID)},
 	{0, }
 };
 MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
-- 
2.17.1

