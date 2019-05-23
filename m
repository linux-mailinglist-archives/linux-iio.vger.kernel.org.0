Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D016278D2
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEWJH6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 05:07:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34572 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWJH6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 05:07:58 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6B16A26C4A5;
        Thu, 23 May 2019 10:07:56 +0100 (BST)
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
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Expose cros_ec_sensors frequency range via iio sysfs
Date:   Thu, 23 May 2019 11:07:34 +0200
Message-Id: <cover.1558601329.git.fabien.lahoudere@collabora.com>
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

Changes since v1:
- Add a cover letter
- Add Nick Vaccaro SoB to patch 1
- Drop fifo size related code

Fabien Lahoudere (3):
  iio: common: cros_ec_sensors: support protocol v3 message
  iio: common: cros_ec_sensors: add sysfs attribute for frequencies
  docs: iio: add precision about sampling_frequency_available

 Documentation/ABI/testing/sysfs-bus-iio       |   7 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |   6 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 121 +++++++++++++++++-
 drivers/iio/light/cros_ec_light_prox.c        |   6 +-
 drivers/iio/pressure/cros_ec_baro.c           |   6 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |   8 +-
 include/linux/mfd/cros_ec_commands.h          |  21 +++
 7 files changed, 162 insertions(+), 13 deletions(-)

-- 
2.20.1

