Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099481E12EB
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbgEYQrg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 12:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387766AbgEYQrf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 12:47:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B2C061A0E;
        Mon, 25 May 2020 09:47:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h9so3935496qtj.7;
        Mon, 25 May 2020 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t8zEWUrm5GoCOEcVhpshh2tA+4Vj6BGZIYSk7nPV9Uo=;
        b=gF2ae7jdmu3EfJ1DHBNkoCxIzaIPv8/KmuYxU6F0rIohBImh+YnijgzshZvoNS7NOR
         yPj1KJn2/JDiVoU/YbAP7QHmTiT0AgMftNZs+u8DZ2U8nizkKjtxQKft/GYu7Qa61uel
         fF36ryMgDX5f7Ra7Wxx/mypgpNArpN7TW7cGI3T+thspbqG9f6W/d1EflHu7hf7b587B
         2IF6IaY/r4WMStLrKTZCjHr17T3G66tZFyojFD1LV+DVQ4lSSdWq3d6qRw9mPTcPPTVB
         O50rq1X53p3GW5GlLfnRXlsF6qiWbywW3BG+Z7cMXbPyGk0ZptDEgdP/2FfwZQeM0QzG
         GM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t8zEWUrm5GoCOEcVhpshh2tA+4Vj6BGZIYSk7nPV9Uo=;
        b=TZgQEAHMETZdGE6LFbjO4xu60aZX/qjIvdnrZGubqCI2R638eFtXScPQvYCNaQ0QB0
         uqYvFF/upKLCymFnA+YzCSmTpPCWA0uh9ZtBMPl834FNShM4eOALWL+UqKZEQBfQ0WLf
         sk0M2Qrj0ArLBHwHqnlSdsl4UwmoqaDH1x+EZIqDAHLRoAPvoaN2S6s1zKPkIXEv28S/
         PUeUnJ3EsMv2pANAFdwAzdDOzVbYO3/K+kpI2Z+cZfdwpqadGMMk7bYz7KOlS2gmlcs/
         qggplm8QyHHtvWNsjDXZ8BymaOprvCJKGTCyckH+A7/1r3/BKyN0y3L62HHWZ2wqd25v
         4V0g==
X-Gm-Message-State: AOAM530KWy2zCT/wYS09O119+C9bDQQdyXQc7nvGVD++dTQ3qxDyMYeb
        3Be1W0BmO4dTKHUEnK19B5jG4VLSi4w=
X-Google-Smtp-Source: ABdhPJwlC1dvHr4PGrcdBP2nZFqf3pGAhOM27ptunP0xRjgGCZiMfRez+vSCSuVEN99GX+HcgzPVjw==
X-Received: by 2002:aed:3b62:: with SMTP id q31mr3717224qte.293.1590425254143;
        Mon, 25 May 2020 09:47:34 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id g5sm15559618qti.87.2020.05.25.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 09:47:33 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v4 0/5] iio: imu: bmi160: added regulator and mount-matrix support
Date:   Mon, 25 May 2020 18:45:59 +0200
Message-Id: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v4:
 - add maintainer
 - clean up of documentation
 - added case concerning the need to add regulators, see [PATCH v4 4/5] 

v3: 
 - separate typo fix into another patch
 - clean up of documentation
 - clean up of patch messages
https://lore.kernel.org/linux-iio/20200520194656.16218-1-jonathan.albrieux@gmail.com/

v2: 
 - fixed missing description for iio: imu: bmi160: added regulator
   support
https://lore.kernel.org/linux-iio/20200519075111.6356-1-jonathan.albrieux@gmail.com/

v1:
 - initial patch submission
https://lore.kernel.org/linux-iio/20200518133358.18978-1-jonathan.albrieux@gmail.com/

Convert txt format documentation to yaml.
Add documentation about vdd-supply, vddio-supply and mount-matrix.

Add vdd-supply and vddio-supply support.

Add mount-matrix binding support. As chip could have different
orientations a mount matrix support is needed to correctly translate
these differences.

Jonathan Albrieux (5):
  dt-bindings: iio: imu: bmi160: convert format to yaml, add maintainer
  dt-bindings: iio: imu: bmi160: add regulators and mount-matrix
  iio: imu: bmi160: fix typo
  iio: imu: bmi160: added regulator support
  iio: imu: bmi160: added mount-matrix support

 .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
 .../bindings/iio/imu/bosch,bmi160.yaml        | 91 +++++++++++++++++++
 drivers/iio/imu/bmi160/bmi160.h               |  3 +
 drivers/iio/imu/bmi160/bmi160_core.c          | 46 +++++++++-
 4 files changed, 139 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml

-- 
2.17.1

