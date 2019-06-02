Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8CEE32147
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2019 02:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfFBARX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jun 2019 20:17:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:28940 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFBARX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jun 2019 20:17:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jun 2019 17:17:23 -0700
X-ExtLoop1: 1
Received: from shsensorbuild2.sh.intel.com ([10.239.133.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2019 17:17:22 -0700
From:   hongyan.song@intel.com
To:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        hdegoede@redhat.com, jic23@kernel.org, even.xu@intel.com,
        hongyan.song@intel.com
Subject: [PATCH v3] hid: remove NO_D3 flag when remove driver
Date:   Sun,  2 Jun 2019 08:17:21 +0800
Message-Id: <1559434641-11783-1-git-send-email-hongyan.song@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Song Hongyan <hongyan.song@intel.com>

Remove the NO_D3 flag when remove the driver and let device enter
into D3, it will save more power.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3 changes: 
After test the former implmentation, we found FW will enter D3 when
system enter into S0i3. Change the implementation to meet the requirement:
device enter D3 and have no impact to ISH platform.

 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index b239db2..5daa16f 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -193,6 +193,7 @@ static void ish_remove(struct pci_dev *pdev)
 	struct ishtp_device *ishtp_dev = pci_get_drvdata(pdev);
 
 	ishtp_bus_remove_all_clients(ishtp_dev, false);
+	pdev->dev_flags &= ~PCI_DEV_FLAGS_NO_D3;
 	ish_device_disable(ishtp_dev);
 }
 
-- 
2.7.4

