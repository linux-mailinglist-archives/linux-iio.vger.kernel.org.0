Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6896A4242DE
	for <lists+linux-iio@lfdr.de>; Wed,  6 Oct 2021 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhJFQku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Oct 2021 12:40:50 -0400
Received: from box.trvn.ru ([194.87.146.52]:56661 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232027AbhJFQkt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 Oct 2021 12:40:49 -0400
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 4F8DE403D6;
        Wed,  6 Oct 2021 21:31:13 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1633537876; bh=owVziXtaEOSRnp0UZO9k8u+7DK0W6uABm5+DZhQVhh8=;
        h=From:To:Cc:Subject:Date:From;
        b=Q4uIKF0w0HpOKcy5YOQwgcjd3flZ1UZ5uJ8AZr56WPeuuPcFhtTFoRa9XlzVKwFod
         6KSm4samyutKJtCo32sIopzpS05Ie7c/VBi0PKq/TNVeAuNllyYsS0Vs7OI2ccpH46
         N0lhhx4bggK4OXw9a1MvWp+ay/Q5MrBV/Ur8Amz+iO7yYFjfNd/tNLmrBNn/Q1rS1H
         /1vnC/Hd3eqU8hMKbYKdAYC9uRsmsiEwwd916is4vVPiG2Ry5zXzqZbyIpsf0SAwC8
         XlIiWJmRDunhUJ85i0RfYOLPJ1leNhWxsLaTpqUR32eh/+jkQI4VzaeggKBKz6JlDO
         HEksH/LEiU90w==
From:   Nikita Travkin <nikita@trvn.ru>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, stephan@gerhold.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Document liteon vendor prefix
Date:   Wed,  6 Oct 2021 21:30:55 +0500
Message-Id: <20211006163058.145842-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add vendor prefix for LITE-ON Technology Corp.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1d77f151555b..477a5cba16fe 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -659,6 +659,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^liteon,.*":
+    description: LITE-ON Technology Corp.
   "^litex,.*":
     description: LiteX SoC builder
   "^lltc,.*":
-- 
2.30.2

