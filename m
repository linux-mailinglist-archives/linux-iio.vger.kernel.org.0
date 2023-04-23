Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE66EBE9F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Apr 2023 12:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDWKdV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Apr 2023 06:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDWKdU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Apr 2023 06:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE23C2
        for <linux-iio@vger.kernel.org>; Sun, 23 Apr 2023 03:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BCD860BA1
        for <linux-iio@vger.kernel.org>; Sun, 23 Apr 2023 10:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E68CC433D2;
        Sun, 23 Apr 2023 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682245998;
        bh=9oBl7svJVXpBjSlyzbv97XL1uFz3ZdoSW8DNCfBlfaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EutLsiIIhVkPx6Mm8sDRX2XL8kYaqAssbHUGNGxtb25iRy3wv3QbX7otaMtSd78tI
         lph83bBWURJumEuNdfqzSp9y3ZIxMmMTu3Ku19qYHnCsgNfzfxUnDAkPJNGUgUJ6pW
         oSbkNiHiK2w7yJ14trS17fCS3Ze1b7I4cACln4BJWfER15lAkz0JS+Th5kyIT9Weyt
         8eIDmQPjbDKylpSbufgUFlNJW62j8ga9iSYb9YsoWOZRmpG0VBpVmWw0RP2giyFz/O
         zmQf5ETBdu1M2Ko/1NGFET/ui4Borff/H4x25i8Zj+oOU4v6pq+eiyEb5a3iPBVeg4
         uiQM7KhUwgatw==
Date:   Sun, 23 Apr 2023 11:48:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] iio: accel: st_accel: Fix invalid mount_matrix on
 devices without ACPI _ONT method
Message-ID: <20230423114855.1596fe0c@jic23-huawei>
In-Reply-To: <822cff64-f7f8-b998-1b8e-5ada542b86b7@mariushoch.de>
References: <20230416212409.310936-1-hdegoede@redhat.com>
        <822cff64-f7f8-b998-1b8e-5ada542b86b7@mariushoch.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Apr 2023 14:32:42 +0200
Marius Hoch <mail@mariushoch.de> wrote:

> On 16/04/2023 23:24, Hans de Goede wrote:
> > When apply_acpi_orientation() fails, st_accel_common_probe() will fall back
> > to iio_read_mount_matrix(), which checks for a mount-matrix device property
> > and if that is not set falls back to the identity matrix.
> >
> > But when a sensor has no ACPI companion fwnode, or when the ACPI fwnode
> > does not have a "_ONT" method apply_acpi_orientation() was returning 0,
> > causing iio_read_mount_matrix() to never get called resulting in an
> > invalid mount_matrix:
> >
> > [root@fedora ~]# cat /sys/bus/iio/devices/iio\:device0/mount_matrix
> > (null), (null), (null); (null), (null), (null); (null), (null), (null)
> >
> > Fix this by making apply_acpi_orientation() always return an error when
> > it did not set the mount_matrix.
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> Tested, with the LSM303D patches applied, on a Lenovo Yoga Tablet 2 1051-F.
> 
> Tested-by: Marius Hoch <mail@mariushoch.de>

Needs a fixes tag:. I think...

Fixes: 3d8ad94bb175 ("iio: accel: st_sensors: Support generic mounting matrix")

actually introduced the issue rather than the patch that added the _ONT support

Linus, that's one of yours.  Could you also take a glance at this.

Seems 'obviously' correct but I've been wrong before :)
> 
> 
> > ---
> >   drivers/iio/accel/st_accel_core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> > index 1628b177d0ed..f7b823ebc96b 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -1291,12 +1291,12 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
> >   
> >   	adev = ACPI_COMPANION(indio_dev->dev.parent);
> >   	if (!adev)
> > -		return 0;
> > +		return -ENXIO;
> >   
> >   	/* Read _ONT data, which should be a package of 6 integers. */
> >   	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
> >   	if (status == AE_NOT_FOUND) {
> > -		return 0;
> > +		return -ENXIO;
> >   	} else if (ACPI_FAILURE(status)) {
> >   		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
> >   			 status);  
> 

