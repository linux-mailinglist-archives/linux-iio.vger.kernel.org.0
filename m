Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285D7189799
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 10:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCRJKC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 05:10:02 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42107 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 05:10:02 -0400
Received: by mail-wr1-f49.google.com with SMTP id v11so29302554wrm.9;
        Wed, 18 Mar 2020 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e28C2S//kHe4jqdKcjRXGdpKD49/Om53s4eGmBh94Do=;
        b=tIR0IDHBHKC6djjyI1kGXHehoxutDOa482BqmdeOHL/090CxLNG0+GoZCvJ8b7oCSq
         Sw6uYnWpQN6lw0TIz8Zt7f4dJ/ukGe774ZMKQh4s4Q3DofLKrYQ9xytKXJAInyRF6BVh
         TKHQ6DxEzVikhnWUK9iEdrz/c1Mkz5UZv7ciP0g2E46GB9TZ4OUZkRhtS7fF9lUqtMVE
         HpKEauJtfAbIqnWqu7weGcEVP1XhiPuHepKTU8ekZAV010He6AWlN1wq/xfLabtIToO9
         EowK/bdDL769lDYG8n7P8lWlh1fK5MOZUO6dzCLdQcD4ZohmtI6Q267JfKFKecB+1pEe
         /SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e28C2S//kHe4jqdKcjRXGdpKD49/Om53s4eGmBh94Do=;
        b=uIvEw2zb8ibGgRmeqX49CqM2kDhtuCfSq/pWk8nSP7F49xGu9Ed6l4okOvwQz4Ma5F
         k2L6OrpKKYmoJbG95dgtqmTs8WHSEpwxyZMvxU1YCQCSNrNl0YAALZqnnCIuJAcHezhb
         c6TgcCu37YUmPm6wOkC0UPOd7bnWOo5OlrfPqYh8+w6xZ2QttFtxgpB0gE2MoSzZOY5Y
         tMy8z/IX6U7s4dUMLOMEB2hsF5hyJJhDAbndkfjK4zngXoIe9Cei8GUc/KwiGawbIBYb
         OY7pAR/HBxoM+tJLEwVmtXwKcjBl86oOunD6o7X62y+fgga+agUhbBoLk2kNf8ECx3Oj
         Uvow==
X-Gm-Message-State: ANhLgQ0Mrk3KCIQBkTaLssCxRBuCViwzbmKJPRoMUm8pjn16kG8XXQyF
        A2qNBdXFQqVaD/+R5cKNMXIrjjPRnYg=
X-Google-Smtp-Source: ADFU+vutDa5mYogUhh5sFGje8oF34MGpF16NSRZLFE1xAPgVs7vmd/Qon8vHoEsaBXhRvgRehCqsbA==
X-Received: by 2002:adf:ea03:: with SMTP id q3mr4304859wrm.267.1584522600362;
        Wed, 18 Mar 2020 02:10:00 -0700 (PDT)
Received: from localhost.localdomain ([95.77.248.51])
        by smtp.gmail.com with ESMTPSA id w1sm2823986wmc.11.2020.03.18.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:09:59 -0700 (PDT)
From:   Alexandru Tachici <tachicialex@gmail.com>
X-Google-Original-From: Alexandru Tachici <alexandru.tachici@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH v3 0/6] iio: accel: adxl372: add peak mode
Date:   Wed, 18 Mar 2020 13:09:54 +0200
Message-Id: <20200318110958.8621-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds the possibility to configure
the device, from sysfs, to work in peak mode. This enables
adxl372 to capture only over threshold accelerations.

1. Create sysfs files for falling_period/rising_period
and thresh_falling_value/thresh_rising_value in events/ dir.
Set INT1 reg for activity/inactivity and push
event code in events fifo on irq.

2. Add additional ABIs in order to explain the
user that setting values in the events/ sysfs files
also changes devices behaviour.

3. Update sysfs docs: renames, added two new
entries for the activity_detect_event/
inactivity_detect_event

Alexandru Tachici (3):
  iio: accel: adxl372: add event interface
  iio: accel: adxl372: add additional events ABIs
  iio: accel: adxl372: Update sysfs docs

1. Device FIFO can now be set in peak mode and only over the
threshold accelerations will be stored.

Stefan Popa (1):
  iio: accel: adxl372: Add support for FIFO peak mode

Changelog v2 -> v3:
- now use iio_device_claim_direct_mode before setting peak mode
- if peak mode is enabled and not all axis are enabled, filter out disabled axis
data before iio_push_to_buffers
- add events enable attributes: (thresh_rising_en/thresh_falling_en)
- renamed attr: buffer_peak_mode_enable to hwfifo_peak_mode_enable
- squashed event interface related commits into one

 .../ABI/testing/sysfs-bus-iio-accel-adxl372   |  30 ++
 drivers/iio/accel/adxl372.c                   | 345 +++++++++++++++++-
 2 files changed, 368 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372

-- 
2.20.1

