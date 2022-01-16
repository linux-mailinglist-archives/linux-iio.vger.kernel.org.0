Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB08E48FC91
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 13:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiAPMOk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiAPMOh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 07:14:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA01C061574;
        Sun, 16 Jan 2022 04:14:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A989E60C8A;
        Sun, 16 Jan 2022 12:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069D9C36AE7;
        Sun, 16 Jan 2022 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642335273;
        bh=0nTpCxV3/NmYJAFvbKWWK16Kk2dkcjasD1fsDem5m1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZpxB46oSShWrtE6D7x228gquZufo3zs7VPH22XfDcLmFbk0l8jGssxl3ZbzDw8bP2
         1hAI5QaH/3YX6kYbdrR9ZmY2D4BjUCjjM9sxSgKiRXrNbqtQmdJbRrV6iIQzIiXCXz
         X4csAU21wVn85COFIAvLEQMich5ZWTeLsO1aB/aubUGtCL7gh4gZ2gobMd9SHZ6Nt/
         EOIGACnjpLJ/zl2USSV5zVSJ62nLauGSpod5Z4x+11XUF6xgskEWLqCG6yz4fk8dQo
         WBCO9ye8u2z7bdhyQEiAQLBb/OGa4V8wTJ0lrNJBGKwU6xiQPzFhPZKyDFm3vrFO6d
         nPLiRj2oDurnQ==
Date:   Sun, 16 Jan 2022 12:20:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 2/3] iio: ABI: add ABI file for the LTC2688 DAC
Message-ID: <20220116122034.7db81c50@jic23-huawei>
In-Reply-To: <20220115092705.491-3-nuno.sa@analog.com>
References: <20220115092705.491-1-nuno.sa@analog.com>
        <20220115092705.491-3-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 Jan 2022 10:27:04 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Define the sysfs interface for toggle or dither capable channels. Dither
> capable channels will have the extended interface:
>=20
>  * out_voltageY_dither_en
>  * out_voltageY_dither_raw
>  * out_voltageY_dither_offset
>  * out_voltageY_dither_raw_available
>  * out_voltageY_dither_frequency
>  * out_voltageY_dither_frequency_available
>  * out_voltageY_dither_phase
>  * out_voltageY_dither_phase_available
>=20
> Toggle enabled channels will have:
>=20
>  * out_voltageY_toggle_en
>  * out_voltageY_raw0
>  * out_voltageY_raw1
>  * out_voltageY_symbol

Maybe worth just stating the normal interface here as well because
it's not clear from these examples if
out_voltageY_raw still exists for toggle enabled channels (I'm assuming not=
?)

>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
ABI seems good to me, just a few comments on details of the documentation.

Thanks,

Jonathan
> ---
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688 b/Docume=
ntation/ABI/testing/sysfs-bus-iio-dac-ltc2688
> new file mode 100644
> index 000000000000..38d1df81c6dc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
> @@ -0,0 +1,80 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_en
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Dither enable. Write 1 to enable dither or 0 to disable it.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_raw
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This raw, unscaled value refers to the dither signal amplitude.
> +		The same scale as in out_voltageY_raw applies. However, the
> +		offset might be different as it's always 0 for this attribute.

We'll have to be careful if we ever generalize these docs but what you have=
 here
is fine whilst it applies to just this device.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_raw_available
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Available range for dither raw amplitude values.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_offset
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Offset applied to out_voltageY_dither_raw. Read only attribute
> +		always set to 0.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_frequency
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Sets the dither signal frequency.
Units.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_frequency_av=
ailable
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Returns the available values for the dither frequency.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_phase
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Sets the dither signal phase.

Units.  Radians, or refer to the main _phase docs and say it's the same.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_phase_availa=
ble
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Returns the available values for the dither phase.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Toggle enable. Write 1 to enable toggle or 0 to disable it.

Say why this is useful (presumably toggle with a clock rather than via _sym=
bol)

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		It has the same meaning as out_voltageY_raw. This attribute is
> +		specific to toggle enabled channels and refers to the DAC output
> +		code in INPUT_A. The same scale, offset, etc applies.

Same as what?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Same as out_voltageY_raw0 but referring to the DAC output code
> +		in INPUT_B.

You could combine this with previous and have two what lines.  Might allow
a slightly more compact clear description.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol

Ah. That answers one of my binding related questions :)  You have kept
software control as an option for toggle.

> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Performs a SW toggle. This attribute is specific to toggle
> +		enabled channels and allows to toggle between out_voltageY_raw

_raw0

> +		and out_voltageY_raw1 through software. Writing 0 will select
> +		out_voltageY_raw while 1 selects out_voltageY_raw1.
_raw0

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 16e344d52b1e..16a7fd7f98ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11187,6 +11187,7 @@ M:	Nuno S=C3=A1 <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>  F:	drivers/iio/dac/ltc2688.c
> =20
>  LTC2947 HARDWARE MONITOR DRIVER

