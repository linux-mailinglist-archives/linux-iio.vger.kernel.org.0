Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA71D7A11
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgERNhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNhM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:37:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC300C061A0C;
        Mon, 18 May 2020 06:37:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so11856052wrp.12;
        Mon, 18 May 2020 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0wEQMlaUvTH8ksVed4GVXI40odDZq6n0mfuJKz/wn/Q=;
        b=gQKBPQt3iRkD15YkhlAzt7uGrEu+I1N1w06VpMeqf37WkZSjJ7JPwzXulVa52Ww84w
         4gj2LGGw4XySU+DeSmNGBkuI7MEiSebaFPK6jr2DRjPWg4jljemtvP+PkQIxwZhrJWMt
         CEyhS3S/8DPAbmm+kiBUWciWkSf0TfIxw/lVKrL3GAKxCVeupVYoDzigV+A/pugMSI/q
         SaGvZKu6skScnyh7DwrsGLkoFbwVh0rTuzrbWDBWogeGtQPGqMJWudDw22f1xD/IT8+G
         uyNwn4MjsbGdrvLDisCI7tdsMRnehYOxOi3WD8MrWCAXKqv1Gm7jx0VtGB6zBYFdYGRw
         k+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0wEQMlaUvTH8ksVed4GVXI40odDZq6n0mfuJKz/wn/Q=;
        b=W4/lQPCRRKChYKBzkqUB4qfz7hzfoscy/CrVx2TezqMA8zC2X+RlwV6tFRrSeNHT2r
         s3gn9h145ia5Ef2+fIEtgmiGcev/RAECCmjFIfh9krUz0WBhuJAurJWnIMmRG9S7CLvD
         oLZWpn6koBUnFgs1GS497/FwbI3S3SAuGHHiIM8dnIc12YXvvh8TbIuSxT2R9HoccW1F
         hvUYfxGkncezCWaEfQs8PhJjQd0euqodlTe1dEBTSM6ZLjGqrseSL9BeEIrARlO/kcAW
         fgS0sVrXgGtNWS27Id+Znlj9yqLzgJGw3nxF6dU6bxZwmjU84jkC71Vm2rW/UAyDsfhM
         2kMQ==
X-Gm-Message-State: AOAM533gYRyZgETupG+mDemoFMcFdoct4sUzMIK4IymkKsm4D1+DN+uY
        /PFjLiWtrPeSC34/VpebTk8MzdRjH5g=
X-Google-Smtp-Source: ABdhPJybqvRk6/cTVIYSwgFo/qBojTLBUK3CxB6bCR0fM+CcsPJbdUTwiIRyhy+zBDvj7VOcvebQkQ==
X-Received: by 2002:adf:a118:: with SMTP id o24mr19276861wro.330.1589809030049;
        Mon, 18 May 2020 06:37:10 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id o26sm17054328wro.83.2020.05.18.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:37:09 -0700 (PDT)
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
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/3] iio: magnetometer: ak8975: Add gpio reset support
Date:   Mon, 18 May 2020 15:36:35 +0200
Message-Id: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert documentation from txt format to yaml. Add documentation about
reset-gpio. 

Set reset gpio to high on ak8975_power_on, set reset gpio to low on
ak8975_power_off.

Without setting it to high on ak8975_power_on driver's probe fails
on ak8975_who_i_am while checking for device identity for AK09911 chip

AK09911 has a reset gpio to handle register's reset. If reset gpio is
set to low it will trigger the reset. AK09911 datasheed says that if not
used reset pin should be connected to VID and this patch emulates this
situation

Jonathan Albrieux (3):
  dt-bindings: iio: magnetometer: ak8975: convert txt format to yaml
  dt-bindings: iio: magnetometer: ak8975: add gpio reset support
  iio: magnetometer: ak8975: Add gpio reset support

 .../bindings/iio/magnetometer/ak8975.txt      | 30 --------
 .../bindings/iio/magnetometer/ak8975.yaml     | 70 +++++++++++++++++++
 drivers/iio/magnetometer/ak8975.c             | 21 +++++-
 3 files changed, 89 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml

-- 
2.17.1

