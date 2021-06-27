Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB8E3B52DA
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhF0Knm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 06:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhF0Knm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jun 2021 06:43:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECE7C061574
        for <linux-iio@vger.kernel.org>; Sun, 27 Jun 2021 03:41:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q16so11796585lfr.4
        for <linux-iio@vger.kernel.org>; Sun, 27 Jun 2021 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2fNyrggqJtyuzEzEgroA2a/el13YmuqDaWuufAQhz/U=;
        b=NMFJT6RphvT1L6LRQKgvkS3zbvTKaA4po6osgAo/2zNyF8yPTb+Er4fXtcmVAntaI2
         /e31fyc6NSIgLoMzEXdKMFAXlGhxgTvrq8drN6hgK2KX83lIU0325PxSCO/P6C/hoFVq
         XFqHzWtaT9hJ/l9cTva3R1Q284UGqBb66w02DHDXrD2Yf83pROHvaqqau+LgUyBrv7Ui
         UK4ZzdZohyp1CCYM+2TrWcGTUMGLJ0K4Ez+WD0I0s7CF/rDzYHLJnw7pHvXRH7KtSo8p
         UiEkwM3WSj7aPIvSldl5IvaB9Dzvj43rnUSG3W0hp+XsHCOaUS/2h4ex/xui8JvqD5j9
         M/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2fNyrggqJtyuzEzEgroA2a/el13YmuqDaWuufAQhz/U=;
        b=TCDorRdFtNK/9EpZIM5OWVUgcNLSeoxNL3E6Be4tI7/5D6TJU2wYGfa/GGvvX/8UZp
         lbT2PfPy+uIp2ok19jYr3LlEPxq094XVtQG08KfzaPlsh1dkdnfPSO/ua0UZiTD22Wy7
         L4UMdg26ulZAY6Fz2Ze5Pwvi35ruoODaxIs3vYeCXakz6OMcNLtZVDxhuTJ/yYPpS+NK
         jyk4sGCFtDBJcNPClGiyx+QNadIvZynLmOBih40pb2cMn7X6S0yCT66kRC7hyaL0xUzx
         Bm0+WAaLbyIIRA44i4UVFMYSTAeEDObNOBb/d+cYOq5ugYnqn3MFB26J85K4oRbQUwLb
         fVCg==
X-Gm-Message-State: AOAM531D3hUOJSYqK0pFQUT+7KWD15mcC3ESBZ3gC1iXNymXezQ/AH94
        98i3fPQp6O2EUdYucaVaSOO9MzM5vLQtZHAy+bNOO0S9pR4=
X-Google-Smtp-Source: ABdhPJx61LilHvcPVurWE5zjoG1mViCmP1/XYOlKj/oKm6ZmfJP4+WGpOF8R58SC3yHnb0GP3KdH80JhMzCUbBGp6ns=
X-Received: by 2002:a19:6e44:: with SMTP id q4mr15088159lfk.586.1624790476490;
 Sun, 27 Jun 2021 03:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210625235532.19575-1-dipenp@nvidia.com>
In-Reply-To: <20210625235532.19575-1-dipenp@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Jun 2021 12:41:04 +0200
Message-ID: <CACRpkdYovj8Fwv3HknUcD9TzwXL6np081Ay1nPboCW0BFv=Mug@mail.gmail.com>
Subject: Fwd: [RFC 00/11] Intro to Hardware timestamping engine
To:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is an unsolicited forward on the posting of the hardware timestamping
engine that nVidia has, and which might be of interest to IIO as well,
at least we need to make sure the DT bindings and in-kernel interfaces
make sense for the IIO camp.

Yours,
Linus Walleij

---------- Forwarded message ---------
From: Dipen Patel <dipenp@nvidia.com>
Date: Sat, Jun 26, 2021 at 1:48 AM
Subject: [RFC 00/11] Intro to Hardware timestamping engine
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
<linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
<bgolaszewski@baylibre.com>, <warthog618@gmail.com>,
<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
<dipenp@nvidia.com>, <robh+dt@kernel.org>


This patch series introduces new subsystem called hardware timestamping
engine (HTE). It offers functionality such as timestamping through hardware
means in realtime. The HTE subsystem centralizes HTE provider and consumers
where providers can register themselves with subsystem and the consumers can
request interested entity which could be lines, GPIO, signals or buses. The
HTE subsystem provides timestamp in nano seconds, having said that the provider
need to convert the timestamp if its not in that unit. There was upstream
discussion about the same at
https://lore.kernel.org/lkml/4c46726d-fa35-1a95-4295-bca37c8b6fe3@nvidia.com/

To summarize upstream discussion:
- It was heavily favoured by Linus and Kent to extend GPIOLIB and supporting
GPIO drivers to add HTE functionality and I agreed to experiment with it.
This patch series implements and extends GPIOLIB and GPIO tegra driver.
- Discussed possibility to add HTE provider as irqchip instead which
was argued against as HTE devices are not necessarily event emitting
devices.
- Discussed other possibility if HTE device can be added as posix clock
type like PTP clocks. That was also argues against since HTE devices
are not necessarily tightly coupled with hardware clock.

