Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519F219595C
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 15:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0Oza (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 10:55:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34677 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0Oza (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 10:55:30 -0400
Received: by mail-pj1-f67.google.com with SMTP id q16so4418978pje.1;
        Fri, 27 Mar 2020 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hMe+oSHJBW6UsdbtjmeglsZzzpJBLz67w+Nq9lTpv0M=;
        b=uclgbugm3q1+tDitqZwMtXmnPFnoPKF9EBr+hyERJ8aQrR+926othflFR12Xnwla9P
         4HoLuO18+YGXlP/TRpt3jG5Yf7diItTSj0kCud7TFXo1Zm0vnQu0ZXoEO0LfCh1qHX/x
         cb6bO9LSy7V4l8ThHESVtPA7qWtU4rKJlRWwNa7/fX5ySS2ibrQvEOd38dxAk2AUaGVm
         j+jmyRrEANcSegdxton5r3fEzSNA3bjG6VZSwnnJOovxGoYbO941DXVUOaR0uU+rcDjn
         RC3u5OkIH6kGdLRAE8gn8GuSuzRfs4gLw5PzdWL6cb/K8nCG2+U/DO6fLp5/vTmqyQum
         BzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hMe+oSHJBW6UsdbtjmeglsZzzpJBLz67w+Nq9lTpv0M=;
        b=FvDa74X8Q8J2hK1do1IHd8w0+70t1QUo4gECB5b01aMaQV4J+Us00hdaura3xkBt3d
         VX6sShV1QNCaC1mQvspxd6Guq/4BhokN98hx237teuP8Y0oI4gcA2so0moe2kQLiXI8V
         3+MxiakeLi43nttGCRmWPaXTe9xNFhYuLifu5jdZNWX5orcnnkedKoQJ3z4/eyu3juii
         EQoKsslAUW0RJHX4STgKSm8je9GSnhbE3r7acl3JznCj4ppt2j71cayQjStJgWWm88Nk
         8rOjtsINruAdlb7gqtNwBfVXPbC0ga/EHJzSjMtKblzV1tMDCtEmBotiRDGlDxWMQpoY
         FjUA==
X-Gm-Message-State: ANhLgQ2KcKUnKbKlfs+Trl5UV5xhJRil+6M/5e2lDY6uwclYN311wDfZ
        NvgUdXJfcFbRvBOVt1UeHcdzwERfcyVcb9mvzv0=
X-Google-Smtp-Source: ADFU+vt/mVFDoSr3PudJB8BF8eGZnZLEv617k9lqwl/4PZPvavEiozFscKiHZPly8fetj5mNUWou2WE2GG13XahiHtA=
X-Received: by 2002:a17:902:5acb:: with SMTP id g11mr6245009plm.18.1585320927632;
 Fri, 27 Mar 2020 07:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com> <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
In-Reply-To: <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Mar 2020 16:55:20 +0200
Message-ID: <CAHp75VcTnZzf9_=ftO=+LbSx3v5FWqVq5RJ=FW32z2FPCnYbsw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 27, 2020 at 7:01 AM Sandeep Singh <Sandeep.Singh@amd.com> wrote=
:
>
> From: Sandeep Singh <sandeep.singh@amd.com>
>
> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2
> processor (MP2 which is an ARM=C2=AE Cortex-M4 core based
> co-processor to x86) and it runs on MP2 where in driver resides
> on X86. This part of module will communicate with MP2 FW and
> provide that data into DRAM

You asked for review, here you are.
TL,DR; it requires a bit of work.

...

> +       depends on (X86_64 || COMPILE_TEST) && PCI

For better maintenance
       depends on X86_64 || COMPILE_TEST
       depends on PCI

...

> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile - AMD SFH HID drivers
> +# Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
> +#

> +#

Perhaps simple blank line instead?

> +ccflags-y +=3D -I$(srctree)/$(src)/

Why?

...

> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>

Keep in order?

+ blank line?

Missed bits.h, types.h.

> +#include "amd_mp2_pcie.h"

...

> +       write64((u64)info.phy_address, privdata->mmio + AMD_C2P_MSG2);

Why explicit cast?

...

> +       /*fill up command register */

Space is missed.

...

> +       if (!sensor_id)
> +               return -ENOMEM;

I can say -EINVAL as per its definition, but why do you need this at all?

...

> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct pci_dev=
 *pdev)
> +{
> +       int rc;
> +       int bar_index =3D 2;
> +       resource_size_t size, base;

> +       pci_set_drvdata(pdev, privdata);

Better to assign when you are sure (to some extend in both of them):
a) it's needed
b) driver is going to be probed correctly

...

> +       rc =3D pcim_iomap_regions(pdev, 1 >> 2, DRIVER_NAME);

What 1 >> 2 means? Shouldn't be simple BIT(2)?
How was this been tested?

> +       if (rc)
> +               goto err_pci_regions;

...

> +       base =3D pci_resource_start(pdev, bar_index);
> +       size =3D pci_resource_len(pdev, bar_index);
> +       dev_dbg(ndev_dev(privdata), "Base addr:%llx size:%llx\n",
> +               (unsigned long long)base, (unsigned long long)size);

Read printk-formats.rst.
Now, when you get familiar with it, find proper specifier and drop
these ugly castings.
But wait, why do you need this? `dmesg` will show it anyway during
boot / hotplug event time.

...

> +       privdata->mmio =3D ioremap(base, size);
> +       if (!privdata->mmio) {
> +               rc =3D -EIO;
> +               goto err_dma_mask;
> +       }

