Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA804D4CA8
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 06:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfJLEKH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 12 Oct 2019 00:10:07 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17423 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbfJLEKH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 00:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570853390; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=BiBxH7KhDmOsnDqop5h4o5bbhozBryZ5DZ4MnjiyLqrHcjpXgjtWQdPtJZR2g1k4jAfpVpHSl6qJGGRNVft3a08tdWmLcRklpSHYJBlLt0dKmKJWrlIDiOqBVTbbD/ZIME0vDpbMC3NMEt8zEpmPvXF+tjMse7+UJ9tQOaqDBEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570853390; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oeTxi5QaruJPoVyBCiNl4Xp3VAv0VaEjwtZzHVJ/nEs=; 
        b=n0eMBkfevNxPQW3wycKS0lDBtWO8s1z4LAclr+L20ghRlbZJwQBL1GAmQWzvbjO8xQu/qsuL1gCdjSM4x7HbVj3kX8si2HPnUU3QyZWWAS3yXkjQED9JKITOvTPJstYJx6HdeX/YzeoEkQSmSJRWtcmMR6zAr7CSndY6vIY1yqA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 157085338873220.028522707521006; Fri, 11 Oct 2019 21:09:48 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191012035420.13904-2-dan@dlrobertson.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: accel: bma400: add bindings
Date:   Sat, 12 Oct 2019 03:54:19 +0000
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012035420.13904-1-dan@dlrobertson.com>
References: <20191012035420.13904-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
accelerometer sensor.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 .../devicetree/bindings/iio/accel/bma400.txt     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bma400.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/bma400.txt b/Documentation/devicetree/bindings/iio/accel/bma400.txt
new file mode 100644
index 000000000000..abba4f104941
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bma400.txt
@@ -0,0 +1,16 @@
+
+* Bosch BMA400 triaxial acceleration sensor
+
+https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf
+
+Required properties:
+
+  - compatible : should be "bosch,bma400"
+  - reg : the I2C address of the sensor
+
+Example:
+
+bma400@14 {
+	compatible = "bosch,bma400";
+	reg = <0x14>;
+};


