Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B91CEDFC62
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 05:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfJVD4f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 23:56:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41734 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbfJVD4f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 23:56:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so9091310pga.8;
        Mon, 21 Oct 2019 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQpTtZM/y7qP8DVtXmZT0zjDljcg+h3NWyKjsVAn7Xw=;
        b=XXU/xjF64L/4degM8Hl+Xc3iqW37zWSuv0EPTS2tbPWlUNinGZGD8iwgEJN5+mA6BO
         biQPbuWTu/GMguYnrSih+BBVsWIJlun9jDpRCfx1QHBb5OnorOnc6FFiqu4nEJ2R5LkV
         aEqU3JOtw8DyU9FrYeWqRPgvN7nC6ieWtl23ll4DEdrrUvPVGHdaXLCksexnWExGO5eN
         UGS6FM3LUeHs71LCLPmGC3V6NzcCiH+WH8LWBtyqD3CF1Q0go5kuU98Zs1mzEpHKyRAJ
         lgjHir0+yBlquSTOlkjGb6LElGpVB+RKpxHQn+7Nl8PeIlPCrkwC70kgaKEokapGxqy6
         biRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQpTtZM/y7qP8DVtXmZT0zjDljcg+h3NWyKjsVAn7Xw=;
        b=Tr5YHc0L1tcp9TpdM9PWeFShYZ1n6rgCA/q57L6YYqvzSEsbbbr560UF7cFZmiqD1o
         xO35HQUiW+mokLUWd8xx7C6ewHBWWkooJfRzv220+8KZNo6vVVrFzYnB0LRKGoHZ+XLQ
         DVmZry2WTzAm+CGHwdZ7Ji1zGwvn1ni3SiaML0jNR49bc1vLCwwgoPWhFa7DHrFM2uCv
         ShMPq35R2PDjy5A4IsC7ppjkxUjmmSctSyAqdiB/KSkIDqHLZymSoFnZUhqvnS4gFAGu
         Pky1IWITx0RWQlL8/bRRbxBauggRvoc9wLvJuM15BUw5z8f4kdfzc6AYt1XY9pH5JAYw
         82Vg==
X-Gm-Message-State: APjAAAXdpAz9sTlygsnQ4i2iOeipI0b+zCm9OwlaDavf8OgMsO9ySRRd
        wGD9y4JQcywrX/xHV1sGZsqj3ANC
X-Google-Smtp-Source: APXvYqzazOxR80J2OqRZUk9yky/b+C+CGXJTxn2/FjuXPiDf2Tob/yx8o6Qs10Z6X487h8pmc1VV0g==
X-Received: by 2002:a62:28b:: with SMTP id 133mr1691809pfc.242.1571716592662;
        Mon, 21 Oct 2019 20:56:32 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id l22sm14955769pgj.4.2019.10.21.20.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 20:56:31 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mma8452: Re-word 'interrupt-names' description
Date:   Mon, 21 Oct 2019 20:56:26 -0700
Message-Id: <20191022035626.13002-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Current wording in the binding documentation doesn't make it 100%
clear that only one of "INT1" and "INT2" will ever be used by the
driver and that specifying both has no advantages. Re-word it to make
this aspect a bit more explicit.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/iio/accel/mma8452.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
index e132394375a1..b27b6bee9eb6 100644
--- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
+++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
@@ -17,7 +17,7 @@ Optional properties:
 
   - interrupts: interrupt mapping for GPIO IRQ
 
-  - interrupt-names: should contain "INT1" and/or "INT2", the accelerometer's
+  - interrupt-names: should contain "INT1" or "INT2", the accelerometer's
 		     interrupt line in use.
 
   - vdd-supply: phandle to the regulator that provides vdd power to the accelerometer.
-- 
2.21.0

