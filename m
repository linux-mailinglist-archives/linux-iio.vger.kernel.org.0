Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E06C43C46F
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbhJ0H5X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhJ0H5X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Oct 2021 03:57:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205DEC061570;
        Wed, 27 Oct 2021 00:54:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u12so1445511pjy.1;
        Wed, 27 Oct 2021 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpWj0oN2nhXKNgQMFgyfpaonwjc0rOLvMyT83iInyoc=;
        b=lJhEjucYFsFAkFkgfa5YPL6aglbDkwW50bxLyYX5S28yMY3MVQVStg4FkjPs8Zvi4W
         dwglVZmC1LgnKzNn43CbryvHrLXB58qiWAkJ4llx7csvn2KzjL9lkbZXixrVUnwYFhIr
         u2zfNoOYHQIVOxyM7HTVdeXxmQKokldxziNTVpy7cjZ6OCJ4RKGtlrsoOe925eCjb9nH
         sC6QUvQCq/q7xb2MlAszrXwQ2jWj8xmMAz7gGtQbTBpHJ5gqO07235NN27h0EbjvfNqH
         n6uUaC2T9RR/GlqSoS7LimOzMsvgGsx2fkMrlDhS4GEZlaQZXC7dtG8OuC70dgZk633T
         syaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpWj0oN2nhXKNgQMFgyfpaonwjc0rOLvMyT83iInyoc=;
        b=ylJld/hpfVP/0xOXENEqzTHs96TQndz57s16VaATQ6ZZCK80NYXqWcu2eBo8rdhwBL
         1wKBS+i0aXBllin6ygYtqFHKYTQXdMaBCOumKU0UZDbzU1d0F9q3S2PYttPhSXNTPwjU
         47lvBliyZJcsdVG+2JpWGXj1ikrSNrGB3S660MNQFSaN18rYL0wBgrjSoL593KSQgc6u
         Xg0xWiJZwCNH7CiiaCeqzDQD0XeULZhLzixPdDYxv2G3a3DG10nMoDTpZGEI4zTHbL4L
         povX00T3MUQgAPi70H289te9lktH6kRymv8CXphbVUBkyIqTd8hdYzC4MtnWw2OYGgXQ
         nsuA==
X-Gm-Message-State: AOAM533ZJROkJwUtQKwFMM6BLU5DxGYE29kU/zAUDSO9DqPQQXCg7TSH
        FygbuR0N84CmVuKxB7klRKc=
X-Google-Smtp-Source: ABdhPJwVvQAGehpA1gJGpq9l0Tt6kf833XpJN2+D1D8PZaLfgNIlIi5O5a415bQOL6ciVL+2mj2oOQ==
X-Received: by 2002:a17:902:704c:b0:13f:2c24:c1ff with SMTP id h12-20020a170902704c00b0013f2c24c1ffmr26842726plt.55.1635321297563;
        Wed, 27 Oct 2021 00:54:57 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id l6sm16182404pfc.126.2021.10.27.00.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:54:56 -0700 (PDT)
Date:   Wed, 27 Oct 2021 16:54:52 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] docs: counter: add latch_mode and latched_count
 sysfs attributes
