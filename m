Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F09CDEDD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfJGKLC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 06:11:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46133 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfJGKK7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 06:10:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id b8so1559190pgm.13
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2019 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ERqIOKakQGLjInDRvAedMR7AaZNxUUgWN7Nn/dFXW3w=;
        b=nTmBF9EkHgs5UmnhmN0Q+0jbo2Gs/CvFqezpp83LtQ/OvJkcfpqFVUVVFoHDH5zVIU
         6KW2dZit83ws6Wk8ymClNCEq4eZMRarsMxzXqMQIROca7IPlcMrOQzecDlSP4zFbGNKH
         ggZB5mVInKxVNsB8ANhJbO++HEyKiBHZVM25xQKk7XfQZHfe9ceZzB/ieC3Dse/kmQvA
         kWMA9AntTCuAekow6pg8WC65DXMm1oNcbh6BYyHAQQnaa16AWATMxIcXwmgyrRHVmsnC
         yHp7Gl8jukwhz8msKVFta1XWIFx4gJ6JdqFx7LBjeN5lVTkkppE0mDwWdCNUPWDV8zSj
         ygxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ERqIOKakQGLjInDRvAedMR7AaZNxUUgWN7Nn/dFXW3w=;
        b=VgUB5HJmmwAYNKxaTIBCE5Xuq5MKH5yQpk1KlZvecDONaUsYtypt5Ys+VA6XQwdjdp
         XguEaw9Rldxy1jlhGTW6Ycmdoo0Zw06wpx4Kgd7VnMTKGY98aCciARiG61zm1Prjg/Wq
         fjuuxnTfdhFL3BtY7jvuVB3Nif3mrxSFXpq3Rzn5v1fRlOfzYkB+MtbINomxN6LOlMxm
         KKmbKnC2HsJgdllL4V//H05ujvYRxwrFfxNW7x6buyNmvaPushG6pD4g7Rm5DNMLsV8+
         Ozg+0s9lC8WM47f+y6Xho4yvzL5TtuIyOjN0cXG6EZJ3GvufuUvIWVhOvVh7oQBS8BLS
         KPMA==
X-Gm-Message-State: APjAAAW23pt5mLWNkeT8E6H/alZTjGld6e+Lgq7yi6Bt4sQG5z4vgIfK
        SlDAYvbzoohe4rSPOuAyul/V
X-Google-Smtp-Source: APXvYqyb/5tYBVyOuvCN5oePoRjDrJOcZqVo9dWFxVwhAfY/XuYbMQttdfNeerQzgBBYT8EN7n2e/g==
X-Received: by 2002:aa7:953c:: with SMTP id c28mr31981236pfp.106.1570443058066;
        Mon, 07 Oct 2019 03:10:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:801:5b45:54fa:fc3f:2c55:c2df])
        by smtp.gmail.com with ESMTPSA id z4sm17465132pfn.45.2019.10.07.03.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 03:10:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Date:   Mon,  7 Oct 2019 15:40:26 +0530
Message-Id: <20191007101027.8383-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for Analog Devices ADUX1020 Photometric
sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/iio/light/adux1020.txt           | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.txt

diff --git a/Documentation/devicetree/bindings/iio/light/adux1020.txt b/Documentation/devicetree/bindings/iio/light/adux1020.txt
new file mode 100644
index 000000000000..e896dda30e36
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/adux1020.txt
@@ -0,0 +1,22 @@
+Analog Devices ADUX1020 Photometric sensor
+
+Link to datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADUX1020.pdf
+
+Required properties:
+
+ - compatible: should be "adi,adux1020"
+ - reg: the I2C address of the sensor
+
+Optional properties:
+
+ - interrupts: interrupt mapping for IRQ as documented in
+   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+adux1020@64 {
+	compatible = "adi,adux1020";
+	reg = <0x64>;
+	interrupt-parent = <&msmgpio>;
+	interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.17.1

