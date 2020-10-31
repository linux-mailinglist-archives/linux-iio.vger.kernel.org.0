Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80B22A1A21
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgJaSwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgJaSwf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65CD2072C;
        Sat, 31 Oct 2020 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170354;
        bh=MELyhTcu0o8qVgu/wSpV74BV8KVA1g7r1Xgta+7Lbiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jE4VO6NIbSr9atTl1qjUojZJA50LJkssDkEyDGbeuUe4tE5jokZ8xCFGEd336GhV6
         6JMliLNNUL8/KNpPCzAgcKKpnmn0dWrSqtqPnsuQVutcCBcFuTRHTUufogm7Qy4bNB
         YfoTATWr2DFkzNG4ao6q9vG8C71NGB6cAbHQMcZI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 46/46] dt-bindings:iio:temperature: Drop generic binding file.
Date:   Sat, 31 Oct 2020 18:48:54 +0000
Message-Id: <20201031184854.745828-47-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

So far, the thermocouple-type property described in here is only
used in a single driver.  Whilst I would like it to be more generally
used that hasn't happened yet and I don't see a reason to maintain
this small file in the hope that it happens.

I pushed for this generic binding in the first place.  Hopefully
we can bring it back at somepoint.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
---
 .../bindings/iio/temperature/temperature-bindings.txt      | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
deleted file mode 100644
index 8f339cab74ae..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-If the temperature sensor device can be configured to use some specific
-thermocouple type, you can use the defined types provided in the file
-"include/dt-bindings/iio/temperature/thermocouple.h".
-
-Property:
-thermocouple-type:	A single cell representing the type of the thermocouple
-			used by the device.
-- 
2.28.0

