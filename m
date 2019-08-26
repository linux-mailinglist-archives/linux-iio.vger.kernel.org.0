Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E189CB77
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2019 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfHZIWb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 04:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbfHZIWa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Aug 2019 04:22:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C61A52173E;
        Mon, 26 Aug 2019 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566807749;
        bh=WG63OnvQzmYwCnVe1xN6beeXvigDwBI1wx+bbNc1af8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gvPqJ4bJ5SrC7JHyzr9V74IT7Kq4Ks/KB8DGPVYFks24IbMH9A4cZpmSGwk5DoExx
         visWZuw5B6nprX4d00Z0fHhLpyT33x7p3Y1aBe7c9RLucK94YZfHyyRCYghnh+w4kD
         i1MnAv55LmNN/b/bWVhnR1gFWyc58ruTLODoeAkQ=
Date:   Mon, 26 Aug 2019 09:22:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Pascal Bouwmann <bouwmann@tau-tec.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: Linux Kernel: Bug in the bmc150 driver
Message-ID: <20190826092225.73a459a2@archlinux>
In-Reply-To: <87be60bb-895c-b6a0-9e04-ffeda1f7fb28@tau-tec.de>
References: <87be60bb-895c-b6a0-9e04-ffeda1f7fb28@tau-tec.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Aug 2019 06:58:26 +0200
Pascal Bouwmann <bouwmann@tau-tec.de> wrote:

> Dear Mr. Cameron,
>=20
> in the bmc150 driver I probably found a mistake:
> In the datasheets of the supported devices it is written that the=20
> central temperature is 23=C2=B0C (see links below).

Hi. This is curious. =20
>=20
> BMC150:=20
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMC150=
-DS000.pdf,=20
> page 27

Look at page 72 where the register is defined and there the 0 value is spec=
ified as 24.

I haven't checked the others but at a quick glance at this one case it woul=
d seem the
data sheets are internally inconsistent.

I'm inclined to go with the version provided with the register definition r=
ather than
the descriptive text, but obviously the best option would be to get a clari=
fication
on this from Bosch.

Thanks,

Jonathan

> BMI055:=20
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMI055=
-DS000.pdf,=20
> page 23
> BMA255:=20
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA255=
-DS004.pdf,=20
> page 19
> BMA250E:=20
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA250=
E-DS004.pdf,=20
> page 19
> BMA222E:=20
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA222=
E-DS004.pdf,=20
> page 19
> BMA280:=20
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA280=
-DS000.pdf,=20
> page 19
>=20
> In the driver drivers/iio/accel/bmc150-accel-core.c the constant=20
> BMC150_ACCEL_TEMP_CENTER_VAL should therefore be 23 instead of 24.
> This constant is defined in line=20
> 120:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/pl=
ain/drivers/iio/accel/bmc150-accel-core.c?h=3Dv5.3-rc6
>=20

