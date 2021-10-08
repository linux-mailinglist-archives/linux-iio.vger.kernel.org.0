Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DBC4268BB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbhJHLak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 07:30:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65262 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240344AbhJHLah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 07:30:37 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1981fMeI003084;
        Fri, 8 Oct 2021 07:28:28 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bhtt1pmwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 07:28:28 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 198BSQeq029968
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Oct 2021 07:28:27 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 8 Oct 2021 04:28:25 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 8 Oct 2021 04:28:25 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 8 Oct 2021 04:28:25 -0700
Received: from andrei-VirtualBox.ad.analog.com (ADRIMBAR-L02.ad.analog.com [10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 198BSMC4022852;
        Fri, 8 Oct 2021 07:28:22 -0400
From:   <andrei.drimbarean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <fazilyildiran@gmail.com>,
        <andrei.drimbarean@analog.com>, <robh+dt@kernel.org>,
        <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
Subject: [PATCH 0/2] ADPD188 linux driver
Date:   Fri, 8 Oct 2021 14:27:45 +0300
Message-ID: <20211008112747.79969-1-andrei.drimbarean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oP_EpB22cHIlZEo76gJQOYq3h1USiML8
X-Proofpoint-GUID: oP_EpB22cHIlZEo76gJQOYq3h1USiML8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110080067
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Andrei Drimbarean <andrei.drimbarean@analog.com>

The ADPD188BI is a complete photometric system for smoke 
detection using optical dual wavelength technology. The module 
integrates an efficient photometric front end, two light 
emitting diodes (LEDs), and two photodiodes (PDs). 

The front end of the application specific integrated circuit 
(ASIC) consists of a control block, a 14-bit analog-to-digital 
converter (ADC) with a 20-bit burst accumulator, and three 
flexible, independently configurable LED drivers.

Datasheet information here: https://www.analog.com/media/en/technical-documentation/data-sheets/adpd188bi.pdf

The device is controlled via either SPI or I2C interface.

The first implementation used adpd188_spi/i2c.c to initialize regmap that
was then used in the core driver source. But the I2C implementation needed
to work with multiple daisy-chained devices. The properties of the
daisy-chained devices is that only one of them sets the sampling rate
automatically while the others sample when they receive a sample ready
signal from the previous device and only the last of the chain forwards and
interrupt to the host, which needs to read data from all devices at that
point.

Moreover, all devices start on power-up with the same I2C address, which is
not configurable in the hardware. It needs to be configured in software by
changing a register. To differentiate between devices that need to change
address and those that don't we set devices to change only when their GPIO1
is held high. Each device has its GPIO1 tied to GPIO0 of the previous
device, except the first device, which has its GPIO1 tied low.

So the way to change the addresses is as follows:
 1. Set all GPIO1 to high.
 2. Change devices that have GPIO1 tied high to a new address.
 3. Change GPIO1 to low for devices of the old address.
 4. Go to new address and repeat from step 1.

Because of this, a single driver instance ends up controlling multiple
physical devices that are daisy-chained at the same time.

Andrei Drimbarean (2):
  dt-bindings: add adpd188 schema
  drivers:iio:light: add ADPD188 driver support

 .../bindings/iio/light/adi,adpd188.yaml       |   72 +
 drivers/iio/light/Kconfig                     |   30 +
 drivers/iio/light/Makefile                    |    3 +
 drivers/iio/light/adpd188.c                   | 1389 +++++++++++++++++
 drivers/iio/light/adpd188.h                   |   64 +
 drivers/iio/light/adpd188_i2c.c               |  243 +++
 drivers/iio/light/adpd188_spi.c               |   97 ++
 7 files changed, 1898 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml
 create mode 100644 drivers/iio/light/adpd188.c
 create mode 100644 drivers/iio/light/adpd188.h
 create mode 100644 drivers/iio/light/adpd188_i2c.c
 create mode 100644 drivers/iio/light/adpd188_spi.c

-- 
2.25.1

