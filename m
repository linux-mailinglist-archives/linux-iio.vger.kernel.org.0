Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981AF3E4135
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 09:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhHIH6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhHIH6o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 03:58:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D6C0613CF;
        Mon,  9 Aug 2021 00:58:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ca5so26586779pjb.5;
        Mon, 09 Aug 2021 00:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbnfIseIdRUiYY5Rd1yC66CYf+wGkmSvk4ybj5gum1M=;
        b=dArC/b5Dz20nE50yWMHVQwtXWp0FAIy5V/ptlB678aFeEitUFreshNQI4pzGB0OwNa
         PaIXV2LNEmsrDUEKdr2zJdWs4SUChOueZiLXrw95n9RRzJk9abnTBIFdk42y2NWTw4O3
         QTVrW4i9JGrJdMqoTNRRBaghdknw9e3VOxytl7JxDEXikaE9JqRPgHHYXR/s5pyB4OgN
         ttGZbmRdes0UwBfLeQHFn/dxE7jAf/JlZd1l41MpZJlj7GKxuVmZX1W7wnlE5r8wdwLV
         CvTK0jcYXcFvM/m6RbH7gW1UIEO+LjT7E1XzC8Mm7oo0U8AXgBqE6hK3whQbIhy39sI8
         M0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbnfIseIdRUiYY5Rd1yC66CYf+wGkmSvk4ybj5gum1M=;
        b=lQSparpM6OBXHDfEan9yy0FYFCwrwFdCGI0gOWDNAcZuDIItB0KGEynKrxNHyj97IO
         ImL0H2FYdCbIvK1N2/JiyKfUDZIBBY3X5Z2vhNcYJtwVzqyBzMtHXqkO4Pl7Pf7BenBS
         kSNTpFyHuLS/1kTgMIpPKH0UUmldfbBr1otGpC1JOWYeT/yl0oWdEldgM5ftQm4mwQnF
         fKz4+pwArb4ChLm3qcSFwmSTeaSHkZxzGaNSAOe4s7DebBhVWT7KQJ+kmLUyIMr9Flr5
         RICgP5jcwARX1ITnsYRE2rGuEiuHyBmwbW+qBH5KWy5tgGEcepcuHR96BDdfupkx4bIp
         rAgQ==
X-Gm-Message-State: AOAM532bA6g7xLovU8mNnHt8qo2mB6JzP6p5yeZb2jGyCK6d1bC1GVed
        9JnU9yqnfCZ5hgPwVhZpBP8=
X-Google-Smtp-Source: ABdhPJxhvdmOQOqlZ8ghgItK1lQs+IVwGjOSEULdwBrPhfmAJrHXUPSYmSyKmsNByAr40Yl9wpg3Pg==
X-Received: by 2002:a17:90a:d910:: with SMTP id c16mr15400549pjv.154.1628495902622;
        Mon, 09 Aug 2021 00:58:22 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:188:d7b2:ea47:4575:ff46:5465])
        by smtp.googlemail.com with ESMTPSA id b17sm21425112pgl.61.2021.08.09.00.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 00:58:21 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] iio: potentiometer: Add driver support for AD5110
Date:   Mon,  9 Aug 2021 13:27:18 +0530
Message-Id: <20210809075745.160042-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt-bindings and driver support for AD5110, a Nonvolatile 
Digital Potentiometer.

Changes since v1:
 - Drop 'shared_by_type' since it's a single channel
 - Add error check for i2c read/write data bytes
 - Simplified calculation for tolerance
 - Add shift for eeprom wiper pos read
 - Change new custom ABI to existing ABI
 - Allow top-scale mode by writting max_pos to val

Mugilraj Dhavachelvan (2):
  dt-bindings: iio: potentiometer: Add AD5110 in trivial-devices
  iio: potentiometer: Add driver support for AD5110

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/potentiometer/Kconfig             |  10 +
 drivers/iio/potentiometer/Makefile            |   1 +
 drivers/iio/potentiometer/ad5110.c            | 339 ++++++++++++++++++
 5 files changed, 358 insertions(+)
 create mode 100644 drivers/iio/potentiometer/ad5110.c

-- 
2.25.1

