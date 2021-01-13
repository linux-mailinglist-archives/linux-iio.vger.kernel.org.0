Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD72F4955
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jan 2021 12:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbhAMLBJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jan 2021 06:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbhAMLBI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Jan 2021 06:01:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38CB923442;
        Wed, 13 Jan 2021 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=ykEet3EI/ADgoSKLzwNCpDq7KddS6zlSWibH/hw3RFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pb8I5UUyyDvOrvpxjCKIOB44foG974g42MpJ2ltWAXtOfUkw9hiw23WnDYMCpkEhw
         NGHs9nDMbvjjR0OoYE8XNOsAVgPvZFjppLLMKK6NiDRBQjEMxEVVNa5H7VnFRSZQCu
         cjrpekabgfWQlW9b7PCrNZksJjecEwy1e7CQ5oqlJMnvD51UKJYlfQbT/vvI9V74dv
         7vQWzIhGGY4AOAck26cnmfmwvZHFbqOKua7VUKrBxC3UJxkvJOenY6jygGGWHcL0s5
         KhL2LWwI7CY7wdEfdCnh4l50G9lUSnhgJg93kbArxdYGJ6uyltlP2HGs7vTNK+HPC2
         +mY0mFpaokIrQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGr-TO; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/24] dt-bindings:iio:adc: update adc.yaml reference
Date:   Wed, 13 Jan 2021 11:59:24 +0100
Message-Id: <8e37dba8ae9099acd649bab8a1cf718caa4f3e6a.1610535350.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changeset b70d154d6558 ("dt-bindings:iio:adc: convert adc.txt to yaml")
renamed: Documentation/devicetree/bindings/iio/adc/adc.txt
to: Documentation/devicetree/bindings/iio/adc/adc.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index e0cc3b2e8957..22b7ed3723f6 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -80,7 +80,7 @@ properties:
     type: boolean
 
   bipolar:
-    description: see Documentation/devicetree/bindings/iio/adc/adc.txt
+    description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
     type: boolean
 
 required:
-- 
2.29.2

