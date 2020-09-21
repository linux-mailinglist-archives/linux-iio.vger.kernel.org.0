Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DAF272249
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIULYL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 07:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgIULYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 07:24:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A22C061755;
        Mon, 21 Sep 2020 04:24:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fa1so7307481pjb.0;
        Mon, 21 Sep 2020 04:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZVBGHtDSzOLc1GxJvapSkIMrWP9AXcJF0oZj5LUMkTw=;
        b=j26O2IIKh2BQvZrr7JeDqqW8xJNZZP64H++7Q+AU/9sKx1ipzRSJbPy8Mj/U+t/VQk
         OhPNVI1BdcFyi99BiKQlh6+nbM0PycvmsE33PCcQFGlsW1EGMJGx0MJs5uD0gfccDrpb
         LKHa4GUGNX4brKuRbaTd63LYeIpAcARZzOV4jGN7aLWPE6YnXoGgFeDfnzU8/++rxtHB
         rr8Hj4rTRmtk2TzdPTKsnMoJTC6xQs0b7vrIozNAQ72DHRqDiqWADADCBXiPUfFZxNR8
         z7pMtRqhGtr7iLXCFmmEIp6o+egxxYqBd+wjmjCDP9SnvqSNQMixJdybQEl7uD+nhePn
         jiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZVBGHtDSzOLc1GxJvapSkIMrWP9AXcJF0oZj5LUMkTw=;
        b=UYHWomK3cDCg6wabRRjQCdsvB7zmh65Dl5F9Fs3sKhAecJ2kFucAuOLNBEdsmFRaP1
         838meWsElid6ZZ/zhRhSJsShturwI+MrXYLIo4dYWU9QL+EmE9o072Uv2FmSBnoawVhL
         g5XzQLyz3/TSrXLW+UZ1QJjFzv3ToJeRBoK9Fod9t1piVOSy9ROPuqMhnr6RKOo2jjWV
         svo9hFJnc9Mq5aXRMRbpoORo0Z05AuHoTSqdkx3hhIwSDfKPXTrIsabyC0T8Hy26NNSC
         JkZya9pfFVFVpQPW7cK5FuzhnZcPb3+qg7XWZaCVXsqLNUOC/HiMQXlK/5lEbbF1YmDi
         CIdw==
X-Gm-Message-State: AOAM532b76+lb5Cwt3QX8w3mpQDqjU+BzV0032noLfPqhvdFPsvdXI47
        fZkU9jzcubKWtDjGvuwWpIU=
X-Google-Smtp-Source: ABdhPJyprBCyokbpB5WY+Tc9aH8GsiEmMDXANnpp7QmG52UDs1reFxCPa6DrbcDrUukU3Y9ZiAFMTw==
X-Received: by 2002:a17:90a:eb06:: with SMTP id j6mr24377399pjz.46.1600687451102;
        Mon, 21 Sep 2020 04:24:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:8024:8a0d:5d5f:6f8a:a2bd])
        by smtp.gmail.com with ESMTPSA id x7sm9978663pjv.16.2020.09.21.04.24.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 04:24:10 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 0/3] iio: adc: mt6360: Add ADC driver for MT6360
Date:   Mon, 21 Sep 2020 19:23:59 +0800
Message-Id: <1600687442-23658-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
 drivers/iio/adc/mt6360-adc.c                                       |  363 ++++++++++
 5 files changed, 487 insertions(+)

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

