Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F37245A58
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 02:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHQAvC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 20:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHQAvB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 20:51:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60FCC061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 17:51:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p14so11926475wmg.1
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 17:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uPXUJGG/urnZWIGvOG0Oo9fZAeznk7ypl0i8BvRFFN0=;
        b=pqldIbp87u9cmjz3e8AiIQdo4euscVRdB4Gc7e+935AWRF/ZScHxeB0PUW26FqjaT1
         CVZ1RnCVpLF9kRbwbQ6Mk9QwwstoXU78a4cjBKWc7zQYkGA/PCHlBcDulfDsPMAsS+lU
         q7v66GuyNxQJFBldW6k70ylyHUizGzL/gEKtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uPXUJGG/urnZWIGvOG0Oo9fZAeznk7ypl0i8BvRFFN0=;
        b=WWdP41W2xbgWHWUrnC4I55dcRsIMoD97cYXxLSjxikGKfVSZdnPYkqD4yu6wwUA38W
         9LsdnG5SGEs/qblwcigB2yvebk6kBGIXQUSGeBJ5KHxtk+YPTBScwRQTkZMwP/RgOHKV
         8OSDGh43V+SvavuYNbkxdVH6IeSFSDBZBhiNX2aVwB//XlQ4lOns1SA/9OPfivmMYEqc
         zaIrpvrwnXO8O+XTci53xHjjLqq2MAg2hAxPkZQ6Li/s3ONbg3IkULStjUUCzcpv3USW
         +/n2eBmzlevpdGPF0cRGOWDGnAvId1alOAKaC/zST7LYc4sU5zgNOoxxwv3hRSu4isqT
         KKZQ==
X-Gm-Message-State: AOAM5303iy4IRjE86pLatcf1j33V6am4QbhoCd+M1aVi/W2quVMMJniD
        KpkEJ/7guzvmpb2DcvTgZhUOoP2SucEh8Ytg
X-Google-Smtp-Source: ABdhPJwp+GNCPwTrHNjI11jdoplRpoy+ezOD0IwWLjiTA/hhVt87fQgHiptdwxzH2Vq4xjgQyKW8JQ==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr11801115wme.23.1597625459390;
        Sun, 16 Aug 2020 17:50:59 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id b139sm29892711wmd.19.2020.08.16.17.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 17:50:58 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: chemical: add Atlas EZO Humidity module documentation
Date:   Mon, 17 Aug 2020 03:50:51 +0300
Message-Id: <20200817005052.11565-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200817005052.11565-1-matt.ranostay@konsulko.com>
References: <20200817005052.11565-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../devicetree/bindings/iio/chemical/atlas,sensor.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
index 46496dc250f2..f1130d613735 100644
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
@@ -20,6 +20,7 @@ description: |
     http://www.atlas-scientific.com/_files/_datasheets/_oem/RTD_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_probe/EZO_CO2_Datasheet.pdf
     https://www.atlas-scientific.com/files/EZO_O2_datasheet.pdf
+    https://www.atlas-scientific.com/files/EZO_HUM_Datasheet.pdf
 
 properties:
   compatible:
@@ -31,6 +32,7 @@ properties:
       - atlas,rtd-sm
       - atlas,co2-ezo
       - atlas,o2-ezo
+      - atlas,hum-ezo
 
   reg:
      maxItems: 1
-- 
2.20.1

