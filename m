Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC573A3DD1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhFKIN6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:58 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.104]:36316 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFKIN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399112; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eEonQJtfTPvaOpT4b3dcPpuo61oJgpLJF3jf8tmvFE7ptJ11ixvZQO+B2sIYr87ZNt
    dj8Ub2uZUBCWTb6UM9fBgsSQMBBbTWFNQ2Fw7nc43PejTll99vS/T+4DnSeP8xDqx26g
    Cr4MlfILLD0pNaKyKSdCXPghBPatV/xjrVRRQGUgR7+JdYwQbNeednxlH7AfCPU12dGP
    +VYLNHLp/jLgzjmxSixPSBpucvF00xZBhaE2IfMrV1JBsKj53p0W1jLGU0HvC8PwIIwt
    eQQi8tAiCWB5bmCMVd6mZ5Pnnmd/wqjbWX+6P9mrMkvwpXgaKHcv7uwmQGMN5yjLWaQY
    s/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399112;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mzhlFtT0uPEpgxtGsCZLk5RpPAfjBTETW3jiAJ+alHo=;
    b=RbD3YhmKpVNTmVV7drwxwKOJhJCC3Fw+iwpS38RCL6nzIqw5gVzqlDIAgRCV0nzowH
    2Wwv5wgSLaz3h4xwshEDOkCl8lPGQnsE8Br71qlv9FW6HDe3k3nUFo4RjiZDauIImAAx
    ho6Z+cGNIHUKjlq7odqfAmiGxqMyRD2ZspB6omiQd0vAuJjPtPFf9j/oZnYCLE5G9T1A
    XTFkrNk5qHb6FM87NOgwFZJB7Au+sqjzNgzd2/wfzCoaUXaejs93sW2Vcv0qJcI6uxRQ
    E61ZlU6VW0UR+UIkqD610qJAqNvZo1458AKCEt+yp6cgfS3SPGGTQ/wSrv/O2wxcJxLP
    0Mww==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399112;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mzhlFtT0uPEpgxtGsCZLk5RpPAfjBTETW3jiAJ+alHo=;
    b=Fn/tioDmXK0mcc0fyDASjMc/HgeDWtYoUhKz6KzTLatO8L7NemRHvSL52NGE+5S94p
    BP2ydg8RGB2AeZiidm1kR4qMr7xDIjkUpcU3/56RCW9opI08eeSQ1tsVbsVLVmJD/Lyc
    eemev7sQ8RBm7SGr/lGF57y5Kq6v9ehvibNdSs+oQSmsa0tTZ45FsJtaD2OK9ZDlvalR
    PzHqp3sZbMQfj/gfIgxRGiphCxZ/IAs60B2OmP7pS070SHjrKr/OodkOva/oRqhl5H/V
    R279lOZ3oCpUFvHIXYxdxSnL9bsbEk4JkFZrtto2yoPOt+crbw25aU5H2FhJBT00lJ1l
    Njow==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bq02k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:52 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 06/10] dt-bindings: iio: accel: bma255: Document bosch,bma253
Date:   Fri, 11 Jun 2021 10:08:59 +0200
Message-Id: <20210611080903.14384-7-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMA253 is mostly like BMA255 that is already supported by the
bmc150-accel driver. Document an extra bosch,bma253 compatible for it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index c2efbb813ca2..8afb0fe8ef5c 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - bosch,bmc150_accel
       - bosch,bmi055_accel
+      - bosch,bma253
       - bosch,bma255
       - bosch,bma250e
       - bosch,bma222
-- 
2.32.0

