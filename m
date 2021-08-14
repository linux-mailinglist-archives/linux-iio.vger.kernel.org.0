Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9B3EC444
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 19:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhHNR5B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 13:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhHNR5A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Aug 2021 13:57:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC23C061764;
        Sat, 14 Aug 2021 10:56:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u15so569817plg.13;
        Sat, 14 Aug 2021 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cs6oaPPljTB0+S+sPjJM9MtEY7KAmNyX9Kmkft2EBOk=;
        b=auBm+DwETbmdnf9jS5r3/nRRLZ6dderzen1M1VtP9EvFVNeVZ+DBFvC0VEIxJz3iuU
         8l8gY8vTi1wG4DvgMYY4ZULxpzDsvWzKFthOIPBLmYXFbaNNk5lkhJ9fVEcWSRPvuC24
         FF+AkusJPfNx5i2l6AQk0lJCZShh+z4S3tlfY+nu0YmLjQPibs2VyaukngCXZfkOf/No
         xwrUQ7aO2eq3zuqab/xPGhg+RWvq9B75BkeILpHe6jcHAZ9lgtJSr8qwl1YR5WRnk2ZC
         i4TWF6iSR4VzeBV2j3/61sMZqjMm1rUD0SuAdUEilXP66FoAnw3isFDYNUCm0W616eiX
         ofdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cs6oaPPljTB0+S+sPjJM9MtEY7KAmNyX9Kmkft2EBOk=;
        b=Op7a5zWZaZ2/OF/6sPHpLbBly/tf2ctjCMixKe8wylYqiw639O3oDaxPxMn9NFOrUu
         BsS3pj9CngcuSl9xT6nCiiM1H7JAyYcQt+2Oy2861n9WJxYN4hzQcBwVY2FBFOkRjbr+
         DXelH69C2fzRpAFCay74Cq9TNkmSJHGDqZ3GzEOkOI1arIIJBn6zh4BlFMQec92FMsd+
         IOFZhBCOS8AwDJoKfc9DmjjT4sZDSXWb3bAmBnmkHX0I97++CqB4297urVzk69rYw2x+
         KTteSETZSd0uDRNOBupC1F27i68DdcodGsIUdgbRGoMWps3zQPjW9LNSMhwi/Do0Th6J
         LTeg==
X-Gm-Message-State: AOAM533tkyK9K9JopMaIFcuO0OQ6NDqCM01HAnWBZ1rVshmuBgL9XO1E
        MCFbzW2oQWCa8JvSAKTTeOE=
X-Google-Smtp-Source: ABdhPJza6zQ5SXSPH8L5SUcy077tZ6Y1AFseIkpXjdhBlTOwKmG4EHXy97qMeGXM7SyNH/w2pR1J0g==
X-Received: by 2002:a62:7e41:0:b029:3e0:9c3f:ab50 with SMTP id z62-20020a627e410000b02903e09c3fab50mr7956500pfc.57.1628963791526;
        Sat, 14 Aug 2021 10:56:31 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6293:2348:f0eb:567b:5544:c735])
        by smtp.googlemail.com with ESMTPSA id q26sm6305380pff.174.2021.08.14.10.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 10:56:30 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 0/2] iio: potentiometer: Add driver support for AD5110
Date:   Sat, 14 Aug 2021 23:25:38 +0530
Message-Id: <20210814175607.48399-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt-bindings and driver support for AD5110, a Nonvolatile 
Digital Potentiometer.

Changes since v2:
 - Drop Redundant blank lines
 - Add missed prefix name
 - Add comma to non terminator line
 - Add missed error code return when ret < 0
 - Explanation for msleep(20)
 - Change to IIO_DEVICE_ATTR_RW()
 - Remove comma for terminator line
 - Drop data->cfg dead code since I'm using probe_new()

Changes since v1: 
 - Drop 'shared_by_type' since it's a single channel
 - Add error check for i2c read/write data bytes
 - Simplified calculation for tolerance
 - Add shift for eeprom wiper pos read
 - Change new custom ABI to existing ABI 
 - Allow top-scale mode by writting max_pos to val 

Mugilraj Dhavachelvan (2):
  dt-bindings: iio: potentiometer: Add AD5110 in trivial-devices
  iio: potentiometer: Add driver support for AD5110

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/potentiometer/Kconfig             |  10 +
 drivers/iio/potentiometer/Makefile            |   1 +
 drivers/iio/potentiometer/ad5110.c            | 345 ++++++++++++++++++
 5 files changed, 364 insertions(+)
 create mode 100644 drivers/iio/potentiometer/ad5110.c

-- 
2.25.1

