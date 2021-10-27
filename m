Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4693143C333
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 08:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbhJ0GtE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 02:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbhJ0GtA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Oct 2021 02:49:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80375C061745;
        Tue, 26 Oct 2021 23:46:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090a530100b001a1efa4ebe6so2780550pjh.0;
        Tue, 26 Oct 2021 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y7gwGiASJEFrbmc+5fzAPURspTpeBi4FYZUcQ7WbVCE=;
        b=N24vFHm16eCHZXvMd10Rk/AiC7bRqCz2UF3LvMw7JIBAU+2a/031pPXIZtSSZuex/F
         i7MSPaGtGROlLOycu7B4PXVWRGI9fSikrQlIXZeWLnpSChFqKNX+YYrcRFaT6IwsPe74
         kZx0ZMv6PpEsoRroH7D7Vqs1pRcKhiJpM7xuHgX6W+oS3CsreKFBmZ10bGWFf3giWjFt
         C9K29Aq4zdUZUARtFhovytBHo3OJ6MCQDzEUnNQhjcz3J3IFKelUZzPjPDyLQI+kaKAQ
         l7FAD2xVKj5wVj7BgxeUDSmA+hgMYn/8778iEDhlVu9byUXiM3joGc/Wac9y+2fTMNrt
         uN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7gwGiASJEFrbmc+5fzAPURspTpeBi4FYZUcQ7WbVCE=;
        b=QKvO3YWaKIFYBsfCUt84fcfhmsiseq5FvqeL01wsBUAzht0ONMDY3YOwOcso9dzhG3
         3n+F4mMe4s6vyqFjGAOAekav+eZ/5f/Aak9tG9pZRpV1Oi/97sAMH7KM7gWv/uiYUNvx
         HuB99utMJz7dtSIvhyp313rCy5rbgNUW8Jb3EEaoQVqtXbae6BfWqSMiS55UMDmy6UG7
         HdnTgjiNQx4ns0QDvD59dYeaNlWw/tMhdLg7zlhUkWlvMhXQnj8reifXlZvgSrjFiT4J
         uLdv3xsq7Dn5TlP168/HIFqqASxzcSYav+VX7m8XR7SZLmDbJ9+iE4CMvmxtMofUMVQW
         vFzA==
X-Gm-Message-State: AOAM530mGwjZnZ385SCHV06ElMJzQ4jKaqWp2tuKwUcPH6r/91ZHswyf
        gMxZFTifncec5+5vFDwesJQYa4xD3OY=
X-Google-Smtp-Source: ABdhPJy9JMOrQk+HJ5YEpSCz+4qPlUg2ZzA4ItTlUN3Ca4s+cQHYdts7GkiwHkLAyVx2V6pg1whOUw==
X-Received: by 2002:a17:902:6544:b0:13e:dd16:bd5b with SMTP id d4-20020a170902654400b0013edd16bd5bmr27190310pln.61.1635317193986;
        Tue, 26 Oct 2021 23:46:33 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id a135sm13813710pfd.96.2021.10.26.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 23:46:33 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:46:29 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] docs: counter: add unit timer sysfs attributes
Message-ID: <YXj1xc6DdeOrUKjW@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-5-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P6cTM9CQv3NfngqX"
Content-Disposition: inline
In-Reply-To: <20211017013343.3385923-5-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--P6cTM9CQv3NfngqX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 16, 2021 at 08:33:39PM -0500, David Lechner wrote:
> This documents new unit timer sysfs attributes for the counter
> subsystem.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>

Hello David,

The unit timer is effectively a Count in its own right, so instead of
introducing new sysfs attributes you can just implement it as another
Count in the driver. Count 0 is "QPOSCNT", so set the name of this new
Count 1 as "Unit Timer" (or the datasheet naming if more apt) to
differentiate the Counts. You can then provide the "unit_timer_enable",
"unit_timer_period", and "unit_timer_time" functionalities as respective
Count 1 extensions ("enable" and "period") and Count 1 "count".

