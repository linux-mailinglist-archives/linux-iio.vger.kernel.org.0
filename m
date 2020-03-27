Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE3921957D8
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0NSr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 09:18:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39871 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NSr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 09:18:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id f20so8457432qtq.6;
        Fri, 27 Mar 2020 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jqrals/DlRSRzD2FBJsMSNR0STEdfCIvgqrhwYb6xjM=;
        b=gJsRc5fXU04/ti7uaCr4CL1DP+JU/xVSVn6U+PWdIryDySbegTXzeD2pH0PaKylODk
         nRYOcb7v7hA+khl3sFdOdfUT059XMdjgqyBngiOeERUZ9orE0jZRsfH2jAwz4arMWu3C
         7LY/iUP5xUuI/7PIhZzl2cjBoR/RYXjqZ/ODBm+eCUzNjSS5/+z9bZc3loXrYe/9AjR1
         E3YToCMYyHTYnhWqGpcHDLSOBG1sARvef+Ym7uzmK8wUf+De4lpSZK0bmDEgJEN8OxNG
         CpYCe4fI7mz5xJ0vHK/mMlkbIVIGVTPiLE7wfPbndWkhTASzZbMciaV3zrQwtPpb82nh
         Flww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jqrals/DlRSRzD2FBJsMSNR0STEdfCIvgqrhwYb6xjM=;
        b=Zr9pSbGhDWEdvc/dxSPBnAvNxq2n9cCm3QoSel2yY5TAe7rrU8L8LnlW9GSovXfoGN
         fvsoTGPR2ZHPNw1y5LvePZVgXa7KIkRKmrYvSfrvsCIB3dcWQyGpPjPI0VNH/ioTOphs
         pTkSXcBiGOkqbi2WzYoSR1I064FRb98vAA7uAePVCGfhxf04f1iHxLqmPPbKPda0gEE5
         kLYTXMjju5fEpALfsfIjGicI07PNBZWmmTBjHleRYWUfsttiy/kPOcoHhOD9xOJw/gTa
         xyxmpsux/iqPLY4KPbicDRX35KIQFsCLWltGvDzNokxuY8eecgYHKnmKduMJAQmAs9h8
         EqEw==
X-Gm-Message-State: ANhLgQ36ktLNsYvXPDEBhIgOD1v29l8hskbiA3tRumwgUEphm/XBXu8d
        QHKobly3FPylw5BXruoq5cf653DnMRk=
X-Google-Smtp-Source: ADFU+vu11Qis7wLq8KGvKi1TOOj827610u/IrA2NxQGaVGrPCd3k+OGfLG5jmqbejtfv8+ra9LXhuA==
X-Received: by 2002:ac8:2f15:: with SMTP id j21mr14259609qta.55.1585315125952;
        Fri, 27 Mar 2020 06:18:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:5bb::4])
        by smtp.gmail.com with ESMTPSA id o186sm3663914qke.39.2020.03.27.06.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 06:18:45 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     robh+dt@kernel.org, alexandru.tachici@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] dt-bindings: iio: dac: ad5770r: Fix the file path
Date:   Fri, 27 Mar 2020 10:18:25 -0300
Message-Id: <20200327131825.23650-3-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327131825.23650-1-festevam@gmail.com>
References: <20200327131825.23650-1-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following warning is seen with 'make dt_binding_check':

Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml: $id: relative path/filename doesn't match actual path or filename

Fix it by removing the "bindings" directory from the file path.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index fa86ef52b121..5661d62b994f 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -2,7 +2,7 @@
 # Copyright 2020 Analog Devices Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/bindings/iio/dac/adi,ad5770r.yaml#
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5770r.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Analog Devices AD5770R DAC device driver
-- 
2.17.1

