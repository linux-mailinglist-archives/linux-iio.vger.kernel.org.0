Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0753F2BC19F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgKUSws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgKUSws (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 13:52:48 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60FD2100A;
        Sat, 21 Nov 2020 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605984767;
        bh=IizbgpwErbJ0WdRS9sDvtFCgeiFKeREputej/1MN4aw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nBC2o99dHRLSfg8C/TWmJsLlXp0xZ3gH+YHzpGKt8myYbtsSiJCSZUuA4GJXVRcDr
         /dRbfTrgZQ1ripWDQMG4c8nebIjm3FoiBXtApG74rJfqBJ5H2wmA54h2cv97lSllum
         lFPyFqYCGXTVkuHBxNiFap3hOD7aHxpwvm4HD44o=
Date:   Sat, 21 Nov 2020 18:52:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 00/12] iio: core,buffer: add support for multiple
 IIO buffers per IIO device
Message-ID: <20201121185243.255d33b2@archlinux>
In-Reply-To: <20201117162340.43924-1-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 18:23:28 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Continuing from:
>   https://lore.kernel.org/linux-iio/20200517144023.6c5cb169@archlinux/
>=20
> This is a V2 of the initial attempt in the discussion above.
> But it did not occur to me that I should mark it as V2 when I generated
> the patches.
> I've only tested [so far] that the current IIO buffer mechnism still work=
s.
> And decided to show this sketch patchset.
>=20
> This requires the ioctl() centralization mechanism, for which I sent a
> fix earlier.
>   https://lore.kernel.org/linux-iio/CA+U=3DDsqf3UgyM666Gg9EmehpWiucDx2P0b=
msC9JR--JJDT_eWQ@mail.gmail.com/T/#t
>   https://lore.kernel.org/linux-iio/20201117095154.7189-1-alexandru.ardel=
ean@analog.com/T/#u
>=20
> The gist of this is that now, the first IIO buffer should work as
> before, but all extra buffers should go through the anon inodes
> mechanism.
> I'd need to find a device or a way or a chip to test these extra buffers
> stuff. But I'm confident that this current form should eventually work
> with multiple IIO buffers per 1 IIO device and with anon inodes.
>=20
> Maybe I'll take some of the patches in this set separately and send them
> individually. The problem with patchsets like this that tackle changes
> in a framework (like IIO) is that I become unsure after the 5th-7th patch,
> that the approach is correct. And I get even more unsure after that.
>=20
> I'll create some userspace code to test this a bit, but I thought I'd
> send an RFC in the meantime.

=46rom a first read, with all the warnings you give above, this looks pretty
good to me.   The kobj stuff is a little nasty and needs more docs
but other than that it all looks quite pleasant and readable and was
roughly what I was expecting from earlier discussions (which is great!).

Good work on this, looking forward to next steps.

Jonathan

>=20
> Alexandru Ardelean (12):
>   iio: core: register chardev only if needed
>   iio: buffer: add back-ref from iio_buffer to iio_dev
>   iio: buffer: rework buffer & scan_elements dir creation
>   iio: buffer: add index to the first IIO buffer dir and symlink it back
>   iio: core: split __iio_device_attr_init() to init only the attr object
>   iio: buffer: re-route scan_elements via it's kobj_type
>   iio: buffer: re-route core buffer attributes via it's new kobj_type
>   iio: buffer: add helper to get the IIO device to which a buffer
>     belongs
>   iio: re-route all buffer attributes through new buffer kobj_type
>   iio: core: wrap iio device & buffer into struct for character devices
>   iio: buffer: introduce support for attaching more IIO buffers
>   iio: buffer: add ioctl() to support opening extra buffers for IIO
>     device
>=20
>  drivers/iio/accel/adxl372.c                   |  36 +-
>  drivers/iio/accel/bmc150-accel-core.c         |  34 +-
>  drivers/iio/adc/at91-sama5d2_adc.c            |  30 +-
>  .../buffer/industrialio-buffer-dmaengine.c    |  13 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  30 +-
>  .../common/hid-sensors/hid-sensor-trigger.c   |  32 +-
>  drivers/iio/iio_core.h                        |  11 +
>  drivers/iio/industrialio-buffer.c             | 582 ++++++++++++++----
>  drivers/iio/industrialio-core.c               | 117 ++--
>  include/linux/iio/buffer.h                    |   2 +
>  include/linux/iio/buffer_impl.h               |  25 +-
>  include/linux/iio/iio-opaque.h                |   6 +
>  include/linux/iio/iio.h                       |   2 +-
>  include/linux/iio/sysfs.h                     |  50 ++
>  include/uapi/linux/iio/buffer.h               |  16 +
>  15 files changed, 735 insertions(+), 251 deletions(-)
>  create mode 100644 include/uapi/linux/iio/buffer.h
>=20

