Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE892649D5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIJQcy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 12:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgIJQU1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 12:20:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC5321D79;
        Thu, 10 Sep 2020 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599754785;
        bh=XL/yLUGWGiJdk/mhoX+RmpLCAvn1heVhfC4nRB0t1CQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AhUWISxmRLPEeqyqFN1VIILYUYzcyK30t5NC24oFgTnSStnAQKsb98uImfzCQ+0Tb
         060ktHYZuk7rRnCS/pZu0WUiZV2eTlNmKjc9rjDT6xbGuEMP45nB45vOaLLTIreiws
         LWEqENAeNFCTmrP4l0prN77w+e/mcGDOlHhB6ZGM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: exynos-adc: do not require syscon on S5Pv210
Date:   Thu, 10 Sep 2020 18:19:33 +0200
Message-Id: <20200910161933.9156-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910161933.9156-1-krzk@kernel.org>
References: <20200910161933.9156-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC in S5Pv210 does not have ADC phy registers in separate block for
which syscon would be needed.  Remove this requirement to fix dtbs_check
warnings like:

  arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: adc@e1700000: 'samsung,syscon-phandle' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

---

Changes since v1:
1. Add Ack.
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 17a08be3fe85..37d6591ff78c 100644
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

