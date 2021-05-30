Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E16394EC1
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhE3BBH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhE3BBG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F586C061574;
        Sat, 29 May 2021 17:59:28 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id h20so7992359qko.11;
        Sat, 29 May 2021 17:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2CLZOqNCLOtkIGGc1vQejjtBTOblqWdJI35uJ6GHEM=;
        b=oLj3OrVzAJeJTDNaIB9ap9f47u8UhfYH2tUtIPbay7NZ0dizDnt4cI6VZKSC+ftu3D
         EwbrrHuIz5Az0Ory3xitFHeFAwoPIWZyZRuBSAuh2Cnlz5OzDfSZSsAsNb6//9mUDcGC
         iqfFSODikqQ9TJL7HKIMzJWuQzZHaFe3BJoTi74J2gi0abSVrVSOvm+REPD6bbxJKVtb
         6PKx/x7BsmncXPWcO9K1br04Zaj+6WtFuAqt+GEri5ZDmdcXDDjDt8u6+vVzSvZCmSRm
         RqtZYRubEdGuoc+G96/0FLT0h1qu3R5jxUPiQcXmSUj84OCEXS68ZnlRXnBf/RXjfhRd
         E+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2CLZOqNCLOtkIGGc1vQejjtBTOblqWdJI35uJ6GHEM=;
        b=VYuXzDKbuGrdYzVBQIt2Sh0+MyLZaNRghxBX5+lrmYddX+4f2/SmaasQ5jEy0tByue
         Ot9Jbmsn1McUqQcYBu673XyXDZ8LFqMh/nRRLepK94lR0dJ20Afg0rgfAzEhLx3GO9i/
         XqSEYg0AIamsJmwd73CvkxDbf2tqKKUvfPGtrK+gl8okmS/oUhe6Y0JTjWWKXLGifGxm
         Xcx8CcBgr5vuQJqyVt2Rb3TtU2hM0rJ1IwWhuAA6bXs5fKCe5vzXtwLlLeMNvTJg8Gz4
         K2s3TiAkA7M5ENt/v/UvbcLDZvVTlehSe0/RFUGdI8mmWJUYOxKkXJIUnwAoSmT801j/
         HIkg==
X-Gm-Message-State: AOAM531ebUQht1ipbRe2oR7fgHEPqkAS9g5Dkh50z/WB1XUpvTww3hho
        JnFje0blgv3NzUCS3HsoWzY=
X-Google-Smtp-Source: ABdhPJy3qy2srNk3wMck8+qd9/IC+9becSiOJivle5PpHuILqSb6eoub8E5uMe4h4okvv6cOuGvwnA==
X-Received: by 2002:a37:7844:: with SMTP id t65mr10546654qkc.429.1622336367456;
        Sat, 29 May 2021 17:59:27 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:27 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 0/9] iio: afe: add temperature rescaling support
Date:   Sat, 29 May 2021 20:59:08 -0400
Message-Id: <20210530005917.20953-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add temperature rescaling support to the IIO Analog Front End driver.

This series adds support for three kinds of temperature front end
circuits:
- temperature-sense-rtd for which the resistance is proportional to the
  temperature
- temperature-sense-current for which the current is proportional to the
  temperature
- temperature-sense-amplifier for which the voltage is proportional to
  the temperature

At first I tried to use iio_convert_raw_to_processed() to get more
precision out of processed values but ran into issues when one of my
ADCs didn't provide a scale. I tried to address this in first patch.

When adding offset support to iio-rescale, I also noticed that
iio_read_channel_processed() assumes that the offset is always an
integer which I tried to address in the second patch.
If it makes sense to add support for fractional offsets, I could give it
a try in another series.

Related to: https://patchwork.kernel.org/project/linux-iio/list/?series=483087

Thanks for your time

Liam Beguin (9):
  iio: inkern: always apply scale requested by consumer
  iio: inkern: error out on unsupported offset type
  iio: afe: rescale: use core to get processed value
  iio: afe: rescale: add offset support
  iio: afe: rescale: add support for temperature sensors
  dt-bindings: iio: afe: update MAINTAINERS file
  dt-bindings: iio: afe: add binding for temperature-sense-rtd
  dt-bindings: iio: afe: add binding for temperature-sense-current
  dt-bindings: iio: afe: add binding for temperature-sense-amplifier

 .../iio/afe/temperature-sense-amplifier.yaml  |  55 +++++
 .../iio/afe/temperature-sense-current.yaml    |  61 ++++++
 .../iio/afe/temperature-sense-rtd.yaml        |  65 ++++++
 MAINTAINERS                                   |   9 +-
 drivers/iio/afe/iio-rescale.c                 | 190 +++++++++++++++---
 drivers/iio/inkern.c                          |  12 +-
 6 files changed, 354 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml


base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
2.30.1.489.g328c10930387

