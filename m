Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5342A1986
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgJaS0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaS0j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:26:39 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8837520709;
        Sat, 31 Oct 2020 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168798;
        bh=iG4tEeMkuEN1CjPDrAJAVJqqu/0GAuYu7rHxJfcwEh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wqS9/8BwBiYbW0ULplEDBToNq1SznyfAKwUbxV6XQeYTSwDigiVowT8Ktx3TzeQ9Q
         enr/GAIrB4QSDbI+IUiGfRk1g4sQdoHIsVMX1WxnzsRkThugBwGmyOOJAQXySGok0H
         7EIv99V96O4Nmekn4dp/Q+cYTl94tJFwzey4iBtM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH 3/3] dt-bindings:iio:adc:adi,ad7292: Use new adc.yaml binding for channels.
Date:   Sat, 31 Oct 2020 18:24:23 +0000
Message-Id: <20201031182423.742798-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182423.742798-1-jic23@kernel.org>
References: <20201031182423.742798-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also add additionalProperties: false for the child nodes.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
index 108d202b288f..a3e39a40c9b3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -45,10 +45,10 @@ required:
 
 patternProperties:
   "^channel@[0-7]$":
+    $ref: "adc.yaml"
     type: object
     description: |
       Represents the external channels which are connected to the ADC.
-      See Documentation/devicetree/bindings/iio/adc/adc.txt.
 
     properties:
       reg:
@@ -58,13 +58,13 @@ patternProperties:
           - minimum: 0
             maximum: 7
 
-      diff-channels:
-        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
-        maxItems: 1
+      diff-channels: true
 
     required:
       - reg
 
+    additionalProperties: true
+
 additionalProperties: false
 
 examples:
-- 
2.28.0

