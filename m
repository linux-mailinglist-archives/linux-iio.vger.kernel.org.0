Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8139A37A91D
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhEKO00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:26:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:31928 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhEKO00 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 10:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620743105; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FcAVKS3UNpLQ8gj8eAghEpOPRQFEwSbn2aGZC1YYtXjLiPqhK89rW6pb/+zIZl7zum
    9lZRlFmnzOqmC3f/yvpPAMQQAW8nBUWSspqmtNanpP31NmYZ6xsWYdQyfen1Z4Hteo2o
    Mgv22y0N7cOl0FxnG124PLYVKq7240aN+mKs6lf2kLJ3jPg5zD4RoDWKH0mNXT3RuCNe
    acfk6fAzaQuHYg5nswnQ6KZ3J0vsRAjIoWVMqwR7ikkIiHE7nX89b3jD33VGkr89vYTR
    OyzBhhkBHnn1nOK1Tm/atfF42jvXXaue4+vV0mYuSOfa3EtOEonySId7yTjjtNnQIIhH
    szfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620743105;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7yyxdVM6KYbZoGA9Q0XvOMSAphuounGt4Tz7A3rbIGQ=;
    b=mkSeNJCwzcDuypwBr21kBOwOmNht/n01Ptxgnq36CAqtVDLot/tvSDjxDsDBY3q6iV
    yWpRdbiLuCPC9UO6UGoMTt0RCTb+meBWpEQoSuUg2XcUwFYUJ9WoCq7wMYbZStGX+psL
    6mv5/h0WfnVk7+PrsYYAR5MMjGlkAjYfn2Ds9wE7M0nc5ymAcaFqClCmCPPZGTEd9YA6
    y9xZDmN4hC7cecQIa4umRnrv1cV/ApJibRAQmpSumWOxt5e94Ayg2wiVOBdn9GauC3Hz
    ROMY6NSj8IIPrQVJkDJEG0gEtYV7rWw13UGRFbMwfGuMuhB63QRrzIcU/NrTnnn0DZzu
    GldQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620743105;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7yyxdVM6KYbZoGA9Q0XvOMSAphuounGt4Tz7A3rbIGQ=;
    b=cV/YL3173mkXQA1ahlkNXLpQPl7xdcwsPZH9oFUHDfYoNI/if9MfXRVVtk9oo5IP3x
    hvM7PTjM8mjGM45dGtPzCAj14iA1YkHEvIufGSRgVlQFa2NvdFHM3Ak1ckcTag2MfvjI
    ljXAXRztHd2J+PK44hBktNT3h4xvC/lGAo21MFR/Lp7KA4TDxCiJyiBxIf9jvI8JcohJ
    Z3CXuo9aaNRCHNu0lRUv0Nmd4NL4SRrI/M0m2bls7exrQgKUbclG8PcKT41/bJNiYmZf
    VclOWOfWQiwPj35w6aJAWksIAjbeQ+L9pp5NwyhsetkW5TukRuZjDV1IghlMrAlU2L3b
    nZqQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6ONKhX"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.25.7 DYNA|AUTH)
    with ESMTPSA id j06c13x4BEP50bk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 16:25:05 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 1/3] dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
Date:   Tue, 11 May 2021 16:24:00 +0200
Message-Id: <20210511142402.4457-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511142402.4457-1-stephan@gerhold.net>
References: <20210511142402.4457-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The KX023-1025 accelerometer uses similar register bits as kxcjk1023,
so it can make use of the same driver. Document the new kionix,kx023-1025
compatible that is also supported by the kxcjk-1013 driver now.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
index fbb714431e3d..52fa0f7c2d0e 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
@@ -16,6 +16,7 @@ properties:
       - kionix,kxcj91008
       - kionix,kxtj21009
       - kionix,kxtf9
+      - kionix,kx023-1025
 
   reg:
     maxItems: 1
-- 
2.31.1

