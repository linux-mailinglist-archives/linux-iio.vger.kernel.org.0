Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A2414D19
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhIVPgp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 11:36:45 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46428 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236437AbhIVPgo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 11:36:44 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MFFasJ027607;
        Wed, 22 Sep 2021 17:34:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=Lr0bM1q7p7A5V6d2HWR0Wdwxxfx2AsBqJVanDijXVaU=;
 b=8JFMPNj051qtIXybDMir4IW0t6Hld7JhMJfomvr85W6yevjLExIJl+b4xlkJiNDHCbvh
 ZNkxfYySN+Lams9JxtMN2U+AtICg44Xh6LnCQ66eGjaDonZAj0qBYN5CAXYy6xYjYub1
 /jpd2pZB5DkAP2u5xPp11de+wIoFkhN5e6ubaq+tTyZXTpJvuuxJIF0dQwYjt/TPKmJb
 OGzX7ALuNW3pu5urwlpxE6x4yOskQWa4it6v/pFUspdSf4ZdEp7rBRiWE8iQFrX9Uf+T
 KTqlYBHqvYzCyDriumcyuytRUDYYRebG6LZV1/5+ubfkHxkfNtZvt0AlXXV55JIwyzQg pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b8347svge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 17:34:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 764C210002A;
        Wed, 22 Sep 2021 17:34:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DAD524187A;
        Wed, 22 Sep 2021 17:34:52 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep 2021 17:34:51
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/7] iio: adc: stm32-adc: add internal channels support
Date:   Wed, 22 Sep 2021 17:34:11 +0200
Message-ID: <20210922153418.21033-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_06,2021-09-22_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support of ADC2 internal channels VDDCORE, VREFINT and VBAT
on STM32MP15x SoCs. The generic IIO channel bindings is also introduced here
to provide this feature. The legacy channel binding is kept for backward compatibility.

Changes in v2:
- Add 'deprecated' to channels legacy properties in ADC bindings
- Add set/clr service for common registers, to make code more generic in
  internal channels enable/disable services.
- Expose vrefint channel as a processed channel to return
  the actual value of vrefp.
- Minor code improvements

Olivier Moysan (7):
  dt-bindings: iio: stm32-adc: add generic channel binding
  dt-bindings: iio: stm32-adc: add nvmem support for vrefint internal
    channel
  iio: adc: stm32-adc: split channel init into several routines
  iio: adc: stm32-adc: add support of generic channels binding
  iio: adc: stm32-adc: add support of internal channels
  iio: adc: stm32-adc: add vrefint calibration support
  iio: adc: stm32-adc: use generic binding for sample-time

 .../bindings/iio/adc/st,stm32-adc.yaml        | 108 ++++-
 drivers/iio/adc/stm32-adc-core.h              |   8 +
 drivers/iio/adc/stm32-adc.c                   | 424 ++++++++++++++++--
 3 files changed, 485 insertions(+), 55 deletions(-)

-- 
2.17.1

