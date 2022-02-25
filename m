Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3434C4526
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiBYNCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 08:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiBYNCh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 08:02:37 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F122618022E;
        Fri, 25 Feb 2022 05:02:04 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21P6t078018527;
        Fri, 25 Feb 2022 08:01:46 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3eet8yhbpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 08:01:46 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 21PD1jPG013400
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Feb 2022 08:01:45 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Feb 2022 08:01:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Feb 2022 08:01:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Feb 2022 08:01:44 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21PD1WL1024659;
        Fri, 25 Feb 2022 08:01:35 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v4 0/3] Add support for LTC2688 
Date:   Fri, 25 Feb 2022 14:01:26 +0100
Message-ID: <20220225130129.69-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DK2ciF072j7ufV2y1VZRQWDeN-hHLYlF
X-Proofpoint-ORIG-GUID: DK2ciF072j7ufV2y1VZRQWDeN-hHLYlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_07,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250074
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v3:

 ltc2688:
  * Fix mismatch between functions and function pointers detected by kernel
test bot; 
  * Always use if (ret) when ret > 0 has no meaning;
  * Rename ltc2688_bulk_disable -> ltc2688_disable_regulators;
  * Report dither phase in radians rather than degrees.

 ABI:
  * Specify units for dither_phase and dither_freqency; 
  * Say why its useful to have dither_en and toggle_en;
  * Combine out_voltageY_raw0 and out_voltageY_raw1;
  * Fix some description issues in out_voltageY_raw{0|1} and
out_voltageY_symbol.

 Bindings:
  * Remove mentions to ABI (linux specifix);
  * Slightly rephrased VREF and adi,toggle-dither-input properties and
suggested.
   
changes in v4:

 ltc2688:
  * Use reg_size + val_size instead of plain 3 in regmap;
  * Use out_unlock instead of unlock in goto labels;
  * Add comma to LTC2688_CHANNEL(), ltc2688_regmap_bus and
ltc2688_regmap_bus;
  * Use __clear_bit() instead of clear_bit();
  * Flip the logic in vref regulator so that error condition is handled
first;
  * Change to device API. With this, we need to_of_node()
for devm_get_clk_from_child().

 ABI:
  * Update kernel version.

 Bindings:
  * Add Rob's Rb tag.

[1]: https://marc.info/?l=linux-iio&m=163662843603265&w=2

Nuno Sá (3):
  iio: dac: add support for ltc2688
  iio: ABI: add ABI file for the LTC2688 DAC
  dt-bindings: iio: Add ltc2688 documentation

 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |   86 ++
 .../bindings/iio/dac/adi,ltc2688.yaml         |  146 +++
 MAINTAINERS                                   |    9 +
 drivers/iio/dac/Kconfig                       |   11 +
 drivers/iio/dac/Makefile                      |    1 +
 drivers/iio/dac/ltc2688.c                     | 1071 +++++++++++++++++
 6 files changed, 1324 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
 create mode 100644 drivers/iio/dac/ltc2688.c

-- 
2.34.1

