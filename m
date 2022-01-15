Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0159048F623
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 10:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiAOJ1p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 04:27:45 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57380 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbiAOJ1p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 04:27:45 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20F6Pfgl006905;
        Sat, 15 Jan 2022 04:27:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dks07rnn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jan 2022 04:27:25 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 20F9ROjP058177
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Jan 2022 04:27:24 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 15 Jan 2022 04:27:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 15 Jan 2022 04:27:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 15 Jan 2022 04:27:22 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20F9RBL5010081;
        Sat, 15 Jan 2022 04:27:14 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 0/3] Add support for LTC2688 
Date:   Sat, 15 Jan 2022 10:27:02 +0100
Message-ID: <20220115092705.491-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: LHeLNkaEMsyXtcV2kCUSG6LNIVWdq4Ux
X-Proofpoint-ORIG-GUID: LHeLNkaEMsyXtcV2kCUSG6LNIVWdq4Ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-15_01,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ABI defined for this driver has some subtleties that were previously
discussed in this RFC [1]. This might not be the final state but,
hopefully, we are close to it:

toggle mode channels:

 * out_voltageY_toggle_en
 * out_voltageY_raw0
 * out_voltageY_raw1
 * out_voltageY_symbol

dither mode channels:

 * out_voltageY_dither_en
 * out_voltageY_dither_raw
 * out_voltageY_dither_raw_available
 * out_voltageY_dither_offset
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

changes in v2:

 ltc2688:
  * Use local buffer for regmap read. Do not assume that reg is part of
larger buffer;
  * Renamed GPIO to "clr" so that is consistent with the datasheet;
  * Renamed 'mask' and 'm' to info. 'mask' is a thing from the past;
  * Removed 'LTC2688_CHAN_TOGGLE()' and defined to static ext_info arrays;
  * Use 'regmap_set_bits' to set external ref;
  * Use FIELD_{PREP|GET} for dither amplitude and channel calibbias where
only 13bits are used;
  * Use 'regmap_write()' instead of update_bits for channels settings;
  * Init 'val' at the beginning of the channel configuration loop
(and drop mask);
  * Comment 'ltc2688_reg_writable()' to account for the special condition;
  * Kmemdup default channels so that it can be safely changed per probed
device;
  * Replace extended info multiplexer functions by individual functions;
  * Use raw0 ABI for toggle channels;
  * Use dedicated offset ABI for dither channels;
  * Misc changes (spell fixes, blank lines...);
  * Have a clock property per channel. Note that we this I moved to OF
since we now have to use 'devm_get_clk_from_child()' which is using
device_node. Note that I could use 'to_of_node()' but mixing of.h and
property.h does not feel like a good idea.

 ABI:
  * Added out_voltageY_raw0 ABI for toggle mode;
  * Added out_voltageY_dither_offset.

 Bindings:
  * Use standard microvolt unit;
  * Added constrains for adi,output-range-microvolt and removed negative
values from the dts example;
  * Moved clocks to the channel object;
  * Dropped clock-names;
  * Add a dependency between 'adi,toggle-dither-input' and 'clocks'.
 
[1]: https://marc.info/?l=linux-iio&m=163662843603265&w=2

Nuno Sá (3):
  iio: dac: add support for ltc2688
  iio: ABI: add ABI file for the LTC2688 DAC
  dt-bindings: iio: Add ltc2688 documentation

 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |   80 ++
 .../bindings/iio/dac/adi,ltc2688.yaml         |  147 +++
 MAINTAINERS                                   |    9 +
 drivers/iio/dac/Kconfig                       |   11 +
 drivers/iio/dac/Makefile                      |    1 +
 drivers/iio/dac/ltc2688.c                     | 1070 +++++++++++++++++
 6 files changed, 1318 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
 create mode 100644 drivers/iio/dac/ltc2688.c

-- 
2.33.1

