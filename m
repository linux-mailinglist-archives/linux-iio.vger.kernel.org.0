Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA2A2CB8FA
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 10:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbgLBJgc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 04:36:32 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:28837 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgLBJgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 04:36:32 -0500
X-Greylist: delayed 3422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 04:36:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606901620;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=SG5xVAaGLAUccFX3LQt43sv4uywqw6E+YEUD++Uwcsc=;
        b=kmxJXywnRsrl+TnJeskU0TTrASPzmnoObUpI+rZHMvz9ruV5yjqJN+WYrSY+aYfa9v
        D1l8XjOmmSFUGh8HMcHdUs3JmWO30vjccFJhfVQXUc83faRlwHmUhlUvqOzNjU6OQpBh
        VhgPzsjnBJ225rDyVkrtfeAz6hAH7DfFbL0wkrDa55zIxhyde3cNcDBfIZEl9YQk5GcT
        eOaJcg+ZJH0MrEujfLxgl3UoN7+L2i9xQC6EgFsiVnjZXbWh27b0ocU1na4MJ264WCHq
        n3nvS94RU/DwcYYfJwkhxe/W7Ycv/XaEfQusUX2xcj2iKxeOLzl4+wI++kDLqlGQFnkT
        r8vw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626NJkxR"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB29XcVud
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 10:33:38 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/4] dt-bindings: iio: gyroscope: bmg160: Document regulator supplies
Date:   Wed,  2 Dec 2020 10:33:21 +0100
Message-Id: <20201202093322.77114-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202093322.77114-1-stephan@gerhold.net>
References: <20201202093322.77114-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMG160 needs VDD and VDDIO regulators that might need to be explicitly
enabled. Document support for vdd/vddio-supply to implement this.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
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

