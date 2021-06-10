Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB383A28DE
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJKBY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 06:01:24 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:33276 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJKBY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 06:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623318986; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TTLliUPITIGp9qJoCkRy9QEboMPfPULvED4DLCYnZ0krf4+/5P41izI9Rr2ju6/jH6
    ZTPt7m9q1x3G5HvpSgvmKNnMQYrcyFmVWNt36K8Y2eqHPo0+vyeGPRJa19/a+KuV+DMy
    QWfh1an9z1NBN3YnCbzR7uBpecjS4WVJCrZ60M7sBK5SjoLd20KQaGFFxNmHD5Fib3uG
    BdYGpsN3DL3A7GdWAo7lmBDT+7o2s3+vf9KqcMuMixeQM41NnJjBAqVs2uiW/cFiA6q6
    6jtDYBHqTbtNACc0QzLct0Osug5Y5kq3GVlm4vBdIJkb9BA+DxrVWI1CCSLj6w75e+Hf
    9iUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318986;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Q3vxYG9DwGWTpHZF0muiHrGzUfeM8Kn9aAfnCoRgf8w=;
    b=lzfKLLYBvGaaShc/XWjIJRXh7frgqdLFFiweCrQkrPiQYGZllU/z6mUtzQxHFsgUdP
    5HX3awpnm/7tDu5TYJaIYuFpeHuHn2bqG0sEkOl5vX+v955hY4QpFofNhAZtVaiOd+kA
    NQsstxFHz85XBs5i5rlUZj46ggYxDEsxuTt6YZO8qHWOGJJ8SfL6Rd74DLIALjeWVByn
    ZeMji+A958+E8zK0xE+nqpIRxoP2x2nqaZNkGanYDD65RsCiTbMAweS9LFF/ZuCqncqa
    uZl5JUx8Z2MAD82YB+kM4Ypwy6NEKCnOZMT3D3OMe/2I0IQjNBsUFInkuO1fSQW3C8vo
    wHAQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318986;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Q3vxYG9DwGWTpHZF0muiHrGzUfeM8Kn9aAfnCoRgf8w=;
    b=lEHXrVIEyRaH5tmEBLJTqhYBjpfmbOPV37r47sOxRSyTLGOwCPyw+IvYVg31HWk9vk
    J7HbpTaB1xn6vIrz76UJd0NxvbrzgKD5gW6FC2TZACfFGuhvXVIIcyIBMK2FHKrDUgAn
    CzNxY4vdPLwfVmaf5PdYwcc8hzDqJ+jCs7W2HL5yMiAnHmKAw11PXKMHLV+mo39/eLpy
    PA1/0SS+I/vITFKTCOyM2uAwAo8FRUcnN5HJnwJGTnYSELYTrj0AAVHVMhe8i5nwYwlj
    GAkNUsZJTIkTSUpFX954zjweBPB+tzzFUdY/dAnSub+iuB612ZgF1tcGHP8+n+l+DYmY
    mEhA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5A9uPso2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 11:56:25 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Laurentiu Palcu <laurentiu.palcu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 4/6] dt-bindings: iio: bma255: Allow multiple interrupts
Date:   Thu, 10 Jun 2021 11:52:58 +0200
Message-Id: <20210610095300.3613-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610095300.3613-1-stephan@gerhold.net>
References: <20210610095300.3613-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMA253 has two interrupt pins (INT1 and INT2) that can be configured
independently. At the moment the bmc150-accel driver does not make use
of them but it might be able to in the future, so it's useful to already
specify all available interrupts in the device tree.

Set maxItems: 2 for interrupts to allow specifying a second one.
This is necessary as preparation to move the bosch,bma254 compatible
from bosch,bma180.yaml to bosch,bma255.yaml since bma180 allows two
interrupts, but BMA254 is better supported by the bmc150-accel driver.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/iio/accel/bosch,bma255.yaml        | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 8afb0fe8ef5c..65b299a5619b 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -32,7 +32,12 @@ properties:
   vddio-supply: true
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    description: |
+      The first interrupt listed must be the one connected to the INT1 pin,
+      the second (optional) interrupt listed must be the one connected to the
+      INT2 pin (if available).
 
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
-- 
2.31.1

