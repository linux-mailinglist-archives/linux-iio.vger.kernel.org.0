Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F66D6F1
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfGRWy1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12036 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727972AbfGRWy1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:27 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMpxnC028505;
        Fri, 19 Jul 2019 00:54:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=STMicroelectronics;
 bh=tbqMNULwlutC0w1E9MqHFHmo36HMqFmZbgA4rLXWn/c=;
 b=iF+ROkg7nyfwKjtvCuuoqfSvol/yqD0LNiGlQ0TxpYPsE+yaff7MayMIhepUshQe/5f7
 gRXwTmoMlitGJGQcTe/oKaOoYUFxipbSRuWSVD0Btnw/NJ2pibhKOl0NJpCbNgcteDyb
 RAj3BjEmHUpII2P7YGJbVR+a4t5mCyW0pRFuduBmnnOyLORBEQcmlq3s0eo3vTe/WSGw
 c9OJIp4Q3X0PhjSjs+qznCKV5swsQmrdU87y80w44/zWLIMEnFGcaRMM8hqTxR9D21TP
 x3SaH6SObq9XiCfqC2hohUqjCNm1bwebgajswlsYlN3SHmTbr0GCRP2+n2moKHiJC2up Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tq4e9da85-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4EAD34;
        Thu, 18 Jul 2019 22:54:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D28A10A4;
        Thu, 18 Jul 2019 22:54:21 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:20
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 00/11] iio:st_sensors: make use of regmap API
Date:   Thu, 18 Jul 2019 15:53:42 -0700
Message-ID: <20190718225353.2078-1-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Updated patch series for st_sensors driver making use of regmap API.
In order to move the spi 3-wire related into st_sensors_spi.c some
rework was needed that's why in the series I don't export the
multiread bit only but it becomes the full get_settings.

Denis Ciocca (11):
  iio:common:st_sensors: add st_sensors_get_settings_index() helper
    function
  iio:accel: introduce st_accel_get_settings() function
  iio:gyro: introduce st_gyro_get_settings() function
  iio:magn: introduce st_magn_get_settings() function
  iio:pressure: introduce st_press_get_settings() function
  iio:accel: device settings are set immediately during probe
  iio:gyro: device settings are set immediately during probe
  iio:magn: device settings are set immediately during probe
  iio:pressure: device settings are set immediately during probe
  iio: move 3-wire spi initialization to st_sensors_spi
  iio: make st_sensors drivers use regmap

 drivers/iio/accel/st_accel.h                  |   1 +
 drivers/iio/accel/st_accel_buffer.c           |   3 +-
 drivers/iio/accel/st_accel_core.c             |  25 +++-
 drivers/iio/accel/st_accel_i2c.c              |  23 ++-
 drivers/iio/accel/st_accel_spi.c              |  20 ++-
 .../iio/common/st_sensors/st_sensors_buffer.c |  10 +-
 .../iio/common/st_sensors/st_sensors_core.c   | 118 ++++++---------
 .../iio/common/st_sensors/st_sensors_i2c.c    |  73 +++++----
 .../iio/common/st_sensors/st_sensors_spi.c    | 141 +++++++++---------
 .../common/st_sensors/st_sensors_trigger.c    |  10 +-
 drivers/iio/gyro/st_gyro.h                    |   1 +
 drivers/iio/gyro/st_gyro_buffer.c             |   3 +-
 drivers/iio/gyro/st_gyro_core.c               |  25 +++-
 drivers/iio/gyro/st_gyro_i2c.c                |  22 ++-
 drivers/iio/gyro/st_gyro_spi.c                |  20 ++-
 drivers/iio/magnetometer/st_magn.h            |   1 +
 drivers/iio/magnetometer/st_magn_buffer.c     |   3 +-
 drivers/iio/magnetometer/st_magn_core.c       |  25 +++-
 drivers/iio/magnetometer/st_magn_i2c.c        |  22 ++-
 drivers/iio/magnetometer/st_magn_spi.c        |  20 ++-
 drivers/iio/pressure/st_pressure.h            |   1 +
 drivers/iio/pressure/st_pressure_buffer.c     |   3 +-
 drivers/iio/pressure/st_pressure_core.c       |  25 +++-
 drivers/iio/pressure/st_pressure_i2c.c        |  31 ++--
 drivers/iio/pressure/st_pressure_spi.c        |  22 ++-
 include/linux/iio/common/st_sensors.h         |  47 +-----
 include/linux/iio/common/st_sensors_i2c.h     |   4 +-
 include/linux/iio/common/st_sensors_spi.h     |   4 +-
 28 files changed, 399 insertions(+), 304 deletions(-)

-- 
2.22.0