Message-ID: <YXkFzK0TA5zswSrQ@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-7-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8tPnTEQud8gMPGnp"
Content-Disposition: inline
In-Reply-To: <20211017013343.3385923-7-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--8tPnTEQud8gMPGnp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 16, 2021 at 08:33:41PM -0500, David Lechner wrote:
> This documents new counterX/latch_mode* and
> counterX/countY/latched_count* attributes.
>=20
> The counterX/signalY/*_available are moved to the
> counterX/countY/*_available section similar to the way we already have
> The counterX/*_component_id and The counterX/signalY/*_component_id
> grouped together so that we don't have to start a 3rd redundant section
> for device-level *_available section.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>

Please separate these two distinct changes into two distinct patches.

> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 39 ++++++++++++++++-----
>  1 file changed, 30 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index 37d960a8cb1b..78bb1a501007 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -59,10 +59,13 @@ What:		/sys/bus/counter/devices/counterX/countY/error=
_noise_available
>  What:		/sys/bus/counter/devices/counterX/countY/function_available
>  What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
>  What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> +What:		/sys/bus/counter/devices/counterX/latch_mode_available
> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_availa=
ble
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Discrete set of available values for the respective Count Y
> +		Discrete set of available values for the respective component
>  		configuration are listed in this file. Values are delimited by
>  		newline characters.
> =20
> @@ -147,6 +150,14 @@ Description:
>  			updates	the respective count. Quadrature encoding
>  			determines the direction.
> =20
> +What:		/sys/bus/counter/devices/counterX/countY/latched_count
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Latched count data of Count Y represented as a string. The value
> +		is latched in based on the trigger selected by the
> +		counterX/latch_mode attribute.
> +

Latches are pretty common components of devices, and not simply limited
to latching the count data. I wonder if it would be better to omit the
"_count" suffix in order to make this more general. Well, the name
"latched_count" is suitable for counters so you probably don't need to
change it, but it's something to think about in the future.

>  What:		/sys/bus/counter/devices/counterX/countY/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> @@ -209,6 +220,7 @@ What:		/sys/bus/counter/devices/counterX/countY/count=
_mode_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/latched_count_component_=
id
>  What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_=
id
> @@ -218,6 +230,7 @@ What:		/sys/bus/counter/devices/counterX/signalY/cabl=
e_fault_enable_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_=
component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_componen=
t_id
>  What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_compon=
ent_id
> +What:		/sys/bus/counter/devices/latch_mode_component_id
>  What:		/sys/bus/counter/devices/unit_timer_enable_component_id
>  What:		/sys/bus/counter/devices/unit_timer_period_component_id
>  What:		/sys/bus/counter/devices/unit_timer_time_component_id
> @@ -244,6 +257,22 @@ Description:
>  		counter_event data structures. The number of elements will be
>  		rounded-up to a power of 2.
> =20
> +What:		/sys/bus/counter/devices/counterX/latch_mode
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that selects the trigger for latching
> +		values. Valid values are device-specific (given by
> +		latch_mode_available attribute) and may include:
> +
> +		"Read count":
> +			Reading the countY/count attribute latches values.
> +
> +		"Unit timeout":
> +			Unit timer timeout event latches values.
> +
> +		The latched values can be read from latched_* attributes.
> +

To make these modes more generic for use in future drivers, I suggest
removing the "Unit " prefix and just leaving that mode as "Timeout". In
a similar vein, rewording "Read count" to "Count read" would make this
mode easier to understand in case a future driver introduces a mode
called "Signal read" or similar.

William Breathitt Gray

>  What:		/sys/bus/counter/devices/counterX/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> @@ -298,14 +327,6 @@ Description:
>  		Active level of index input Signal Y; irrelevant in
>  		non-synchronous load mode.
> =20
> -What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
> -What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_availa=
ble
> -KernelVersion:	5.2
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Discrete set of available values for the respective Signal Y
> -		configuration are listed in this file.
> -
>  What:		/sys/bus/counter/devices/counterX/signalY/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> --=20
> 2.25.1
>=20

--8tPnTEQud8gMPGnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF5BcwACgkQhvpINdm7
VJIvGRAA6uHCenBqcjA8Tzw2uK5PsOx2yaTxE7pbLkLdVLDrNykyGalbl83xaYVa
BRMAxJkn/wK0+lVE3/fzT9ATCNT9zLs9OeHgySb5+ETBthKVawNbz5aUSN7cRgkn
mF5O5aTIWfN74/EPrBIdtFk1XufmcZ0lJgTdF4oh/PYzNpsqbItqAUQNelo4LnoC
PrExQ04Gf9e60sm6Dv9hNWYXq1XYvjyY2EfZR/F0rnHBwU5YuBQqqlIFNN13K42q
UVq3xPLZ+kJ8KkXb+eACS8epxGsPZGjbN1VXFvgmRuSLXkSJkNRbFMzc7Oust0J4
khmscUYWx482T0INur7pXvPKMszA7rXNkOlb+FXXv10Uj4oKa7vGMKSPZ4CFjoZ4
1nMbwfMPZQpUgTIMQ9keq4vSJf9Fh2cYB8HW/sAWgr+AYW7UdLCqKfHLK7p/S06v
dZd8WPzvgkX9jyc3tMPKGVSaaAFvPs8qJiFPO2mgg+nXK5TjG0ILbPa2j3EW4N+t
kKPHO2Vosacv0jbNmGqxUb4WnUxgIBy6Npr/nraBgPh+nYSRu2TWlZa/u/oIYIuS
pvkpWr+sjHQhS/eKyyweI9VeFVaOuE8+QQ7EZK2ZytowIodxbl1Q30N8n3LTq859
Kvi2aJ8uArKumI8ERZj75GjXy5lpyCPJ4pYU6NgwpHtiRr8OHCg=
=F5Gv
-----END PGP SIGNATURE-----

--8tPnTEQud8gMPGnp--
