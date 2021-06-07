Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE11239DF14
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFGOt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFGOt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:49:27 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B82BC061766;
        Mon,  7 Jun 2021 07:47:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f70so1675415qke.13;
        Mon, 07 Jun 2021 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMN59PtZ5z0AUWY25PDNZoVNr0HWxKSo5UEY7flatdQ=;
        b=mMMFOMc3xXuLU2dI9kkPVP7lt8xQkbELvMHdvq1gcyTId+qy9poe//r5RKvfgWkDgB
         gtCDzqAGlFSUyS+es5CUUVNv4e3J049Wa7FjEy5hkkx9In00YvyVbq+kJjYK6EGFhdTU
         tkcC2o8/mI0j5agq7mEE2Fqm/pS7d9AgB0dLpKYeivTvNpe5dSxR70l/1+0NMjBiARUw
         B0WhZzlx9AGoQiYZY72lt5rtYGF0ppuAj82BEFahy5xPE/VTbfGDdX5ABQVH/bz7t5nS
         CXFYwWzwrqVSNsgDTxY27vsSaCuwpuZvAPdSo1Evy1X+UZ0Ld0arluE9Xz9cg59s7MXS
         xePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMN59PtZ5z0AUWY25PDNZoVNr0HWxKSo5UEY7flatdQ=;
        b=DbQ76ABUlFhWdUGviV2s1vNRnmxnRdqFB8f/5kfrYHRSxDdcyzybhOAJys+WB8UfJ8
         azxgwganIIC66+9c5GkuJgvoUVUo5BuwEH64o1gacLzR/F5Cm8H+E+2A/fzooqzDESh8
         LGkTnwgLXKYrWFKvcKOrrtDpomLNw7E1c2hEI4x8WX1BgLh6KJq/pXJoi9nB7f1BrMdX
         QTPJFdWM9IhPwMcuVSL6k/yx7PCrkKBXN1Sfalbdg6mmO64g26W04oxXf6GSXO6azBMq
         jixCeZVlmF03X0mNG/vxOqOuvBh22McGfcXrCy6JKyT58Eak179poOzotcw8qtGYUfKA
         M8Nw==
X-Gm-Message-State: AOAM532nWDONryypWLuMXIXD8k202AehNkN/YLmJGsnRNIdlz7ObABgM
        fq1Rb4kBeqLlWJWz2ItlkI4D1uZ7X1iqhw==
X-Google-Smtp-Source: ABdhPJyMKEUmncihYbm3TcvGSd4UZ4L21nF1Ms/X3hotoYqoY1tW9cs9/9KC8TCbvWuBYUFXpeLspg==
X-Received: by 2002:a37:ad5:: with SMTP id 204mr16770476qkk.373.1623077248168;
        Mon, 07 Jun 2021 07:47:28 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:27 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 0/8] iio: afe: add temperature rescaling support
Date:   Mon,  7 Jun 2021 10:47:10 -0400
Message-Id: <20210607144718.1724413-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add temperature rescaling support to the IIO Analog Front End driver.

This series includes minor bugfixes and adds support for a generic
temperature front end circuit.

As Peter suggested in v1, if the upstream channel has an offset, the
rescaler will default to using the processed value. This was done to
avoid having to process all supported offset an scale type combinations.

At first I tried to use iio_convert_raw_to_processed() to get more
precision out of processed values but ran into issues when one of my
ADCs didn't provide a scale. I tried to address this in the first two
patches.

When adding offset support to iio-rescale, I also noticed that
iio_read_channel_processed() assumes that the offset is always an
integer which I tried to address in the third patch without breaking
valid implicit truncations.

Related to: https://patchwork.kernel.org/project/linux-iio/list/?series=483087

Changes since v1:
- rebase on latest iio `testing` branch
- also apply consumer scale on integer channel scale types
- don't break implicit truncation in processed channel offset
  calculation
- drop temperature AFE flavors in favor of a simpler generic
  implementation

Thanks for your time

Liam Beguin (8):
  iio: inkern: apply consumer scale on IIO_VAL_INT cases
  iio: inkern: apply consumer scale when no channel scale is available
  iio: inkern: error out on unsupported offset type
  iio: inkern: return valid type on raw to processed conversion
  iio: afe: rescale: add upstream offset support
  iio: afe: rescale: add offset support
  iio: afe: rescale: add temperature sensor support
  dt-bindings: iio: afe: add binding for temperature-sense-amplifier

 .../iio/afe/temperature-sense-amplifier.yaml  | 57 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/iio/afe/iio-rescale.c                 | 39 ++++++++++++-
 drivers/iio/inkern.c                          | 46 +++++++++++----
 4 files changed, 131 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml

