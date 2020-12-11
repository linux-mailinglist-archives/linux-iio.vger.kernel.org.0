Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6AD2D7E45
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 19:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgLKSmX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 13:42:23 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:33289 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgLKSmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 13:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607711951;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
        bh=lntMdrL2vzHYJajzbCu4672DSUcaxlayS8rnWeVRSw0=;
        b=oLgJkq1lewSEdRLXc3b9xfnapBTT6u+/OFJLi8JxVmt5qbBVy5hGIV0kGnMIK4G2B8
        4cWdxrxGstvt601Rs+AsSSHsgfK14NNWMtBu0ER26FxDpFSDpZEBuCFrF7lYcneKKL02
        Oe4Bk/moQmKpzRWXvAENbMCuppfY3srbXazzIxl2TgdGo1s6fU4ESCpAF8gWAGkOyGNr
        KlbTDOarYZnaU+tUi8RsRlO7Efc54EUPzn69ogpgj+IOpIN1+iGwODVwq0elrtbrQemK
        8a/vyDPdYL+iA64ZCLuzALSW+2we5r3Y/BP/GcBEs9DERLjtn2JLTD/c0a0n2FoS9IH4
        1G1w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626OARkI"
X-RZG-CLASS-ID: mo00
Received: from droid..
        by smtp.strato.de (RZmta 47.7.1 DYNA|AUTH)
        with ESMTPSA id 409b08wBBId34ec
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 11 Dec 2020 19:39:03 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: gyroscope: bmg160: Document regulator supplies
Date:   Fri, 11 Dec 2020 19:38:14 +0100
Message-Id: <20201211183815.51269-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMG160 needs VDD and VDDIO regulators that might need to be explicitly
enabled. Document support for vdd/vddio-supply to implement this.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
  - Split from patches for bmc150
  - Add Reviewed-by:
---
 .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index 0466483be6bb..b6bbc312a7cf 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -19,6 +19,9 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply: true
+  vddio-supply: true
+
   interrupts:
     minItems: 1
     description:
-- 
2.29.2

