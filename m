Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE72F00D6
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbhAIPaH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 10:30:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:14592 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbhAIPaH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2021 10:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610206035;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
        bh=3mOuEVJy/DLRACmMhFfXQTMELVOdizr65zb2vOtbg3Q=;
        b=NjC4LMyuqlzSIZBCgnvV8VDunCH535zHddoy60i1O9VA1+2wwNdis/OT0YdQbaWGgj
        jXqrgqCzkC/RX85GECFHXAlR+XlBaHuf8Rz6rsWu+GEOgWvdgRCpkP39NnDANE3qNipq
        dLpcXNCT/IxHp6FJdUEtVf1dkKHYtBvSzi3//L0/CXMQ6UlGn04irctw/VOzN8GUN6vb
        MS+Y7GtoXgrbBrBjqWg/phtLUxGCjcq4DL6J+Xai8nEBZk3am23t0hb0fm6ErKnaGxae
        g3lmRAAX2E9VExRxMmuZmWk3N4z8C8LNHRM8QlonBYNJEOyt8YAgHvW0xo51H6DGdvRv
        +yDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5W6NRVg="
X-RZG-CLASS-ID: mo00
Received: from droid..
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id R0a218x09FO3UP3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 9 Jan 2021 16:24:03 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: magnetometer: bmc150: Document regulator supplies
Date:   Sat,  9 Jan 2021 16:23:26 +0100
Message-Id: <20210109152327.512538-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMC150 needs VDD and VDDIO regulators that might need to be explicitly
enabled. Document support for vdd/vddio-supply to implement this.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2: Picked up Reviewed-by:, split patch series from bmg160
---
 .../bindings/iio/magnetometer/bosch,bmc150_magn.yaml           | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
index cdef7aeba708..2867ab6bf9b0 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
@@ -30,6 +30,9 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply: true
+  vddio-supply: true
+
   interrupts:
     maxItems: 1
 
-- 
2.30.0

