Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65A0394ED1
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhE3BBU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhE3BBQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:16 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3519C06138A;
        Sat, 29 May 2021 17:59:36 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j184so8012629qkd.6;
        Sat, 29 May 2021 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnqLIa5mgKuFptyC1mSB5xtRSuUDg8keZCubojCgino=;
        b=oG56CJKepdRVk3v0PioJss3qcfbcczF3d5fGoelHQ/1iyKFD1zjyL31WBNt5KwO3/u
         +LIBr6rHLrygxTJ3/2uaRH1+qvxI3/8kueceHkR03F8jspX2tv7qoWALPFipZviITkUB
         Qg7fieio+GTFOy9mjX47axtxFZSpl5qjHLz/61NyUH6jyBd1tLzS02OZx9OTK+lSGJeU
         YyItC2XhKS8xJuWSuUhmO9hPocGbjeqYDvmN0avBCW0OPbaVM9tgWKss/DHSKxuZvk+n
         QRJu45+NG9Nj5o0ALck7VYfZoNDKFlufHenbHRSR94NcyfB1+KJ/8rMka46E4NQzKUnq
         sS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnqLIa5mgKuFptyC1mSB5xtRSuUDg8keZCubojCgino=;
        b=OrT97QQ6Ad5bjZMDFaqdrrIBeHOEh+cPuex4tkT6xAhUg+Hwr79KEN4xXDqSMD2v0b
         T/4zTzdlkPxaJox2c1ANAHoUeJQVTr+T5iASwt9fFkN44KFUo2nnWXtC3hRI8u0p0vK6
         KwmgZre2eabrPAudHOVI+fDwPeoCURxTdKtru5VvQxgGBUQc9O3lc8wK6cBC/lkX207Q
         n8EuDnmtbzXt6Qsan1fYRuQkPpUrtnA7ofw6lt/SxXu4+GXCqcIXx0JfjYG8mMuG/03U
         34D2D7FIEYITReoysm6Hbz6KgzPXxJ3iWMCAyZ+l3E/ka0CUux2mqbZnfCHRNobVqISt
         d80Q==
X-Gm-Message-State: AOAM532knZK+1vdV9S8zD4mzGcTBoGnKz8fECH+jF6hBM6xuWwet1cif
        tiCJGSNxtjTT486dHnpzJqs6hHKH1EKmrg==
X-Google-Smtp-Source: ABdhPJwH/NP0PT2T46ua+79svieDA/IJph0YsCTXUYTw44bpEi7tTFN7JqElyrSLnBBAfEBDggidOQ==
X-Received: by 2002:a37:8f05:: with SMTP id r5mr5058764qkd.26.1622336374207;
        Sat, 29 May 2021 17:59:34 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:33 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 6/9] dt-bindings: iio: afe: update MAINTAINERS file
Date:   Sat, 29 May 2021 20:59:14 -0400
Message-Id: <20210530005917.20953-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

The IIO Analog Front End devicetree bindings files have been update to
yaml. Make sure the MAINTAINERS file matches the tree.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..d3ab0ccc34ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8719,9 +8719,9 @@ IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
-F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
-F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
+F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 F:	drivers/iio/afe/iio-rescale.c
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
-- 
2.30.1.489.g328c10930387

