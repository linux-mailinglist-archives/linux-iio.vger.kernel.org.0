Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6695937A430
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhEKKDh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 06:03:37 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:13239 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhEKKDg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 06:03:36 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 06:03:36 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1620726992; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J2ta0a5yVvTxVt9J/zfd9aOXPeFoaQ/95y29vfwx51LNBjV813C4lFgmLLdUfQPSWk
    VYSdk/vNR8/IFiB+Z4xx0gmhPwpzEwlx+zqYDsbHW1eKtR8n5NJXTB0MXC4TLuoPOgDN
    iPrg3vcr24LpeBRXQepgD505Td+KpHVhSyxXLZZDSsPMvUlirQ1co4r0fk4GCVaqnXjL
    ieBykutrQMvuhjMHeUPVKWCujoQEe+a7Ry7Tg6ZUTgobd4NrZ92MuJl3SLW9oqbGBUTF
    xE3c7rwnl8fqzcSCt4e6RNEc1tFFmxM/06FRfjcgQ9adAsNxSqwqlqol9eIxuA5s/WyQ
    wQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620726992;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RGYVmoRtdZgczF6ucMTYojAPveEDlGD8oZ1ug/swBjk=;
    b=Y9cRz8M8psv2fSGORNW5y0MyGpuejjRhtHVN8Qz6TUUNDXJcODNtyOkdeYNHa4Roef
    ImUWI9H6Y/dSAARl6LwAWfu7TCUy/TJemgaeimjJeR8PrGyI1TVa8oPOEQc+Bss+4CEw
    p+p2ukatzAMQeVPNVNtEx4061WGAWMubMZuoBcJaolL1YN2b0mZZdnhODMa9P0VFQXoT
    IjLcAMy5LzhvnFGp3dVQ42GZRBP+GkaDVCH+IKNpEuBFs96LskHKY3wITBe3Acjnx/88
    GxoqJ3ZMOCR+vLq1a12WW+/Ghd3Tc69RC1ehzwT1KSXD4g7v02n6k/MBf99MsaapoG+q
    ONfA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620726992;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RGYVmoRtdZgczF6ucMTYojAPveEDlGD8oZ1ug/swBjk=;
    b=K5b9dBxt+xUCKQELyTCzfcJKVV9WQdfq1FQ3SgZUoEUmAG+zH4G5slEYiDXlPv1WpN
    +bw5SPZW4YlM6HFdRjNSN17k6169fDtfvUR+Mh3pmPBb+MqTdgLWOA0s2GPo2AdkCwYt
    tmLUs7r9wldKz8KKk9LaLt5ArekdpNm9ncun7hVk8lm5nBgLBsorGGHHCMOUThuY0DSj
    9PkIfwA0BXoyJy17TvpH5Iz1894Tsel8gqkMoMnMVHfzlOECtdwhS+dkHkksKTuqiMzJ
    G42H4r5vSBV8yTItGODNZ8aicBCIKEvh7WaP4+W4h558XujsTkQiRSUNWZQIScY/HHaE
    L6Yw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6ONKhX"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id R01591x4B9uW06F
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 11:56:32 +0200 (CEST)
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
Subject: [PATCH 1/3] dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
Date:   Tue, 11 May 2021 11:54:07 +0200
Message-Id: <20210511095409.9290-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511095409.9290-1-stephan@gerhold.net>
References: <20210511095409.9290-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The KX023-1025 accelerometer uses similar register bits as kxcjk1023,
so it can make use of the same driver. Document the new kionix,kx023-1025
compatible that is also supported by the kxcjk-1013 driver now.

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

