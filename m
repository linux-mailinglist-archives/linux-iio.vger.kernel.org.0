Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF94960E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 01:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFQXuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 19:50:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43664 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbfFQXuQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 19:50:16 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HNkFOp021454;
        Tue, 18 Jun 2019 01:50:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=STMicroelectronics;
 bh=Sp8DiK8sYIq0lkn6ngtuCxv6tqYrY1I8jQR7zX3uDVU=;
 b=e8RIclCLf1i9W1lpIXpo1XkPAFbQPT7R2tUTcDh0WxwgC2+q4FjXjMaUngXD8NbkrD+e
 kI9mQkNGaiXQUVS45+wSxJCvbrX82dXuDGfCxmM7Q/nvOXI/op0J2Jw+9u9BvUo8wkeH
 ImugkJ7egYsrRHyyqw7ZgfGl1q3L1SBlocX0TJ72fQTPohjr0BbhmIGnvNKmMxfxILZg
 RRP7T+QnoSOboJOWKwb1qQId6e8FO9+aW8z/ow/Iiu3mtvira/UZEjEJiZgaduNi1ORX
 Avf72vA+6/3R92HAtneKBGwju68nJnvqnwzg0JVZd7fgSLfWXLl/1YgdIyqDUXdUZbmZ YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4qjhvws1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 01:50:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 456EF34;
        Mon, 17 Jun 2019 23:50:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C1AB1276;
        Mon, 17 Jun 2019 23:50:10 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG2NODE1.st.com (10.75.127.4)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Jun 2019 01:50:09
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <denis.ciocca@st.com>, <lorenzo@kernel.org>
Subject: [PATCH 0/7] iio:st_sensors: make use of regmap API
Date:   Mon, 17 Jun 2019 16:49:36 -0700
Message-ID: <20190617234943.10669-1-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_09:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series is meant to replace I2C/SPI APIs and make use of regmap
to reduce redundancy.

Denis Ciocca (7):
  iio:common:st_sensors: add st_sensors_get_settings_index() helper
    function
  iio:accel: introduce st_accel_multiread_bit() function
  iio:magn: introduce st_magn_multiread_bit() function
  iio:gyro: introduce st_gyro_multiread_bit() function
  iio:pressure: introduce st_pressure_multiread_bit() function
  iio: make st_sensors driver use regmap
  iio:common: make st_sensors_write_data_with_mask() inline

 drivers/iio/accel/st_accel.h                  |   1 +
 drivers/iio/accel/st_accel_core.c             |  19 +++-
 drivers/iio/accel/st_accel_i2c.c              |   7 +-
 drivers/iio/accel/st_accel_spi.c              |   6 +-
 .../iio/common/st_sensors/st_sensors_buffer.c |  10 +-
 .../iio/common/st_sensors/st_sensors_core.c   |  90 ++++++++-------
 .../iio/common/st_sensors/st_sensors_i2c.c    |  65 +++++------
 .../iio/common/st_sensors/st_sensors_spi.c    | 103 +++++-------------
 .../common/st_sensors/st_sensors_trigger.c    |  10 +-
 drivers/iio/gyro/st_gyro.h                    |   1 +
 drivers/iio/gyro/st_gyro_core.c               |  19 +++-
 drivers/iio/gyro/st_gyro_i2c.c                |   5 +-
 drivers/iio/gyro/st_gyro_spi.c                |   6 +-
 drivers/iio/magnetometer/st_magn.h            |   1 +
 drivers/iio/magnetometer/st_magn_core.c       |  19 +++-
 drivers/iio/magnetometer/st_magn_i2c.c        |   5 +-
 drivers/iio/magnetometer/st_magn_spi.c        |   6 +-
 drivers/iio/pressure/st_pressure.h            |   1 +
 drivers/iio/pressure/st_pressure_core.c       |  19 +++-
 drivers/iio/pressure/st_pressure_i2c.c        |   5 +-
 drivers/iio/pressure/st_pressure_spi.c        |   6 +-
 include/linux/iio/common/st_sensors.h         |  41 +------
 include/linux/iio/common/st_sensors_i2c.h     |   5 +-
 include/linux/iio/common/st_sensors_spi.h     |   5 +-
 24 files changed, 230 insertions(+), 225 deletions(-)

-- 
2.22.0

