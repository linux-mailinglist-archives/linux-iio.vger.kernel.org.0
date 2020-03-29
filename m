Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7D196C14
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgC2J1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 05:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgC2J1L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Mar 2020 05:27:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C767206CC;
        Sun, 29 Mar 2020 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585474030;
        bh=p1dnSJJEqRK9BrL5kAdwlm93iK6znjQUpSF3jkakrNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IKp5bJEaibdjMIMmaU7HweCZT4awde5YYEeZfcDEWgoRWPWEi+uxmUWb+M+RI6Mhh
         MOcZofql85HkHAfbArZsph+COwCIU6qr6j3Mk0KYsv41gQFcqQ5gOPkmnPN4jOKcw/
         PVEIIyPgIkNgKH0BbSAMlBu1NNRmubVfPF7tobuA=
Date:   Sun, 29 Mar 2020 10:27:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: ABI: document IIO
 in_proximity_near_level file
Message-ID: <20200329102705.0a69000c@archlinux>
In-Reply-To: <bffa50e16f64df2a97913d9a9e87481c6e7e4852.1585134362.git.agx@sigxcpu.org>
References: <cover.1585134362.git.agx@sigxcpu.org>
        <bffa50e16f64df2a97913d9a9e87481c6e7e4852.1585134362.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Mar 2020 12:09:08 +0100
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> The vcnl4000 IIO driver introduced a new attribute
> "in_proximity_near_level".  This adds it to the list of documented ABI
> for sysfs-bus-iio.

Description and patch title are now wrong due to dropping the _

I can fix that up whilst applying if nothing else comes up.

The rest of the series looks good to me, just giving time
for others to comment before taking this.

Thanks,

Jonathan

>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-proximity | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-proximity
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity b/Document=
ation/ABI/testing/sysfs-bus-iio-proximity
> new file mode 100644
> index 000000000000..2172f3bb9c64
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity
> @@ -0,0 +1,10 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_nearlevel
> +Date:		March 2020
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Near level for proximity sensors. This is a single integer
> +		value that tells user space when an object should be
> +		considered close to the device. If the value read from the
> +		sensor is above or equal to the value in this file an object
> +		should typically be considered near.

