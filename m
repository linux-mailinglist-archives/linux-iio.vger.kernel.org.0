Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2494449C95
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfFRJHB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 05:07:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59970 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFRJHB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 05:07:01 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8DC9A260A33;
        Tue, 18 Jun 2019 10:06:59 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Expose cros_ec_sensors frequency range via iio sysfs
Date:   Tue, 18 Jun 2019 11:06:31 +0200
Message-Id: <cover.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Chromebooks EC sensors must expose a range of frequencies for each sensors using
the standard ABI sampling_frquency_available.

Changes since v2:

- use read_avail callback
- rework core functions to avoid code duplication

Changes since v1:
- Add a cover letter
- Add Nick Vaccaro SoB to patch 1
- Drop fifo size related code

Fabien Lahoudere (8):
  iio: common: cros_ec_sensors: move iio_info management to core
  iio: common: cros_ec_sensors: move channels to core structure
  iio: common: cros_ec_sensors: move registration to core
  iio: common: cros_ec_sensors: clean code
  iio: common: cros_ec_sensors: use core structure
  iio: common: cros_ec_sensors: support protocol v3 message
  iio: common: cros_ec_sensors: add sysfs attribute for frequencies
  docs: iio: add precision about sampling_frequency_available

 Documentation/ABI/testing/sysfs-bus-iio       |   7 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  | 148 +++++------
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 230 +++++++++++++++---
 drivers/iio/light/cros_ec_light_prox.c        | 124 ++++------
 drivers/iio/pressure/cros_ec_baro.c           | 101 +++-----
 .../linux/iio/common/cros_ec_sensors_core.h   |  43 +++-
 6 files changed, 357 insertions(+), 296 deletions(-)

-- 
2.20.1

