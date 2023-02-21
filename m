Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2AE69DDFF
	for <lists+linux-iio@lfdr.de>; Tue, 21 Feb 2023 11:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjBUKkc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Feb 2023 05:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBUKkb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2023 05:40:31 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB21D925;
        Tue, 21 Feb 2023 02:40:30 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L8esxM002476;
        Tue, 21 Feb 2023 05:40:08 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3nvdcm4mpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 05:40:08 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 31LAe7hE023030
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 05:40:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 21 Feb
 2023 05:40:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Feb 2023 05:40:06 -0500
Received: from okan.localdomain (IST-LT-43126.ad.analog.com [10.25.36.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 31LAdbGu012847;
        Tue, 21 Feb 2023 05:39:42 -0500
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v5 0/5] Add MAX77541/MAX77540 PMIC Support
Date:   Tue, 21 Feb 2023 13:39:08 +0300
Message-ID: <20230221103926.49597-1-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _e1Sim865fJMHos2DRlqZimxplejLkdM
X-Proofpoint-ORIG-GUID: _e1Sim865fJMHos2DRlqZimxplejLkdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_06,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210092
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MFD, regulator and ADC driver and related bindings for MAX77540/MAX77541.
The patches are required to be applied in sequence.

Changes in v5:
* Patch 1: "dt-bindings: regulator: max77541: Add ADI MAX77541/MAX77540 Regulator"
  * Drop compatible properties.
* Patch 2: "regulator: max77541: Add ADI MAX77541/MAX77540 Regulator Support"
  * Change if-else ladder to switch case for chip->id
  * Drop driver_data in platform_device_id
* Patch 3: "iio: adc: : max77541 Add ADI MAX77541 ADC Support"
  * Drop max77541_adc_iio struct
* Patch 4: "dt-bindings: mfd: max77541: adi,max77541.yaml Add MAX77541 bindings"
  * Drop allOf
* Patch 5: "mfd: max77541: Add MAX77541/MAX77540 PMIC Support"
  * Dont use compatible when using MFD_CELL_OF MACRO

Changes in v4:
* Patch 1: "dt-bindings: regulator: Add ADI MAX77541/MAX77540 Regulator"
  * NO CHANGE
* Patch 2: "drivers: regulator: Add ADI MAX77541/MAX77540 Regulator Support"
  * Drop OF ID Table
  * Drop driver_data in platform_device_id
* Patch 3: "drivers: iio: adc: Add ADI MAX77541 ADC Support"
  * Add missing blank line
* Patch 4: "dt-bindings: mfd: adi,max77541.yaml Add MAX77541 bindings"
  * NO CHANGE(Order of patchset changed, and [4/5] has dependency to [1/5])
* Patch 5: "drivers: mfd: Add MAX77541/MAX77540 PMIC Support"
  * Use pointers in the driver_data
  * Use probe_new instead of probe
  * Use PLATFORM_DEVID_NONE macro instead of "-1"

Changes in v3:
* Patch 1: "drivers: mfd: Add ADI MAX77541/MAX77540 PMIC Support"
  * Change struct name from max77541_dev to max77541
  * Adjust max-line-length lower than 80
* Patch 2: "dt-bindings: mfd: Add ADI MAX77541/MAX77540"
  * Remove adc object as we do not need
  * Remove adc node from example
* Patch 3: "drivers: regulator: Add ADI MAX77541/MAX77540 Regulator Support"
  * Change node name from "BUCK#_id" to "buck#_id" in regulator desc
* Patch 4: "dt-bindings: regulator: Add ADI MAX77541/MAX77540 Regulator"
  * Change node name from "BUCK" to "buck" in regulators
* Patch 5: "drivers: iio: adc: Add ADI MAX77541 ADC Support"
  * Convert voltage values from V to mV for scaling.
  * Convert temperature values from C to miliC for scale and offset
  * Do not set offset bit in info_mask_separate for voltage that does not need offset
  * Remove unnecessary dev_get_drvdata() instead of it use dev_get_regmap to have regmap.
  * Assing hard coded name for adc dev name

Changes in v2:
* Patch 1: "drivers: mfd: Add MAX77541/MAX77540 PMIC Support"
  * Drop "this patch adds" from commit message.
  * Drop redundant blank lines.
  * Drop module version
  * Use definition for parameter of devm_mfd_add_devices(.., -1,..)
  * Use desc in chip_info to adding desc for different devices.
  * Add missing headers and forward declarations.
  * Drop unused elements from max77541_dev struct
  * Add chip_info into max77541_dev struct to identify different devices.
* Patch 2: "dt-bindings: mfd: adi,max77541.yaml Add MAX77541 bindings"
  * Drop "this patch adds" from commit message.
  * Fix $ref path
  * Drop adc part under allOf
  * Keep only one example (more complex one)
  * Fix make dt_binding_check errors.(trailing space, No newline)
* Patch 3: "drivers: regulator: Add MAX77541 Regulator Support"
  * Drop "this patch adds" from commit message.
  * Add trailing comma for required structs.
  * Fix wrong indentation.
  * Drop redundant blank lines.
  * Drop max77541_regulator_dev struct.
  * Use "regulator_desc *desc" for both regulator
    regarding to "max77541->id"
* Patch 4: "dt-bindings: regulator: max77541-regulator.yaml Add MAX77541
            Regulator bindings"
  * Drop "this patch adds" from commit message.
  * Chance filename (matching compatible), so adi,max77541-regulator.yaml
  * Fix make dt_binding_check errors.(trailing space, No newline)
* Patch 5: "drivers: iio: adc: Add MAX77541 ADC Support"
  * Drop "this patch adds" from commit message.
  * Drop redundant blank lines.
  * Fix wrong include path.
  * Use switch instead of if-else for range setting in max77541_adc_scale
  * Move max77541_adc_range enum from max77541.h to here.
  * Use definition from units.h
  * Drop unused elements from max77541_adc_iio struct
  * Drop the .data from platform_device_id

Okan Sahin (5):
  dt-bindings: regulator: max77541: Add ADI MAX77541/MAX77540 Regulator
  regulator: max77541: Add ADI MAX77541/MAX77540 Regulator Support
  iio: adc: max77541: Add ADI MAX77541 ADC Support
  dt-bindings: mfd: max77541: Add ADI MAX77541/MAX77540
  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC Support

 .../devicetree/bindings/mfd/adi,max77541.yaml |  68 +++++
 .../regulator/adi,max77541-regulator.yaml     |  38 +++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max77541-adc.c                | 195 ++++++++++++++
 drivers/mfd/Kconfig                           |  13 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77541.c                        | 243 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77541-regulator.c        | 154 +++++++++++
 include/linux/mfd/max77541.h                  | 102 ++++++++
 12 files changed, 836 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yaml
 create mode 100644 drivers/iio/adc/max77541-adc.c
 create mode 100644 drivers/mfd/max77541.c
 create mode 100644 drivers/regulator/max77541-regulator.c
 create mode 100644 include/linux/mfd/max77541.h

-- 
2.30.2

