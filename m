Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FC71D7A19
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgERNhV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNhU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:37:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05310C061A0C;
        Mon, 18 May 2020 06:37:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z72so10470416wmc.2;
        Mon, 18 May 2020 06:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WFA7QhqouFMfNHmQWuKWADaCRobJrYX/ZzRMY7foYDI=;
        b=eXH5tzaVhvmDLI+k8PdUvDjYOiUbK+UKgJHJvjBCeBl3RAIlYzGOyvGfYrl1EYSo8o
         wBC0umMU3RgK4+yz1EMCqlC4O4f8+/eeMqzucMgtNlyqeQ27myG//6xnEjp2LkMl1/3J
         9rzA7piy/9r2D4AVd0Jwtv5bPt0TSiP6uO4Ocp2LhCTrpOirPfUbwHaxC9PeMwrZdP0g
         cPhPwS2rkGWTTlwjBKR45kPAy9HnAyZpq+PGv6Zw8BNbpiM7X/Y+xic96sDEkz+pzacK
         4mRHlLTI2q4UQasyp23YHy7s1UTY65qJlL/FwP+CLGgJjcxDCZVQQwglYVE9dEkauvrR
         OuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WFA7QhqouFMfNHmQWuKWADaCRobJrYX/ZzRMY7foYDI=;
        b=LcIwDO2nqfIPMxvp1FRrN8426oGqvs3FHkzFrypmdQD3nudZjt0P6rpzaXjHiJFKSY
         zwxfDEoabWLKb8P/31K8kvovYOM7d7nWIgK/JrL3xQXiyHW1swK7aYGrcr8U5TvqtLjY
         0SYIrqpY7LDR78zsdQVsgevqAhJokMsmn/Dcz9fmjEDNo+AxnpOJ/qQvWbhGqoumLz4D
         a53hxn9S7rfU6vuZOlQA7ySJMC4vm5sy0WpimYWklxqvusYcmTiKNYQ31InLc4mgshPz
         3q/0TXwiC8vtak3IIqd4vy7vqSQVeo6Jn2RZZksDTee907F+OSo8h/dNMK5NrvBR0Trr
         19pA==
X-Gm-Message-State: AOAM532TS2KKdTTgFkc96IvA3/viYK23biV6yC2xE0y7RSgnkVp1bQtP
        6rHaAy582Trv/PcbnD63EAkK6IZWnRF0Lw==
X-Google-Smtp-Source: ABdhPJyiWeheKDNpM1MZ9XExcB8ck0ZW66IS/qdMVAcK8H6Fu9nNE5tDHvp5NtqASYWyvStgPDnhLw==
X-Received: by 2002:a7b:cc0f:: with SMTP id f15mr20465440wmh.78.1589809038207;
        Mon, 18 May 2020 06:37:18 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id o26sm17054328wro.83.2020.05.18.06.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:37:17 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/3] dt-bindings: iio: magnetometer: ak8975: add gpio reset support
Date:   Mon, 18 May 2020 15:36:37 +0200
Message-Id: <20200518133645.19127-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add reset-gpio support.

AK09911 has a reset gpio to handle register's reset. If reset gpio is
set to low it will trigger the reset. AK09911 datasheed says that if not
used reset pin should be connected to VID and this patch emulates this
situation

Without setting it to high on ak8975_power_on driver's probe fails
on ak8975_who_i_am while checking for device identity for AK09911 chip

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../devicetree/bindings/iio/magnetometer/ak8975.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
index 86e3efa693a8..a82c0ff5d098 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
@@ -37,6 +37,9 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix
 
+  reset-gpio:
+    description: an optional pin needed for AK09911 to set the reset state
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
             reg = <0x0c>;
             gpios = <&gpj0 7 0>;
             vdd-supply = <&ldo_3v3_gnss>;
+            reset-gpio = <&msmgpio 111 1>;
             mount-matrix = "-0.984807753012208",  /* x0 */
                            "0",                   /* y0 */
                            "-0.173648177666930",  /* z0 */
-- 
2.17.1

