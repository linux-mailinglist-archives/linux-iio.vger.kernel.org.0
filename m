Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC741AF30C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDRSGs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSGr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:06:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A14721D6C;
        Sat, 18 Apr 2020 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587233207;
        bh=Tjiq+jjCeCCPuoO5rbKEnElv5WiWarZq5dC2b4IddC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lJV322+FUZdtnAlnguxVmT0S4xQfbeh1BVUwjpRPvk+8DOmAKISrbTHC5+h3Q+bqe
         kJ6AMqD55vIPfOWynMJqSySmMa6Kzl4hiTd2dhxQTBScJB66tjwQI5s2rxoTXywGcx
         YT6sC/Mc0maExmWosbbFLFjRfRT5B7+5iwyy9nMk=
Date:   Sat, 18 Apr 2020 19:06:41 +0100
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
Subject: Re: [PATCH v4 5/5] Documentation: ABI: document IIO
 in_proximity_nearlevel file
Message-ID: <20200418190641.72df5e92@archlinux>
In-Reply-To: <4d3d41e42721128916640d097cc4dbf7b19fb525.1586094535.git.agx@sigxcpu.org>
References: <cover.1586094535.git.agx@sigxcpu.org>
        <4d3d41e42721128916640d097cc4dbf7b19fb525.1586094535.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Apr 2020 15:50:32 +0200
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> The vcnl4000 IIO driver introduced a new attribute
> "in_proximity_nearlevel".  This adds it to the list of documented ABI
> for sysfs-bus-iio.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

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

