Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1845115016D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 06:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBCFeq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 00:34:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:2368 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgBCFeq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Feb 2020 00:34:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 21:34:45 -0800
X-IronPort-AV: E=Sophos;i="5.70,396,1574150400"; 
   d="scan'208";a="223817963"
Received: from dishasha-mobl.gar.corp.intel.com ([10.252.169.219])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 21:34:41 -0800
Message-ID: <f7f507a0831abda54de73d0ed70e84a6ef60f175.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Shah, Nehal-bakulchandra" <nbshah@amd.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Date:   Sun, 02 Feb 2020 21:34:37 -0800
In-Reply-To: <e93b0b3f-ea4b-5238-2f35-8642bc2fd833@amd.com>
References: <1580272046-32101-1-git-send-email-Sandeep.Singh@amd.com>
         <1580272046-32101-3-git-send-email-Sandeep.Singh@amd.com>
         <e93b0b3f-ea4b-5238-2f35-8642bc2fd833@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2020-02-03 at 10:35 +0530, Shah, Nehal-bakulchandra wrote:
> Hi
> 
> On 1/29/2020 9:57 AM, Sandeep Singh wrote:
> > From: Sandeep Singh <sandeep.singh@amd.com>
> > 
> > AMD SFH uses HID over PCIe bus.SFH fw is part of MP2
> > processor and it runs on MP2 where in driver resides
> > on X86.This part of module will communicate with MP2 FW and
> > provide that data into DRAM
> > 
> > Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> > Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
Any possibility of using devm_* calls for both pci_* and memory
allocation?

Thanks,
Srinivas