Typical HTE provider does following:
- Register itself with HTE subsystem
- Provide *request, *release, *enable, *disable timestamp callbacks and
optional get_clk_src_info callback to HTE subsystem.
- Provide optional xlate callback to the subsystem which can translate
consumer provided logical ids into actual ids of the entity, where entity here
is the provider dependent and could be GPIO, in chip lines or signals, buses
etc...This converted id will be used between HTE subsystem and the provider for
below bullet point.
- Push timestamps to the subsystem. This happens when HTE provider has
timestamp data available and willing to push it to HTE subsystem. The HTE
subsystem stores it into software buffer for the consumers.
- Unregister itself

Typical HTE consumer does following:
- Request interested entity it wishes to timestamp in realtime to the
subsystem. During this call HTE subsystem allocates software buffer to
store timestamps data.
- The subsystem does necessary communications with the provider to
complete the request, which includes translating logical id of the entity to
provider dependent physical/actual id and enabling hardware timestamping on
requested id.
- It can optionally specify callback during registration, this cb will
be called when provider pushes timestamps. Once notified through cb, the
consumer can call retrieve API to read the data from the software buffer.
If cb is not provided, the consumers can elect to call blocking version of
retrieve API.
- Manage pre allocated software buffer if needed. It includes changing buffer
length and watermark/threshold. The subsystem automatically sets watermark or
threshold at 1, consumers can later change it to any other value it wishes. The
main purpose for having threshold functionality is to notify consumer either
through callback if provided or unblock waiting consumer when threshold is
reached.
- Retrieve timestamp using various means provided by subsystem.
- Release entity and its resources.

HTE and GPIOLIB:
- For the HTE provider which can timestamp GPIO lines.
- For the GPIO consumers, either in kernel or userspace, The GPIOLIB and its
CDEV framework are extended as frontend to the HTE by introducing new APIs.
- Tegra194 AON GPIO controller has HTE support also known as GTE
(Generic Timestamping Engine). The tegra gpio driver is modified to accommodate
HTE functionality.

Dipen Patel (11):
  Documentation: Add HTE subsystem guide
  drivers: Add HTE subsystem
  hte: Add tegra194 HTE kernel provider
  dt-bindings: Add HTE bindings
  hte: Add Tegra194 IRQ HTE test driver
  gpiolib: Add HTE support
  gpio: tegra186: Add HTE in gpio-tegra186 driver
  gpiolib: cdev: Add hardware timestamp clock type
  tools: gpio: Add new hardware clock type
  hte: Add tegra GPIO HTE test driver
  MAINTAINERS: Added HTE Subsystem

 .../bindings/gpio/nvidia,tegra186-gpio.txt    |    7 +
 .../devicetree/bindings/hte/hte-consumer.yaml |   47 +
 .../devicetree/bindings/hte/hte.yaml          |   34 +
 .../bindings/hte/nvidia,tegra194-hte.yaml     |   83 +
 Documentation/hte/hte.rst                     |  198 +++
 Documentation/hte/index.rst                   |   21 +
 Documentation/hte/tegra194-hte.rst            |   65 +
 Documentation/index.rst                       |    1 +
 MAINTAINERS                                   |    8 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/gpio/gpio-tegra186.c                  |   78 +
 drivers/gpio/gpiolib-cdev.c                   |   65 +-
 drivers/gpio/gpiolib.c                        |   92 ++
 drivers/gpio/gpiolib.h                        |   11 +
 drivers/hte/Kconfig                           |   49 +
 drivers/hte/Makefile                          |    4 +
 drivers/hte/hte-tegra194-gpio-test.c          |  255 +++
 drivers/hte/hte-tegra194-irq-test.c           |  400 +++++
 drivers/hte/hte-tegra194.c                    |  554 +++++++
 drivers/hte/hte.c                             | 1368 +++++++++++++++++
 include/linux/gpio/consumer.h                 |   21 +-
 include/linux/gpio/driver.h                   |   13 +
 include/linux/hte.h                           |  278 ++++
 include/uapi/linux/gpio.h                     |    1 +
 tools/gpio/gpio-event-mon.c                   |    6 +-
 26 files changed, 3657 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/hte.yaml
 create mode 100644
Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
 create mode 100644 Documentation/hte/hte.rst
 create mode 100644 Documentation/hte/index.rst
 create mode 100644 Documentation/hte/tegra194-hte.rst
 create mode 100644 drivers/hte/Kconfig
 create mode 100644 drivers/hte/Makefile
 create mode 100644 drivers/hte/hte-tegra194-gpio-test.c
 create mode 100644 drivers/hte/hte-tegra194-irq-test.c
 create mode 100644 drivers/hte/hte-tegra194.c
 create mode 100644 drivers/hte/hte.c
 create mode 100644 include/linux/hte.h

--
2.17.1
