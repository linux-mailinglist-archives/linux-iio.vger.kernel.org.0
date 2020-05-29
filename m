Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFB51E7F8D
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2ODw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2ODw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 10:03:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B7C03E969;
        Fri, 29 May 2020 07:03:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so1201586plb.3;
        Fri, 29 May 2020 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+8BeeRU5yq84Y7xACwKjlFj8O/sTm7r6UQxGrXKL3S4=;
        b=LBX7NcGjcyBVPH9aCqA99HJ4KnFCFHTxWNboCHWHg2r/aJJm5mLByb+hfCK9ZHIWDq
         Fo3HsLz2q9aH1YK60dbyLiDLpcdtuem3wxqV9r0Tx8TK5R1MqK8QChtpj2+tK4t7cwfx
         5pnf+vzVQ1w5TvNZPRovP2JvdjU+TGS38M/syflcU3GkgY8J+4OJZmoP3sPmiST4HVFp
         mXbqzGxg61SKoj8D9gYpp0eqOnmdpYddesLribSDTSrTdwrH1EGhkFYG1Dt6H7r/DVIq
         2x3ZfVyetr7Z+C3IYPDdHhZpwndlavP3MTxr19Ptk9323lq+e9oRXW/tPHreMSZ4XsIS
         3uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+8BeeRU5yq84Y7xACwKjlFj8O/sTm7r6UQxGrXKL3S4=;
        b=I2vb8x+H5MLOJS3CjVjcp7owUl5TCpoCZeDxGTLPcImC/IlQ5Wxp+l+GyCKzM6cAhm
         QYaxhaopAx1mYyxmn6hs0frj7Gi0XQB9bs+86HfB9OFvU9XCosiZxsT7vi74iqU6TMcx
         FLKJSHqdRZvHN4rjDJTvA3ucb0gCkT2swZi3cIOk11AfRDtENWWMgVkGneHEt7Gcurbh
         NBo8AI3skW/i1fKv80SLO2DqzTqmZs2CeVgSFeKVSz7wXOkoSiE50DR3y67ANHggqCxa
         x5tdu2WIWvJsxFXiXSmDMuI7csjh8ZHVOCOus5cbo0m+MOKUbtVd/iaNyzPLwVmuqWaR
         O5ag==
X-Gm-Message-State: AOAM530UNH9Sv4SB8Rk87ROmhcnPkrLCzi12KaYQhUPG8Vezq4qSQD0/
        4l1gGFLZf9NunsI3DyFSqZb11e068ZYtIRPyCQc=
X-Google-Smtp-Source: ABdhPJxK/Dhov3cOO+ENzMiqgUnOFOHG45NHV82YolYh2ed/Y7nyHhn/DYvljwO2yf4T26yX+u70Wv21Fibyzchtv1Q=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr9509227pjd.181.1590761031400;
 Fri, 29 May 2020 07:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com> <1590759730-32494-3-git-send-email-Sandeep.Singh@amd.com>
In-Reply-To: <1590759730-32494-3-git-send-email-Sandeep.Singh@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 May 2020 17:03:39 +0300
Message-ID: <CAHp75VcLUwXPaEUE+vrkYKdqhe2hTDz5Q7mxqoYWJu3fX0G+JA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] SFH: PCI driver to add support of AMD sensor
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
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Richard Neumann <mail@richard-neumann.de>,
        Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 29, 2020 at 4:42 PM Sandeep Singh <Sandeep.Singh@amd.com> wrote=
:
>
> From: Sandeep Singh <sandeep.singh@amd.com>
>
> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2
> processor (MP2 which is an ARM=C2=AE Cortex-M4 core based
> co-processor to x86) and it runs on MP2 where in driver resides
> on X86. This part of module will communicate with MP2 FW and
> provide that data into DRAM
>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>

> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>

Why you are submitting code if Nehal's SoB last in the list?

...

> Reported-by: kbuild test robot <lkp@intel.com>

I guess it's not applicable here, since it's a new code. Rather you
may mentioned this in changelog in cover letter.

