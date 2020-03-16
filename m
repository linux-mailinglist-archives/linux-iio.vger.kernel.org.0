Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183A9186F2B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 16:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgCPPuy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 11:50:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46019 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731890AbgCPPuy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 11:50:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id t2so11805252wrx.12;
        Mon, 16 Mar 2020 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmLZ2qN4R4wKBOzN/0eeaAXSnhYva6IoUpfiG2sUI4U=;
        b=ZaNJNA/izv2UTTE0fphMn1Y3rPyGlxHJYmCq9jMTdAGslvX0XRh8BaBdXtEN4bBFIr
         8gVewYBotOBoYW6HaQzhwYu4Tquy5TmSjvPUnBGX+q40EXlXDuIVH4Yay0Drmv6cMd6D
         6p11mg9aBwAHoLmNp7G3UdhEo7CUKro9IOM7qd20lIYRJRlmhs4HQGjUrCbNDzNXAMi7
         ZD6uBeydU/bjFOeQILfUDm5MMxjw0PFHDoQuqGqVxDtvjLBWYklg9/pTtUZIwHBXnv0y
         uhLUcM2O4Sb0GhliG3mQQLFRJj09SRzP9I+JJ5ktxwAGiWl+Q7KJme0y5Au4tGx3jaFV
         oHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmLZ2qN4R4wKBOzN/0eeaAXSnhYva6IoUpfiG2sUI4U=;
        b=m2AePkPpCrNk5n/Y9UV4W8l0ZvnsSb0gUVqf8bByfhlGVaHN2JJx8nsopdLES1B8+k
         zIOFmSqVxpebgIphbxU4NqLZrzUcZAg6nyWEJ/i8xu7A/foRn03Y6+/A0F9mYemU3sUa
         +DDxWcgGJG4fKvY/yeHhiWZYU5E3TvqyZCo9k84UFxHYSfRh/mqmVsHRAshGbUkCxW3g
         wAoK456QCtvCzGMeCxmklzrxqNPutPUn+zZLACiCzpxx9D4yKgG7t/dHs/GYb1kMUlHA
         0L6qamwa9fA7j0CcL2fPw3QIt7hZsGMsjXofLOP4YR+TEZT6kDbZeq9axYu8gO75u13d
         RfRA==
X-Gm-Message-State: ANhLgQ1/M/+2sHWaPUHEAHAqPBFHYQDy0jvxBYSX+7corQ4eqrjoy92k
        Z9fVf/+7ZWsPv/kmr071ZytW2r5v
X-Google-Smtp-Source: ADFU+vssUSCgq7o2kXHdmInIcujdbFxVHI1N1v0Q6p3GHf7PP2lPeydG+by10GWhERmRAPwzHA6h3g==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr45471wrr.82.1584373851467;
        Mon, 16 Mar 2020 08:50:51 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id n14sm153558wmi.19.2020.03.16.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:50:50 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v10 0/8] iio: adi-axi-adc,ad9647: Add support for AD9467 ADC
Date:   Mon, 16 Mar 2020 17:50:27 +0200
Message-Id: <20200316155035.25500-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This changeset adds support for the AD9467 LVDS High-Speed ADC.
In order to support it, support for an FPGA ADI AXI ADC is added in this
set.
This uses the current support for IIO buffer DMAEngine.

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
 .../bindings/iio/adc/adi,axi-adc.yaml         |  63 +++
 drivers/iio/adc/Kconfig                       |  35 ++
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/ad9467.c                      | 420 +++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 | 495 ++++++++++++++++++
 .../buffer/industrialio-buffer-dmaengine.c    |  41 +-
 include/linux/fpga/adi-axi-common.h           |   6 +-
 include/linux/iio/adc/adi-axi-adc.h           |  64 +++
 include/linux/iio/buffer-dmaengine.h          |   3 +
 10 files changed, 1192 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
 create mode 100644 drivers/iio/adc/ad9467.c
 create mode 100644 drivers/iio/adc/adi-axi-adc.c
 create mode 100644 include/linux/iio/adc/adi-axi-adc.h

-- 
2.20.1

