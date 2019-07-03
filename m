Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633DD5EB26
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGCSGy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 14:06:54 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:59172 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfGCSGy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jul 2019 14:06:54 -0400
Received: from localhost.localdomain (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CA390C54AE;
        Wed,  3 Jul 2019 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1562177211; bh=rFoC5qULgkgZLGx9OtZLKlFFvNlr0AhFTgrrSrhAbls=;
        h=From:To:Cc:Subject:Date;
        b=LTdRQA0HWQbe/oCEDkrpK8V3Ntcka6iyW8oHFAVzCj415zOkGB3oyqa78KMU2QbtI
         4k2+dk2eKHVm6z4ycEOg68aEuch199qnxDNxXZvky+KNWwra/+d5RJSLIgl/56UHOz
         viG/4UDB3qPlvOYqKxyjVp+vfVuCWG/D52Wq7zII=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vivek Unune <npcomplete13@gmail.com>,
        Hannes Schmelzer <hannes.schmelzer@br-automation.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Martijn Braam <martijn@brixit.nl>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~martijnbraam/pmos-upstream@lists.sr.ht,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for sensortek
Date:   Wed,  3 Jul 2019 20:05:57 +0200
Message-Id: <20190703180604.9840-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sensortek Technology Corp. produces Proximity Sensors with ALS and
Accelerometers.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
This patch series depends on "iio: light: stk3310: Add support for
stk3335", that's curerntly in linux-next.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 342bb23e0a73..d197c9609ea7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -813,6 +813,8 @@ patternProperties:
     description: Semtech Corporation
   "^sensirion,.*":
     description: Sensirion AG
+  "^sensortek,.*":
+    description: Sensortek Technology Corporation
   "^sff,.*":
     description: Small Form Factor Committee
   "^sgd,.*":
-- 
2.22.0

