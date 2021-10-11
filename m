Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60254293FC
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhJKQA0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 12:00:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48502 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233973AbhJKQAZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 12:00:25 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B9sOND023189;
        Mon, 11 Oct 2021 17:58:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=W/s3u3+Z9QbqBfrXJaxmOrhalio76CjYsV89ygdkHVg=;
 b=jGFf6RCXrJDKS9RnjXArl3lt2YWafxnUJ5EUTviALU3rO9LXXkzCBywpwVRKr4TMEJI1
 oi1hVS+QnhjGnOn/GJBJ1sqG+unmbFlunt4CyR4aDX5xyPa7nmVFGd/RMrA5EJe8nusP
 DjVoWE3hWug0O+coFPOO6X0EvWHs4nxI793kPvveeGdeQSlCv31LaKD+xIl8fiXH02QN
 OVMf0ZJbB+AnZ7byHC2qMOUBmStIFT/RqvQjUOC5j9tX3K95ALQ0rzADYe6s29N2t9OF
 aEtsrEN/F04RGyN1c+aNT9R6Bh1XZG0OuSRXDonjbt4JAw1qVedDZpTYfJiykOvZtLkc Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bmdxrkung-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 17:58:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE3D310002A;
        Mon, 11 Oct 2021 17:57:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C3D43231DE0;
        Mon, 11 Oct 2021 17:57:59 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 11 Oct 2021 17:57:59
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
Subject: [PATCH v4 0/7] iio: adc: stm32-adc: add internal channels support
Date:   Mon, 11 Oct 2021 17:57:10 +0200
Message-ID: <20211011155717.1594-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_05,2021-10-11_01,2020-04-07_01
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

Changes in v3:
- fix vrefint sampling time check.

Changes in v4:
- fix binding
- add dedicated spin lock for common register
- manage probe_defer on nvmem read

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
 drivers/iio/adc/stm32-adc-core.c              |   1 +
 drivers/iio/adc/stm32-adc-core.h              |  10 +
 drivers/iio/adc/stm32-adc.c                   | 422 ++++++++++++++++--
 4 files changed, 486 insertions(+), 55 deletions(-)

-- 
2.17.1

