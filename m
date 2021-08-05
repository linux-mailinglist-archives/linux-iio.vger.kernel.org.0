Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842AF3E0E58
	for <lists+linux-iio@lfdr.de>; Thu,  5 Aug 2021 08:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhHEG3l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Aug 2021 02:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhHEG3k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Aug 2021 02:29:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828FC061765;
        Wed,  4 Aug 2021 23:29:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u2so5841070plg.10;
        Wed, 04 Aug 2021 23:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=U53GwXYPNVuC1gL+sQD0tXMRZ6iejl3JWOU1xEqukTk=;
        b=ach9Ysibc1+qPY3gNEAcvpur9xtW8yK4ei16NUX1LDj5nQTw/0aeFu+XNCu7/JwtHf
         RAs09VadBj44MuoBrJw05L8TGSLPj3DdBXulL13Bf1zpypQD3UgV4NECuu5TqEHijmI2
         QRxzciYP2H3KooXw75DZrYGNgqXQiPX5/Q/yIRnhs9N3EDboeq/5ZxuV2ct9E/ZIMM95
         8j1Y5nFJWRP4mLyIvsgflxnXaexC81eX8MEl236b9DrDBiy3TTfzBKcxadTb35P99Bhd
         nOXchdRhKbHJPcE97tYbb85a9zwqushZAFxQisMV9ku/7DfgvFZ6s2MZojmCJlDdyBT9
         OJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=U53GwXYPNVuC1gL+sQD0tXMRZ6iejl3JWOU1xEqukTk=;
        b=QKoM4fSHYzC1VnNSM1Zjvc4kne1hQjb3sA/j0yU/3sHOyMEJS1ZTKNmx2f90KVcj7m
         03XP4JZ53NCavcCbyTogUkb9+5thieiBSDFUMYUvz7K2owqb44w6tA36z7p85WhRvRIi
         BEBsHqnlU7ylr4fSTy8iBWJUX9r2MzZs1h5mGW2RhCHCVETfqOv9fogh7dzOZgV1lf4H
         kctnPQiHsfcXPnKXAZt8Am5O3XAyyYvVLzFDRSRFRo7TgRwxP2i7YgybnZUoyru0QqpE
         znMDRRCDOlctI4ojzl8tMA+msxvWpDi5noETbZe4et4XUj0hwdAF9G3/ToV5olWEAjgQ
         VsNg==
X-Gm-Message-State: AOAM532+kgmehnLTjdqJKjBuIM2Ff/9XUmEQnTls0qDbn2ij9kPdkVQD
        ambUJTEprrj0wIeGCXFIWKZuYY/oRenczluBWRQ=
X-Google-Smtp-Source: ABdhPJyPW415gwzwiMfbqVh5mv6MZKafTnj3YOo+j7pXiH2SnDDZzSlGt1N9fwAMU2uaw0Wr65AMlw==
X-Received: by 2002:a05:6a00:b83:b029:352:9507:f3b9 with SMTP id g3-20020a056a000b83b02903529507f3b9mr3287576pfj.13.1628144965598;
        Wed, 04 Aug 2021 23:29:25 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1005])
        by smtp.gmail.com with ESMTPSA id c27sm5138656pfj.34.2021.08.04.23.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 23:29:25 -0700 (PDT)
Date:   Thu, 5 Aug 2021 03:29:21 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: accel: Add support for ADXL313 accelerometer
Message-ID: <cover.1628143857.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver support and dt-bindings documentation for ADXL313 digital
accelerometer.

Changelog v1 -> v2:
- Add vs-supply, vdd-supply and interrupt-names fields in the dt doc
- Add default case for switch statements
- Use function pointer argument in core_probe for interface specific setup
- Check `spi->mode & SPI_3WIRE` to enable the device's 3wire mode
- Remove unnecessary 0s from id structs and commas after null terminators

Lucas Stankus (2):
  dt-bindings: iio: accel: Add binding documentation for ADXL313
  iio: accel: Add driver support for ADXL313

 .../bindings/iio/accel/adi,adxl313.yaml       |  90 +++++
 MAINTAINERS                                   |   9 +
 drivers/iio/accel/Kconfig                     |  29 ++
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl313.h                   |  63 ++++
 drivers/iio/accel/adxl313_core.c              | 321 ++++++++++++++++++
 drivers/iio/accel/adxl313_i2c.c               |  65 ++++
 drivers/iio/accel/adxl313_spi.c               |  85 +++++
 8 files changed, 665 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
 create mode 100644 drivers/iio/accel/adxl313.h
 create mode 100644 drivers/iio/accel/adxl313_core.c
 create mode 100644 drivers/iio/accel/adxl313_i2c.c
 create mode 100644 drivers/iio/accel/adxl313_spi.c

-- 
2.32.0

