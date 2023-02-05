Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A315A68B02E
	for <lists+linux-iio@lfdr.de>; Sun,  5 Feb 2023 15:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBEOJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Feb 2023 09:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBEOJN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 09:09:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747441F919
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 06:09:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CCCF60BB9
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 14:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFF1C433EF;
        Sun,  5 Feb 2023 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675606151;
        bh=EIPPW8v5SlK8XMsl94QkmZj/APinNurssQVOWrrDXzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQf453f06cvXajvcee+L6p9q2s/jOeRMgAL5wcteDjTx2+jd9lTQ31b5FgtJgtbcv
         B5Bjg0aZd7ZbERcLoEPcYPaf4srEYDpCTfyhE9eKUCd2nYg2lZKj3UmyIb9EZ+/agA
         ZjBFh79QNBZV5pjDUw1iRNAmWeMqy+9wlfsvNdjPiH9rfatrdDKZWiVvwU9YySHaBt
         QxrcmAm6jWqpNg6MYp3f9qIQZd6kL/u4hjXfFxUIxMHhZfoKkC8g/rahhVefZzd7Gr
         zOjOGy1i80c/guSHidYkNAQIbmbX6lcB3DdbpooD/ExhcAxgGHZfVc+lA6A8hZ4hrO
         1HswOWYJTNonw==
Date:   Sun, 5 Feb 2023 14:23:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     linux-iio@vger.kernel.org, lorenzo@kernel.org, carnil@debian.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/2] iio: imu: lsm6dsx: Add ACPI mount matrix retrieval
Message-ID: <20230205142312.4c75e7c6@jic23-huawei>
In-Reply-To: <CAMxBKG2+XOvXs-89hakTcxH_FPnTjSBkbbuuCjGwVSObLPBFkw@mail.gmail.com>
References: <20230130201018.981024-1-jic23@kernel.org>
        <20230130201018.981024-3-jic23@kernel.org>
        <CAMxBKG2+XOvXs-89hakTcxH_FPnTjSBkbbuuCjGwVSObLPBFkw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Jan 2023 20:11:07 +0000
Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:

> Here's the device info:
> 
> ** Model information
> sys_vendor: LENOVO
> product_name: 82AT
> product_version: IdeaPad Duet 3 10IGL5
> chassis_vendor: LENOVO
> chassis_version: IdeaPad Duet 3 10IGL5
> bios_vendor: LENOVO
> bios_version: EQCN35WW
> board_vendor: LENOVO
> board_name: LNVNB161216
> board_version: SDK0R32802 WIN
> 
> I'll try to adapt the full patches to my Debian 6.1 source for
> testing, and report back to you.
> 
> Darrell

Hi Darrel, 

Once the other thread has reached a conclusion, if you could give
a Tested-by tag or reply here with what is wrong, that would be great.

Due to bad timing this may well have to wait for next cycle now, but it
would be good to at least get it queued up for mainline.

Jonathan

> 
> On Mon, 30 Jan 2023 at 19:56, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > DSDT ROTM method seen in the wild with SMO8B30 _HID.
> > Making assumption it is similar to that used for bmc150 plus
> > information from Darrell that the rotation is out by 90 degrees at boot.
> >
> > Method (ROTM, 0, NotSerialized)
> > {
> >     Name (RBUF, Package (0x03)
> >     {
> >         "0 -1 0",
> >         "1 0 0",
> >         "0 0 1"
> >     })
> >     Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.ROTM.RBUF */
> > }
> >
> > Reported-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > ---
> > Untested.  Fingers crossed.
> >
> > We could factor this out if it keeps turning up.  The bmc150 varient
> > is more complex as multiple method IDs exist depending on the configuration.
> >
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 65 +++++++++++++++++++-
> >  1 file changed, 62 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 3f6060c64f32..3c2d67f8d9b7 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -56,6 +56,7 @@
> >
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/acpi.h>
> >  #include <linux/delay.h>
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> > @@ -2602,6 +2603,61 @@ static int st_lsm6dsx_init_regulators(struct device *dev)
> >         return 0;
> >  }
> >
> > +static bool lsm6dsx_get_acpi_mount_matrix(struct device *dev,
> > +                                         struct iio_mount_matrix *orientation)
> > +{
> > +       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > +       struct acpi_device *adev = ACPI_COMPANION(dev);
> > +       union acpi_object *obj, *elements;
> > +       acpi_status status;
> > +       int i, j, val[3];
> > +       char *str;
> > +
> > +       if (!has_acpi_companion(dev))
> > +               return -EINVAL;
> > +
> > +       if (!acpi_has_method(adev->handle, "ROTM"))
> > +               return -EINVAL;
> > +
> > +       status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
> > +       if (ACPI_FAILURE(status)) {
> > +               dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
> > +               return -EINVAL;
> > +       }
> > +
> > +       obj = buffer.pointer;
> > +       if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
> > +               goto unknown_format;
> > +
> > +       elements = obj->package.elements;
> > +       for (i = 0; i < 3; i++) {
> > +               if (elements[i].type != ACPI_TYPE_STRING)
> > +                       goto unknown_format;
> > +
> > +               str = elements[i].string.pointer;
> > +               if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
> > +                       goto unknown_format;
> > +
> > +               for (j = 0; j < 3; j++) {
> > +                       switch (val[j]) {
> > +                       case -1: str = "-1"; break;
> > +                       case 0:  str = "0";  break;
> > +                       case 1:  str = "1";  break;
> > +                       default: goto unknown_format;
> > +                       }
> > +                       orientation->rotation[i * 3 + j] = str;
> > +               }
> > +       }
> > +
> > +       kfree(buffer.pointer);
> > +       return 0;
> > +
> > +unknown_format:
> > +       dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
> > +       kfree(buffer.pointer);
> > +       return -EINVAL;
> > +}
> > +
> >  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> >                      struct regmap *regmap)
> >  {
> > @@ -2676,9 +2732,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> >                         return err;
> >         }
> >
> > -       err = iio_read_mount_matrix(hw->dev, &hw->orientation);
> > -       if (err)
> > -               return err;
> > +       err = lsm6dsx_get_acpi_mount_matrix(hw->dev, &hw->orientation);
> > +       if (err) {
> > +               err = iio_read_mount_matrix(hw->dev, &hw->orientation);
> > +               if (err)
> > +                       return err;
> > +       }
> >
> >         for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> >                 if (!hw->iio_devs[i])
> > --
> > 2.39.1
> >  

