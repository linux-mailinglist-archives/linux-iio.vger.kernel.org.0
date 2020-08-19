Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A933249A94
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHSKkt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 06:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgHSKks (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 06:40:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A800EC061757;
        Wed, 19 Aug 2020 03:40:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so11449353pfx.13;
        Wed, 19 Aug 2020 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3/taaSSwO43T3oc5wD34j8cRbsw4iP1ZjgRFOGtK5pY=;
        b=qBYVASY5hfdMO/SvJVzfxLQw1/Q6gXb23BAjAmEMUtyiwEnzzIdAmQg7ciEpAwbhif
         Pb6IBmQbBH109u1U1FPnmF37a3O5/gIAjr/m7Unb2NWH+HtLDjlM/M0TTPxGDOgzRokD
         uz5VgzedAV2Nws9yOhJNUhPoU7W+Cp1uxjIHhUYenufBQ1D7iv2FCPssKcO3VchdfhyU
         C/xInnCMLKRXSDVifWvLb8XaKVC6nTXTX6YilTZY4KdCJGlurdZESdHoH1aR1DNn60LA
         CaNb0a9iJJ9opCES3dvNrbXKuQI4A54zsusdBX3iWYcrygReI093bAOD//NXnHYHNA+x
         BUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3/taaSSwO43T3oc5wD34j8cRbsw4iP1ZjgRFOGtK5pY=;
        b=oTXEj9hRCM+Jok6fqa2unJMRehkSQJtEiH4u5RE29AVzAXNdSwFoLv0VCGWEy0Z/K4
         pe+htHworPAaEQeqyECNcWu15UBORt+6AnLnNoYRrAJjHV0QkGNhWRx49gQ2W5Wx9qm4
         bY/RQbVg1IdFypNqCZBapaDtsSLqAsBzQc/ZkWjdrg+y1gnnEPgTpHf89Pis0aJV+PjZ
         t9MLhQTjxAVEBVHYo5dzGp7JOxkJ6FBprqm3/0o2gIODrP7FwRT6QRVkZdBbzZfNElOK
         VHxsWl7MsooZ3PoXELcLTJdD8fm690pXru5k1AwLmeIwr32nxxXvlKZ6+I9e9+y8uWTO
         hCgw==
X-Gm-Message-State: AOAM533pzHQXrdLAETM6zb4VybUeczgGBH47XzX3YwFQCrwEsEK92uMm
        qx1DQvsZTPi0N7zLIuuXSF0+SDHl992ImZqKZmI=
X-Google-Smtp-Source: ABdhPJyANAvip0iOJNMTBHtRuxrCZ86Aso3zZki/CssCkxnZIjEtqv2jPKc1r7ECvitN+Fm7bv0h2kXjteCtz/pXE1w=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr16243315pgk.4.1597833643342;
 Wed, 19 Aug 2020 03:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200809102511.2657644-1-Sandeep.Singh@amd.com> <20200809102511.2657644-3-Sandeep.Singh@amd.com>
In-Reply-To: <20200809102511.2657644-3-Sandeep.Singh@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 13:40:27 +0300
Message-ID: <CAHp75VcOVHspaUYTGHHx++1qsWZ0NL=7qhh3avd+cK2sqoj8Ew@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] SFH: PCIe driver to add support of AMD sensor fusion
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
        Marco Felsch <m.felsch@pengutronix.de>,
        Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 9, 2020 at 1:25 PM Sandeep Singh <Sandeep.Singh@amd.com> wrote:

> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2 processor
> (MP2 which is an ARM=C2=AE Cortex-M4 core based co-processor to x86) and
> it runs on MP2 where in driver resides on X86. This part of module

where the driver

> will communicate with MP2 FW and provide that data into DRAM

...

> +#
> +#

One is enough.

...

> +#define ACEL_EN                BIT(accel_idx)
> +#define GYRO_EN                BIT(gyro_idx)
> +#define MAGNO_EN       BIT(mag_idx)
> +#define ALS_EN         BIT(als_idx)

What is this?

...

> +int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id)
> +{
> +       int activestatus, num_of_sensors =3D 0;
> +

> +       if (!sensor_id)
> +               return -EINVAL;

Is it possible?

> +       privdata->activecontrolstatus =3D readl(privdata->mmio + AMD_P2C_=
MSG3);
> +       activestatus =3D privdata->activecontrolstatus >> 4;
> +       if (ACEL_EN  & activestatus)
> +               sensor_id[num_of_sensors++] =3D accel_idx;
> +
> +       if (GYRO_EN & activestatus)
> +               sensor_id[num_of_sensors++] =3D gyro_idx;
> +
> +       if (MAGNO_EN & activestatus)
> +               sensor_id[num_of_sensors++] =3D mag_idx;
> +
> +       if (ALS_EN & activestatus)
> +               sensor_id[num_of_sensors++] =3D als_idx;
> +
> +       return num_of_sensors;
> +}

...

> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct pci_dev=
 *pdev)
> +{
> +       int rc;
> +

> +       pci_set_drvdata(pdev, privdata);

This is better to have after initial resources were retrieved.

> +       pcim_enable_device(pdev);

> +       pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);

Where is the error check?

> +       privdata->mmio =3D pcim_iomap_table(pdev)[2];
> +       pci_set_master(pdev);
> +
> +       rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +       if (rc)
> +               rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +       return rc;
> +}

What is the point to have this function separated from ->probe()?

...

> +       rc =3D amd_sfh_hid_client_init(privdata);
> +       if (rc)
> +               return rc;
> +       return 0;

return amd_...(...);

...

> +static const struct pci_device_id amd_mp2_pci_tbl[] =3D {
> +       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2) },

> +       {},

No comma.

> +};

...

> +#include <linux/pci.h>

I don't see any users of it in the file.
Use forward declaration instead.

> +#include <linux/types.h>

...

> +enum command_id {
> +       enable_sensor =3D 1,
> +       disable_sensor =3D 2,
> +       stop_all_sensors =3D 8,

> +       invalid_cmd =3D 0xf

GENMASK()?
(Will require bits.h)

> +};
> +
> +enum sensor_idx {
> +       accel_idx =3D 0,
> +       gyro_idx =3D 1,
> +       mag_idx =3D 2,
> +       als_idx =3D 19

+ comma.

> +};
> +
> +struct amd_mp2_dev {
> +       struct pci_dev *pdev;
> +       struct amdtp_cl_data *cl_data;

> +       void __iomem *mmio;

Is __iomem provided by linux/types.h? Otherwise include corresponding heade=
r.

> +       u32 activecontrolstatus;
> +};

--=20
With Best Regards,
Andy Shevchenko
