Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB32744F6
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 07:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403859AbfGYFca (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 01:32:30 -0400
Received: from comms.puri.sm ([159.203.221.185]:59582 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403844AbfGYFc1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Jul 2019 01:32:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 95244E0306;
        Wed, 24 Jul 2019 22:32:26 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g_8GC1yWpkdU; Wed, 24 Jul 2019 22:32:26 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 5/5] dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1 device bindings
Date:   Thu, 25 Jul 2019 07:31:32 +0200
Message-Id: <20190725053132.9589-6-martin.kepplinger@puri.sm>
In-Reply-To: <20190725053132.9589-1-martin.kepplinger@puri.sm>
References: <20190725053132.9589-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index 92b48f242356..fd1722fc93af 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -12,6 +12,7 @@ Required properties:
   "st,lsm6dsox"
   "st,lsm6dsr"
   "st,lsm6ds3tr-c"
+  "st,lsm9ds1"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.20.1

