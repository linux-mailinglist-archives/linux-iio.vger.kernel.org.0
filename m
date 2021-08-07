Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182BB3E3388
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 07:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhHGFKI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 01:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhHGFKI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 01:10:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D324C0613CF;
        Fri,  6 Aug 2021 22:09:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k11-20020a17090a62cbb02901786a5edc9aso1980843pjs.5;
        Fri, 06 Aug 2021 22:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dN32Pz8vtFkZs7cGtIiJw3IxISRVEkSeEPghCjfuGw=;
        b=FD5EJVU4XINMbdWEcEyi3ZecVVKRywFjtQr5F4cgZ5Ec7Qy10lmDH/AVu+3BaYWhTr
         jXm4E8hOLVxbcnCu75TwJoqkNiTpV4bDYkeADceHR2SiZDfS4WqnQ7EzD/D13EY9wuO0
         xB2IlfbmOTEweEEWmCtk9RashxqbnvuJ1+3o+Qhsh78AEllrJ2ZPzIJX3oPxhynM65Ok
         NaCORIs3Hr6vzFt+oSgjMAyKXHi2YsIQp6h+C7tZjcluvU/pML/x2Gm4ODrRV346vo65
         ZTVi+cuXYTyZE2su8tyLq5JG8RoigsyJQ8Ikoxp9xTZVY5Yssb9oyjU3Wdc1MAl7D4kS
         473A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dN32Pz8vtFkZs7cGtIiJw3IxISRVEkSeEPghCjfuGw=;
        b=k7NXlliRJWymcv8C2pGQUZA55/P/STqCh9oL/Kke6ImsNDcetB5Sp7hekyqttXaUSo
         fD0J12BpHE4qZFFUW9GQfg43AmCm2YIp8fD4y7dfMOsqCbFGieXLqgd1lKYvaBS81QjQ
         kyWC9IvRDBlquvB5G/PSGDPPbnyY3+dXny3HS81L1iFwSWOCjqlzZJ0lR0HiNJvka3Hw
         YiPeHTvMR8fy8whyeBNwhQh+BJTL5idhBtAMQ2Tl/J9EXuqQcjnjwIYpUNFoZzT8HLzd
         D6F1J8z6mxQJZQiM5f/XJzccffXWwQ+ZSD8RUVq9QxmFhR7FIrIrkG49EHP9/Ht7jlrw
         MhPg==
X-Gm-Message-State: AOAM530cBgXcz4rADxRH2COHhIZYHwBGpiD1plXDu/NBRcy3KCflj+o/
        HClqAGIew/4Bvq+8hkvJHd0=
X-Google-Smtp-Source: ABdhPJyvbdcK78r+UcvQti793FkrcqDHMLrhnX5z5NaSSTZyncty0AS0QnzlyZBqBwOiu9Coeq1CxA==
X-Received: by 2002:a17:903:2302:b029:12c:bb4f:cbdf with SMTP id d2-20020a1709032302b029012cbb4fcbdfmr11612195plh.22.1628312990883;
        Fri, 06 Aug 2021 22:09:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:92:61e9:aa2d:89ae:905d:dacf])
        by smtp.googlemail.com with ESMTPSA id l14sm14433011pjz.19.2021.08.06.22.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 22:09:50 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: potentiometer: Add driver support for AD5110
Date:   Sat,  7 Aug 2021 10:38:53 +0530
Message-Id: <20210807050900.10075-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt-bindings and driver support for AD5110, a Nonvolatile 
Digital Potentiometer.

Mugilraj Dhavachelvan (2):
  dt-bindings: iio: potentiometer: Add AD5110 in trivial-devices
  iio: potentiometer: Add driver support for AD5110

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/potentiometer/Kconfig             |  10 +
 drivers/iio/potentiometer/Makefile            |   1 +
 drivers/iio/potentiometer/ad5110.c            | 333 ++++++++++++++++++
 5 files changed, 352 insertions(+)
 create mode 100644 drivers/iio/potentiometer/ad5110.c

-- 
2.25.1

