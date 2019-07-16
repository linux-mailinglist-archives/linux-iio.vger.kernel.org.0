Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB956A4A3
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfGPJL0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 05:11:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58754 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731581AbfGPJLZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2019 05:11:25 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8da1:9c00:f43f:8285:c795:bffa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 800D328B7D3;
        Tue, 16 Jul 2019 10:11:23 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/1] Expose cros_ec_sensors frequency range via iio sysfs
Date:   Tue, 16 Jul 2019 11:11:05 +0200
Message-Id: <cover.1563268064.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Chromebooks EC sensors must expose a range of frequencies for each sensors using
the standard ABI sampling_frquency_available.

This patch needs https://lkml.org/lkml/2019/7/2/345

Changes since v4:
- Remove trailing whitespace
- Use checkpatch.pl successfully

Changes since v3:
- Split patch 6
- Drop clean up patches
- Fix minor changes

Changes since v2:
- use read_avail callback
- rework core functions to avoid code duplication

Changes since v1:
- Add a cover letter
- Add Nick Vaccaro SoB to patch 1
- Drop fifo size related code

Fabien Lahoudere (1):
  iio: common: cros_ec_sensors: Expose cros_ec_sensors frequency range
    via iio sysfs

 .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 65 +++++++++++++++++++
 drivers/iio/light/cros_ec_light_prox.c        |  3 +
 .../linux/iio/common/cros_ec_sensors_core.h   | 21 ++++++
 4 files changed, 92 insertions(+)

-- 
2.20.1

