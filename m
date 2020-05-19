Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054181D9157
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgESHvv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgESHvu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 03:51:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75985C061A0C;
        Tue, 19 May 2020 00:51:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e16so14699568wra.7;
        Tue, 19 May 2020 00:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oPqV/U6ZMKrfCAPX/g+ptuFFrR608MN26a6/3zmIm9U=;
        b=Qx4FxYkRVjXqo1Bee59HHHicL1AVPpEWHYEEn1yxhHtRPxJKgfauplYwAp20Hy3kzz
         OuMFhUNBdt5pmK/Bx1k2qDniw4rlOSnYFJ21NPosQw+gJ4fwRtocqjydkrS5UVZ6fYIp
         2Uw36v+GODgo3DNtt0/39KY7D6+P7/7+jfe40PTkTU+bS7HN9IvOkIuInMz215QBJ/yI
         S+bsHwCLhYIAvB9+fQcI4lrz62SSogApBqzLtTC5y3xuhIX9DOwLHyORI13esw0xRHiD
         MMjAKMuZ+CVzPW361/tIXR4ipx423JQ5xX9iwxZXCB5mTODDDPXUUfDbTzFXg1ewc/ky
         7vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oPqV/U6ZMKrfCAPX/g+ptuFFrR608MN26a6/3zmIm9U=;
        b=Z7i83//66gF5FyCa8J7SsVjm6DaWKN2Kvvba3qpipVDj9PI2kqm5CsTbYPzBU+A1lE
         2i3YMqAci5CND/njWkj2BpZkHQB3BeGn6NWjc/Pg059mDpcEPHlo6d/Rdh4MFX+i5crE
         tnTJb0+Tus/o6x3dvuPylSboaKBP58f91ziHSYpt+Got3Ul1swJrHTOBqarzGdpuOvLi
         jQ1WEP5ezTRN2XQEzYj8XVYT+/74eoA8mch3tCsZ1e8n2dfeSKUDxwbV6+GzT+m9ar6O
         kEmv5OcNZ650v2iUoVq7v3qzYVaH9eaeJyi94fKnEzZV5hYH3zQ7L/vUyBSYbprEjMO3
         XhWg==
X-Gm-Message-State: AOAM532Dnphbvl5It0JDPOtL8EZ9AGZHxiCVuabiel4Q/3voEBFu/XAX
        OJswHgI3qoM+K2cWfSl0N6MvdnDDBks=
X-Google-Smtp-Source: ABdhPJxtWNV9gW9Gu6NsxHHpnkmIO0W67f11Kv3Ql8NrcqBrMJfCm5F98MsSLTQqy72dH60DwEPoLA==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr26016134wru.198.1589874708018;
        Tue, 19 May 2020 00:51:48 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w18sm20019697wro.33.2020.05.19.00.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 00:51:46 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 0/4] iio: imu: bmi160: added regulator and mount-matrix support
Date:   Tue, 19 May 2020 09:50:56 +0200
Message-Id: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v2: fixed missing description for iio: imu: bmi160: added regulator
support

Convert txt format documentation to yaml.
Add documentation about vdd-supply, vddio-supply and mount-matrix.

Add vdd-supply and vddio-supply support. Without this support, vdd and
vddio should be set to always-on in device tree.

Add mount-matrix binding support. As chip could have different
orientations a mount matrix support is needed to correctly translate
these differences

Jonathan Albrieux (4):
  dt-bindings: iio: imu: bmi160: convert txt format to yaml
  dt-bindings: iio: imu: bmi160: add regulators and mount-matrix
  iio: imu: bmi160: added regulator support
  iio: imu: bmi160: added mount-matrix support

 .../devicetree/bindings/iio/imu/bmi160.txt    |  37 ------
 .../devicetree/bindings/iio/imu/bmi160.yaml   | 105 ++++++++++++++++++
 drivers/iio/imu/bmi160/bmi160.h               |   3 +
 drivers/iio/imu/bmi160/bmi160_core.c          |  47 +++++++-
 4 files changed, 154 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml

-- 
2.17.1