Range-diff against v1:
 1:  36f038f93537 <  -:  ------------ iio: inkern: always apply scale requested by consumer
 2:  fd3e9a69841a <  -:  ------------ iio: inkern: error out on unsupported offset type
 3:  91c473be7098 <  -:  ------------ iio: afe: rescale: use core to get processed value
 4:  1097973f3bf7 <  -:  ------------ iio: afe: rescale: add offset support
 5:  786badf92421 <  -:  ------------ iio: afe: rescale: add support for temperature sensors
 6:  0cae8abf6a06 <  -:  ------------ dt-bindings: iio: afe: update MAINTAINERS file
 7:  e806c73122f8 <  -:  ------------ dt-bindings: iio: afe: add binding for temperature-sense-rtd
 8:  f156b16ba01a <  -:  ------------ dt-bindings: iio: afe: add binding for temperature-sense-current
 -:  ------------ >  1:  8ebae9e606a2 iio: inkern: apply consumer scale on IIO_VAL_INT cases
 -:  ------------ >  2:  4d6e4d772f94 iio: inkern: apply consumer scale when no channel scale is available
 -:  ------------ >  3:  dd26ddb49658 iio: inkern: error out on unsupported offset type
 -:  ------------ >  4:  56e9e00cab9d iio: inkern: return valid type on raw to processed conversion
 -:  ------------ >  5:  d86fabc43985 iio: afe: rescale: add upstream offset support
 -:  ------------ >  6:  332fdb2d59ae iio: afe: rescale: add offset support
 -:  ------------ >  7:  3eabc81fb9aa iio: afe: rescale: add temperature sensor support
 9:  9bfdfe7d86b7 !  8:  37980da320b2 dt-bindings: iio: afe: add binding for temperature-sense-amplifier
    @@ Commit message
         dt-bindings: iio: afe: add binding for temperature-sense-amplifier
     
         An ADC is often used to measure other quantities indirectly. This
    -    binding describe one cases, the measurement of a temperature through a
    -    voltage sense amplifier such as the LTC2997.
    +    binding describe such a use case, the measurement of a temperature
    +    through an analog front end connected to a voltage channel.
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
    @@ Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml (new)
     +  - Liam Beguin <lvb@xiphos.com>
     +
     +description: |
    -+  When an io-channel measures the output voltage of a temperature IC such as
    -+  the LTC2997, the interesting measurement is almost always the corresponding
    ++  When an io-channel measures the output voltage of a temperature analog front
    ++  end such as an RTD (resistance thermometer) or a temperature to current
    ++  sensor, the interesting measurement is almost always the corresponding
     +  temperature, not the voltage output. This binding describes such a circuit.
     +
     +properties:
    @@ Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml (new)
     +  '#io-channel-cells':
     +    const: 1
     +
    -+  alpha-micro-volts-per-degree:
    -+    description: |
    -+      Output voltage gain of the temperature IC.
    ++  sense-gain-mult:
    ++    $ref: /schemas/types.yaml#/definitions/uint32
    ++    description: Amplifier gain multiplier. The default is <1>.
     +
    -+  use-kelvin-scale:
    -+    type: boolean
    -+    description: |
    -+      Boolean indicating if alpha uses Kelvin degrees instead of Celsius.
    ++  sense-gain-div:
    ++    $ref: /schemas/types.yaml#/definitions/uint32
    ++    description: Amplifier gain divider. The default is <1>.
    ++
    ++  sense-offset-millicelsius:
    ++    description: Amplifier offset. The default is <0>.
     +
     +additionalProperties: false
     +required:
     +  - compatible
     +  - io-channels
    -+  - alpha-micro-volts-per-degree
     +
     +examples:
     +  - |
    -+    znq_temp: iio-rescale0 {
    ++    pt1000_1: temperature-sensor {
     +        compatible = "temperature-sense-amplifier";
     +        #io-channel-cells = <1>;
     +        io-channels = <&temp_adc 3>;
     +
    -+        use-kelvin-scale;
    -+        alpha-micro-volts-per-degree = <4000>;
    ++        sense-gain-mult = <1000000>;
    ++        sense-gain-div = <3908>;
    ++        sense-offset-millicelsius = <(-255885)>;
     +    };
    -+
     +...
     
      ## MAINTAINERS ##
    @@ MAINTAINERS: L:	linux-iio@vger.kernel.org
      F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
      F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
     +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
    - F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
    - F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
      F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
    + F:	drivers/iio/afe/iio-rescale.c
    + 

base-commit: 41340965b4f8055f975f73e1e3d23eff8038f013
-- 
2.30.1.489.g328c10930387

