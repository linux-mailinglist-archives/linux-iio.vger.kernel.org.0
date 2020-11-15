Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC52B38BA
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgKOTcD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:02 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B7622450;
        Sun, 15 Nov 2020 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468722;
        bh=Y9VRZv8QmXJaUps1gLHyOqX1ST1UIegXHzcwBj9wxfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjnY8I/cMkmpQkM0CTfJNB5SvFH4ttyt90efwXx/arz+J8Xe5MPpV8ltwClgU0kLI
         462J/mBkiqm1hC3/vDoLsIXl/eO/PxO5uZPj0p8iVrEq0hLPn8xIWGkwo42UW+QN/h
         ZEo3Iv8HssGRu7trccEZUUxmolRMqU9oKBJ5cya8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jishnu Prakash <jprakash@codeaurora.org>
Subject: [PATCH 1/9] dt-bindings:iio:qcom-spmi-vadc drop incorrect io-channel-ranges from example
Date:   Sun, 15 Nov 2020 19:29:43 +0000
Message-Id: <20201115192951.1073632-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

io-channel-ranges is a property for io-channel consumers. Here
it is in an example of a provider of channels so doesn't do anything
useful.

Recent additions to dt-schema check this property is only provided
alongside io-channels which is not true here and hence an error is
reported.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reported-by: Rob Herring <robh@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jishnu Prakash <jprakash@codeaurora.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 7f4f827c57a7..95cc705b961b 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -48,8 +48,6 @@ properties:
     description:
       End of conversion interrupt.
 
-  io-channel-ranges: true
-
 required:
   - compatible
   - reg
@@ -249,7 +247,6 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         #io-channel-cells = <1>;
-        io-channel-ranges;
 
         /* Channel node */
         adc-chan@39 {
-- 
2.28.0

