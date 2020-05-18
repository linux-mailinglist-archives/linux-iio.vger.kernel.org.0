Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19071D79FD
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgERNfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERNfr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:35:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992EC061A0C;
        Mon, 18 May 2020 06:35:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y3so11938356wrt.1;
        Mon, 18 May 2020 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bCY5r4YTOkDM+fCZ3vFBdxf8tVG94ohdlsr2qJImxJ0=;
        b=l4eOBhzhG4FQOhogJXhZgzRROXU0UmSKA9YdQFre/kLazF3z/zKhS3s0YWMN4z9OOZ
         V3Gh/6pS4VB7/m+4UOhZlJnG3C9dkQQtCyoL6/bnKtU9LLpQcZ2vJPKMru1xmsX5xmxc
         U9xCO/Sq0W++BDWQLcCs3oQWLLEhwUDzrmQWlIztfsG+K2rqa6d/hkJMnNtVF54D1PHU
         vtmK+z0jV1xCALXfOCviQ0cuTmJwHpdm1pAth5sj+HdPpsQ+yX7eonAZ+bBdlG6xtcYd
         9o1ADcVdG4ZkitxEHlWqhv/BLSQZa8ji4biOIWFKyTaRVMxRPdsxv1pZopKKo2RKb46s
         84Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bCY5r4YTOkDM+fCZ3vFBdxf8tVG94ohdlsr2qJImxJ0=;
        b=CaOTZTMKwQMLUm8uKV4rr70GQX29NtntfW/jAcPQs5H6uLGzmGpitHuYw+BHBINeGT
         KgQFyfth5LP0ANbz1M/RfCk2/9uNhzvjgMH588rSN6TVysIpKuE1QMNmxYFTlSA/T9lB
         5t1Vh1LS1KDx2OTs1ETZgZKsxseB3BcLJiIzCuRu30UVfzuLVqYlnMH+6rZvmVeNLjM1
         hsSQk4bGwdz9/zg6y/Geuyt/Jo10INR3ZTpuvqMi70SyPLm8/NCG7MLdvLCdteTVWLC3
         tsQWNHZ3trTHXTzY2Vp1oaHpQLnH7Tz62Q5tT7x40AT0BS3zkEFK+3UWwSP91yfR0u2j
         pPWA==
X-Gm-Message-State: AOAM532BL9D4EPqsK8XpYoSCclTfckpYMFQmbx+6exURY88DjVAK3zpp
        N//3KpbESXLqDJGVsin8P020Kl5nEqQ=
X-Google-Smtp-Source: ABdhPJw743+7MGJW+NObPH/KwdEVW5t6sR88mX2brB2Xo7OtjjcsRxViETq9fNnLxc/LSBIj6LApBg==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr19125224wrv.141.1589808943895;
        Mon, 18 May 2020 06:35:43 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id l19sm17086772wmj.14.2020.05.18.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:35:43 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 0/4] iio: imu: bmi160: added regulator and mount-matrix support
Date:   Mon, 18 May 2020 15:33:44 +0200
Message-Id: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert txt format documentation to yaml.
Add documentation about vdd-supply, vddio-supply and mount-matrix.

Add vdd-supply and vddio-supply support. Without this support, vdd and vddio
should be set to always-on in device tree.

Add mount-matrix binding support. As chip could have different orientations
a mount matrix support is needed to correctly translate these differences

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

