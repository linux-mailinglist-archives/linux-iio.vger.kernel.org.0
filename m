Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6530DEC69E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 17:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKAQXg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 12:23:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39609 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKAQXf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 12:23:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id t8so13590460qtc.6;
        Fri, 01 Nov 2019 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5PXuEODf0tHsyho144HcsLYtl45N8rUUBL79/n/u2Dc=;
        b=s1m1Wu2HbiMUybqjrKlu9+YxcO/lBMy/TrduqCyJSq+m4t2qw4qeaVlpo2BleY9qWj
         3RT3KPLm+AemEFA/pWSd/vjpuWRrOXKbNUaDEcYfIWYPG5HvSWt72mYJfAYDJbg2uoRT
         bnn2QS/HDRHfeI1xNkN554PqxrPdlpt3ktyJ/q9Q7L4Xv3irc3W8jwkaacJZzfTyI1+I
         Gylx1QKRTFHpiCZk5ahos+w2T1TDTuACh0SjJF7OmP21ZeEgCFJAvuW3y+75f4XuIxOV
         NjNF+7kyagCTw/kujkX3uORLs/3rzQUSMkVZfV9nwd/XrVhV47RvwXJif8DVDO2b98T0
         /POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5PXuEODf0tHsyho144HcsLYtl45N8rUUBL79/n/u2Dc=;
        b=nYx/z0xN9cSjEGh2wMCqukHzCMskZHIzh62fkBu+mfH0qguP15FJXxURQgCzGS/n/S
         lK94RgMw/rsEFXYPHa2M4L6PPEAFTiCsu1Y1VV6pbtsPS/B9p79ntMg7ZtgJIdC+Xpmg
         8k1W6Mj+EAHatVmTpXj4qtbunnP1x9CPGP39paxWebMfIgf0tlDJlO3wZIbusDWwbRUJ
         cYTr3nPs/OJigwV1PmvFjitmUS5wGo8aU04iU3URriIM4Gugo+4hvw0N3B2/bI2HxbLK
         lrSQr5cc+Kafwhxj26EEwkGVyi4D55AUMZAoiJbJvg7Yq2bnZJEV5M/Vj5dMUkONfuuq
         oAvw==
X-Gm-Message-State: APjAAAWa7yVgx+Xgxdhf/14fN5k6dQ8pWQ7K0Vv2Os1nrDv0hIA30qgm
        3BnU4qQWXQLtgg35U4rjKlU=
X-Google-Smtp-Source: APXvYqyeAOrrfD5ZBv8n9jmhJcPgdn3Vu5rTDgnGGrWlYKvapgkAOEOLMWKG1p4qOpWPZ+XbSn5gpQ==
X-Received: by 2002:a0c:d2b3:: with SMTP id q48mr10895564qvh.5.1572625414522;
        Fri, 01 Nov 2019 09:23:34 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id a70sm287905qkb.86.2019.11.01.09.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 09:23:34 -0700 (PDT)
Date:   Fri, 1 Nov 2019 13:23:30 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 0/2] iio: adc: Add support for AD7292
Message-ID: <cover.1572614297.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds a basic driver for the AD7292 ADC/DAC system along
with devicetree binding documentation.

Changelog V3:
- dt-binding: changed spi-cpha property
- dt-binding: added spi-cpha to the list of required properties
- dt-binding: renamed example device node
- dt-binding: added ';' to the final curly braces correctly closing dt-schema
- ad7292: fix up a typo in channel macros

Marcelo Schmitt (2):
  dt-bindings: iio: adc: Add dt-schema for AD7292
  iio: adc: Add driver support for AD7292

 .../bindings/iio/adc/adi,ad7292.yaml          | 103 ++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7292.c                      | 350 ++++++++++++++++++
 5 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 create mode 100644 drivers/iio/adc/ad7292.c

-- 
2.23.0