If you believe it appropriate, you can provide the raw timer ticks via
the Count 1 "count" while a nanoseconds interface is provided via a
Count 1 extension "timeout" (or something similar).

William Breathitt Gray

> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 24 +++++++++++++++++++++
>  drivers/counter/ti-eqep.c                   |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index 06c2b3e27e0b..37d960a8cb1b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -218,6 +218,9 @@ What:		/sys/bus/counter/devices/counterX/signalY/cabl=
e_fault_enable_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_=
component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_componen=
t_id
>  What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_compon=
ent_id
> +What:		/sys/bus/counter/devices/unit_timer_enable_component_id
> +What:		/sys/bus/counter/devices/unit_timer_period_component_id
> +What:		/sys/bus/counter/devices/unit_timer_time_component_id
>  KernelVersion:	5.16
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -345,3 +348,24 @@ Description:
>  			via index_polarity. The index function (as enabled via
>  			preset_enable) is performed synchronously with the
>  			quadrature clock on the active level of the index input.
> +
> +What:		/sys/bus/counter/devices/unit_timer_enable
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that starts or stops the unit timer. Valid
> +		values are boolean.
> +
> +What:		/sys/bus/counter/devices/unit_timer_period
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that selects the unit timer timeout in
> +		nanoseconds.
> +
> +What:		/sys/bus/counter/devices/unit_timer_time
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that indicates the current time of the
> +		unit timer in nanoseconds.
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index a4a5a4486329..1ba7f3c7cb7e 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -680,7 +680,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	pm_runtime_get_sync(dev);
> =20
>  	/*
> -	 * We can end up with an interupt infinite loop (interrupts triggered
> +	 * We can end up with an interrupt infinite loop (interrupts triggered
>  	 * as soon as they are cleared) if we leave these at the default value
>  	 * of 0 and events are enabled.
>  	 */
> --=20
> 2.25.1
>=20

--P6cTM9CQv3NfngqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF49bsACgkQhvpINdm7
VJIsxQ/+NlqGyom3rHdIRp5zS/p1NHrDS9ip4Guwu+o2vs/pL/q4i8kIAdtHqMRt
QUor8ZKVecm62TkgeHgognLnDWqzNeCpfHxJa2+pYbJHAtWZ5+0kSvYywI9sO54O
d43Rgx87uwOlUaNo6qLOjqLAuyJb8X5ZSxazkk1zAnL+bpXoWTEkxWA5w9OKNbRF
duW9uSsudT4dYbmxDiXOyZkppEH91ZazClbolG8Sg5aAHxrA92GcFODpWoIOYf8A
adjpXeWtadJcH+V/+YxKcH//aQKPwm4JKnzgJKWixdQ7gBNc+R5Kzxe7wmN/aLaL
g15tuuZzf0D5LF2if0d2uFZrojhh+WVgPDmA7ZW9D9h9yQbCtIhZGuyzRCODHqgt
OvzhQEtjSDBLpMZ/LOYe/zQUgkeF7InTQdl9tHu2mjuUW8r+dYCim6tvwX8fuGwu
AVSLDTklNgY+QhrLv4hURxtjIVms1mde/+7BcTgNzNAWOPirztqZg/kdulPUeHNF
VZgWFK0e6/fzpdVXJgpBOHvpAezpjtZPLOyCBYrTXF/clEeyqiZ4FaTZoCZ6Mk0w
ANMaTZHRLJ1B+a1CA7bSmyPLFFP12EhZ9eNV8VC/k3MTta+AAlUoL8ehkmArSEx0
nqcufqFU9JTT+Fv6ulpQEt5dFCWpF7K+mvrQJHEdTdaJ3s8JkVQ=
=SYqP
-----END PGP SIGNATURE-----

--P6cTM9CQv3NfngqX--
