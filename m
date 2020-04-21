Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747D01B2073
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgDUHzl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUHzl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 03:55:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B684CC061A0F;
        Tue, 21 Apr 2020 00:55:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so2536910wml.2;
        Tue, 21 Apr 2020 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KHZNctYOhjFckhn2qMQlu+HnNBvg93+938BxzB/qXk=;
        b=rD4G4DY+VhyR8RlILQ8P5h6uIb96WX59w47l9toPCaaDFia2jKbT3IMMXkZ5wtDxu6
         +r06QIqmZoIh16Fki/4nI2NPrAED8m74o0mUxULApjNPMKeaUeJwLnnYkfgAqaAMzUEQ
         BCxTPPmB/XPJXC3yLP/xfzhgXdonVOpJp74S+c4K/NYCE02sYCis2zR8EVcKVHRR0yWM
         iHwgSM/3NrWal8kWuypWMosb4PVO+NfGHoRMUa736Ix8JNeKpogoRKrVczmFcPKMgNso
         XgepSBebYVt8BZdTbOVU236FAEuzYz5+vAQLRERHiKdC7iOyam5pbY1Be088DUL/swmF
         uxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KHZNctYOhjFckhn2qMQlu+HnNBvg93+938BxzB/qXk=;
        b=Wj2i3jyXrVEvaCVU/HAIOsXlUoUrx8hlSgRHYS4qONboV8m6+JT7dRNRvvVViXxy4f
         HTqqomidJKshqIfjiyEcF6399/f35cgFDpB/J6U6/MLoGI1AehnXibjPRgwxmT8xj+2U
         meJLvnvGYPEzPhasnp6dCuen2WtDSQ8JN1dCYX7GYYQz6MMamL3Fs4XHEII7wOJqxfVK
         ohq35H1ZbLIwC7uzqsLQQk6iH4SQOSTrwKouzc4PTo6LbrTPmEsnVeKeFCQeP4NkPRuK
         Lh7zoRDZGEuj4Fso9OdTNgI0+D9wlKv9VuWdpZHSgW42l83ERi3UaaHjo7Jq/hixKHFO
         OvqA==
X-Gm-Message-State: AGi0PuaKolV0+X7o3JlRacjADKDimu1f8N2hZH2bEwPkAi69/JprOGmB
        Ea6OdBGomJohkgwNunSweJw=
X-Google-Smtp-Source: APiQypL62K50g4PegXCteX7g4tERnjiyhSM92fWXcY/FKxxnndsAHDVief66jJxPR/WOaiYRCzqxNw==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr3410328wmk.36.1587455739444;
        Tue, 21 Apr 2020 00:55:39 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:f9a2:4:b043:a3fb])
        by smtp.gmail.com with ESMTPSA id c190sm2514510wme.10.2020.04.21.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:55:38 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v4 0/4] iio: vcnl: Add interrupts support for VCNL4010/20.
Date:   Tue, 21 Apr 2020 09:55:28 +0200
Message-Id: <20200421075532.19192-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Here's a v4 addressing Peter and Andy remarks. The most important change is
the removal of most mutex uses, as i2c accesses are already protected
by the i2c framework.

Thanks,

Mathieu

Changes from v3:
* Use i2c_smbus_read_byte_data and i2c_smbus_write_word_data
for read and write functions.
* Rename vcnl4010_prox_threshold to vcnl4010_config_threshold.
* Do not lock i2c accesses as they are already protected.
* Fix a typo in irq name.
* Do not provide ALS sampling frequency operation, as ALS data
are not buffered anymore.
* Return bool in vcnl4010_in_periodic_mode and vcnl4010_thr_enabled
functions.

Changes from v2:
* Rebase on iio testing branch.
* Remove useless test in vcnl4010_probe_trigger.

Changes from v1:
* Split into four different patches.
* Use iio_device_claim_direct_mode to protect
raw access from buffer capture.
* Requesting a sampling frequency above the limit is no longer possible.
* Inline read_isr and write_isr functions.
* Remove IIO_LIGHT data from buffer capture.
* Make sure postenable and predisable functions respect the common form.
* Do not set the trigger by default.
* Remove the devm_iio_triggered_buffer_setup top half.

Mathieu Othacehe (4):
  iio: vcnl4000: Factorize data reading and writing.
  iio: vcnl4000: Add event support for VCNL4010/20.
  iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
  iio: vcnl4000: Add buffer support for VCNL4010/20.

 drivers/iio/light/Kconfig    |   2 +
 drivers/iio/light/vcnl4000.c | 747 +++++++++++++++++++++++++++++++----
 2 files changed, 683 insertions(+), 66 deletions(-)

-- 
2.26.0

