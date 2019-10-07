Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA87CDE64
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 11:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfJGJn4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 05:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfJGJnz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 05:43:55 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CE3021655;
        Mon,  7 Oct 2019 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570441435;
        bh=/1BlHJidn6YTk/N3hfexX/eOvjbULORrJ1LWvj8xVis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZJrG4oeTqH5X3IbmKRZr1cNT2yIHgyeMd7R2Rfi46EFUHzavSR3M6nmbGzxa30uO
         kfaXLBgeS7m/ixKjZD1YVImKyNtb1UpMiCC557XQroXOXPXwDa7JQf6qMjF8F/wFgW
         jTiG16Zrobo+5vigQOmmtfliYYnHgQkobI/tGFIQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds0 device bindings
Date:   Mon,  7 Oct 2019 11:43:38 +0200
Message-Id: <86786d8de65eb1c2b16e8433aa673d217cc27dcd.1570441034.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570441034.git.lorenzo@kernel.org>
References: <cover.1570441034.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index 1a07d38c813f..fc018ecba086 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -14,6 +14,7 @@ Required properties:
   "st,lsm6ds3tr-c"
   "st,ism330dhcx"
   "st,lsm9ds1-imu"
+  "st,lsm6ds0"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.21.0

