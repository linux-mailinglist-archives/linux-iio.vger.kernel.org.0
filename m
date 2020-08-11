Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D78241BD7
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 15:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgHKNzM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Aug 2020 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbgHKNzB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2020 09:55:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431CCC061788
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 06:55:01 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1k5Ujt-0007X5-5j; Tue, 11 Aug 2020 15:54:53 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1k5Ujr-0000Ll-Cv; Tue, 11 Aug 2020 15:54:51 +0200
Date:   Tue, 11 Aug 2020 15:54:51 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, rdunlap@infradead.org,
        Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v7 2/4] SFH: PCIe driver to add support of AMD sensor
 fusion hub
Message-ID: <20200811135451.atfcymsorrkh4xva@pengutronix.de>
References: <20200810213055.103962-1-Sandeep.Singh@amd.com>
 <20200810213055.103962-3-Sandeep.Singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810213055.103962-3-Sandeep.Singh@amd.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:43:21 up 270 days,  4:01, 258 users,  load average: 0.02, 0.04,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Sandeep,

On 20-08-10 21:30, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2 processor
> (MP2 which is an ARM® Cortex-M4 core based co-processor to x86) and
> it runs on MP2 where in driver resides on X86. This part of module
> will communicate with MP2 Firmware and provide that data into DRAM

IMO we should reword the commit message since it is a bit odd.

> diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
> new file mode 100644
> index 000000000000..a163c7f62b32
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Makefile - AMD SFH HID drivers
> +# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
> +#
> +#
> +
> +ccflags-m := -Werror

Hm.. is this really needed? Don't get me wrong I'm a fan of no-warnings
but only a few drivers set this flag.

> +   obj-$(CONFIG_AMD_SFH_HID) +=amd-sfhtp-hid.o
> +   amd-sfhtp-hid-objs := amdsfh_hid.o
> +   amd-sfhtp-hid-objs+= amdsfh_hid_client.o
> +   amd-sfhtp-hid-objs+= amd_mp2_pcie.o
> +   amd-sfhtp-hid-objs+= hid_descriptor/amd_sfh_hid_descriptor.o

IMHO a patch should be self-contained. By that I mean that if uspstream
apply just that patch it won't break things. This isn't the case here
since you already added the support the other driver parts.

Also please check indentation and whitespaces.

> +
> +ccflags-y += -I$(srctree)/$(src)/
> diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> new file mode 100644
> index 000000000000..898157f4240b
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD MP2 PCIe communication driver
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *	    Sandeep Singh <Sandeep.singh@amd.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/types.h>
> +#include "amd_mp2_pcie.h"
> +
> +#define DRIVER_NAME	"pcie_mp2_amd"
> +#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Driver"
> +
> +#define ACEL_EN		BIT(accel_idx)
> +#define GYRO_EN		BIT(gyro_idx)
> +#define MAGNO_EN	BIT(mag_idx)
> +#define ALS_EN		BIT(als_idx)
> +
> +void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor_info info)
> +{
> +	union sfh_cmd_param cmd_param;
> +	union sfh_cmd_base cmd_base;
> +
> +	/* fill up command register */
> +	cmd_base.ul = 0;

Why not memset()? Please see my below comments on the header.

> +	cmd_base.s.cmd_id = enable_sensor;
> +	cmd_base.s.period = info.period;
> +	cmd_base.s.sensor_id = info.sensor_idx;
> +
> +	/* fill up command param register */
> +	cmd_param.ul = 0;
> +	cmd_param.s.buf_layout = 1;
> +	cmd_param.s.buf_length = 16;
> +
> +	writeq(info.phys_address, privdata->mmio + AMD_C2P_MSG2);
> +	writel(cmd_param.ul, privdata->mmio + AMD_C2P_MSG1);
> +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +
> +void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx)

Why has amd_stop_sensor() a complete different API than
amd_start_sensor(). IMHO I would keep it in sync. Also u16 sensor_idx is
to large. Just use the struct amd_mp2_sensor_info.

> +{
> +	union sfh_cmd_base cmd_base;
> +
> +	/* fill up command register */
> +	cmd_base.ul = 0;
> +	cmd_base.s.cmd_id = disable_sensor;
> +	cmd_base.s.period = 0;
> +	cmd_base.s.sensor_id = sensor_idx;
> +
> +	writeq(0x0, privdata->mmio + AMD_C2P_MSG2);
> +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +
> +void amd_stop_all_sensors(struct amd_mp2_dev *privdata)
> +{
> +	union sfh_cmd_base cmd_base;
> +
> +	/* fill up command register */
> +	cmd_base.ul = 0;
> +	cmd_base.s.cmd_id = stop_all_sensors;
> +	cmd_base.s.period = 0;
> +	cmd_base.s.sensor_id = 0;
> +
> +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +
> +int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id)
> +{

Nit: Why not amd_get_sensor_num() to keep naming scheme? Also I would
keep the API and make use of 'struct amd_mp2_sensor_info'.

> +	int activestatus, num_of_sensors = 0;
> +
> +	if (!sensor_id)
> +		return -EINVAL;
> +
> +	privdata->activecontrolstatus = readl(privdata->mmio + AMD_P2C_MSG3);
> +	activestatus = privdata->activecontrolstatus >> 4;

Magical shift here? Please make use of FIELD_GET().

> +	if (ACEL_EN  & activestatus)
> +		sensor_id[num_of_sensors++] = accel_idx;
> +
> +	if (GYRO_EN & activestatus)
> +		sensor_id[num_of_sensors++] = gyro_idx;
> +
> +	if (MAGNO_EN & activestatus)
> +		sensor_id[num_of_sensors++] = mag_idx;
> +
> +	if (ALS_EN & activestatus)
> +		sensor_id[num_of_sensors++] = als_idx;
> +
> +	return num_of_sensors;
> +}
> +
> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	pci_set_drvdata(pdev, privdata);
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +	pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
> +
> +	privdata->mmio = pcim_iomap_table(pdev)[2];
> +	pci_set_master(pdev);
> +
> +	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (rc)
> +		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +	return rc;
> +}
> +
> +static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct amd_mp2_dev *privdata;
> +	int rc;
> +
> +	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
> +	if (!privdata)
> +		return -ENOMEM;
> +	privdata->pdev = pdev;

