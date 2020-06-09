Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B6A1F4743
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jun 2020 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgFITls (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jun 2020 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389383AbgFITlo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jun 2020 15:41:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4073C03E97C
        for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2020 12:41:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so22497pfe.4
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2020 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKjncVZ4QOe9AtcEsOqfdOIJlppfhRTgsX8dqfWz9G0=;
        b=Afuo/4MCKsk638UL6cRXXyK+mDgOSMyHLpn5vOBhRNoKPQCDgl+M0Uj8XzX0bJWuYJ
         c/dDLw4BBIXnUu15Zb/cIcm5HDugcu5iHISy7IZqTwmYRFxyOcZQT6BoJrmjcLh5VInZ
         tj5sOtNvkGdeIqHAMqFiw//ciBmU59qGwtctY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKjncVZ4QOe9AtcEsOqfdOIJlppfhRTgsX8dqfWz9G0=;
        b=nvyViS6NiCIJdB7bSPM9BMDQgrYKKSl7gNA3B7vRD4HjPNdahxM2ua79P7eSGwwtvD
         FH519/zn4FQ84uBAWe0CamuPEDsRqTJb6/hSqIKSb7pD9+WAnYZBPOfVez5uadW09Qco
         PXVtPYqh9SSq/zAZ35h+czOIDqelt1pFycR8/GioTgdCxYbimK2xHvHDj1b0boIIXAsR
         e9UKEghtQYBD/eASKoBXBWRaSqhqOt26MZCE6vz891AQzwrqvBvY5x7U/zqEwd9Sk/WA
         5JqEoaZD/Btq5YKAH3oAsEbO+q0az1E+JnsAukdOdPC2rMTm/hwKOi+WP502zZGdYECK
         Gc+Q==
X-Gm-Message-State: AOAM532v5VPbU+MqYWP0K34FAJR/upb7WtAUfH+a6fJ0Cu9+BCu38p9M
        rKw6vsh3joM+1hePs56lPyPpxg==
X-Google-Smtp-Source: ABdhPJxsY59wlAe7u96jNUc1NqgqgXcXvHG5lQxGtLmG4W1wZtRJWLQrD/JmjZCM1sSUUi23YzvSSg==
X-Received: by 2002:a62:ee0b:: with SMTP id e11mr8584104pfi.185.1591731704151;
        Tue, 09 Jun 2020 12:41:44 -0700 (PDT)
Received: from ubuntu.Home (anon-42-81.vpn.ipredator.se. [46.246.42.81])
        by smtp.gmail.com with ESMTPSA id z85sm10563627pfc.66.2020.06.09.12.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:41:43 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: chemical: add O2 EZO module documentation
Date:   Tue,  9 Jun 2020 12:41:16 -0700
Message-Id: <20200609194117.5837-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609194117.5837-1-matt.ranostay@konsulko.com>
References: <20200609194117.5837-1-matt.ranostay@konsulko.com>
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
index 69e8931e0ae8..46496dc250f2 100644
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
@@ -19,6 +19,7 @@ description: |
     http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/RTD_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_probe/EZO_CO2_Datasheet.pdf
+    https://www.atlas-scientific.com/files/EZO_O2_datasheet.pdf
 
 properties:
   compatible:
@@ -29,6 +30,7 @@ properties:
       - atlas,ph-sm
       - atlas,rtd-sm
       - atlas,co2-ezo
+      - atlas,o2-ezo
 
   reg:
      maxItems: 1
-- 
2.25.1

