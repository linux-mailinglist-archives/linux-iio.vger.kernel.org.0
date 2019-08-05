Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7606E816D5
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 12:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfHEKTA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 06:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfHEKS7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 06:18:59 -0400
Received: from localhost.localdomain.com (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0402087B;
        Mon,  5 Aug 2019 10:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565000338;
        bh=vxORERL5aPVXOqk9I15yWK8FBFb8Fa12KScWqvsSvTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKn2ejrLQ3gCb6w5nlVIVwA+x09OKi1ZyYwJaOrFQyLH917OhSy8w4Zk+tMiU6/55
         7qJUv/Q1Gg3E0WbRRhVwWRVgbUr2SukD7zKD78JwKrhOv2lYiRvh7fCv9fuBDe2TtB
         Z7DnyhQi2U0xKHaIGOdIQsIbGwAHYkH3qT0d0kjI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add ism330dhcx device bindings
Date:   Mon,  5 Aug 2019 12:18:44 +0200
Message-Id: <0a970fdcd934c940be1af82ecf1fe2a746abcd2a.1564999807.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564999807.git.lorenzo@kernel.org>
References: <cover.1564999807.git.lorenzo@kernel.org>
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
index 92b48f242356..87407d110bb7 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -12,6 +12,7 @@ Required properties:
   "st,lsm6dsox"
   "st,lsm6dsr"
   "st,lsm6ds3tr-c"
+  "st,ism330dhcx"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.21.0

