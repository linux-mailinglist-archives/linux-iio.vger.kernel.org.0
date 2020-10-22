Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBC6295CE3
	for <lists+linux-iio@lfdr.de>; Thu, 22 Oct 2020 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896666AbgJVKqY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Oct 2020 06:46:24 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896648AbgJVKqW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Oct 2020 06:46:22 -0400
Received: from [172.23.45.10] ([81.14.225.83]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Myb8P-1kCfsW0Ghp-00yy4b; Thu, 22 Oct 2020 12:45:57 +0200
Message-ID: <c283029535cb351e11016e5e6315e655399c73fa.camel@richard-neumann.de>
Subject: Re: [PATCH v8 2/4] SFH: PCIe driver to add support of AMD sensor
 fusion hub
From:   Richard Neumann <mail@richard-neumann.de>
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        m.felsch@pengutronix.de, rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com
Date:   Thu, 22 Oct 2020 12:45:54 +0200
In-Reply-To: <20201009200138.1847317-3-Sandeep.Singh@amd.com>
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
         <20201009200138.1847317-3-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iY2sEhqffKCNJmVN51jDw7EF62+nUTePiFCsb9r4qusI4HLPBtb
 figj4sU8XrPrXwX0ir5O4IWyncPhIHLSWpkGHXd2FYnldEAke2gpH5E2vwyNRIkt/YRWSAS
 5xmb/mQw9Op7Q42LzEevEiBCSlVOdQw65t3ytWzkS79C7BM4msO06ER6CBwQfqvXwhtuk44
 Rm/PNn69c1Nfv8u3QyQhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v1w6R2/D6xs=:CAbHybJ2sDrsIiPHC2aVJd
 DJCJYPpOjD5Me3/qpPmHecVXJd4FTWC2N85t6uq3n3E6MalcmK/EjF6bHmR3rAQ744KmT4snE
 jdwd8t9Z+1BJU367+ps+oWEd/FG/Xk2Pe/hKVs8HQYuEQ9ZDFE38pvxjySuIMDa+ELe7bcTQX
 2hKbiDPLWyS/f7qxwkaNPJK5ip2u081bEKaVBJ1J3vxk1jFnVpqpYUZ/2r3baLs//83rmw9Uv
 NfEAEGE4SpHDhqu8Qkzz79vxgYOKqaNH+S9oNQIt2oLjLbkcKwAAeXlPIj+CS4qInlSk0ptk+
 9F28Sa+LYlwW2vFkH7RA7BXVdpXzvBK/7WMQ2H8lNoC4FgyVcAiKGBzfIlqG0ZQKICjHm1AQC
 SbK/S+L9K6A7vNKSMykPmvlnEwzX8gTUYQu0SpuN6b0ghMOxngNX1buH+RmrRBeoYOaS9YLZ4
 bBrCztZhyQ==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

on a quick glance, I noticed, that the sensor masks (*_EN) are no
longer derived from their indices:

amd_sfh_pcie.h:

   enum sensor_idx {
        accel_idx = 0,
        gyro_idx = 1,
        mag_idx = 2,
        als_idx = 19
   };
   
amd_sfh_pcie.c:

   #define ACEL_EN              BIT(1)
   #define GYRO_EN              BIT(2)
   #define MAGNO_EN     BIT(3)
   #define ALS_EN               BIT(19)

Why were all except ALS_EN shifted by one?
Is this intentional or a bug?

I have received an email by a user, suggesting that this change breaks
correct sensors detection when compared to activestatus. Can you
confirm this?

Also I wonder why the structures "enum desc_type", "struct
_hid_report_descriptor" and "struct _hid_device_descriptor" have been
introduced in amd_sfh_hid_desc.h as they aren't used anywhere in the
code.

Kind regards,

Richard

Am Samstag, den 10.10.2020, 01:31 +0530 schrieb Sandeep Singh:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> AMD SFH (Sensor Fusion Hub) is a solution running on MP2
> (which is ARM core connected to x86 for processing sensor data).
> AMD SFH uses HID over PCI bus to form the HID descriptors and
> talks to HID clients like the monitor-sensor/iio-proxy. MP2 which
> is exposed as a PCI device to the x86, uses mailboxes to talk to
> MP2 firmware to send/receive commands.
> 
> Co-developed-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> ---
>  drivers/hid/Kconfig                    |   2 +
>  drivers/hid/Makefile                   |   2 +
>  drivers/hid/amd-sfh-hid/Kconfig        |  18 +++
>  drivers/hid/amd-sfh-hid/Makefile       |  13 +++
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 152
> +++++++++++++++++++++++++
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.h |  79 +++++++++++++
>  6 files changed, 266 insertions(+)
>  create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
>  create mode 100644 drivers/hid/amd-sfh-hid/Makefile
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 05315b434276..1b5f5e9b8d0d 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1174,4 +1174,6 @@ source "drivers/hid/i2c-hid/Kconfig"
>  
>  source "drivers/hid/intel-ish-hid/Kconfig"
>  
> +source "drivers/hid/amd-sfh-hid/Kconfig"
> +
>  endmenu
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index d8ea4b8c95af..7d8ca4e34572 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -141,3 +141,5 @@ obj-$(CONFIG_I2C_HID)               += i2c-hid/
>  
>  obj-$(CONFIG_INTEL_ISH_HID)    += intel-ish-hid/
>  obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)   += intel-ish-hid/
> +
> +obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
> diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-
> hid/Kconfig
> new file mode 100644
> index 000000000000..db069a83e9a2
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +menu "AMD SFH HID Support"
> +       depends on X86_64 || COMPILE_TEST
> +       depends on PCI
> +       depends on HID
> +
> +config AMD_SFH_HID
> +       tristate "AMD Sensor Fusion Hub"
> +       help
> +         If you say yes to this option, support will be included for
> the
> +         AMD Sensor Fusion Hub.
> +         This driver will enable sensors functionality on AMD
> platforms
> +         starting from 17h family of RYZEN parts.
> +
> +         This driver can also be built as a module. If so, the
> module will
> +         be called amd-sfh.
> +         Say Y or M here if you want to support AMD SFH. If unsure,
> say N.
> +endmenu
> diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-
> hid/Makefile
> new file mode 100644
> index 000000000000..35e704da5612
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Makefile - AMD SFH HID drivers
> +# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
> +#
> +#
> +obj-$(CONFIG_AMD_SFH_HID) += amd_sfh.o
> +amd_sfh-objs := amd_sfh_hid.o
> +amd_sfh-objs += amd_sfh_client.o
> +amd_sfh-objs += amd_sfh_pcie.o
> +amd_sfh-objs += hid_descriptor/amd_sfh_hid_desc.o
> +
> +ccflags-y += -I $(srctree)/$(src)/
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> new file mode 100644
> index 000000000000..9c5eb442e1a6
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD MP2 PCIe communication driver
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *         Sandeep Singh <Sandeep.singh@amd.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "amd_sfh_pcie.h"
> +
> +#define DRIVER_NAME    "pcie_mp2_amd"
> +#define DRIVER_DESC    "AMD(R) PCIe MP2 Communication Driver"
> +
> +#define ACEL_EN                BIT(1)
> +#define GYRO_EN                BIT(2)
> +#define MAGNO_EN       BIT(3)
> +#define ALS_EN         BIT(19)
> +
> +void amd_start_sensor(struct amd_mp2_dev *privdata, struct
> amd_mp2_sensor_info info)
> +{
> +       union sfh_cmd_param cmd_param;
> +       union sfh_cmd_base cmd_base;
> +
> +       /* fill up command register */
> +       memset(&cmd_base, 0, sizeof(cmd_base));
> +       cmd_base.s.cmd_id = ENABLE_SENSOR;
> +       cmd_base.s.period = info.period;
> +       cmd_base.s.sensor_id = info.sensor_idx;
> +
> +       /* fill up command param register */
> +       memset(&cmd_param, 0, sizeof(cmd_param));
> +       cmd_param.s.buf_layout = 1;
> +       cmd_param.s.buf_length = 16;
> +
> +       writeq(info.phys_address, privdata->mmio + AMD_C2P_MSG2);
> +       writel(cmd_param.ul, privdata->mmio + AMD_C2P_MSG1);
> +       writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +
> +void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx)
> +{
> +       union sfh_cmd_base cmd_base;
> +
> +       /* fill up command register */
> +       memset(&cmd_base, 0, sizeof(cmd_base));
> +       cmd_base.s.cmd_id = DISABLE_SENSOR;
> +       cmd_base.s.period = 0;
> +       cmd_base.s.sensor_id = sensor_idx;
> +
> +       writeq(0x0, privdata->mmio + AMD_C2P_MSG2);
> +       writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +
> +void amd_stop_all_sensors(struct amd_mp2_dev *privdata)
> +{
> +       union sfh_cmd_base cmd_base;
> +
> +       /* fill up command register */
> +       memset(&cmd_base, 0, sizeof(cmd_base));
> +       cmd_base.s.cmd_id = STOP_ALL_SENSORS;
> +       cmd_base.s.period = 0;
> +       cmd_base.s.sensor_id = 0;
> +
> +       writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +
> +int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8
> *sensor_id)
> +{
> +       int activestatus, num_of_sensors = 0;
> +
> +       privdata->activecontrolstatus = readl(privdata->mmio +
> AMD_P2C_MSG3);
> +       activestatus = privdata->activecontrolstatus >> 4;
> +       if (ACEL_EN  & activestatus)
> +               sensor_id[num_of_sensors++] = accel_idx;
> +
> +       if (GYRO_EN & activestatus)
> +               sensor_id[num_of_sensors++] = gyro_idx;
> +
> +       if (MAGNO_EN & activestatus)
> +               sensor_id[num_of_sensors++] = mag_idx;
> +
> +       if (ALS_EN & activestatus)
> +               sensor_id[num_of_sensors++] = als_idx;
> +
> +       return num_of_sensors;
> +}
> +
> +static void amd_mp2_pci_remove(void *privdata)
> +{
> +       amd_sfh_hid_client_deinit(privdata);
> +       amd_stop_all_sensors(privdata);
> +}
> +
> +static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *id)
> +{
> +       struct amd_mp2_dev *privdata;
> +       int rc;
> +
> +       privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata),
> GFP_KERNEL);
> +       if (!privdata)
> +               return -ENOMEM;
> +
> +       privdata->pdev = pdev;
> +       pci_set_drvdata(pdev, privdata);
> +       rc = pcim_enable_device(pdev);
> +       if (rc)
> +               return rc;
> +
> +       rc = pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
> +       if (rc)
> +               return rc;
> +
> +       privdata->mmio = pcim_iomap_table(pdev)[2];
> +       pci_set_master(pdev);
> +       rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +       if (rc) {
> +               rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +               return rc;
> +       }
> +       rc = devm_add_action_or_reset(&pdev->dev, amd_mp2_pci_remove,
> privdata);
> +       if (rc)
> +               return rc;
> +
> +       return amd_sfh_hid_client_init(privdata);
> +}
> +
> +static const struct pci_device_id amd_mp2_pci_tbl[] = {
> +       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> +
> +static struct pci_driver amd_mp2_pci_driver = {
> +       .name           = DRIVER_NAME,
> +       .id_table       = amd_mp2_pci_tbl,
> +       .probe          = amd_mp2_pci_probe,
> +};
> +module_pci_driver(amd_mp2_pci_driver);
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> +MODULE_AUTHOR("Sandeep Singh <Sandeep.singh@amd.com>");
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> new file mode 100644
> index 000000000000..e8be94f935b7
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * AMD MP2 PCIe communication driver
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *         Sandeep Singh <Sandeep.singh@amd.com>
> + */
> +
> +#ifndef PCIE_MP2_AMD_H
> +#define PCIE_MP2_AMD_H
> +
> +#include <linux/pci.h>
> +
> +#define PCI_DEVICE_ID_AMD_MP2  0x15E4
> +
> +#define ENABLE_SENSOR          1
> +#define DISABLE_SENSOR         2
> +#define STOP_ALL_SENSORS       8
> +
> +/* MP2 C2P Message Registers */
> +#define AMD_C2P_MSG0   0x10500
> +#define AMD_C2P_MSG1   0x10504
> +#define AMD_C2P_MSG2   0x10508
> +
> +/* MP2 P2C Message Registers */
> +#define AMD_P2C_MSG3   0x1068C /* Supported Sensors info */
> +
> +/* SFH Command register */
> +union sfh_cmd_base {
> +       u32 ul;
> +       struct {
> +               u32 cmd_id : 8;
> +               u32 sensor_id : 8;
> +               u32 period : 16;
> +       } s;
> +};
> +
> +union sfh_cmd_param {
> +       u32 ul;
> +       struct {
> +               u32 buf_layout : 2;
> +               u32 buf_length : 6;
> +               u32 rsvd : 24;
> +       } s;
> +};
> +
> +struct sfh_cmd_reg {
> +       union sfh_cmd_base cmd_base;
> +       union sfh_cmd_param cmd_param;
> +       phys_addr_t phys_addr;
> +};
> +
> +enum sensor_idx {
> +       accel_idx = 0,
> +       gyro_idx = 1,
> +       mag_idx = 2,
> +       als_idx = 19
> +};
> +
> +struct amd_mp2_dev {
> +       struct pci_dev *pdev;
> +       struct amdtp_cl_data *cl_data;
> +       void __iomem *mmio;
> +       u32 activecontrolstatus;
> +};
> +
> +struct amd_mp2_sensor_info {
> +       u8 sensor_idx;
> +       u32 period;
> +       phys_addr_t phys_address;
> +};
> +
> +void amd_start_sensor(struct amd_mp2_dev *privdata, struct
> amd_mp2_sensor_info info);
> +void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx);
> +void amd_stop_all_sensors(struct amd_mp2_dev *privdata);
> +int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8
> *sensor_id);
> +int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata);
> +int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata);
> +#endif


