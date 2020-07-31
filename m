Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7A234974
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbgGaQs7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbgGaQs6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:48:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D4C06174A
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:48:58 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y18so17430984ilp.10
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cVetK5nIesi0/Ex17cIGWVsuuHEr6h7cl14V2jBj1nw=;
        b=EScaqkNKGSq4QWuRYxrAYaJnwueDUzxHY9mh/cVF4h346RmZKs6v8yUUzinpjg1sxt
         xpiyD4LFKIgMxVcsBcRonrv9bM2uyKdt8HLbkCq88gE+EJUV8Vd+1UFr4ZlVAco8LbFx
         4fUWktLLe3pdf3v9+YFZ2l4a/KLMp8tHAwkwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cVetK5nIesi0/Ex17cIGWVsuuHEr6h7cl14V2jBj1nw=;
        b=J1EEVT2ebJRuEtHB+vUqTk4rWnuM5co/JUd3F5aWRQKfwvhUhcp2Sqrdr7m3kPSkjB
         VNV4GbcCJ8bNfr44QgbQtKuAwIjvKmD6gMeh4+oNzC8McqSBkizzorUiakY19LQb9Yf5
         8dV/MUh6E3Fw9v2RVOg1OIOlEyQxkUzGjewxy0OpyMtwqQExyuLNlDqiUXo/DcUxENcI
         KdyurGu5QlL/dFDm3AgyWYKthpFnLsxkC9ps2soCYsq3WFd65spnFWufQd72WPtp7qgy
         fouxO9RJVluocLQf3p9Hp1eGPH0ThBXSGuu5F+4WfPGDSexgqjX6zIbv4XmDrW3ZFOhI
         WJ6w==
X-Gm-Message-State: AOAM530f10IRIB5LZiQdWU195ZDgKCyNyE1Cz36r/RjF8qaF30krMTf+
        pIZVpeCGPkYcBWBG6XTGPwcYAw==
X-Google-Smtp-Source: ABdhPJzSTciSjMie7Y8xMLo8OjSsZRynipy4vTPB1gJIA+BvbQFMFzw5TxwsN5UF9GjSScakMrKZXg==
X-Received: by 2002:a92:c8c5:: with SMTP id c5mr4653054ilq.47.1596214137205;
        Fri, 31 Jul 2020 09:48:57 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:48:56 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3 00/15] sx9310 iio driver updates
Date:   Fri, 31 Jul 2020 10:48:37 -0600
Message-Id: <20200731164853.3020946-1-campello@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The first patch resends the DT binding for the driver that was merged in
v5.8-rc1 with a small change to update for proper regulators. The second
through the eleventh patch fixes several issues dropped from v8 to v9
when the initial patch was merged.  The twelveth patch drops
channel_users because it's unused. The thirteenth patch adds support to
enable the svdd and vdd supplies so that this driver can work on a board
where the svdd supply isn't enabled at boot and needs to be turned on
before this driver starts to communicate with the chip. The final patch
updates irq trigger flags.

Changes in v3:
 - Moved irq presence check down to lower methods
 - Changed buffer to struct type to align timestamp memory properly.
 - Added static assert for number of channels.
 - Added irq trigger flags commit to the series.

Changes in v2:
 - Added #io-channel-cells as a required property
 - Reordered error handling on sx9310_resume()
 - Added #include <linux/mod_devicetable.h>
 - Added '\n' to dev_err()
 - Fixed commit message from "iio: sx9310: Align memory"
 - Changed prox_stat to chan_prox_stat bitmap.
 - Fixed dev_err() message
 - Added '\n' to dev_err()

Daniel Campello (12):
  dt-bindings: iio: Add bindings for sx9310 sensor
  iio: sx9310: Update macros declarations
  iio: sx9310: Fix irq handling
  iio: sx9310: Remove acpi and of table macros
  iio: sx9310: Change from .probe to .probe_new
  iio: sx9310: Fixes various memory handling
  iio: sx9310: Use long instead of int for channel bitmaps
  iio: sx9310: Use regmap_read_poll_timeout() for compensation
  iio: sx9310: Update copyright
  iio: sx9310: Simplify error return handling
  iio: sx9310: Use variable to hold &client->dev
  iio: sx9310: Miscellaneous format fixes

Stephen Boyd (3):
  iio: sx9310: Drop channel_users[]
  iio: sx9310: Enable vdd and svdd regulators at probe
  iio: sx9310: Use irq trigger flags from firmware

 .../iio/proximity/semtech,sx9310.yaml         |  65 +++
 drivers/iio/proximity/sx9310.c                | 429 +++++++++---------
 2 files changed, 282 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

--
2.28.0.163.g6104cc2f0b6-goog

