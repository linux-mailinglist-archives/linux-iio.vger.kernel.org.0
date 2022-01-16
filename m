Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80FC48FE2C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 18:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiAPR2a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiAPR23 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:28:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820AC061574;
        Sun, 16 Jan 2022 09:28:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A0D860F95;
        Sun, 16 Jan 2022 17:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE98CC36AE9;
        Sun, 16 Jan 2022 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642354107;
        bh=mP/g/7ilC25AmVavPQA58iZQQiKw+DamgQZsALJsWMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cMIN9T/pQ0d7TWYMi5n8Rg36AYTC7U/8aRDQVHMS8iha/2V9nf1rVx0kOuDdH9SUp
         591u6ZiHgCTOug8eVbh07GkEoJDW6q/d8Q088ejUsNTvDgNZIBkPSQ3ykt2fIrrtQm
         wnqHSKd4o4jkF2NK9ohiebRdDdJj19jPC4/rmQTKFd3TljKMRrqjsCp7/wriPFkneu
         m48cF7txJnfMbO33i+lkhnNmcS6hWjcukg7BHlZg2Qf9xV+ITtfj6sUXj+NOvzfhPd
         UKmA18GNyQS2NBzZbWwRS+PFBZ1gRahVUcV9ETwt0Rre6eJnQjfqyf9qRmtAE51QH/
         9dqvU2xCwKWVQ==
Date:   Sun, 16 Jan 2022 17:34:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] Add support for LTC2688
Message-ID: <20220116173429.698919f7@jic23-huawei>
In-Reply-To: <20220115092705.491-1-nuno.sa@analog.com>
References: <20220115092705.491-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



>   * Have a clock property per channel. Note that we this I moved to OF
> since we now have to use 'devm_get_clk_from_child()' which is using
> device_node. Note that I could use 'to_of_node()' but mixing of.h and
> property.h does not feel like a good idea.

Ah, that's unfortunate given the clk is only needed in certain modes...

Andy/Rafael/Rob, any thoughts on how we should handle this?  Obviously
ACPI and clocks is generally a no go, but in this particular case we
aren't looking at a power management related use of clocks, but rather
using the clk framework to provide a way to control one of our inputs
used to generate the output dithered signal...  If the device just its
own clock then we'd just control it directly with no problems, but it uses
and external source.

We don't know of anyone actually looking at this device in conjunction with
ACPI so maybe just using dt specific calls for now rather than generic
firmware properties is the best we can do.

Thanks,

Jonathan

>=20
>  ABI:
>   * Added out_voltageY_raw0 ABI for toggle mode;
>   * Added out_voltageY_dither_offset.
>=20
>  Bindings:
>   * Use standard microvolt unit;
>   * Added constrains for adi,output-range-microvolt and removed negative
> values from the dts example;
>   * Moved clocks to the channel object;
>   * Dropped clock-names;
>   * Add a dependency between 'adi,toggle-dither-input' and 'clocks'.
> =20
> [1]: https://marc.info/?l=3Dlinux-iio&m=3D163662843603265&w=3D2
>=20
> Nuno S=C3=A1 (3):
>   iio: dac: add support for ltc2688
>   iio: ABI: add ABI file for the LTC2688 DAC
>   dt-bindings: iio: Add ltc2688 documentation
>=20
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |   80 ++
>  .../bindings/iio/dac/adi,ltc2688.yaml         |  147 +++
>  MAINTAINERS                                   |    9 +
>  drivers/iio/dac/Kconfig                       |   11 +
>  drivers/iio/dac/Makefile                      |    1 +
>  drivers/iio/dac/ltc2688.c                     | 1070 +++++++++++++++++
>  6 files changed, 1318 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688=
.yaml
>  create mode 100644 drivers/iio/dac/ltc2688.c
>=20

