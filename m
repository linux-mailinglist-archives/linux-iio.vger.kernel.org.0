Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DF018DED0
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 09:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgCUIxw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 04:53:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16192 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728213AbgCUIxw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 04:53:52 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L8rQOo009305;
        Sat, 21 Mar 2020 04:53:51 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yw4ec1st3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 04:53:50 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02L8rnCC049565
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Mar 2020 04:53:49 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 04:53:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 04:53:42 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Mar 2020 04:53:42 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02L8rdei008553;
        Sat, 21 Mar 2020 04:53:39 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <Laszlo.Nagy@analog.com>,
        <Andrei.Grozav@analog.com>, <Michael.Hennerich@analog.com>,
        <Istvan.Csomortani@analog.com>, <Adrian.Costina@analog.com>,
        <Dragos.Bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v11 0/8] iio: adi-axi-adc,ad9647: Add support for AD9467 ADC
Date:   Sat, 21 Mar 2020 10:53:07 +0200
Message-ID: <20200321085315.11030-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-21_02:2020-03-20,2020-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210051
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v10 -> v11:
* added 'Reviewed-by: Rob Herring <robh@kernel.org>' tag to DT bindings patches
* patch 'dt-bindings: iio: adc: add bindings doc for AXI ADC driver'
  removed 'maxItems' from dma-names property
* sent from an @analog.com server; author was showing as @gmail.com on
  V9 & V10

Changelog v9 -> v10:
* patch 'iio: adc: adi-axi-adc: add support for AXI ADC IP core'
  - removed IQ correction logic; the AD9467 ADC driver has only 1 channel,
    so it can't have I & Q; also the IQ correction assumes that all
    even channels are Q and all odd channels are I, which is true for
    current ADI-AXI ADC IP cores, but shouldn't be an assumption designed
    in the driver; the IQ correction stuff will be re-added later,
    and will try to use the IIO_MOD_I & IIO_MOD_Q modifiers

Changelog v8 -> v9:
* adding more Analog people to the list; predominantly HDL people; this
  should help me sync people about the details of regs/reg-names
* added 'Acked-by: Moritz Fischer <mdf@kernel.org>' tag to fpga patches
  - we can always re-update these patches if something else is decided about
    the location of the 'adi-axi-common.h' header; I'm not insisting about
    where to put it; I'm open to other proposals
* patch 'iio: adc: adi-axi-adc: add support for AXI ADC IP core'
  - prefixed regs ADI_AXI_ ; I tried ADI_AXI_ADC_, but that seemed to make
    them too long
  - dropped unused regs; will add them as stuff gets added in the upstream
    driver; in the meantime, reg-names can be reworked
  - dropped generic LOWERXY_SET/GET macros
  - update reg-names a bit; will update them in the docs and HDL
  - order in adi_axi_adc_conv_unregister() should now be symmetrically
    oppposite now to the register function
  - implemented 'is_visible()' callback to adi_axi_adc_attributes[] so that
    attrs can be made invisible to userspace if needed;
  - 'indio_dev->name = "adi-axi-adc";'
  - added kernel doc-string for @reg_access
* patch 'iio: adc: ad9467: add support AD9467 ADC'
  - ad9467_spi_read() split in 2 buffers; tbuf & rbuf
  - removed 'if (chan->extend_name)' test ; left-over from initial driver
  - removed 'if (!st->clk)' check; driver will fail probe without a clock
  - removed 'if (!spi->dev.of_node)' in probe; shouldn't be needed
  - using 'of_device_get_match_data()' in probe to get data; moved chip
    info table entry as data on the of_device_id table

Changelog v7 -> v8:
* in 'iio: adc: adi-axi-adc: add support for AXI ADC IP core'
  - updated register definitions and bits to newer format/docs; the ref driver wasn't really up-to-date
    -- prefixed bit names with reg-name to avoid bit definition colisions; that makes some macros longer, but at least the format is consistent
  - using dev_name(&pdev->dev) for indio_dev->name
  - moved reset to own axi_adc_reset() function; may be re-used later
  - some re-formatting/alignment changes
  - address ENOSYS checkpatch complaint; changed with EOPNOTSUPP

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

 .../bindings/iio/adc/adi,ad9467.yaml          |  65 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |  62 +++
 drivers/iio/adc/Kconfig                       |  35 ++
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/ad9467.c                      | 420 +++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 | 495 ++++++++++++++++++
 .../buffer/industrialio-buffer-dmaengine.c    |  41 +-
 include/linux/fpga/adi-axi-common.h           |   6 +-
 include/linux/iio/adc/adi-axi-adc.h           |  64 +++
 include/linux/iio/buffer-dmaengine.h          |   3 +
 10 files changed, 1191 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
 create mode 100644 drivers/iio/adc/ad9467.c
 create mode 100644 drivers/iio/adc/adi-axi-adc.c
 create mode 100644 include/linux/iio/adc/adi-axi-adc.h

-- 
2.17.1

