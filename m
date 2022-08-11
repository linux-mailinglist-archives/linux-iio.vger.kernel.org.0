Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B158FD98
	for <lists+linux-iio@lfdr.de>; Thu, 11 Aug 2022 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiHKNnQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Aug 2022 09:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiHKNnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Aug 2022 09:43:16 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229526540
        for <linux-iio@vger.kernel.org>; Thu, 11 Aug 2022 06:43:15 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BBh9gg027419;
        Thu, 11 Aug 2022 09:43:08 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3huwpyx86t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 09:43:08 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 27BDh7sS032384
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Aug 2022 09:43:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 11 Aug
 2022 09:43:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 11 Aug 2022 09:43:06 -0400
Received: from euswvd-wpr-708.reddog.microsoft.com ([10.140.226.204])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27BDgtnj032231;
        Thu, 11 Aug 2022 09:42:59 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: [PATCH v3 0/2] iio: adc: add max11410 adc driver
Date:   Thu, 11 Aug 2022 13:42:41 +0000
Message-ID: <20220811134243.111-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: xAvLvhwtwr906wDDoKt8Uqx2-QZsA-xg
X-Proofpoint-ORIG-GUID: xAvLvhwtwr906wDDoKt8Uqx2-QZsA-xg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110044
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I added filter enable attributes for 50Hz and 60Hz FIR filters.
Disabling both will set filter to sinc4, allowing higher sampling rates.

Regards,
Ibrahim

Note: No sign-off tag for David as he was unreachable when the initial patch was sent.

Changelog:
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


Ibrahim Tilki (2):
  iio: adc: add max11410 adc driver
  dt-bindings: iio: adc: add adi,max11410.yaml

 .../bindings/iio/adc/adi,max11410.yaml        | 165 +++
 drivers/iio/adc/Kconfig                       |  13 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max11410.c                    | 954 ++++++++++++++++++
 4 files changed, 1133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
 create mode 100644 drivers/iio/adc/max11410.c

-- 
2.36.1

