Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246BC2A1984
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgJaS0h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaS0h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:26:37 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EB0206E3;
        Sat, 31 Oct 2020 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168797;
        bh=b9Dh/bWwe6lmZSkFVinTczSbW5JZfK3sKEJgcUr6r5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmRU2eXv5KRFzNrbMzv2zZcJ1d6i0OqyifW9bpuf0xtrI/OwYav7W/QWiCyQR8Snk
         VrlTrAW6LHKfM8HYHy4rMgRHgaPPIZmcIAIpLiAbzlsCE9zCP/pe1+XIKlbYjPRPMa
         1PS6lU4CnEdmKi6Wvj93IpuPjDxu6L8mReLBCoOo=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 2/3] dt-bindings:iio:adc:adi,ad7124: Use the new adc.yaml channel binding
Date:   Sat, 31 Oct 2020 18:24:22 +0000
Message-Id: <20201031182423.742798-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182423.742798-1-jic23@kernel.org>
References: <20201031182423.742798-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This both ensures this binding is compliant with the generic properties
and reduces the amount we need to specify in this separate binding.

Whilst here mark the child node as additionalProperties: false

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index f1c574c896cb..fb3d0dae9bae 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -63,10 +63,10 @@ required:
 
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
+    $ref: "adc.yaml"
     type: object
     description: |
       Represents the external channels which are connected to the ADC.
-      See Documentation/devicetree/bindings/iio/adc/adc.txt.
 
     properties:
       reg:
@@ -88,15 +88,9 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1, 3]
 
-      diff-channels:
-        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
-        items:
-          minimum: 0
-          maximum: 15
+      diff-channels: true
 
-      bipolar:
-        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
-        type: boolean
+      bipolar: true
 
       adi,buffered-positive:
         description: Enable buffered mode for positive input.
@@ -110,6 +104,8 @@ patternProperties:
       - reg
       - diff-channels
 
+    additionalProperties: false
+
 additionalProperties: false
 
 examples:
-- 
2.28.0

