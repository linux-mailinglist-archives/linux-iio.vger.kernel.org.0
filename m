Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB15513883C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2020 21:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbgALUdb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jan 2020 15:33:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34713 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732960AbgALUdb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jan 2020 15:33:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id z22so7772904ljg.1;
        Sun, 12 Jan 2020 12:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEXS1Fk5NwKMmzWNoapPYNtdz3Lk1NcwWzzA/BJNXDg=;
        b=UpBX2EaY5SAVsaubaMJ7OUg/H+3PFwPFWA3+VizPmtV1FrcMOEUvg+jy+QNcADa0EW
         wlNKY2usPqmqXZa2RtNx5iAIPpV1lDnV7ivg+LuzaK+mjELcnRZAtiDZyoQe1eOFVkBY
         Z5u9KtBWEuP5/dXv8h9b50GvFyS1sGqe5OM8+02k/rgagrofWkXwBLMai/gcMtXOJi3k
         47sMBOgzgLy9n/kbh73QTfpghPMSn9xGgZ3A4zL4X8TDzmhF0HcjwjxgQ7AuBwfcmWXc
         RBsILhJ3F8f1o5OCgBjh1OFvhsdXIrTfDIQd++tnCXaBDx+oD7dmjl0AwdUFKK0XdJK/
         FDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEXS1Fk5NwKMmzWNoapPYNtdz3Lk1NcwWzzA/BJNXDg=;
        b=gDdREcjrq7ntvFyn7HDVRlrHrkfIxpgeb8oLb6+ZKFeGWoU+25/+YjOJs3wgJfxRDy
         CyPgutGbmEvLXikMi3/SW0Y3UnychC1+kGIlPFCZcyXxN8OGgiSv/2Nk+qur65ltJKg3
         P0pP8y4Yne7fHo9O4V7GtHDrab1w9a6vNCEj1BBKQG++MXfNZsfV72QZ9ZZhPshBlvN/
         B4babSnuWDhROf2m6/puNTVPASnXa32wX0lmKp0SacgWyCcZxnTFt0jERwGb/JBHtdAs
         1QOs2OZjfkYEEcgYsYdNCUaS+27D39/I767SLNrlFs8zDla+4Ap4LBhFG7LkicOY0utN
         +qsA==
X-Gm-Message-State: APjAAAXCKQDhGUSpkbz/cyu75FOa6e87HJTfBpoWPiwPqzPI4LH4uK4j
        cn0d6DKD+P9zpnJ1s8FIuKI=
X-Google-Smtp-Source: APXvYqwVk17pUy2k573QCR+qFhYjB4UrRtNQEr+dE2/IAp0CfNsasaxxBu5SgNftYikvEYvHIr6TuQ==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr9097471ljg.144.1578861209411;
        Sun, 12 Jan 2020 12:33:29 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u16sm5255192lfi.36.2020.01.12.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 12:33:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: iio: accel: kxcjk1013: Document mount-matrix property
Date:   Sun, 12 Jan 2020 23:33:01 +0300
Message-Id: <20200112203301.30235-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112203301.30235-1-digetx@gmail.com>
References: <20200112203301.30235-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The generic IIO mount-matrix property conveys physical orientation of the
hardware chip.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/iio/accel/kionix,kxcjk1013.txt     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
index eb76a02e2a82..ce950e162d5d 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
@@ -9,9 +9,16 @@ Required properties:
     "kionix,kxtf9"
  - reg: i2c slave address
 
+Optional properties:
+
+  - mount-matrix: an optional 3x3 mounting rotation matrix
+
 Example:
 
 kxtf9@f {
 	compatible = "kionix,kxtf9";
 	reg = <0x0F>;
+	mount-matrix =	"0", "1", "0",
+			"1", "0", "0",
+			"0", "0", "1";
 };
-- 
2.24.0

