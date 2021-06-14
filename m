Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2373A6BE8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhFNQgm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 12:36:42 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:8538 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhFNQgm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 12:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623688472; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nbR6mWDd243J3k2HuVYGvdPPeMfLBmtFICeAgkA4w97WXzchLnL+ih2bD9ZyOPQYcQ
    JOmBVY35GUaVr00dCwK6oVitCgA8/F+NPE415rqvcdndxATdC9YwSwi7xCFd8Wy52HmH
    oIqZFtLyrv+vSEl76kTFNJhFAJPgUorOPzD7n27Pe2sOixUKhTr1KvjtScZh934QRfbA
    eCFdVxrT7330dcQyIkDGmcXFbmI63ngB1TSPWQfSYRxa1wU2F258Fa6GBdIS2WK7OMH0
    5psgYL7msweXEXAgghdlcjCrCF+PaqewyLPsW2Nt6vreD3+znpF2GXUZ0iFdzeK7K8vi
    C97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623688472;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Lv8RLjDS2Zjs8oIsPVIv8YQWYQQ2/u1oHQyLb7NkEVo=;
    b=Jv5nvcrgxTKiAxdcZhuyNrfjaPrcNcqfa7dC3ar09KmV1Efx8lcvG6YMyNgV7QzM6P
    l1DnjHKZ7Jhj61D2eB6vZHqHmtDBf4R2TtPYjby0lh5uHMmyDH6DFmTbcrLPAR7y6X0E
    Ntq2AbnZdHEHVPvRw7WOFqdIB4npR6np4Jxzelv40CJREZl4ODgFF3YBYUq5s4XyQqm4
    S8KCAAFooQM/R5+Is3p5mcCmcHuxg2Dd30DIkhBB2f7WgctDVj6Br1mislD74mSFy2Yi
    2TRLQJI5wMqUVA2v2EpS854lDP9t29IDevULcbzqxIe+iod5y0ersYO3/VnaJA6jCOIR
    Fd/w==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623688472;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Lv8RLjDS2Zjs8oIsPVIv8YQWYQQ2/u1oHQyLb7NkEVo=;
    b=V8E+BJoynFwz/ow4sdObaxTPuiPMW6pbWCy35zxwuMZh+fuXxaJwRqXQ70xpfkLWmC
    sk/rd9lbLLLi9OTZV3cTSW9UcNPeGKkyDJ28d9sHWycV0vRmAv0WSSO52Ctphxhialq0
    1vAOPfdG+BD6sxHJKnDoZp15CNKRU7DQM4ANoJkBIx+blcVzG8BTnHnPNuSsCo5JQFDx
    6x1K/pyu1Y8cTog3YvqNpBA65q1pSPKF87QD9TKD7QR5+Yf1NFaID+A2RtEzMigD+Niw
    EUF1uNmwab3FcXuaC/NZawS+M+uayFjG7ka52tcR52s4vDnuoj9VOWwVpxgqEN52e7o7
    eLGA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6NvdbT"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5EGYWJ6s
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 14 Jun 2021 18:34:32 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/3] dt-bindings: iio: accel: bma255: Fix interrupt type / merge bma180
Date:   Mon, 14 Jun 2021 18:31:47 +0200
Message-Id: <20210614163150.7774-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series first fixes the interrupt type in the
bosch,bma255.yaml schema and then combines it with the
bosch,bma180.yaml schema since they are pretty much identical.

Stephan Gerhold (3):
  dt-bindings: iio: accel: bma255: Fix interrupt type
  dt-bindings: iio: accel: bma255: Sort compatibles
  dt-bindings: iio: accel: bma255: Merge bosch,bma180 schema

 .../bindings/iio/accel/bosch,bma180.yaml      | 61 -------------------
 .../bindings/iio/accel/bosch,bma255.yaml      | 23 ++++---
 2 files changed, 16 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml

-- 
2.32.0

