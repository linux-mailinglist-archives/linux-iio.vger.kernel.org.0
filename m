Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592813A28CF
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJJ6a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 05:58:30 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:15075 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJJ63 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 05:58:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623318985; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kL1jJXcE0xo6QWSo9ju02qX17Yja6qia0RHHSaDIPaePqE581EnCVbPLab1M/dr9MY
    BSVxYNH6Gwtzy6fvgAr1DFjPXIsahkBXVHuioozgvBLxfzND4uzyGewwtt8KNlgTiAMM
    fUiJR8yZsD50vf1IbE3hHugPiIQJo0veBWYemaPJIcOT3Sb1B9EqTh4vsCFqhSKoeQpn
    PxFaAlmBVn9CMkG0ggCTHm2fH1LrOayrlBj+g52l0+63+qiCp69n7XchGVOso7URMCvJ
    /aIy2hjwUfyZw8ZUihWkdUzXyxZurJSvfpzqyyEhaQ1PiZV6lUpCivQraZ6oPdoSBSMD
    aYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318985;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FwZnaZ8gRC2vRn8D/qw8fV39RZrjSrX/Xoxl+96C+g4=;
    b=CN5FOKVr8Brm4CDj7PvePzvTTIXEUU6UCeeIvMVP9BQnRESV61V8CQDNz83qwJWHW4
    vEflBz4qq7gE9OrPwNb8Chjj0miHqua+IuDr6Y2EvLn2s6zDlExzeZsqVjoYZuq8qlwb
    LPT1Jk+DboDpIyldBYb6XiVZCeAEpLVfaVajjeHh9xiuxiQnWG4XJJrEDUEDgDfoq0fM
    UOew+Gw4CNuzDbu3zWHaYXM5hceUmkU4Gg1zDeXCEV/+Mfavek+OKFHZBQRWA9e2KjNn
    EyQdpSA5qETdoYx/dqFCWjlGblcLyF+pKuYrztdQltacGsG1CKNCgkpMIDgeH2QU1P3z
    Ewyg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318985;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FwZnaZ8gRC2vRn8D/qw8fV39RZrjSrX/Xoxl+96C+g4=;
    b=CArtXx1t0EXSp1IAED9rA14stamWxSdP3DsLHg9E6P4gDOpYQjFduTIsorOX9EWmZR
    Y7QPGnTKHWpt7eDljrwnukswnql4PtnKVlJd2ifBRV08dmZIe157RvK1iej/nuEv3xZj
    gqR8qDZ7pyS07/gngfFhw9Sb9p+HXGrdi5AA4PzY/wrmlpVzp2+yh/a79eQYlpAMZf6M
    QdT0n0qSyh/Zrmba5cydYEjr8Vk9pZVwSTTXlLFRt3sGI2guqpn1e8mX4DO26qvL0+5p
    s3QcnBswoSsIG35ed7BfwHMY86K+cmEzVeEI9UH19WzsItiFOcAUtcPz2nOZ1htxdVeC
    LNbg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5A9uOso0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 11:56:24 +0200 (CEST)
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
Subject: [PATCH 2/6] dt-bindings: iio: accel: bma255: Document bosch,bma253
Date:   Thu, 10 Jun 2021 11:52:56 +0200
Message-Id: <20210610095300.3613-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610095300.3613-1-stephan@gerhold.net>
References: <20210610095300.3613-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMA253 is mostly like BMA255 that is already supported by the
bmc150-accel driver. Document an extra bosch,bma253 compatible for it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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
2.31.1

