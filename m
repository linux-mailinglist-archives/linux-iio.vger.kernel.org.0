Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15EE1BA07C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgD0J4K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgD0J4J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 05:56:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA0C0610D5;
        Mon, 27 Apr 2020 02:56:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so19811088wrx.4;
        Mon, 27 Apr 2020 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78897x0Vz8sDaO0Q94P5Aox7/J6SvRZJYjM13t5atvo=;
        b=ZBJEozcW/B2nYEACBeplmtwaIDIjaVdUY70J9ZI7j/o1CBLXPtBtJIoz+awkf9qODn
         zBv6asu3LiVNZK4UIlmfMZiIB4138sSbdwG5ypIE/ZSFrL2LJI/xpAGSIWvMUPxEJdEM
         sNaI2BuGaV7iA+uhM39NpSoMCkQrCoalhRvK+Um+QkduSk2q2DHrFFStVcJIGvbT3ziV
         iNQlc8SveNODARzF4OkbESPiwyVmm3JMmaQqPhYOxcWwHPk25a/nR+Ctb1euCtmLrMDR
         r09avxYMNNfD1ueBP/OAsltcvhWXVPfniPMs5rAqU9xQ48GtbHOjwmVdhhvD+QOUs2LA
         /hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78897x0Vz8sDaO0Q94P5Aox7/J6SvRZJYjM13t5atvo=;
        b=ABhtZ8drq28wkhynT6CdDWvZ55yohFSaDL2n3MXpO4HJT3d1ckHy3qLfCE77sHm7jm
         u/TGOJafzAhsmXnytKn0qVhvLVrlb5g2bpehFnKZ2GvqDWmibbYBrQoehGuHc06Ft6VD
         lhRSJQeTEN+U5Lh4gZGcvAsVjlhaxFneS+wENT7qU4ayIi9kpbxpAXvJ9JScBIYGRV/D
         2cZKDpW4Y2ADXDDG2qxMFIkqOBuz65qs7krTDaudvi2h1Hjgu26uBqmwVcnGRaY5/e/y
         FwKiGi4PvNz4ugJN7cjlDLW+k1Vbej0O6qY/X090EXvDuwle5+GHv0sRVrZt4tPtHe1H
         fquA==
X-Gm-Message-State: AGi0PubzNNnJiw8/vPsmj5ri7MZbLpjwq1SSoKIfFiXwmKfaXuI626jC
        Eg+dvm1poWE71LA/yVK9wDXcnsOnEfc=
X-Google-Smtp-Source: APiQypJmw3gP87szqL6WiP/AjYwYBCy8JLyODqr5Z1MD9+Zw88TK6ydHTdSBMjBSRsK/z2NcabCqRQ==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr26846006wrx.370.1587981367870;
        Mon, 27 Apr 2020 02:56:07 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:7069:9b5d:ebe2:85b8])
        by smtp.gmail.com with ESMTPSA id y10sm14487606wma.5.2020.04.27.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 02:56:07 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v6 0/5] iio: vcnl: Add interrupts support for VCNL4010/20.
Date:   Mon, 27 Apr 2020 11:55:54 +0200
Message-Id: <20200427095559.16131-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Here's a v6 taking Jonathan remarks into account. A new patch is added to fix
i2c measure reads. The driver also uses read_avail callback for sampling
frequency.

Thanks,

Mathieu

Changed from v5:
* Fix i2c measure reads that are broken on the current driver for be16
platforms.
* Use read_avail callback for sampling frequency.
* Move scan_index setting to the correct patch.

Changes from v4:
* Rename vcnl4010_in_periodic_mode into vcnl4010_is_in_periodic_mode
and vcnl4010_thr_enabled into vcnl4010_is_thr_enabled.
Also fix bitmask checking in those functions.
* Refactor vcnl4010_write_proxy_samp_freq to loop in the
other direction.

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

Mathieu Othacehe (5):
  iio: vcnl4000: Fix i2c swapped word reading.
  iio: vcnl4000: Factorize data reading and writing.
  iio: vcnl4000: Add event support for VCNL4010/20.
  iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
  iio: vcnl4000: Add buffer support for VCNL4010/20.

 drivers/iio/light/Kconfig    |   2 +
 drivers/iio/light/vcnl4000.c | 753 ++++++++++++++++++++++++++++++++---
 2 files changed, 689 insertions(+), 66 deletions(-)

-- 
2.26.0