Why?!

...

> +err_dma_mask:
> +       pci_clear_master(pdev);
> +err_pci_regions:
> +       pci_disable_device(pdev);

Are you using devres or not? Please, be consistent.

> +err_pci_enable:

> +       pci_set_drvdata(pdev, NULL);

I think it's some like 5 to 10 years that we don't need this.

> +       return rc;
> +}

...

> +       pci_iounmap(pdev, privdata->mmio);
> +
> +       pci_clear_master(pdev);
> +       pci_disable_device(pdev);
> +       pci_set_drvdata(pdev, NULL);

Ditto as above two comments.

...

> +       dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> +                (int)pdev->vendor, (int)pdev->device, (int)pdev->revisio=
n);

Oh, if you use explicit casting for printf(), 99.9% you are doing
something wrong (in kernel space).
On top of that, why this noise is here?

...

> +       privdata =3D devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERN=
EL);

> +

No need for this blank line.

> +       if (!privdata) {

> +       }

...


> +       rc =3D amd_mp2_pci_init(privdata, pdev);
> +       if (rc)
> +               goto err_pci_init;
> +       return 0;

Why its content can't be simple here? I.o.w. why this function is needed?

...

> +err_pci_init:
> +       return rc;
> +err_dev:
> +       return rc;

Completely useless code.

> +}

...

> +static const struct pci_device_id amd_mp2_pci_tbl[] =3D {
> +       {PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
> +       {0}

0 is not needed, but it's up to you.

> +};

...

> +static int __init amd_mp2_pci_driver_init(void)
> +{
> +       return pci_register_driver(&amd_mp2_pci_driver);
> +}
> +module_init(amd_mp2_pci_driver_init);
> +
> +static void __exit amd_mp2_pci_driver_exit(void)
> +{
> +       pci_unregister_driver(&amd_mp2_pci_driver);
> +}
> +module_exit(amd_mp2_pci_driver_exit);

module_pci_driver()
We have it for years.

...

> +#include <linux/pci.h>

I don't see users of it, but missed headers
types.h

...

> +#define PCI_DEVICE_ID_AMD_MP2  0x15E4

Why it's not in C file?

...

> +#define AMD_P2C_MSG0   0x10680 /*Do not use*/
> +#define AMD_P2C_MSG1   0x10684
> +#define AMD_P2C_MSG2   0x10688
> +#define AMD_P2C_MSG3   0x1068C /*MP2 debug info*/
> +#define AMD_P2C_MSG_INTEN      0x10690 /*MP2 int gen register*/
> +#define AMD_P2C_MSG_INTSTS     0x10694 /*Interrupt sts*/

Missed spaces.

...

> +#define write64 amdsfh_write64
> +static inline void amdsfh_write64(u64 val, void __iomem *mmio)
> +{
> +       writel(val, mmio);
> +       writel(val >> 32, mmio + sizeof(u32));
> +}

NIH of lo_hi_writeq().

> +#define read64 amdsfh_read64
> +static inline u64 amdsfh_read64(void __iomem *mmio)
> +{
> +       u64 low, high;
> +
> +       low =3D readl(mmio);
> +       high =3D readl(mmio + sizeof(u32));
> +       return low | (high << 32);
> +}

NIH of lo_hi_readq().

...

> +struct sfh_command_register {
> +       union sfh_cmd_base cmd_base;
> +       union sfh_command_parameter cmd_param;

> +       phys_addr_t phy_addr;

Are you sure? This type is flexible. And by name of the struct I think
it operates with hardware, so, fix it accordingly.

> +};

...

> +enum response_type {
> +       non_operationevent,
> +       command_success,
> +       command_failed,
> +       sfi_dataready_event,
> +       invalid_response =3D 0xff,

GENMASK()

> +};

UPPER CASE?

> +enum status_type {
> +       cmd_success,
> +       invalid_data_payload,
> +       invalid_data_length,
> +       invalid_sensor_id,
> +       invalid_dram_addr,
> +       invalid_command,
> +       sensor_enabled,
> +       sensor_disabled,
> +       status_end,
> +};
> +
> +enum command_id {
> +       non_operation =3D 0,
> +       enable_sensor =3D 1,
> +       disable_sensor =3D 2,
> +       dump_sensorinfo =3D 3,
> +       numberof_sensordiscovered =3D 4,
> +       who_am_i_regchipid =3D 5,
> +       set_dcd_data =3D 6,
> +       get_dcd_data =3D 7,
> +       stop_all_sensors =3D 8,
> +       invalid_cmd =3D 0xf,
> +};

Ditto.

...

> +enum sensor_idx {

Do you need names for enums like this?

> +       ACCEL_IDX               =3D 0,
> +       GYRO_IDX                =3D 1,
> +       MAG_IDX                 =3D 2,
> +       AMBIENT_LIGHT_IDX       =3D 19,
> +       NUM_ALL_SENSOR_CONSUMERS
> +};

...

> +struct amd_mp2_dev {
> +       struct pci_dev *pdev;

> +       void __iomem *mmio;

Header for __iomem?

> +       struct delayed_work work;

Header for this?

> +       void *ctx;
> +       void *cl_data;
> +};

...

> +struct amd_mp2_sensor_info {
> +       u8 sensor_idx;
> +       u32 period;

> +       phys_addr_t phy_address;

Same comment as per above use of phys_addr_t type.

> +};

...

> +#define ndev_pdev(ndev) ((ndev)->pdev)
> +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)

Why? What's the benefit?

--=20
With Best Regards,
Andy Shevchenko
