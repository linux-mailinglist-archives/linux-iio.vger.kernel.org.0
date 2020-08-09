Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7323FE65
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 15:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgHINVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 09:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgHINVv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 09:21:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DEE9206B5;
        Sun,  9 Aug 2020 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596979310;
        bh=MManKlBQlS5BzQSnyGWYsESTG/+MYGfM4FrBkqfA4ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ftTwWnJTIJr8mXXnpTKOcOEriUypqY3Vr9efHu9RKo9IGa9NHATmsfC5XThHpPiIb
         TnfydEBYKzYMnBf/r2/6dsY2BmoIwS3WhK8MujikYB6TCfOhKMu5gVPOSoAIRPNyhK
         h/+wNYR4eINQRdp81NP37mtFBPEvvpbjOANjyxCw=
Date:   Sun, 9 Aug 2020 14:21:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] docs: iio: Add adxl372 documentation
Message-ID: <20200809142147.0eb26f78@archlinux>
In-Reply-To: <20200803172219.33911-4-alexandru.tachici@analog.com>
References: <20200803172219.33911-1-alexandru.tachici@analog.com>
        <20200803172219.33911-4-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Aug 2020 20:22:19 +0300
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
>=20
> Add documentation for adxl372 3-axis accelerometer.
>=20
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

This is ABI docs, so I'd normally expect them in
Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
rather than as part of the main docs.

I can kind of see why you want to take advantage of more free form
docs, but I'd definitely want to see them in the ABI docs first.
Once that is done, then we can see if there is anything left that
needs to be documented like you have here.

Thanks,

Jonathan


> ---
>  Documentation/iio/adxl372.rst | 46 +++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst   |  1 +
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/iio/adxl372.rst
>=20
> diff --git a/Documentation/iio/adxl372.rst b/Documentation/iio/adxl372.rst
> new file mode 100644
> index 000000000000..f8fe5f438400
> --- /dev/null
> +++ b/Documentation/iio/adxl372.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver adxl372
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +  * Analog Devices ADXL372
> +    Prefix: 'adxl372'
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/d=
ata-sheets/ADXL372.pdf
> +
> +Author: Stefan Popa <stefan.popa@analog.com>
> +
> +
> +Description
> +-----------
> +
> +The ADXL372 is an ultralow power, 3-axis, =C2=B1200 g MEMS accelerometer
> +that consumes 22 =CE=BCA at a 3200 Hz output data rate (ODR).
> +
> +The ADXL372 provides 12-bit output data at 100 mg/LSB scale factor.
> +
> +Using the FIFO Buffer
> +---------------------
> +
> +The ADXL372 includes a deep, 512 sample FIFO buffer.
> +The 512 FIFO samples can be allotted in several ways, such as the follow=
ing:
> +
> +    170 sample sets of concurrent 3-axis data
> +    256 sample sets of concurrent 2-axis data (see scan_elements/in_acce=
l_*_en)
> +    512 sample sets of single-axis data
> +    170 sets of impact event peak (x, y, z)
> +
> +By default when using the buffer adxl372 will store all
> +acceleration data. To store only the peak acceleration data, the user mu=
st
> +select the peak data trigger: adxl372-dev0-peak
> +
> +The user can set the thresholds for each axis for activity and inactivit=
y in:
> +- events/in_accel_*_thresh_rising_value
> +- events/in_accel_*_thresh_falling_value
> +
> +An inactivity/activity event is detected when acceleration in all enabled
> +axes remains below/above a specified threshold for a specified time. The=
 user
> +can set these timings in:
> +- events/thresh_falling_period
> +- events/thresh_rising_period
> +
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 58b7a4ebac51..3d0acb1eef86 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -10,3 +10,4 @@ Industrial I/O
>     iio_configfs
> =20
>     ep93xx_adc
> +   adxl372.rst

