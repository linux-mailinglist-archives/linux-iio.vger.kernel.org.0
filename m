Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521078B141
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 09:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfHMHgi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 03:36:38 -0400
Received: from comms.puri.sm ([159.203.221.185]:43700 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbfHMHgi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 03:36:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DE21AE0346;
        Tue, 13 Aug 2019 00:36:36 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ACitjeJvUT6t; Tue, 13 Aug 2019 00:36:36 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 3/3] dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1 device bindings
Date:   Tue, 13 Aug 2019 09:35:33 +0200
Message-Id: <20190813073533.8007-4-martin.kepplinger@puri.sm>
In-Reply-To: <20190813073533.8007-1-martin.kepplinger@puri.sm>
References: <20190813073533.8007-1-martin.kepplinger@puri.sm>
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
index 87407d110bb7..0b0a74d9ab89 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -13,6 +13,7 @@ Required properties:
   "st,lsm6dsr"
   "st,lsm6ds3tr-c"
   "st,ism330dhcx"
+  "st,lsm9ds1"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.20.1

