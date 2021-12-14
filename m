Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22E7474891
	for <lists+linux-iio@lfdr.de>; Tue, 14 Dec 2021 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhLNQ4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 11:56:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3244 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235926AbhLNQ4h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 11:56:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEA0aaU023006;
        Tue, 14 Dec 2021 11:56:18 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cxemctxdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 11:56:18 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1BEGuHgQ031273
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 11:56:17 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 14 Dec 2021 11:56:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 14 Dec 2021 11:56:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 14 Dec 2021 11:56:16 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.5])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1BEGuEop021154;
        Tue, 14 Dec 2021 11:56:14 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 0/3] Add support for LTC2688
Date:   Tue, 14 Dec 2021 17:56:05 +0100
Message-ID: <20211214165608.7903-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: FjExbIYEDj6iVj1XhcWnFg2WoH43-Ida
X-Proofpoint-GUID: FjExbIYEDj6iVj1XhcWnFg2WoH43-Ida
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112140092
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ABI defined for this driver has some subtleties that were previously
discussed in this RFC [1]. This might not be the final state but,
hopefully, we are close to it:

toggle mode channels:

 * out_voltageY_toggle_en
 * out_voltageY_raw1
 * out_voltageY_symbol

dither mode channels:

 * out_voltageY_dither_en
 * out_voltageY_dither_raw
 * out_voltageY_dither_raw_available
 * out_voltageY_dither_frequency
 * out_voltageY_dither_frequency_available
 * out_voltageY_dither_phase
 * out_voltageY_dither_phase_available

Default channels won't have any of the above ABIs. A channel is toggle
capable if the devicetree 'adi,toggle-mode' flag is set. For dither, the
assumption is more silent. If 'adi,toggle-mode' is not given and a
channel is associated with a TGPx pin through 'adi,toggle-dither-input',
then the channel is assumed to be dither capable (there's no point in
having a dither capable channel without an input clock).

There are some stuff where I'm still not 100% convinced though:

1. out_voltageY_dither_raw refers to the dither amplitude. There are some
differences but in essence, the same scale as the raw attr applies. That
is not true for the offset as it's always 0. This is stated in the ABI
file and being an amplitude is more or less obvious. However, I'm not
sure if it's still valuable to have an ut_voltageY_dither_offset?

2. For now, if 'adi,toggle-dither-input' is given, a correspondent clock
as to be given as well. While this makes sense for dither channels, I'm
not so sure for toggle ones. I can easily see a toggled channel being
controlled by, for example, an host GPIO.

3. Dither capable channels are being silently "assumed" by the driver.
Not sure if an "adi,mode" dt property would make sense. Having this
explicitly could make it easier to express some dependencies in the
bindings file.

4. For now the clocks property is not part of the channels object.
The reason for this is that we only have 3 possible clocks for 16
channels so I wanted to avoid getting and enabling the same clock more
than once. But that is not really an issue and together with 3) it
could, again, make it easier to express some dependencies in the bindings
file. That said, I'm pending in doing this property a channel one (as it
truly is) unless I get feedback otherwise.

[1]: https://marc.info/?l=linux-iio&m=163662843603265&w=2

Nuno Sá (3):
  iio: dac: add support for ltc2688
  iio: ABI: add ABI file for the LTC2688 DAC
  dt-bindings: iio: Add ltc2688 documentation

 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |   67 +
 .../bindings/iio/dac/adi,ltc2688.yaml         |  146 +++
 MAINTAINERS                                   |    9 +
 drivers/iio/dac/Kconfig                       |   11 +
 drivers/iio/dac/Makefile                      |    1 +
 drivers/iio/dac/ltc2688.c                     | 1081 +++++++++++++++++
 6 files changed, 1315 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
 create mode 100644 drivers/iio/dac/ltc2688.c

-- 
2.17.1

