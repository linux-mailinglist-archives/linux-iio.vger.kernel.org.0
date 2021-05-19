Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672738849B
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 03:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhESBy2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 21:54:28 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:17134 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbhESBy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 21:54:28 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id A978A80177;
        Wed, 19 May 2021 09:53:06 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] staging: iio: fix some formatting issues
Date:   Wed, 19 May 2021 09:52:50 +0800
Message-Id: <1621389170-5850-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxodS1YfGh8YSx1NSEJCSB5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6Dyo6Cj8cTiovLBECNhdM
        OBRPCjZVSlVKTUlKSENCSkNMT0tCVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFJTkhDNwY+
X-HM-Tid: 0a79825397d4b037kuuua978a80177
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

fixing:
CHECK: Alignment should match open parenthesis
#1351: FILE: drivers/staging/iio/addac/adt7316.c:1351:

CHECK: Alignment should match open parenthesis
#1378: FILE: drivers/staging/iio/addac/adt7316.c:1378:

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/staging/iio/addac/adt7316.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index ccbafca..79467f0 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1348,9 +1348,9 @@ static ssize_t adt7316_show_in_analog_temp_offset(struct device *dev,
 }
 
 static ssize_t adt7316_store_in_analog_temp_offset(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf,
-						size_t len)
+						   struct device_attribute *attr,
+						   const char *buf,
+						   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1375,9 +1375,9 @@ static ssize_t adt7316_show_ex_analog_temp_offset(struct device *dev,
 }
 
 static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf,
-						size_t len)
+						   struct device_attribute *attr,
+						   const char *buf,
+						   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
-- 
2.7.4