...

> +       write64(0x0, privdata->mmio + AMD_C2P_MSG2);

Hmm... What's write64()? Isn't it writeq()?

...

> +       if (ACEL_EN  & activestatus) {
> +               sensor_id[num_of_sensors] =3D ACCEL_IDX;
> +               num_of_sensors++;
> +       }

You can drop a lot of LOCs by doing

    if (ACEL_EN  & activestatus)
        sensor_id[num_of_sensors++] =3D ACCEL_IDX;

...

> +       rc =3D pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
> +       if (rc)

> +               goto err_pci_enable;

Due to use of PCI managed functions error path is not needed at all.
Return directly.

...

> +       rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +       if (rc) {
> +               rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +               if (rc)
> +                       goto err_dma_mask;
> +       }

rc =3D ...;
if (rc)
  rc =3D ...;
if (rc)
  return rc;

...

> +err_dma_mask:
> +       pci_clear_master(pdev);

PCI managed handling does it for you.

> +err_pci_enable:
> +       pci_set_drvdata(pdev, NULL);

Driver code does this for you.

> +       return rc;

...

> +       dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> +                pdev->vendor, pdev->device, pdev->revision);

How is it useful? PCI core prints a lot of information which you may
find in dmesg.

...

> +       privdata =3D devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERN=
EL);
> +       if (!privdata)

> +               rc =3D -ENOMEM;

How this has been tested?

> +       privdata->pdev =3D pdev;

> +       rc =3D amd_mp2_pci_init(privdata, pdev);
> +       if (rc)
> +               return rc;
> +       return 0;

return amd_mp2_pci_init(...);

...

> +static void amd_mp2_pci_remove(struct pci_dev *pdev)
> +{
> +       struct amd_mp2_dev *privdata =3D pci_get_drvdata(pdev);
> +
> +       amd_stop_all_sensors(privdata->pdev);

> +       pci_clear_master(pdev);
> +       pci_set_drvdata(pdev, NULL);

Same comments as per error path in the ->probe()

> +}

...

> +static const struct pci_device_id amd_mp2_pci_tbl[] =3D {
> +       {PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},

Spaces, please,
 { PCI...() },

> +       {0}

0 is not needed here.

> +};

...

> +#ifndef PCIE_MP2_AMD_H
> +#define PCIE_MP2_AMD_H

+ empty line

> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>

> +#define PCI_DEVICE_ID_AMD_MP2  0x15E4

Why not in the C file?

> +/* MP2 C2P Message Registers */
> +#define AMD_C2P_MSG0   0x10500
> +#define AMD_C2P_MSG1   0x10504
> +#define AMD_C2P_MSG2   0x10508
> +#define AMD_C2P_MSG3   0x1050c
> +#define AMD_C2P_MSG4   0x10510
> +#define AMD_C2P_MSG5   0x10514
> +#define AMD_C2P_MSG6   0x10518
> +#define AMD_C2P_MSG7   0x1051c
> +#define AMD_C2P_MSG8   0x10520
> +#define AMD_C2P_MSG9   0x10524
> +
> +/* MP2 P2C Message Registers */
> +#define AMD_P2C_MSG0   0x10680 /*Do not use*/
> +#define AMD_P2C_MSG1   0x10684
> +#define AMD_P2C_MSG2   0x10688
> +#define AMD_P2C_MSG3   0x1068C /*MP2 debug info*/
> +#define AMD_P2C_MSG_INTEN      0x10690 /*MP2 int gen register*/
> +#define AMD_P2C_MSG_INTSTS     0x10694 /*Interrupt sts*/

Do you need all these in the header?

...

> +#define write64 lo_hi_writeq
> +#define read64 lo_hi_readq

Why?! You have writeq() definition or use lo_hi_*() directly.

...

> +int amd_mp2_get_sensor_num(struct pci_dev *dev, u8 *sensor_id);

+ blank line

> +#endif

--=20
With Best Regards,
Andy Shevchenko
