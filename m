Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22F225FEEC
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgIGQMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbgIGQMg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1270421789;
        Mon,  7 Sep 2020 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495155;
        bh=huRRtVQAV4kXuTBNP9D6urMFzmt8KLZCSNdWyYF4x5A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AAhaIjLCHPgSP4hTnbUU5WAX8BN7tc0jQNKZB7arK9c5SQ+dauvzHVbRJp1wFjsaD
         OfpmxIivh9T65EjT7ZKDeaMqKx2zM954N46rSbigDf7q82Vjb6kJUpOqXTWMMMOGt6
         5iqhY+vqX8A2YEuZNS8SXqs9wlQWvLjBVGqvOOt0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 03/25] dt-bindings: iio: adc: exynos-adc: do not require syscon on S5Pv210
Date:   Mon,  7 Sep 2020 18:11:19 +0200
Message-Id: <20200907161141.31034-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC in S5Pv210 does not have ADC phy registers in separate block for
which syscon would be needed.  Remove this requirement to fix dtbs_check
warnings like:

  arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: adc@e1700000: 'samsung,syscon-phandle' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 89b4f9c252a6..75174af72288 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -81,7 +81,6 @@ allOf:
               - samsung,exynos-adc-v2
               - samsung,exynos3250-adc
               - samsung,exynos4212-adc
-              - samsung,s5pv210-adc
     then:
       required:
         - samsung,syscon-phandle
-- 
2.17.1

