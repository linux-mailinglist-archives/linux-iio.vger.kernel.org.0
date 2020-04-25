Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50EC1B890B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgDYTh3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 15:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgDYTh3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 15:37:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79FD206D4;
        Sat, 25 Apr 2020 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843448;
        bh=tIt15L4tv6I2YXrON6x5Huu8ZvXdG8PETuQXZQvfDSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Vcg90tFlqKRYZ/FguMfMVacALb85fqAjLXE8ePvfcVGAVEjaheAu0ULQbA42U5Rc
         Ma4hRJJZpB4sfu3SSq8LZJJvnl/9GBf/Ugr+bu1kim5R+c0+xE7mTcfbkXcEV49f/5
         3FFWH9vI0jpqvmQvwBDRVZ3xVDrSZlakdI87TKm4=
Date:   Sat, 25 Apr 2020 20:37:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] iio: documentation ltc2632_chip_info add
 num_channels
Message-ID: <20200425203723.01168c53@archlinux>
In-Reply-To: <20200420042612.27752-2-chris.ruehl@gtsys.com.hk>
References: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
        <20200420042612.27752-2-chris.ruehl@gtsys.com.hk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 12:26:06 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> The documentation for ltc_2632_chip_info missed the desciption for the
> num_channels. This trivial patch adds it.
>=20
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>=20
> Fixes: 9f15a4a0adc9 ("iio: dac: ltc2632: add support for LTC2636 family")
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Might as well take this one as it stands on its own.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Jonathan

> ---
> v5:
> tags added
>=20
> v4:
> Fix commit text.
>  drivers/iio/dac/ltc2632.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index 7adc91056aa1..2a84ea654645 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -24,6 +24,7 @@
>  /**
>   * struct ltc2632_chip_info - chip specific information
>   * @channels:		channel spec for the DAC
> + * @num_channels:	DAC channel count of the chip
>   * @vref_mv:		internal reference voltage
>   */
>  struct ltc2632_chip_info {