> > ---
> >  drivers/hid/Kconfig                    |   2 +
> >  drivers/hid/Makefile                   |   1 +
> >  drivers/hid/amd-sfh-hid/Kconfig        |  17 +++
> >  drivers/hid/amd-sfh-hid/Makefile       |  17 +++
> >  drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 256
> > +++++++++++++++++++++++++++++++++
> >  drivers/hid/amd-sfh-hid/amd_mp2_pcie.h | 169
> > ++++++++++++++++++++++
> >  6 files changed, 462 insertions(+)
> >  create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
> >  create mode 100644 drivers/hid/amd-sfh-hid/Makefile
> >  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> >  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> > 
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 494a39e..b253ad1 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -1155,4 +1155,6 @@ source "drivers/hid/i2c-hid/Kconfig"
> >  
> >  source "drivers/hid/intel-ish-hid/Kconfig"
> >  
> > +source "drivers/hid/amd-sfh-hid/Kconfig"
> > +
> >  endmenu
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index bfefa36..15a08e8 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -139,3 +139,4 @@ obj-$(CONFIG_I2C_HID)		+= i2c-hid/
> >  
> >  obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
> >  obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+= intel-ish-hid/
> > +obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
> > diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-
> > hid/Kconfig
> > new file mode 100644
> > index 0000000..e2dee39
> > --- /dev/null
> > +++ b/drivers/hid/amd-sfh-hid/Kconfig
> > @@ -0,0 +1,17 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +menu "AMD SFH HID support"
> > +	depends on (X86_64 || COMPILE_TEST) && PCI
> > +
> > +config AMD_SFH_HID
> > +	tristate "AMD Sensor Fusion Hub"
> > +	default n
> > +	select HID
> > +	help
> > +	  If you say yes to this option, support will be included for
> > the AMD
> > +	  Sensor Fusion Hub.
> > +
> > +	  This driver can also be built as modules. If so, the modules
> > will
> > +	  be  called amd-mp2-pcie and amd-sfhtp-hid.
> > +	  Say Y here if you want to support AMD SFH. If unsure, say N.
> > +
> > +endmenu
> > diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-
> > sfh-hid/Makefile
> > new file mode 100644
> > index 0000000..5aae934
> > --- /dev/null
> > +++ b/drivers/hid/amd-sfh-hid/Makefile
> > @@ -0,0 +1,17 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile - AMD SFH HID drivers
> > +# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
> > +#
> > +#
> > +ccflags-m := -Werror
> > +obj-$(CONFIG_AMD_SFH_HID) += amd-mp2-pcie.o
> > +amd-mp2-pcie-objs := amd_mp2_pcie.o
> > +
> > +obj-$(CONFIG_AMD_SFH_HID) +=amd-sfhtp-hid.o
> > +amd-sfhtp-hid-objs := amdsfh-hid.o
> > +amd-sfhtp-hid-objs+= amdsfh-hid-client.o
> > +amd-sfhtp-hid-objs+= amdsfh-debugfs.o
> > +amd-sfhtp-hid-objs+= hid_descriptor/amd_sfh_hid_descriptor.o
> > +
> > +ccflags-y += -I$(srctree)/$(src)/
> > diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> > b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> > new file mode 100644
> > index 0000000..f264d60
> > --- /dev/null
> > +++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> > @@ -0,0 +1,256 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * AMD MP2 PCIe communication driver
> > + *
> > + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > + *          Nehal Bakulchandra Shah <
> > Nehal-bakulchandra.Shah@amd.com>
> > + */
> > +
> > +#include "amd_mp2_pcie.h"
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +
> > +#define DRIVER_NAME	"pcie_mp2_amd"
> > +#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Driver"
> > +#define DRIVER_VER	"1.0"
> > +
> > +#define	ACEL_EN		BIT(ACCEL_IDX)
> > +#define	GYRO_EN		BIT(GYRO_IDX)
> > +#define MAGNO_EN	BIT(MAG_IDX)
> > +#define ALS_EN		BIT(AMBIENT_LIGHT_IDX)
> > +
> > +int amd_start_sensor(struct pci_dev *pdev, struct
> > amd_mp2_sensor_info info)
> > +{
> > +	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
> > +	union sfh_cmd_base cmd_base;
> > +	union sfh_command_parameter cmd_param;
> > +
> > +	/*fill up command register*/
> > +	cmd_base.ul = 0;
> > +	cmd_base.s.cmd_id = enable_sensor;
> > +	cmd_base.s.period = info.period;
> > +	cmd_base.s.sensor_id = info.sensor_idx;
> > +
> > +	/*fill up command param register*/
> > +	cmd_param.ul = 0;
> > +	cmd_param.s.buffer_layout = 1;
> > +	cmd_param.s.buffer_length = 16;
> > +
> > +	write64((u64)info.phy_address, privdata->mmio + AMD_C2P_MSG2);
> > +	writel(cmd_param.ul, privdata->mmio + AMD_C2P_MSG1);
> > +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(amd_start_sensor);
> > +
> > +int amd_stop_sensor(struct pci_dev *pdev, u16 sensor_idx)
> > +{
> > +	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
> > +	union sfh_cmd_base cmd_base;
> > +
> > +	/* fill up command register */
> > +	cmd_base.ul = 0;
> > +	cmd_base.s.cmd_id = disable_sensor;
> > +	cmd_base.s.period = 0;
> > +	cmd_base.s.sensor_id = sensor_idx;
> > +
> > +	write64(0x0, privdata->mmio + AMD_C2P_MSG2);
> > +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(amd_stop_sensor);
> > +
> > +int amd_stop_all_sensors(struct pci_dev *pdev)
> > +{
> > +	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
> > +	union sfh_cmd_base cmd_base;
> > +
> > +	/*fill up command register */
> > +	cmd_base.ul = 0;
> > +	cmd_base.s.cmd_id = stop_all_sensors;
> > +	cmd_base.s.period = 0;
> > +	cmd_base.s.sensor_id = 0;
> > +
> > +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(amd_stop_all_sensors);
> > +
> > +int amd_mp2_get_sensor_num(struct pci_dev *dev, u8 *sensor_id)
> > +{
> > +	struct amd_mp2_dev *privdata = pci_get_drvdata(dev);
> > +	int activestatus;
> > +	int num_of_sensors = 0;
> > +
> > +	if (!sensor_id)
> > +		return -ENOMEM;
> > +
> > +	privdata->eventreg.activecontrolstatus =
> > +			readl(privdata->mmio + AMD_P2C_MSG3);
> > +	activestatus = privdata->eventreg.activecontrolstatus >> 4;
> > +
> > +	if (ACEL_EN  & activestatus) {
> > +		sensor_id[num_of_sensors] = ACCEL_IDX;
> > +		num_of_sensors++;
> > +	}
> > +	if (GYRO_EN & activestatus) {
> > +		sensor_id[num_of_sensors] = GYRO_IDX;
> > +		num_of_sensors++;
> > +	}
> > +	if (MAGNO_EN & activestatus) {
> > +		sensor_id[num_of_sensors] = MAG_IDX;
> > +		num_of_sensors++;
> > +	}
> > +
> > +	if (ALS_EN & activestatus) {
> > +		sensor_id[num_of_sensors] = AMBIENT_LIGHT_IDX;
> > +		num_of_sensors++;
> > +	}
> > +
> > +	return num_of_sensors;
> > +}
> > +EXPORT_SYMBOL_GPL(amd_mp2_get_sensor_num);
> > +
> > +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct
> > pci_dev *pdev)
> > +{
> > +	int rc;
> > +	int bar_index = 2;
> > +	resource_size_t size, base;
> > +
> > +	pci_set_drvdata(pdev, privdata);
> > +
> > +	rc = pci_enable_device(pdev);
> > +	if (rc)
> > +		goto err_pci_enable;
> > +
> > +	rc = pci_request_regions(pdev, DRIVER_NAME);
> > +	if (rc)
> > +		goto err_pci_regions;
> > +
> > +	pci_set_master(pdev);
> > +
> > +	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> > +	if (rc) {
> > +		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> > +		if (rc)
> > +			goto err_dma_mask;
> > +		dev_warn(ndev_dev(privdata), "Cannot DMA highmem\n");
> > +	}
> > +
> > +	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> > +	if (rc) {
> > +		rc = pci_set_consistent_dma_mask(pdev,
> > DMA_BIT_MASK(32));
> > +		if (rc)
> > +			goto err_dma_mask;
> > +		dev_warn(ndev_dev(privdata), "Cannot DMA consistent
> > highmem\n");
> > +	}
> > +
> > +	base = pci_resource_start(pdev, bar_index);
> > +	size = pci_resource_len(pdev, bar_index);
> > +	dev_dbg(ndev_dev(privdata), "Base addr:%llx size:%llx\n",
> > +		(unsigned long long)base, (unsigned long long)size);
> > +
> > +	privdata->mmio = ioremap(base, size);
> > +	if (!privdata->mmio) {
> > +		rc = -EIO;
> > +		goto err_dma_mask;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_dma_mask:
> > +	pci_clear_master(pdev);
> > +	pci_release_regions(pdev);
> > +err_pci_regions:
> > +	pci_disable_device(pdev);
> > +err_pci_enable:
> > +	pci_set_drvdata(pdev, NULL);
> > +	return rc;
> > +}
> > +
> > +static void amd_mp2_pci_deinit(struct amd_mp2_dev *privdata)
> > +{
> > +	struct pci_dev *pdev = ndev_pdev(privdata);
> > +
> > +	amd_stop_all_sensors(pdev);
> > +	pci_iounmap(pdev, privdata->mmio);
> > +
> > +	pci_clear_master(pdev);
> > +	pci_release_regions(pdev);
> > +	pci_disable_device(pdev);
> > +	pci_set_drvdata(pdev, NULL);
> > +}
> > +
> > +static int amd_mp2_pci_probe(struct pci_dev *pdev,
> > +			     const struct pci_device_id *id)
> > +{
> > +	struct amd_mp2_dev *privdata;
> > +	int rc;
> > +
> > +	dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> > +		 (int)pdev->vendor, (int)pdev->device, (int)pdev-
> > >revision);
> > +
> > +	privdata = kzalloc(sizeof(*privdata), GFP_KERNEL);
> > +
> > +	if (!privdata) {
> > +		rc = -ENOMEM;
> > +		goto err_dev;
> > +	}
> > +
> > +	privdata->pdev = pdev;
> > +
> > +	rc = amd_mp2_pci_init(privdata, pdev);
> > +	if (rc)
> > +		goto err_pci_init;
> > +
> > +	return 0;
> > +
> > +err_pci_init:
> > +	kfree(privdata);
> > +err_dev:
> > +	dev_err(&pdev->dev, "Memory Allocation Failed\n");
> > +	return rc;
> > +}
> > +
> > +static void amd_mp2_pci_remove(struct pci_dev *pdev)
> > +{
> > +	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
> > +
> > +	amd_mp2_pci_deinit(privdata);
> > +	kfree(privdata);
> > +}
> > +
> > +static const struct pci_device_id amd_mp2_pci_tbl[] = {
> > +	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
> > +	{0}
> > +};
> > +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> > +
> > +static struct pci_driver amd_mp2_pci_driver = {
> > +	.name		= DRIVER_NAME,
> > +	.id_table	= amd_mp2_pci_tbl,
> > +	.probe		= amd_mp2_pci_probe,
> > +	.remove		= amd_mp2_pci_remove,
> > +};
> > +
> > +static int __init amd_mp2_pci_driver_init(void)
> > +{
> > +	return pci_register_driver(&amd_mp2_pci_driver);
> > +}
> > +module_init(amd_mp2_pci_driver_init);
> > +
> > +static void __exit amd_mp2_pci_driver_exit(void)
> > +{
> > +	pci_unregister_driver(&amd_mp2_pci_driver);
> > +}
> > +module_exit(amd_mp2_pci_driver_exit);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > +MODULE_VERSION(DRIVER_VER);
> > +MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> > +MODULE_AUTHOR("Nehal Bakulchandra Shah <
> > Nehal-bakulchandra.Shah@amd.com>");
> > diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> > b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> > new file mode 100644
> > index 0000000..2bfd2de
> > --- /dev/null
> > +++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> > @@ -0,0 +1,169 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * AMD MP2 PCIe communication driver
> > + *
> > + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > + *          Nehal Bakulchandra Shah <
> > Nehal-bakulchandra.Shah@amd.com>
> > + */
> > +
> > +#ifndef PCIE_MP2_AMD_H
> > +#define PCIE_MP2_AMD_H
> > +
> > +#include <linux/pci.h>
> > +#define PCI_DEVICE_ID_AMD_MP2	0x15E4
> > +
> > +#define write64 _write64
> > +static inline void _write64(u64 val, void __iomem *mmio)
> > +{
> > +	writel(val, mmio);
> > +	writel(val >> 32, mmio + sizeof(u32));
> > +}
> > +
> > +#define read64 _read64
> > +static inline u64 _read64(void __iomem *mmio)
> > +{
> > +	u64 low, high;
> > +
> > +	low = readl(mmio);
> > +	high = readl(mmio + sizeof(u32));
> > +	return low | (high << 32);
> > +}
> > +
> > +enum {
> > +	/* MP2 C2P Message Registers */
> > +	AMD_C2P_MSG0 = 0x10500,
> > +	AMD_C2P_MSG1 = 0x10504,
> > +	AMD_C2P_MSG2 = 0x10508,
> > +	AMD_C2P_MSG3 = 0x1050c,
> > +	AMD_C2P_MSG4 = 0x10510,
> > +	AMD_C2P_MSG5 = 0x10514,
> > +	AMD_C2P_MSG6 = 0x10518,
> > +	AMD_C2P_MSG7 = 0x1051c,
> > +	AMD_C2P_MSG8 = 0x10520,
> > +	AMD_C2P_MSG9 = 0x10524,
> > +
> > +	/* MP2 P2C Message Registers */
> > +	AMD_P2C_MSG0 = 0x10680, /*Do not use*/
> > +	AMD_P2C_MSG1 = 0x10684,
> > +	AMD_P2C_MSG2 = 0x10688,
> > +	AMD_P2C_MSG3 = 0x1068C, /*MP2 debug info*/
> > +	AMD_P2C_MSG_INTEN = 0x10690, /*MP2 int gen register*/
> > +	AMD_P2C_MSG_INTSTS = 0x10694, /*Interrupt sts*/
> > +};
> > +
> > +/*
> > + * SFH Command registers
> > + */
> > +union sfh_cmd_base {
> > +	u32 ul;
> > +	struct {
> > +		u32 cmd_id : 8;
> > +		u32 sensor_id : 8;
> > +		u32 period : 16;
> > +	} s; /*!< Structure used for bit access */
> > +};
> > +
> > +union sfh_command_parameter {
> > +	u32 ul;
> > +	struct {
> > +		u32 buffer_layout : 2;
> > +		u32 buffer_length : 6;
> > +		u32 rsvd : 24;
> > +	} s;
> > +};
> > +
> > +struct sfh_command_register {
> > +	union sfh_cmd_base cmd_base;
> > +	union sfh_command_parameter cmd_param;
> > +	phys_addr_t phy_addr;
> > +};
> > +
> > +/*
> > + * SFH Response registers
> > + */
> > +enum response_type {
> > +	non_operationevent,
> > +	command_success,
> > +	command_failed,
> > +	sfi_dataready_event,
> > +	invalid_response = 0xff,
> > +};
> > +
> > +enum status_type {
> > +	cmd_success,
> > +	invalid_data_payload,
> > +	invalid_data_length,
> > +	invalid_sensor_id,
> > +	invalid_dram_addr,
> > +	invalid_command,
> > +	sensor_enabled,
> > +	sensor_disabled,
> > +	status_end,
> > +};
> > +
> > +enum command_id {
> > +	non_operation = 0,
> > +	enable_sensor = 1,
> > +	disable_sensor = 2,
> > +	dump_sensorinfo = 3,
> > +	numberof_sensordiscovered = 4,
> > +	who_am_i_regchipid = 5,
> > +	set_dcd_data = 6,
> > +	get_dcd_data = 7,
> > +	stop_all_sensors = 8,
> > +	invalid_cmd = 0xf,
> > +};
> > +
> > +union sfh_event_base {
> > +	u32 ul;
> > +	struct {
> > +		u32 response : 4; /*!< bit: 0..3 SFI response_type */
> > +		u32 status : 3; /*!< bit: 6..5 status_type */
> > +		u32 out_in_c2p : 1; /*!< bit: 5 0- output in DRAM,1-in
> > C2PMsg */
> > +		u32 length : 6; /*!< bit: 8..13 length */
> > +		u32 dbg : 2; /*!< bit: 14.15 dbg msg include in p2c msg
> > 1-2 */
> > +		u32 sensor_id : 8; /*!< bit: 16..23 Sensor ID */
> > +		u32 rsvd : 8; /*!< bit: 24..31 Reservered for future
> > use */
> > +	} s;
> > +};
> > +
> > +struct sfi_event_register {
> > +	union sfh_event_base evtbase;
> > +	u32 debuginfo1;
> > +	u32 debuginfo2;
> > +	u32 activecontrolstatus;
> > +};
> > +
> > +enum sensor_idx {
> > +	ACCEL_IDX               = 0,
> > +	GYRO_IDX                = 1,
> > +	MAG_IDX                 = 2,
> > +	AMBIENT_LIGHT_IDX       = 19,
> > +	NUM_ALL_SENSOR_CONSUMERS
> > +};
> > +
> > +struct amd_mp2_dev {
> > +	struct pci_dev *pdev;
> > +	struct dentry *debugfs_dir;
> > +	void __iomem *mmio;
> > +	union sfh_event_base eventval;
> > +	struct sfi_event_register eventreg;
> > +	struct delayed_work work;
> > +	void *ctx;
> > +	void *cl_data;
> > +};
> > +
> > +struct amd_mp2_sensor_info {
> > +	u8 sensor_idx;
> > +	u32 period;
> > +	phys_addr_t phy_address;
> > +};
> > +
> > +int amd_start_sensor(struct pci_dev *pdev, struct
> > amd_mp2_sensor_info info);
> > +int amd_stop_sensor(struct pci_dev *pdev, u16 sensor_idx);
> > +int amd_stop_all_sensors(struct pci_dev *pdev);
> > +int amd_mp2_get_sensor_num(struct pci_dev *dev, u8 *sensor_id);
> > +#define ndev_pdev(ndev) ((ndev)->pdev)
> > +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> > +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> > +#endif
> > 
> 
> any update on this?
> 
> Thanks
> 
> Nehal Shah

