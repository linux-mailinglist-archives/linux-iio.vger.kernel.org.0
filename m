Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96E6493FF
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLKLr0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 06:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKLrZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 06:47:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E4664C0
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 03:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AE9E60D58
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 11:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45AAC433EF;
        Sun, 11 Dec 2022 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670759243;
        bh=b8ABrQTmfV2Pn6Ik3esJzBqXVLKk2W0ueaoy0HRTI2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LJlLnYBP3N0FwtZTj9GTg3mjxrGnle+9qr3Mp57daA2LkHcgXpgzMWdbxB1fFC6ih
         wF8pjcgacNct097oM+VnRWW0cDY+ESnhSCXGNwtw4gQllcH72HsNw90kDmtE/HZImg
         7idORbZX18ds/O+OsOGkmZAuwMaym2jM9B2MWkw55Q8GiWiJdq3/0So+HKJ6SjG7Kc
         oM/haCNOc3Jvgm7rBndBY5DEXwb6w5baR7TpEpZVKnhtIO9KaZOhJaDKBVd41uw191
         ACM4skk4uvKCieYXn2B4A3YedEgGRLVDzjMnBpV0Sba1oivavdLqqude0n7QhJYs5q
         7Ep+Pjc16BrVQ==
Date:   Sun, 11 Dec 2022 12:00:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [POC] iio: ad74413: allow channel configuration to be given via
 module parameters
Message-ID: <20221211120018.24536b11@jic23-huawei>
In-Reply-To: <57e440708c1946c9a309346cc7636fe0@analog.com>
References: <0833ed443220263ce068f5faec33fdef4435226a.camel@gmail.com>
        <20221208133354.2980343-1-rasmus.villemoes@prevas.dk>
        <57e440708c1946c9a309346cc7636fe0@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 9 Dec 2022 08:46:40 +0000
"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:

> > -----Original Message-----
> > From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Sent: Thursday, December 8, 2022 3:34 PM
> > To: Nuno S=C3=A1 <noname.nuno@gmail.com>; linux-iio@vger.kernel.org
> > Cc: Jonathan Cameron <jic23@kernel.org>; Tanislav, Cosmin
> > <Cosmin.Tanislav@analog.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Lars-Peter Clausen <lars@metafoo.de>;
> > Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Subject: [POC] iio: ad74413: allow channel configuration to be given via
> > module parameters
> >=20
> > [External]
> >=20
> > Just to see how it would look, I tried doing the below. Since a board
> > may have more than one ad74412/ad74413, one needs to be able to
> > differentiate between them. So for now each module parameter channelX
> > (X=3D0,1,2,3) accepts a space-separated list of <label>:<function>,
> > where label is matched against the label property in device tree, but
> > also allowing * to match any, which is more convenient when one knows
> > there is only one device.
> >=20
> > Aside from the missing documentation (MODULE_PARM_DESC), there are of
> > course various details to hash out. E.g., should the function be
> > specified with a raw integer as here, or should we take a text string
> > "voltage-output", "current-input-ext-power" etc. and translate those?
> > Should we use space or comma or semicolon as separator? And so on.
> >=20
> > I also considered whether instead of the label one should instead
> > match on the OF_FULLNAME,
> > e.g. /soc@0/bus@30800000/spi@30840000/ad74412r@0, but that's a lot
> > more complicated, and I assume that anybody that has more than one of
> > these chips would anyway assign a label so that they can distinguish
> > their /sys/bus/iio/... directories.
> >=20
> > I should also note that it is not unprecedented for modules to take
> > parameters that do some sort of (ad hoc) parsing to apply settings
> > per-device. For example:
> >=20
> > - ignore_wake in drivers/gpio/gpiolib-acpi.c
> > - mtdparts in drivers/mtd/parsers/cmdlinepart.c
> > - pci_devs_to_hide in drivers/xen/xen-pciback/pci_stub.c
> > - quirks in drivers/hid/usbhid/hid-core.c
> >=20
> > So the question is, is there any chance that anything like this could
> > be accepted? If so, I'll of course spin this into a real patch with
> > proper MODULE_PARM_DESC and commit log etc.
> >=20
> > This has been tested doing
> >=20
> >   insmod ad74413r.ko 'channel0=3D*:1' 'channel1=3D*:3' 'channel2=3D*:2'
> > 'channel3=3D*:4'
> >=20
> > and seeing that the channels did indeed come up as expected, where the
> > device tree specified CH_FUNC_HIGH_IMPEDANCE for all of them.
> >  =20
>=20
> Nuno previously mentioned dynamically loading device tree overlays,
> which seems like a much cleaner solution to me. Have you looked into
> that?
>=20

We are unlikely to take anything else I'm afraid. So hopefully
device tree overlays will work for you.

Dynamic configuration of pretty much anything about input OR output would
be potentially fine (we'd probably want to add limits on output settings
which I think we've done for some devices).  A userspace interface to
switch between those is much more of a corner case and could lead to
hardware damage depending on exactly what is connected to the pins.

Jonathan
