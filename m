Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EDF468659
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355417AbhLDQ4k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 11:56:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47010 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355398AbhLDQ4j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 11:56:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41CFBB80D15;
        Sat,  4 Dec 2021 16:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED433C341C2;
        Sat,  4 Dec 2021 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638636792;
        bh=7KMkqxurLLFu8Ke0Ky2pGPxgUrkAvgYVdZYtNM12i2c=;
        h=From:To:Cc:Subject:Date:From;
        b=VG1ln+MtVpF5iyAS1g/BeIZ0Z9PhEdBUIwaCjgCgdVCUbY3I01cNihnNXlyk6lcAY
         IGzBbjq5OpQbwJo+dcq7GGqqIu47Z8W3/RjaDBYkpZMjXopxhzarcKbNdyf0FyNlCt
         ekiWt0jQH/rDS3iJjRWh8qd+fMrrdUyv9ye4pFEiuoa6P/nIXKwJSx+zqv4CD+iZH/
         7oEK01IDg9G4bd2bVWSgBs/zct9Bb5Lf5CEct/1zkJKcaVeo2fp3Zkk+1DH3IwMrWz
         dmIenbJfcPBH56jpKdaR5HZ1SueDNZN92kw1ib0nEpHmS5fcPMcu9m/Xt6Yul+Fhss
         VjjMBGU4yZIsw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [PATCH] dt-bindings: iio: dac: adi,ad5755: drop unrelated included.
Date:   Sat,  4 Dec 2021 16:58:17 +0000
Message-Id: <20211204165817.2768110-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Probably a cut and paste error, but the binding header used in the
example is for the wrong device and nothing from it is used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
index be419ac46caa..f866b88e1440 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
@@ -125,7 +125,6 @@ oneOf:
 
 examples:
   - |
-    #include <dt-bindings/iio/adi,ad5592r.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
-- 
2.34.1

