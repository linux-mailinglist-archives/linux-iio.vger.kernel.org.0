Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E700661EA36
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 05:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKGE2h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 23:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiKGE2f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 23:28:35 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C42619
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 20:28:33 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o13so5302488ilq.6
        for <linux-iio@vger.kernel.org>; Sun, 06 Nov 2022 20:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4LZuSbq+62Z+d95/+W+ywsx3mp6Nx+cV3+kI5U+PdOc=;
        b=QR/4E5+/a736Lm9rh6vgsr7Ig6qkIr1/U30pvwQRQFnlQYVWpdvWiA1NcBDbGBEEhj
         XKggLx5CPGHVAxIvhrliWT6SVch23Z6X6T8SigN41Hy+MKbrTORd53nmoeABDOxzaDGv
         Mm/GPXleg53H/1yHxDJja12IFMbkoVxrtlavo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LZuSbq+62Z+d95/+W+ywsx3mp6Nx+cV3+kI5U+PdOc=;
        b=4PpEVxRSgm8X588kpDQKVb4yKNAvjuTCvFktTM7lujoS97/PSmBLErhY9Q6+UFqDDN
         pqg+M2k8+ylVI788v06VjJRTuchtkmza+LYozpx+MXDPt6Naw2Rb86urktSpTuE9mqFP
         8SXcEl3npRR6knDhaTcl1dKMZ73gpKbZSYKWAtSBsW2Lqjqttnuj/T9TOQU/4sD/33dQ
         l7n9mniIgSrgjND1B+h1lhkPs/zR1O1uoqXYblWBsUmG4rvEel8r0ExqxaYxmjY9icxS
         2Zx4ll+lpvU7/lsHB6sg2966TO/jrZH6KA2snYi6QU2NAwHCKo3yZkQdRCzIc/tc7q/+
         BV/g==
X-Gm-Message-State: ANoB5plqGfvMaGMQOgxpMTK7gMm+k/u1K3bom7476m4EEvLZdLm5Ic0d
        aim0kNlhODXhAhd72oZsgRpMGjlJvYJ3WQkaxM9N2Q==
X-Google-Smtp-Source: AA0mqf6/XubYBO4mbFuJHxIZEJ4c6oW15jkILyB31mO7j2QXr2WComXpFgKVplbpWg8+mZb1y/5oUdGlIcObjICdjIA=
X-Received: by 2002:a05:6e02:b2a:b0:302:def:5658 with SMTP id
 e10-20020a056e020b2a00b003020def5658mr3248882ilu.299.1667795313086; Sun, 06
 Nov 2022 20:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20221105225157.10081-1-gwendal@chromium.org> <20221106163200.7f889ade@jic23-huawei>
In-Reply-To: <20221106163200.7f889ade@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sun, 6 Nov 2022 20:28:22 -0800
Message-ID: <CAPUE2ut0z6QrMh778hPFpLYrw_nft_ky-ye3ZrwNXTBVgxPZYQ@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: sx9360: Add a new ACPI hardware ID
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jordi Torres <majosamaso@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 6, 2022 at 8:32 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat,  5 Nov 2022 15:51:57 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > From
> > https://treexy.com/products/driver-fusion/database/sensors/semtech/sx9360-proximity/
> >
> > sx9360 SAR sensor can be presented with ACPI ID SAMM0208.
> >
> > Reported-by: Jordi Torres <majosamaso@gmail.com>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/proximity/sx9360.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> > index d9a12e6be6ca6..4ebc5784aa6d9 100644
> > --- a/drivers/iio/proximity/sx9360.c
> > +++ b/drivers/iio/proximity/sx9360.c
> > @@ -865,6 +865,7 @@ static SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
> >
> >  static const struct acpi_device_id sx9360_acpi_match[] = {
> >       { "STH9360", SX9360_WHOAMI_VALUE },
> > +     { "SAMM0208", SX9360_WHOAMI_VALUE },
>
> SAMM doesn't immediately seem to be a valid ACPI vendor ID.
> Anyone have a path to poke people to do this right or confirm whose ID that one is?
>
> Reality is we'll have to live with it, but I like to complain first in vague hope that
> people will one day play by the rules!
Sorry for not having checked UEFI DB first. You are not the only one
to complain: https://andy-shev.dreamwidth.org/151340.html
>  Given semtech has a PNP ID (STH is valid)
> I'm not sure why someone would use an ACPI ID that doesn't seem to be (unless it
> is very recent and no one has updated the DB on uefi.org yet).
uefi.org says the last update is 2/14/2020, but that's not correct,
some entries have been added in 2021:
https://uefi.org/ACPI_ID_List?search=SECC

From http://www.alsa-project.org/db/?f=6196fa05fcd368166cdeee8b0509be7ca64166ee,
the sensor is present on device NT950QED from Samsung

From https://www.samsung.com/sec/galaxybook/galaxy-book2-pro-360-nt950qed-kc71g/NT950QED-KC71G/,
that device is a Samsung Galaxy Book 2 360.

Surprisingly, Samsung does not have an ACPI ID defined, but does have
a PNP ID (SAM). It may have been an uncontrolled spelling mistake.

From https://treexy.com/products/driver-fusion/database/sensors/semtech/,
Semtech sensors do appear under names different from STH.

Gwendal.

>
> Jonathan
>
>
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(acpi, sx9360_acpi_match);
>
