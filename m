Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B76199694
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgCaMb6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 08:31:58 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbgCaMb6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 08:31:58 -0400
Received: from envy ([83.135.88.65]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MsZBb-1j3Eff3LdT-00tzT4; Tue, 31
 Mar 2020 14:31:40 +0200
Message-ID: <4fe47b0323c1d65d429ee89b000e8bfcd984495f.camel@richard-neumann.de>
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
From:   Richard Neumann <mail@richard-neumann.de>
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     Shyam-sundar.S-k@amd.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com
Date:   Tue, 31 Mar 2020 14:31:38 +0200
In-Reply-To: <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
         <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-j1Fj1/kACraQvoo4/Dbg"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:/9Jgtgs5/b4J5wbDYDb3VRV7SzUsZk1pRNnkECJtd4JTCOKz4b6
 +C0PFbZh91uaRMv+36JER9Zm5IMl4INzA5k9og2teoFVuCKzz1/gvrg3EnimTeAymm8Edj2
 uWsgWTWBjkKhG4RijNY/vnSMvcsbNZKpqzAwcZq1PTF2di1FqfcsgzG1NYpd3QBOOD+/NkT
 r4xNoL5cL5P87bgrlYMVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L7DeKZIPqH0=:2mivciAUm/KwmQm8afCSXT
 nGuX1NUi3bW0DXvQ298/9dPJVDV1cGF68F7ekRQ/gZ0ksVL8VkgYwdsY73pamlx8ZKDOSAA3r
 6lnAobG5gA9IvEcSDi07OyvqDkA5SB52nPZzC2HbM8VMytUCMNuQkjhaNxFlNXk5q4E4nFDw/
 sTannizfYpzlb9vsI9D60J4n5VxfS+pDOwerew6eg6r0RuIIYDcrwi09PLlMQmOv9YKRa5Lua
 GEwgBCfz40/HNXu77bpy6un9Fr62gvEmkbmG/9dMxjaUWOF6piOoQz7yX9XEo4XxhOdbBZ43R
 ihNyngYBWEM6ocb4lawNKWSKVdt9wxFdD9zXNlVuL3OG5lnURxoW1dROUxROLun06qDi/9wmw
 Ait1s3H0XndhmFdx4M4Pa5kjcZcv5AhElPBF7ma+puiWDywTqHF5xFnZNGICTnpXuAyE2rg9G
 u7PSpqz9gcdoBJWqgW54wZJ/qyg3yqKBY168pxdqsBQ33T+KrllOY896FxrI8YGRxSQYoluCj
 4i0NZp6lwNxeo82Pw/dDul9sHyAE/o40uW73ul9N3ZN7sA8F8GCEHuNdz1YZJbxOhm9rGiKtv
 lVSuAW5nvjNYzVhpNhQj9NGptp0IrbGDCpPmw5YTe4EcjDRC2puGgr2fD9wcCyf0aQ8VfCGIj
 Ygx0FGVyOy8/uBUNgAfF9QWTSMuQBCNy1q7o75WPaz713smQpSob2CymvKAINwD8Ls9vXHc7R
 pSR9wDmPRpmWpbymzWhzO5vXeYgQVIUExO3qKHBm4agk1EPZL1+LfWwywbUofRgErOSJEAVx1
 7VdccIVYrMyKv6xgRxbTsRr1pfCf5z3ZzuocBFOHkfPe37eIj6ngeRxuYcGN+GttX6GImVN
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--=-j1Fj1/kACraQvoo4/Dbg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not a real review, but your patch series seems to be repeating a lot
from drivers/i2c/busses/i2c-amd-mp2*.
Is there any chance we could re-use the code?
E.g. the AMD_C2P_* definitions from drivers/i2c/busses/i2c-amd-mp2.h?

Am Donnerstag, den 27.02.2020, 10:28 +0530 schrieb Sandeep Singh:
> From: Sandeep Singh <sandeep.singh@amd.com>
>=20
> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2
> processor (MP2 which is an ARM=C2=AE Cortex-M4 core based
> co-processor to x86) and it runs on MP2 where in driver resides
> on X86. This part of module will communicate with MP2 FW and
> provide that data into DRAM
>=20
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/hid/Kconfig                    |   2 +
>  drivers/hid/Makefile                   |   1 +
>  drivers/hid/amd-sfh-hid/Kconfig        |  20 +++
>  drivers/hid/amd-sfh-hid/Makefile       |  16 +++
>  drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 243
> +++++++++++++++++++++++++++++++++
>  drivers/hid/amd-sfh-hid/amd_mp2_pcie.h | 176
> ++++++++++++++++++++++++
>  6 files changed, 458 insertions(+)
>  create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
>  create mode 100644 drivers/hid/amd-sfh-hid/Makefile
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 494a39e..b253ad1 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1155,4 +1155,6 @@ source "drivers/hid/i2c-hid/Kconfig"
> =20
>  source "drivers/hid/intel-ish-hid/Kconfig"
> =20
> +source "drivers/hid/amd-sfh-hid/Kconfig"
> +
>  endmenu
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index bfefa36..15a08e8 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -139,3 +139,4 @@ obj-$(CONFIG_I2C_HID)		+=3D i2c-hid/
> =20
>  obj-$(CONFIG_INTEL_ISH_HID)	+=3D intel-ish-hid/
>  obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+=3D intel-ish-hid/
> +obj-$(CONFIG_AMD_SFH_HID)       +=3D amd-sfh-hid/
> diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-
> hid/Kconfig
> new file mode 100644
> index 0000000..7a224a1
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "AMD SFH HID support"
> +	depends on (X86_64 || COMPILE_TEST) && PCI
> +
> +config AMD_SFH_HID
> +	tristate "AMD Sensor Fusion Hub"
> +	select HID
> +	help
> +	If you say yes to this option, support will be included for the
> AMD
> +	Sensor Fusion Hub.
> +	This driver will enable sensors functionality to user through
> HID
> +	framework. Basically this driver will get data from MP2 FW
> +	and provide that data to HID framework.
> +	MP2 which is an ARM=C2=AE Cortex-M4 core based co-processor to x86.
> +
> +	This driver can also be built as modules. If so, the modules
> will
> +	be  called amd-mp2-pcie and amd-sfhtp-hid.
> +	Say Y or M here if you want to support AMD SFH. If unsure, say
> N.
> +
> +endmenu
> diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-
> hid/Makefile
> new file mode 100644
> index 0000000..fa38d84
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/Makefile
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile - AMD SFH HID drivers
> +# Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
> +#
> +#
> +ccflags-m :=3D -Werror
> +obj-$(CONFIG_AMD_SFH_HID) +=3D amd-mp2-pcie.o
> +amd-mp2-pcie-objs :=3D amd_mp2_pcie.o
> +
> +obj-$(CONFIG_AMD_SFH_HID) +=3Damd-sfhtp-hid.o
> +amd-sfhtp-hid-objs :=3D amdsfh-hid.o
> +amd-sfhtp-hid-objs+=3D amdsfh-hid-client.o
> +amd-sfhtp-hid-objs+=3D hid_descriptor/amd_sfh_hid_descriptor.o
> +
> +ccflags-y +=3D -I$(srctree)/$(src)/
> diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> new file mode 100644
> index 0000000..c67f389
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD MP2 PCIe communication driver
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *          Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com
> >
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include "amd_mp2_pcie.h"
> +
> +#define DRIVER_NAME	"pcie_mp2_amd"
> +#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Driver"
> +
> +#define	ACEL_EN		BIT(ACCEL_IDX)
> +#define	GYRO_EN		BIT(GYRO_IDX)
> +#define MAGNO_EN	BIT(MAG_IDX)
> +#define ALS_EN		BIT(AMBIENT_LIGHT_IDX)
> +
> +void amd_start_sensor(struct pci_dev *pdev, struct
> amd_mp2_sensor_info info)
> +{
> +	struct amd_mp2_dev *privdata =3D pci_get_drvdata(pdev);
> +	union sfh_command_parameter cmd_param;
> +	union sfh_cmd_base cmd_base;
> +
> +	/*fill up command register*/
> +	cmd_base.ul =3D 0;
> +	cmd_base.s.cmd_id =3D enable_sensor;
> +	cmd_base.s.period =3D info.period;
> +	cmd_base.s.sensor_id =3D info.sensor_idx;
> +
> +	/*fill up command param register*/
> +	cmd_param.ul =3D 0;
> +	cmd_param.s.buffer_layout =3D 1;
> +	cmd_param.s.buffer_length =3D 16;
> +
> +	write64((u64)info.phy_address, privdata->mmio + AMD_C2P_MSG2);
> +	writel(cmd_param.ul, privdata->mmio + AMD_C2P_MSG1);
> +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +EXPORT_SYMBOL_GPL(amd_start_sensor);
> +
> +void amd_stop_sensor(struct pci_dev *pdev, u16 sensor_idx)
> +{
> +	struct amd_mp2_dev *privdata =3D pci_get_drvdata(pdev);
> +	union sfh_cmd_base cmd_base;
> +
> +	/* fill up command register */
> +	cmd_base.ul =3D 0;
> +	cmd_base.s.cmd_id =3D disable_sensor;
> +	cmd_base.s.period =3D 0;
> +	cmd_base.s.sensor_id =3D sensor_idx;
> +
> +	write64(0x0, privdata->mmio + AMD_C2P_MSG2);
> +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +EXPORT_SYMBOL_GPL(amd_stop_sensor);
> +
> +void amd_stop_all_sensors(struct pci_dev *pdev)
> +{
> +	struct amd_mp2_dev *privdata =3D pci_get_drvdata(pdev);
> +	union sfh_cmd_base cmd_base;
> +
> +	/*fill up command register */
> +	cmd_base.ul =3D 0;
> +	cmd_base.s.cmd_id =3D stop_all_sensors;
> +	cmd_base.s.period =3D 0;
> +	cmd_base.s.sensor_id =3D 0;
> +
> +	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> +}
> +EXPORT_SYMBOL_GPL(amd_stop_all_sensors);
> +
> +int amd_mp2_get_sensor_num(struct pci_dev *dev, u8 *sensor_id)
> +{
> +	struct amd_mp2_dev *privdata =3D pci_get_drvdata(dev);
> +	int activestatus;
> +	int num_of_sensors =3D 0;
> +
> +	if (!sensor_id)
> +		return -ENOMEM;
> +
> +	privdata->eventreg.activecontrolstatus =3D
> +			readl(privdata->mmio + AMD_P2C_MSG3);
> +	activestatus =3D privdata->eventreg.activecontrolstatus >> 4;
> +
> +	if (ACEL_EN  & activestatus) {
> +		sensor_id[num_of_sensors] =3D ACCEL_IDX;
> +		num_of_sensors++;
> +	}
> +	if (GYRO_EN & activestatus) {
> +		sensor_id[num_of_sensors] =3D GYRO_IDX;
> +		num_of_sensors++;
> +	}
> +	if (MAGNO_EN & activestatus) {
> +		sensor_id[num_of_sensors] =3D MAG_IDX;
> +		num_of_sensors++;
> +	}
> +
> +	if (ALS_EN & activestatus) {
> +		sensor_id[num_of_sensors] =3D AMBIENT_LIGHT_IDX;
> +		num_of_sensors++;
> +	}
> +
> +	return num_of_sensors;
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_get_sensor_num);
> +
> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct
> pci_dev *pdev)
> +{
> +	int rc;
> +	int bar_index =3D 2;
> +	resource_size_t size, base;
> +
> +	pci_set_drvdata(pdev, privdata);
> +
> +	rc =3D pcim_enable_device(pdev);
> +	if (rc)
> +		goto err_pci_enable;
> +
> +	rc =3D pcim_iomap_regions(pdev, 1 >> 2, DRIVER_NAME);
> +	if (rc)
> +		goto err_pci_regions;
> +
> +	privdata->mmio =3D pcim_iomap_table(pdev)[2];
> +	pci_set_master(pdev);
> +
> +	rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		if (rc)
> +			goto err_dma_mask;
> +	}
> +
> +	rc =3D pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		rc =3D pci_set_consistent_dma_mask(pdev,
> DMA_BIT_MASK(32));
> +		if (rc)
> +			goto err_dma_mask;
> +	}
> +
> +	base =3D pci_resource_start(pdev, bar_index);
> +	size =3D pci_resource_len(pdev, bar_index);
> +	dev_dbg(ndev_dev(privdata), "Base addr:%llx size:%llx\n",
> +		(unsigned long long)base, (unsigned long long)size);
> +
> +	privdata->mmio =3D ioremap(base, size);
> +	if (!privdata->mmio) {
> +		rc =3D -EIO;
> +		goto err_dma_mask;
> +	}
> +
> +	return 0;
> +
> +err_dma_mask:
> +	pci_clear_master(pdev);
> +err_pci_regions:
> +	pci_disable_device(pdev);
> +err_pci_enable:
> +	pci_set_drvdata(pdev, NULL);
> +	return rc;
> +}
> +
> +static void amd_mp2_pci_deinit(struct amd_mp2_dev *privdata)
> +{
> +	struct pci_dev *pdev =3D ndev_pdev(privdata);
> +
> +	amd_stop_all_sensors(pdev);
> +	pci_iounmap(pdev, privdata->mmio);
> +
> +	pci_clear_master(pdev);
> +	pci_disable_device(pdev);
> +	pci_set_drvdata(pdev, NULL);
> +}
> +
> +static int amd_mp2_pci_probe(struct pci_dev *pdev,
> +			     const struct pci_device_id *id)
> +{
> +	struct amd_mp2_dev *privdata;
> +	int rc;
> +
> +	dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> +		 (int)pdev->vendor, (int)pdev->device, (int)pdev-
> >revision);
> +
> +	privdata =3D devm_kzalloc(&pdev->dev, sizeof(*privdata),
> GFP_KERNEL);
> +
> +	if (!privdata) {
> +		rc =3D -ENOMEM;
> +		goto err_dev;
> +	}
> +
> +	privdata->pdev =3D pdev;
> +
> +	rc =3D amd_mp2_pci_init(privdata, pdev);
> +	if (rc)
> +		goto err_pci_init;
> +	return 0;
> +
> +err_pci_init:
> +	return rc;
> +err_dev:
> +	return rc;
> +}
> +
> +static void amd_mp2_pci_remove(struct pci_dev *pdev)
> +{
> +	struct amd_mp2_dev *privdata =3D pci_get_drvdata(pdev);
> +
> +	amd_mp2_pci_deinit(privdata);
> +}
> +
> +static const struct pci_device_id amd_mp2_pci_tbl[] =3D {
> +	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> +
> +static struct pci_driver amd_mp2_pci_driver =3D {
> +	.name		=3D DRIVER_NAME,
> +	.id_table	=3D amd_mp2_pci_tbl,
> +	.probe		=3D amd_mp2_pci_probe,
> +	.remove		=3D amd_mp2_pci_remove,
> +};
> +
> +static int __init amd_mp2_pci_driver_init(void)
> +{
> +	return pci_register_driver(&amd_mp2_pci_driver);
> +}
> +module_init(amd_mp2_pci_driver_init);
> +
> +static void __exit amd_mp2_pci_driver_exit(void)
> +{
> +	pci_unregister_driver(&amd_mp2_pci_driver);
> +}
> +module_exit(amd_mp2_pci_driver_exit);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> +MODULE_AUTHOR("Nehal Bakulchandra Shah <
> Nehal-bakulchandra.Shah@amd.com>");
> diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> new file mode 100644
> index 0000000..3ba69ac
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> @@ -0,0 +1,176 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * AMD MP2 PCIe communication driver
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *          Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com
> >
> + */
> +
> +#ifndef PCIE_MP2_AMD_H
> +#define PCIE_MP2_AMD_H
> +
> +#include <linux/pci.h>
> +#define PCI_DEVICE_ID_AMD_MP2	0x15E4
> +
> +/* MP2 C2P Message Registers */
> +#define AMD_C2P_MSG0	0x10500
> +#define AMD_C2P_MSG1	0x10504
> +#define AMD_C2P_MSG2	0x10508
> +#define AMD_C2P_MSG3	0x1050c
> +#define AMD_C2P_MSG4	0x10510
> +#define AMD_C2P_MSG5	0x10514
> +#define AMD_C2P_MSG6	0x10518
> +#define AMD_C2P_MSG7	0x1051c
> +#define AMD_C2P_MSG8	0x10520
> +#define AMD_C2P_MSG9	0x10524
> +
> +/* MP2 P2C Message Registers */
> +#define AMD_P2C_MSG0	0x10680 /*Do not use*/
> +#define AMD_P2C_MSG1	0x10684
> +#define AMD_P2C_MSG2	0x10688
> +#define AMD_P2C_MSG3	0x1068C /*MP2 debug info*/
> +#define AMD_P2C_MSG_INTEN	0x10690 /*MP2 int gen register*/
> +#define AMD_P2C_MSG_INTSTS	0x10694 /*Interrupt sts*/
> +
> +#define write64 amdsfh_write64
> +static inline void amdsfh_write64(u64 val, void __iomem *mmio)
> +{
> +	writel(val, mmio);
> +	writel(val >> 32, mmio + sizeof(u32));
> +}
> +
> +#define read64 amdsfh_read64
> +static inline u64 amdsfh_read64(void __iomem *mmio)
> +{
> +	u64 low, high;
> +
> +	low =3D readl(mmio);
> +	high =3D readl(mmio + sizeof(u32));
> +	return low | (high << 32);
> +}
> +
> +/*
> + * SFH Command registers
> + */
> +union sfh_cmd_base {
> +	u32 ul;
> +	struct {
> +		u32 cmd_id : 8;
> +		u32 sensor_id : 8;
> +		u32 period : 16;
> +	} s;
> +};
> +
> +union sfh_command_parameter {
> +	u32 ul;
> +	struct {
> +		u32 buffer_layout : 2;
> +		u32 buffer_length : 6;
> +		u32 rsvd : 24;
> +	} s;
> +};
> +
> +struct sfh_command_register {
> +	union sfh_cmd_base cmd_base;
> +	union sfh_command_parameter cmd_param;
> +	phys_addr_t phy_addr;
> +};
> +
> +/*
> + * SFH Response registers
> + */
> +enum response_type {
> +	non_operationevent,
> +	command_success,
> +	command_failed,
> +	sfi_dataready_event,
> +	invalid_response =3D 0xff,
> +};
> +
> +enum status_type {
> +	cmd_success,
> +	invalid_data_payload,
> +	invalid_data_length,
> +	invalid_sensor_id,
> +	invalid_dram_addr,
> +	invalid_command,
> +	sensor_enabled,
> +	sensor_disabled,
> +	status_end,
> +};
> +
> +enum command_id {
> +	non_operation =3D 0,
> +	enable_sensor =3D 1,
> +	disable_sensor =3D 2,
> +	dump_sensorinfo =3D 3,
> +	numberof_sensordiscovered =3D 4,
> +	who_am_i_regchipid =3D 5,
> +	set_dcd_data =3D 6,
> +	get_dcd_data =3D 7,
> +	stop_all_sensors =3D 8,
> +	invalid_cmd =3D 0xf,
> +};
> +
> +/**
> + * union sfh_event_base : bit access of C2P commands
> + * @response: bit: 0..3 SFI response_type
> + * @status: bit: 6..5 status_type
> + * @out_in_c2p: bit: 5 0- output in DRAM,1-in C2PMsg
> + * @length: bit: 8..13 length
> + * @dbg:bit: 14.15 dbg msg include in p2c msg 1-2
> + * @sensor_id:bit: 16..23 Sensor ID
> + * @rsvd:bit: 24..31 Reservered for future use
> + */
> +union sfh_event_base {
> +	u32 ul;
> +	struct {
> +		u32 response : 4;
> +		u32 status : 3;
> +		u32 out_in_c2p : 1;
> +		u32 length : 6;
> +		u32 dbg : 2;
> +		u32 sensor_id : 8;
> +		u32 rsvd : 8;
> +	} s;
> +};
> +
> +struct sfi_event_register {
> +	union sfh_event_base evtbase;
> +	u32 debuginfo1;
> +	u32 debuginfo2;
> +	u32 activecontrolstatus;
> +};
> +
> +enum sensor_idx {
> +	ACCEL_IDX               =3D 0,
> +	GYRO_IDX                =3D 1,
> +	MAG_IDX                 =3D 2,
> +	AMBIENT_LIGHT_IDX       =3D 19,
> +	NUM_ALL_SENSOR_CONSUMERS
> +};
> +
> +struct amd_mp2_dev {
> +	struct pci_dev *pdev;
> +	void __iomem *mmio;
> +	union sfh_event_base eventval;
> +	struct sfi_event_register eventreg;
> +	struct delayed_work work;
> +	void *ctx;
> +	void *cl_data;
> +};
> +
> +struct amd_mp2_sensor_info {
> +	u8 sensor_idx;
> +	u32 period;
> +	phys_addr_t phy_address;
> +};
> +
> +void amd_start_sensor(struct pci_dev *pdev, struct
> amd_mp2_sensor_info info);
> +void amd_stop_sensor(struct pci_dev *pdev, u16 sensor_idx);
> +void amd_stop_all_sensors(struct pci_dev *pdev);
> +int amd_mp2_get_sensor_num(struct pci_dev *dev, u8 *sensor_id);
> +#define ndev_pdev(ndev) ((ndev)->pdev)
> +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> +#endif

--=-j1Fj1/kACraQvoo4/Dbg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT62wKwhMqSt8WaustMqNUjvThq9wUCXoM4KgAKCRBMqNUjvThq
91QZAQDtQjZKLSXTrHO938keXUlbjJdrMg3a1fRHRJI1RY5cEQEA0gRxldAHCouu
fZU33IIcnj+XIuKDV98cvhPN8DoCCQg=
=M4dC
-----END PGP SIGNATURE-----

--=-j1Fj1/kACraQvoo4/Dbg--

