Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF35BEA27
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 17:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiITP1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiITP1E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 11:27:04 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED1659E0
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 08:27:03 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KETVTj025060;
        Tue, 20 Sep 2022 11:27:01 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jpn46a6dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 11:27:01 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 28KFQxsg030628
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 11:26:59 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Sep 2022 11:26:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Sep 2022 11:26:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Sep 2022 11:26:58 -0400
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.36.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28KFQl8E007289;
        Tue, 20 Sep 2022 11:26:50 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: [PATCH v5 0/3] iio: adc: add max11410 adc driver
Date:   Tue, 20 Sep 2022 18:26:25 +0300
Message-ID: <20220920152628.285-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8P7xeT_1Bfjs_C4pGSZM85yk8RIS8dPP
X-Proofpoint-GUID: 8P7xeT_1Bfjs_C4pGSZM85yk8RIS8dPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200091
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Note: No sign-off tag for David as he was unreachable when the initial patch was sent.

Changelog:

since v5:
  - allow user to specify both interrupt pins
  - keep irq info in max11410_state struct and use irq by name
  - get irqs by fwnode_get_irq_byname
  - don't allocate trigger when no irq supplied
  - fix deadlock condition in write_raw
  - minor style fixes
  - fix devicetree binding errors reported by dt_binding_check
  - convert module license to GPL as suggested by checkpatch

since v4:
  - add in_voltage_filter2_notch_{center,en} attrs for sinc4 filter
  - add ABI documentation for filter sysfs
  - check interrupt-names property for configuring gpio of max11410
  - remove hardwaregain property
  - add scale_available property for channes using PGA
  - separate vref regulator error -ENODEV from other errors
  - don't register trigger if no irq specified
  - style fixes

since v3:
  - prefix defines with MAX11410_
  - group vref regulators
  - use builtin iio_validate_scan_mask_onehot
  - validate iio trigger
  - move scan data into state struct
  - require vrefn regulator in DT if used by any channel
  - don't require irq for triggered buffer
  - remove filter sysfs attr and ABI documentation
  - add in_voltage_filter[0-1]_notch_{center,en} attrs

since v2:
  - remove bit position shifting, use field_prep instead
  - reduce the amount of reg writes in max11410_configure_channel
  - add error checking in max11410_parse_channels
  - remove some unneeded blank lines and minor style fixes
  - remove scan data assignment in max11410_trigger_handler

Ibrahim Tilki (3):
  iio: adc: add max11410 adc driver
  dt-bindings: iio: adc: add adi,max11410.yaml
  Documentation: ABI: testing: add max11410 doc

 .../ABI/testing/sysfs-bus-iio-adc-max11410    |   13 +
 .../bindings/iio/adc/adi,max11410.yaml        |  177 +++
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/max11410.c                    | 1058 +++++++++++++++++
 5 files changed, 1262 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
 create mode 100644 drivers/iio/adc/max11410.c

-- 
2.25.1

