Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B8F27E433
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgI3IyY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3IyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 04:54:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE946C061755;
        Wed, 30 Sep 2020 01:54:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so701500pfp.11;
        Wed, 30 Sep 2020 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J6RVC1dwGGEOXZfj110V4hRsQlR6vCt8ihvodpQ2OqQ=;
        b=LjOi/8Jxe2hrdsoqFaxgmps0JYdDEHl11LyUCXUhFoy1FJqMhayq4ijKiJdm7O8/fL
         XbtvTRNfD4qI/yhcTSNk1eCgTGzXJ8lpUmskcilKcs7PhmeX9fMX5neAkvRR1inTbYiw
         JRcMlF9ehNqCOV+pNbQ7YWpR/XRajE1By7hbSjgGiC1XSWmpLc1A1txoTBwCbMRqQlaQ
         QZLjySTY2fATayWwDlsZAU8Z2JxrtjWt1OHr+eSWw3GUPvIRf7DSoUFasc1oyWhbESN3
         dEzwjTlVU5zA+mV53Y5uXCMuLlJGKELd0ACuVcBlkwVTikm1F2w4RHKJlBsibEvfBTdB
         FmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J6RVC1dwGGEOXZfj110V4hRsQlR6vCt8ihvodpQ2OqQ=;
        b=bcYGexSo/68hZD808GjGqay+f2xnd/PAn2PSHaAZkvMH1/QnpNCC3cSkpCqvJLdgre
         jUQPpmc2sKJM47j53QzPAmXh0xa7nwHshbHe+x/KypWhoCcZz4AOg1i9ZFLvmIvobEX8
         94KHi+hu+r/Mw0vj56bMhl2aoHnGVbhR5j6TtOea2oqiVQrG4qmr4RsupzpX1+DtahzM
         W0HcnYpatorjAjofdR2cq3d7409vtgj3XjOYKPJh6acBnMoZXEB+fjY9ItOMCuHgp9Kw
         Fo+xSFXmvG+/2E6IwJbyY6WzIPmzMfQyelbCpoRz+V0VChS2k5g6rfdIPMDuU6Xu13PT
         VydA==
X-Gm-Message-State: AOAM530BtEYNGDjeqIps6ykKaE9KYomzkAxPOW9GAc0ItiLnQLP4t/cg
        GhG8YoPQirSmbJphTOge5P8=
X-Google-Smtp-Source: ABdhPJywPJ0fxYhSKELQfCfkMoplqEFJGypucBaCyF3NpkcrinmY//1AX3kzKe5EOsggfSNURmbGtA==
X-Received: by 2002:a62:52d3:0:b029:142:2501:35ee with SMTP id g202-20020a6252d30000b0290142250135eemr1698574pfb.78.1601456062506;
        Wed, 30 Sep 2020 01:54:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56b:d17:8c76:3dc4:5429:d7e4])
        by smtp.gmail.com with ESMTPSA id x13sm1513938pff.152.2020.09.30.01.54.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 01:54:22 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 0/3] iio: adc: mt6360: Add ADC driver for MT6360
Date:   Thu,  1 Oct 2020 16:54:05 +0800
Message-Id: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
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
 drivers/iio/adc/mt6360-adc.c                                       |  362 ++++++++++
 5 files changed, 486 insertions(+)

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

