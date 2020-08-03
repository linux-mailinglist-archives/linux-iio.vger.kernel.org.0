Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2723B12C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgHCXnD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgHCXmB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:42:01 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A308C061756
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:42:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x1so12333672ilp.7
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=REBhfBv0y9iheUmDMAD5SkNTWPE8KTprJ/7qrn9ga3c=;
        b=BwL27FbFizHtr8CZDR3cITVgiP+qWBE5wP5lYLn5rgwHEns8KBZg/OK6bN4uOe2Hj/
         toKEV82gKnsOULOibiH6turbMrtUIpvAqaHN8hbV/newGCaAg0PrYsIqNA8BHuad2EUX
         mY0h1crzvcOz14F6VfjDSBtJlMJ3JiobWv7Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=REBhfBv0y9iheUmDMAD5SkNTWPE8KTprJ/7qrn9ga3c=;
        b=QNMS593li++dPMwITaIL1EMH9H9O2Bif/USCSJxy9aciAtwojioq39IQmGQbEoHfzQ
         93mGJ5I90RWzgo2DPpCkc4KVQ5yjSGzJ3NrMtgelcFKsu1XnaGeKFc54QUfjOVi/fhPb
         +lJQku3kQ/v5nTc93aVUba78L/23xwn8Yt71TWbWrG2NeDHFtXX92xNZELHIHmw9/MNw
         2BZq8DrWxEdxtF32PYSgoSBZRqLUf3Ksqp6ZF1fUaHcd3L9A5vNfPB7JSsIf9LSRSSFG
         IWo017mwRAnq+Q9V8ElMGf/rL0T1HRE1OdMuY5ClM7wPEqhC/AJfr3diITp1cuqRxWQB
         3ZLg==
X-Gm-Message-State: AOAM532sEJkI0R0sRFoJZfzzcXESK/IRedjvhb/j/vu8E4ZnR/l3lyE8
        683owYZZs1LDe9bVXlKVLsmHEg==
X-Google-Smtp-Source: ABdhPJxXgPUqxVxsiaMbVWQZoOwwsc+ysCkOr8SgJMnz1sCbbrdYGP3wICNYwI62CvtKlmGJAR1vMw==
X-Received: by 2002:a05:6e02:cac:: with SMTP id 12mr1972194ilg.175.1596498119359;
        Mon, 03 Aug 2020 16:41:59 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:41:58 -0700 (PDT)
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
Subject: [PATCH v4 00/15] sx9310 iio driver updates
Date:   Mon,  3 Aug 2020 17:41:39 -0600
Message-Id: <20200803234154.320400-1-campello@chromium.org>
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

Changes in v4:
 - Updated macro SX9310_REG_STAT1_COMPSTAT_MASK at call site.
 - Use FIELD_GET/FIELD_PREP instead of manual shift.
 - Reverted condition check logic on enable/disable_irq methods.
 - Use pointer to buffer struct on iio_push_to_buffers_with_timestamp().

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
 drivers/iio/proximity/sx9310.c                | 421 +++++++++---------
 2 files changed, 276 insertions(+), 210 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

--
2.28.0.163.g6104cc2f0b6-goog

