Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABEC26AAD5
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgIORiP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgIORgx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 13:36:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84088C061351;
        Tue, 15 Sep 2020 10:36:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so1713620plb.12;
        Tue, 15 Sep 2020 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VDlB/vF3yD1AI0j4KncO/S1Qql2ZvV+dkP24BievIWM=;
        b=ZtY7n44QRcDMYA5b75t7nFBpPYDlz3xxgeZDAPc/e1/fbeQtk4DWVTdQM5JWSg/lOg
         AydIOgF5q43uhDoqqrxBBuVB5Bdry9p9lzc9d5L+mKOsIj9RusKPdoOMO+5EbNKdXt38
         DaDTg4+2C6vbP+Xm6Wx5nr+hFcrvvX2jkazjSEkrNFrvAPFrLC99thNmCKhNozJI9hV0
         xoujK0B0ms9tVj4WbJNmI/NXVuWNRqauB20fMRcxVNFlPz5SeOcBfLVx+9MD3GAx3KjF
         EHm57JLTMl//yIbsxq5aGbVk4LOZwqZ1j8XTH6nHOuF7sBFObQ4kh95Ss/mGtjw+N96I
         9qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VDlB/vF3yD1AI0j4KncO/S1Qql2ZvV+dkP24BievIWM=;
        b=HrUACaX65z7pzHeLYVXi5LiLGhIrVV9uaNQoCrQGvbU8BcE6lCEB7rsmb4YRWiF/RR
         62nuBhG+yoWYSpNHNnafx1752O/5+tfLY53UTbULoABJrOjOVjtcY22q+xrQQhRc/CN/
         kpeXdkchsr9m9V1pQFZKH0BYDbFGa5S6q4xZlQjFAdvtcbi3+u1exJhMeaWNLM2ZaYIi
         WC72ukLuypU5LZiXbq90FUehGnid3HZ7s2z18gc7zL/V6Ck9t3RaC+9H1GPQtwDjOTZm
         FSggwhTSbr20aKDOTNYtZ5m9J74EjSTKQ5qKB0g0QmLntXDhOZxe205fqUMNieJYxhiH
         xKfg==
X-Gm-Message-State: AOAM530xD6SyL9kqhik9P8LfejSLIYZDAf3RczxgFSCwN8gv7j9RFNZN
        b8/3CcXc+rXYZMllp5o4J7g=
X-Google-Smtp-Source: ABdhPJyhEfvuycm6RqzCR6YKDoBZIiBXYbshieo0bnzp14v86+oY6Tdh6bDVNfQIkJpJLPb0b/+kdw==
X-Received: by 2002:a17:90b:1487:: with SMTP id js7mr385729pjb.187.1600191376006;
        Tue, 15 Sep 2020 10:36:16 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id x3sm14025926pfq.49.2020.09.15.10.36.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:36:15 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v4 0/3] iio: adc: mt6360: Add ADC driver for MT6360
Date:   Wed, 16 Sep 2020 01:36:06 +0800
Message-Id: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series add MT6360 ADC support contains driver, testing document
and binding document

Gene Chen (2)
  dt-bindings: iio: adc: add bindings doc for MT6360 ADC
  Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
  iio: adc: mt6360: Add ADC driver for MT6360

 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360             |   83 ++
 Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml |   32 
 drivers/iio/adc/Kconfig                                        |   11 
 drivers/iio/adc/Makefile                                       |    1 
 drivers/iio/adc/mt6360-adc.c                                   |  357 ++++++++++
 5 files changed, 484 insertions(+)

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

