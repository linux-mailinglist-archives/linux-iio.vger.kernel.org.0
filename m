Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DF44F80F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 14:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhKNN1W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 08:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhKNN1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 08:27:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD804C061767;
        Sun, 14 Nov 2021 05:24:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso13597018wmc.2;
        Sun, 14 Nov 2021 05:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPw6VpyXa/SvSmM4Ls83AAdLfCvyeoi2DGZ1Ra7AU5g=;
        b=Z6xUMFZPZ2PTL9BMCt7vOvcdJG+teaP/5R/pxf6WGd6IouL4tblkLYgh2PWFHaRDH6
         NUh+Nle8kugCynNGVGjEwscBp0dVrn/C/MjwG+8k7w1xnQMCtebkUKXYeTUHp7zChVFk
         JJAMXoPdwwxUFRUz7Yj0U7+0jnQGiOqOi8G60HtQxaC445sFWx1dUBJqwpeax35Y84m+
         h9Xqpi2kmSP4i0SI3I+s86zAlEC9Kty09tCpAMpIo6CDSNTUZSX8ar/55qS53eYUTAk0
         wb21GGtT+yK/Yoz1D5s1/6W1iVoJLrIotD86NKZ2EMEEwWWlAip/5YmIZ1DyAderiW5h
         vwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPw6VpyXa/SvSmM4Ls83AAdLfCvyeoi2DGZ1Ra7AU5g=;
        b=Bb6jxBWIdA/EHsw6zHlX+zXVVsYlZu5o3k4se2ZDy4ktL9YUJV1QmVSm5QHHnBG49L
         I4zKTsF/tiOOZBTWZLrkIv3svzSRIVu8jCznGxZoz35EuUu+1mRAytmYjAfltvtjI/4X
         Wjm0bvtRFMjMjo0uz6FM1HU86fZLIWtP6fdTh1kEwnEWVky1J7dAzZRXgUamuU2PHrtM
         vM+wrnMNKJXkL0Byht1QuSEMaCpeCgzRkapc3AD7pXOcyN0Zjdm5flqTs7y5Pd/+a9Fk
         NUC4M2md0aBVon1YdVh/11LVHQuRErB73u5vHp6BVilICPX3fapJXo5KZhr+EmYIe1Bl
         yP6Q==
X-Gm-Message-State: AOAM531F2KUjXi99Z0AbVbpmC13BuqcHHPWepL1I02Cx108yyxspIprf
        7vUewT0rS8BnfzEQVyz79Ko=
X-Google-Smtp-Source: ABdhPJysKcX8ptWyGg1iYChKuh7ffVRGzM4vMls6t9yjfgWFfQm10ppTr9RC9NDA3fwi6mECKs/GmQ==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr33741591wma.43.1636896257435;
        Sun, 14 Nov 2021 05:24:17 -0800 (PST)
Received: from localhost.localdomain (138.23.87.79.rev.sfr.net. [79.87.23.138])
        by smtp.gmail.com with ESMTPSA id h7sm10858003wrt.64.2021.11.14.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 05:24:17 -0800 (PST)
From:   Gilles Talis <gilles.talis@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Talis <gilles.talis@gmail.com>
Subject: [PATCH 2/2] dt-bindings: trivial-devices: Add Sensirion SHTC3 humidity sensor
Date:   Sun, 14 Nov 2021 14:23:35 +0100
Message-Id: <20211114132335.47651-3-gilles.talis@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211114132335.47651-1-gilles.talis@gmail.com>
References: <20211114132335.47651-1-gilles.talis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sensirion SHTC3 is a humidity and temperature sensor controlled
through I2C interface

Signed-off-by: Gilles Talis <gilles.talis@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 1e4b3464d734..c6cce9826afc 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -277,6 +277,8 @@ properties:
           - sensirion,sgp30
             # Sensirion gas sensor with I2C interface
           - sensirion,sgp40
+            # Sensirion humidity and temperature sensor with I2C interface
+          - sensirion,shtc3
             # Sensortek 3 axis accelerometer
           - sensortek,stk8312
             # Sensortek 3 axis accelerometer
-- 
2.27.0

