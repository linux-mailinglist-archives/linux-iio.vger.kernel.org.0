Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB19F17A158
	for <lists+linux-iio@lfdr.de>; Thu,  5 Mar 2020 09:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgCEIbW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Mar 2020 03:31:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34590 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgCEIbW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2020 03:31:22 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0258SaWg015426;
        Thu, 5 Mar 2020 03:31:20 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnrasm3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 03:31:20 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0258VJTG001826
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 5 Mar 2020 03:31:19 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 5 Mar 2020 03:31:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 5 Mar 2020 03:31:17 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 5 Mar 2020 03:31:17 -0500
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0258VDI1018004;
        Thu, 5 Mar 2020 03:31:14 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v7 0/8] iio: adi-axi-adc,ad9647: Add support for AD9467 ADC
Date:   Thu, 5 Mar 2020 10:33:47 +0200
Message-ID: <20200305083355.8570-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_02:2020-03-04,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This changeset adds support for the AD9467 LVDS High-Speed ADC.
In order to support it, support for an FPGA ADI AXI ADC is added in this
set.
This uses the current support for IIO buffer DMAEngine.

Changelog v6 -> v7:
* Fixed dt-schema build for adi,axi-adc.yaml based on Rob's suggestion
  - added '$ref: /schemas/types.yaml#/definitions/phandle' to 'adi,adc-dev'
  - dropped 'maxItems' from 'adi,adc-dev'

Changelog v5 -> v6
* fix URLs; got changed during rename
   https://wiki.analog.com/resources/fpga/docs/adi_axi_adc_ip ->
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
  - noticed while working on the AXI DAC driver

Changelog v4 -> v5:
* update drivers/iio/adc/Kconfig note about module name; omitted during first rename
   - 'module will be called axi-adc.' -> 'module will be called adi-axi-adc.'

Changelog v3 -> v4:
* addressed Rob's dt-remarks
   - change 'adi-axi-adc-client' prop to 'adi,adc-dev'

Changelog v2 -> v3:
* addressed compiler warning

Changelog v1 -> v2:
* first series was added a bit hastily
* addressed  'make dt_binding_check' complaints; seems I missed a few when running the check; 
* added missing patches to include/linux/fpga/adi-axi-common.h
   - 'include: fpga: adi-axi-common.h: fixup whitespace tab -> space'
   - 'include: fpga: adi-axi-common.h: add version helper macros'
* patch 'iio: buffer-dmaengine: add dev-managed calls for buffer alloc/free'
   - remove copy+pasted comment for 'devm_iio_dmaengine_buffer_alloc()'
   - removed devm_iio_dmaengine_buffer_free() ; hopefully it might never be needed
   - fix-up alignment for devm_iio_dmaengine_buffer_alloc() in header
* patch 'iio: adc: adi-axi-adc: add support for AXI ADC IP core'
   - renamed axi-adc.c -> adi-axi-adc.c & Kconfig symbol
   - prefix all axi_adc -> adi_axi_adc
   - removed switch statement in axi_adc_read_raw() & axi_adc_write_raw()
   - remove axi_adc_chan_spec ; replaced with iio_chan_spec directly ; will think of a simpler solution for extra chan params
   - removed left-over 'struct axi_adc_cleanup_data'
   - moved 'devm_add_action_or_reset()' call right after 'adi_axi_adc_attach_client()'
   - switched to using 'devm_platform_ioremap_resource()'
* patch 'iio: adc: ad9467: add support AD9467 ADC'
  - renamed ADI_ADC reg prefixes to AN877_ADC
  - dropped 'info_mask_separate' field in AD9467_CHAN - will be re-added later when driver gets more features; was left-over from the initial ref driver
  - remove .shift = 0,  in AD9467_CHAN
  - renamed 'sample-clock' -> 'adc-clock'
  - direct returns in ad9467_read_raw() & ad9467_write_raw() & ad9467_setup() switch statements
  - removed blank line after devm_axi_adc_conv_register()
  - removed ad9467_id & reworked to use ad9467_of_match

Alexandru Ardelean (6):
  include: fpga: adi-axi-common.h: fixup whitespace tab -> space
  include: fpga: adi-axi-common.h: add version helper macros
  iio: buffer-dmaengine: use %zu specifier for sprintf(align)
  iio: buffer-dmaengine: add dev-managed calls for buffer alloc
  dt-bindings: iio: adc: add bindings doc for AXI ADC driver
  dt-bindings: iio: adc: add bindings doc for AD9467 ADC

Michael Hennerich (2):
  iio: adc: adi-axi-adc: add support for AXI ADC IP core
  iio: adc: ad9467: add support AD9467 ADC

 .../bindings/iio/adc/adi,ad9467.yaml          |  65 ++
 .../bindings/iio/adc/adi,axi-adc.yaml         |  63 ++
 drivers/iio/adc/Kconfig                       |  35 ++
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/ad9467.c                      | 432 +++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 | 566 ++++++++++++++++++
 .../buffer/industrialio-buffer-dmaengine.c    |  41 +-
 include/linux/fpga/adi-axi-common.h           |   6 +-
 include/linux/iio/adc/adi-axi-adc.h           |  63 ++
 include/linux/iio/buffer-dmaengine.h          |   3 +
 10 files changed, 1274 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
 create mode 100644 drivers/iio/adc/ad9467.c
 create mode 100644 drivers/iio/adc/adi-axi-adc.c
 create mode 100644 include/linux/iio/adc/adi-axi-adc.h

-- 
2.20.1

