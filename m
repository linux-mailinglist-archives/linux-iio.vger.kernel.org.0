Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF28E293669
	for <lists+linux-iio@lfdr.de>; Tue, 20 Oct 2020 10:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgJTIIf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Oct 2020 04:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgJTIIf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Oct 2020 04:08:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9628C061755;
        Tue, 20 Oct 2020 01:08:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b19so626499pld.0;
        Tue, 20 Oct 2020 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rzBULe/uYcMd2biNuOUoirZAkyxIgwm/ep0g4irabeM=;
        b=j/qOX1CRjCJljSPZcb4bbGCVW1mLmUhTrHVtbJJD/ootbD5oyfz7Fz7cYl+sKaEV/J
         zwn5rw4FwvyqtCGrgfHPwUlBHVCPFzmYriPiwLP0alcRJr225m7heK1Q7oDdkb6mEFZD
         P8nSv2V9SBMxwbJZhYT+7//xInnXXSyxnQLfkGaYxSluWV/DVxxZkt+YL/iI3d1NWdvD
         //IZ++RIcxlotD776gTmQHqiwv7/2lObpeTlwOAUtRPgUUAAfmq+KZzQslEIGojJ8MDZ
         A/LtdXToA44/J6eNbLs7PDuWWs8RUbrcz/zhT2Ko/e7v5pjn+HTyFOPjvTNB1Kc7QYM+
         V0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rzBULe/uYcMd2biNuOUoirZAkyxIgwm/ep0g4irabeM=;
        b=KcjQ55OB4TctQpK/+ye9TCWr/A7Q4hTl/tUDhwm5Fa97i2tSqcBLKQ7E9yWd4+tgRR
         NxwsQP30ZUIDhlYl5I4gLForKUXOID554vCgJkbovysuAvphBJJtxb3C7oP8cSvALUjx
         a51rDDOzFelQl8Ncl/Mpu84kklQugLEWWCUxOpyZHU8kCxY7eJy70fhHTUkCVpVB3X6j
         fZhdPlZE9I4eVxOqXcODgEObmkR0rbNRSCE57C6jlGXnqJFBOZoQWRj1LuqShAR5nEFh
         wjDYdCX/0UTpdg3T/4IHpndbsAysDS7iQ6GIhAv2ZlDUKLS7RKewe88zYuEh7L3BKVpr
         G0Dg==
X-Gm-Message-State: AOAM5324w1kq/r/u0f/cfLTlk4Y4rQsspUirubNiRnXGuYRugugLlxkv
        DxrV+VTEOpEMIOIG7x9DvhQ=
X-Google-Smtp-Source: ABdhPJxp3MGSbm/SruzI53jPOkaZngQ8AJL0GjxKIqfl83yNMouMYtjKJnWWKQDl5lHM1Ow2n1VjfQ==
X-Received: by 2002:a17:90a:2c0c:: with SMTP id m12mr995977pjd.44.1603181313257;
        Tue, 20 Oct 2020 01:08:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:477:195c:4b74:c749:e0fe:9e69])
        by smtp.gmail.com with ESMTPSA id 17sm1347270pfi.55.2020.10.20.01.08.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 01:08:32 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 0/3] iio: adc: mt6360: Add ADC driver for MT6360
Date:   Tue, 20 Oct 2020 16:07:44 +0800
Message-Id: <1603181267-15610-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In-Reply-To: 

This patch series add MT6360 ADC support contains driver, testing document
and binding document

Gene Chen (2)
  dt-bindings: iio: adc: add bindings doc for MT6360 ADC
  Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
  iio: adc: mt6360: Add ADC driver for MT6360

 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360                 |   78 ++
 Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml |   34 
 drivers/iio/adc/Kconfig                                            |   11 
 drivers/iio/adc/Makefile                                           |    1 
 drivers/iio/adc/mt6360-adc.c                                       |  372 ++++++++++
 5 files changed, 496 insertions(+)

changelogs between v1 & v2
 - adc: use IIO_CHAN_INFO_PROCESSED only
 - adc: use devm_iio_triggered_buffer_setup
 - adc: use use s64 to record timestamp

changelogs between v2 & v3
 - Rearrange include file order by alphabet
 - Set line length constraint below 100
 - Add Document for testing adc sysfs node guideline
 - Set compiler 64 bit aligned when handle iio timestamp

changelogs between v3 & v4
 - Fix sysfs guideline description
 - Replace iio channel processed by raw/scale/offset
 - Add comment of read adc flow for special HW design

changelogs between v4 & v5
 - Rename dt-bindings aligned to file name
 - Aligned sysfs node name with driver and add VBUSDIVX description
 - Add ADC channel sysfs node "*_labels"

changelogs between v5 & v6
 - Memset aligned adc data
 - Remove strong casting void pointer

changelogs between v6 & v7
 - Avoid adc polling infinite loop

