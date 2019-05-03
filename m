Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D97128BB
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfECH2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 03:28:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38521 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfECH2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 03:28:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so2468885pfo.5;
        Fri, 03 May 2019 00:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xG3BXzoSNSy7tAxX5sR0WHhb5RCNXLJmoOdev9tDivc=;
        b=pUDYAZth1/cN7IFBdUvzoPxGI7x2IfzE1oP4oWYaHFPAgsXF/UEur45b310L3vBqnA
         qbaTAce2XBZqHM8z7Vx+3Ej0UGZxnllvyiua0VvQJ5c9eyV3NurumZFJ6EIIaOtQCHuf
         1ttWNOkwk1OATCzTt2tHIAdWr33QR05MIjiEQ3DAFlbdyFUyGC5ln0N2JiEPclqTIdm3
         hSgkY+B4edwSmhQM4E4/63tRN+YPkchz1k63n1Xwe0dIEh3m/zxhCHWlC3mmLll5Z9vG
         tRZhLnT0El0UuGckeZBJx1O1k5RO4A5z1CSjJVLrwR/bmHZuQnRWCbgSLNFS+my+4tUV
         6KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xG3BXzoSNSy7tAxX5sR0WHhb5RCNXLJmoOdev9tDivc=;
        b=jeQoV7QK65jh8LRk/3xjAwshMa5flq+hnfnCKE3wXrB6+aFV/S/lCvDrRl+LiXE/BM
         tyZIgEK3EOAwIFAfGiulvNoiq2HzhuLiPLRrJq9qfsXUsMmEfbJUmYRaSeuukYNIHmMP
         Rr+ZbnHjwY5ZWyNUPzQpjWHef/e1xKQE3A4xrSsr1BpVZdEPfS3egzo/6sGVwKFyJ+Vr
         qqunPBivbz/TxrraDi4kOXJHLFsytEGErLsT7vMZDtsfYxX1Gvga5ftJZu2KPQUGs/JS
         cMMas5mqAZ/fRSCbHfV2EfmuSdqQ1E/sIYAph7fNOOsSwHoQEiaXPgEozndWdncU9k60
         lFbg==
X-Gm-Message-State: APjAAAVSFDRnKGpkFWvbiC0RRsHB8OuVGYOVXu1ingCputP0hYdOXuzo
        kVtjwXEJdcCdhi/+cKlYolA=
X-Google-Smtp-Source: APXvYqwkix/U4Pl8qw1a/oiCfdrTNq3/mjtlSb174nAEyztOcuN7A4BP+EWtep/RCQWpK8mbpBmvDg==
X-Received: by 2002:a62:5ec4:: with SMTP id s187mr4998560pfb.185.1556868499995;
        Fri, 03 May 2019 00:28:19 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g10sm2944183pfg.153.2019.05.03.00.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:28:19 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/7] Add support for H6 thermal sensor
Date:   Fri,  3 May 2019 03:28:06 -0400
Message-Id: <20190503072813.2719-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for the H6 ths sensor.

Based on IIO-based thermal sensor driver for Allwinner H3 and A83T SoC,
thx to Philipp Rossak's work.

TODO: calibrate thermal sensor by using information from sid.

Yangtao Li (7):
  iio: adc: sun4i-gpadc: rework for support multiple thermal sensor
  iio: adc: sun4i-gpadc: introduce temp_data in gpadc_data
  iio: adc: sun4i-gpadc: introduce gpadc_enable and gpadc_disable in
    gpadc_data
  iio: adc: sun4i-gpadc-iio: support clocks and reset
  dt-bindings: mfd: Add H6 GPADC binding
  iio: adc: sun4i-gpadc-iio: add support for H6 thermal sensor
  iio: adc: sun4i-gpadc-iio convert to SPDX license tags

 .../devicetree/bindings/mfd/sun4i-gpadc.txt   |  27 ++-
 drivers/iio/adc/sun4i-gpadc-iio.c             | 208 +++++++++++++++---
 include/linux/mfd/sun4i-gpadc.h               |   9 +
 3 files changed, 213 insertions(+), 31 deletions(-)

-- 
2.17.1