You don't need the pdev in this driver, why do you store it?

> +	rc = amd_mp2_pci_init(privdata, pdev);
> +	if (rc)
> +		return rc;
> +	rc = amd_sfh_hid_client_init(privdata);

As I said, this is not self-contained.

> +	if (rc)
> +		return rc;
> +	return 0;
> +}
> +
> +static void amd_mp2_pci_remove(struct pci_dev *pdev)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
> +
> +	amd_sfh_hid_client_deinit(privdata);
> +	amd_stop_all_sensors(privdata);

This actions can be done in a devm_add_action_or_reset() and avoids
the remove() callback.

> +}
> +
> +static const struct pci_device_id amd_mp2_pci_tbl[] = {
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2) },
> +	{},

Missing whitespace:
        { },
> +};
> +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> +
> +static struct pci_driver amd_mp2_pci_driver = {
> +	.name		= DRIVER_NAME,
> +	.id_table	= amd_mp2_pci_tbl,
> +	.probe		= amd_mp2_pci_probe,
> +	.remove		= amd_mp2_pci_remove,
> +};
> +module_pci_driver(amd_mp2_pci_driver);
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> +MODULE_AUTHOR("Sandeep Singh <Sandeep.singh@amd.com>");
> diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> new file mode 100644
> index 000000000000..a4ef604c4fe8
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * AMD MP2 PCIe communication driver
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *	    Sandeep Singh <Sandeep.singh@amd.com>
> + */
> +
> +#ifndef PCIE_MP2_AMD_H
> +#define PCIE_MP2_AMD_H
> +
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +
> +#define PCI_DEVICE_ID_AMD_MP2	0x15E4
> +
> +/* MP2 C2P Message Registers */
> +#define AMD_C2P_MSG0	0x10500
> +#define AMD_C2P_MSG1	0x10504
> +#define AMD_C2P_MSG2	0x10508
> +
> +/* MP2 P2C Message Registers */
> +#define AMD_P2C_MSG3	0x1068C /* Supported Sensors info */
> +
> +/* SFH Command register */
> +union sfh_cmd_base {
> +	u32 ul;
> +	struct {
> +		u32 cmd_id : 8;
> +		u32 sensor_id : 8;
> +		u32 period : 16;
> +	} s;
> +};

Why not just:
struct sfh_cmd_base {
	u8 cmd_id;
	u8 sensor_id;
	u16 period;
};

Please use the native data types. Furthermore the code in this driver
assumes that the host(x86) and client(ARM) are using the same
byte-order. I know that ARM is LE too but maybe this changes on newer
ZEN-CPU's.

> +union sfh_cmd_param {
> +	u32 ul;
> +	struct {
> +		u32 buf_layout : 2;
> +		u32 buf_length : 6;
> +		u32 rsvd : 24;
> +	} s;
> +};

This union is only used by amd_start_sensor() and the below struct which
is used nowhere. I would rather drop this here and prepare the
buf_layout and buf_length by FIELD_PREP().

> +struct sfh_cmd_reg {
> +	union sfh_cmd_base cmd_base;
> +	union sfh_cmd_param cmd_param;
> +	phys_addr_t phys_addr;
> +};

This struct is gets never used here.

> +
> +enum command_id {
> +	enable_sensor = 1,
> +	disable_sensor = 2,
> +	stop_all_sensors = 8,
> +	invalid_cmd = 0xf
> +};

Please use CAPITAL_NAMES, e.g.:

enum command_id {
	AMD_MP2_SENSOR_ENABLE = 1,
	AMD_MP2_SENSOR_DISABLE = 2,
	AMD_MP2_SENSOR_STOP_ALL = 8,
}

or use #define.

> +
> +enum sensor_idx {
> +	accel_idx = 0,
> +	gyro_idx = 1,
> +	mag_idx = 2,
> +	als_idx = 19
> +};

Same here.

> +
> +struct amd_mp2_dev {
> +	struct pci_dev *pdev;

pdev is never used.

> +	struct amdtp_cl_data *cl_data;

cl_data gets never set -> useless?

> +	void __iomem *mmio;
> +	u32 activecontrolstatus;

The activecontrolstatus member is also never used.
> +};
> +
> +struct amd_mp2_sensor_info {
> +	u8 sensor_idx;
> +	u32 period;

The sfh_cmd_base defines it as u16.

> +	phys_addr_t phys_address;
> +};
> +
> +void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor_info info);
> +void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx);
> +void amd_stop_all_sensors(struct amd_mp2_dev *privdata);

> +int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id);

I would add this 

> +int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata);
> +int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata);

Why are those functions included here?

Regards,
  Marco

> +#endif
> -- 
> 2.25.1
