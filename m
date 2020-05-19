Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48451D9072
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 08:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgESG62 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 02:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgESG62 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 02:58:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD8C061A0C;
        Mon, 18 May 2020 23:58:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e16so14533516wra.7;
        Mon, 18 May 2020 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6AiFstTGhSyCdoIyVevq1TzhnB979sWMq0QAD1SrSBs=;
        b=WfCP9Jp+k2orQPgDRRs9SJZG2q/hGIvIbZlFmjqXHN5Fi9T/vfLleNqiVsRhf7NCtl
         F3OdStA9N02oazimnHm9h+9m0sNJUGOwDgAOsw5XfobrO57VCvyRMt+SPT+Y7e7W71XC
         R0zQjb5+E6kjP/bZ5txomdxD5uRESteqkt0evAg96Ie4/uXcTApWXmm1+ubQEQPpv2Qu
         qSvvkVNMTzpLwJVM8hVaVps1wGwK4LED4pQJDa0TWukWwGo01M5JiuFmJziRGiMEuj64
         /8/WSo7H5J0znyE4VvM3+jQ6/uVcXKpvF7t4rqajkHCnDUIqtB2P7CueglIcl6Zp8MXe
         SHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6AiFstTGhSyCdoIyVevq1TzhnB979sWMq0QAD1SrSBs=;
        b=PslKd/QEnOVpFDJZA2FcBx+bp8YCfLxuzibZXZmK1HofgWoOFX0OG72hBwaHrarwR/
         jlc4vjFlQvZhMRudcUFvLCsbT/S2pwSmYGXAozvhHTWs8cgJhFNEBUIBkpxyjUms8t/q
         A09j11+WgNnJFCeremFRt81KYFpDjDURYu0VRViDKwyHwozrqu6+Ly6vAhi7r3RAQ1A/
         a/6/T7WO5sX2h4WhdFiANO36B//NrvSymYPWnPStTi0+Um4YYrWlcZlBmvhjoa//FRV8
         Q1emsF+WIIahDwu+WbEQi/wM4Xi++gQaupTYcTbbhqmNl8pahUThD13yWA9RKRWz4Jnv
         7KAQ==
X-Gm-Message-State: AOAM533dXi9yL656hROVMDivcllDlQUBxADjZmu7ODgjJOESsAewHvpI
        YjUh8vuWEZF1Xzy7hLw1SfikxeSDI5A=
X-Google-Smtp-Source: ABdhPJxfUmPhNp7q/loYzQNsi3pPdXWIjEal6xtNYBxVffPeI0E5IhKWYlQ1EOe4Q43a8VIR9AqHCQ==
X-Received: by 2002:adf:f783:: with SMTP id q3mr23693925wrp.348.1589871505014;
        Mon, 18 May 2020 23:58:25 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id p7sm2597550wmc.24.2020.05.18.23.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 23:58:23 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/3] iio: magnetometer: ak8975: Add gpio reset support
Date:   Tue, 19 May 2020 08:57:40 +0200
Message-Id: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert documentation from txt format to yaml. Add documentation about
reset-gpio. 

Deassert reset on ak8975_power_on, assert reset on ak8975_power_off.

Without reset's deassertion during ak8975_power_on, driver's probe fails
on ak8975_who_i_am while checking for device identity for AK09911 chip

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheed says that, if not used, reset pin should be connected
to VID. This patch emulates this situation

Jonathan Albrieux (3):
  dt-bindings: iio: magnetometer: ak8975: convert txt format to yaml
  dt-bindings: iio: magnetometer: ak8975: add gpio reset support
  iio: magnetometer: ak8975: Add gpio reset support

 .../bindings/iio/magnetometer/ak8975.txt      | 30 --------
 .../bindings/iio/magnetometer/ak8975.yaml     | 70 +++++++++++++++++++
 drivers/iio/magnetometer/ak8975.c             | 22 +++++-
 3 files changed, 90 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml

-- 
2.17.1

