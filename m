Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74C243C50A
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhJ0I3I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbhJ0I3I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Oct 2021 04:29:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F1C061570;
        Wed, 27 Oct 2021 01:26:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r2so2177344pgl.10;
        Wed, 27 Oct 2021 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=70nkIk1FToo0R/GNFHrATD7HbTVBXbdIxH+0XdYsr1U=;
        b=GKHaLygw4u+iwCMo2u/mQojshnehQZ2fT+HTaNfIx47JKPyRC3LCc+l1E1J0zwc6A1
         u3WrIMF0ZilVuFKHilL2xm9aJUOlje3vbobEzg+HPAovmTB12Am5IPnGuhs/q0JpOtkC
         +IxZCK+aldlWqKTY9RYnoiC3X6yD/Cj/VV5r8Wi4raJOecAIZRBhXWFJMDgCGFHRYk9O
         MHFnmdfz3S52+UNLKDqZNL3oQbD60ObtCao3VAlbvhBVT4Z6YZKDxS8I7yilQIfa2gag
         zJrCr+FXAGvfPer6fU3yydGunKtnB+OY0f9tBUnjNkB1QZghE1hpTLUWSNjQRzk2sR2+
         mD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=70nkIk1FToo0R/GNFHrATD7HbTVBXbdIxH+0XdYsr1U=;
        b=JA5deZBjOSN8dAfVqhLilX9/8ZetQqEW0Hzv6NG9wGatEQJxH1r1DX3zXkgknTSxIF
         lYZYtCNfYNva/QX+vYReEdl9WBFgAAxLaOPE2p6wtiiuxUGhSMQRBpJzOJWZelsLIl32
         2aP2XCcuPrS140j+S0NLM1LqZoFbBNwtHB+2H9dXHeNj4hRYaEiYewkLgQbs7JlbO0t9
         XNQc4dFmQYglk/VD9t/PrcD0qtRWj+wJrQ9AE2QjS5AK40Wbu9PDRlTsVGgq2cvGxKrF
         jYj+Aou5qAcuhwbXrcJ67Z3KHnF4bV7ZTwkPf3C1+9BiuItb225YD8C7UGdMVLPJ2yIA
         EthA==
X-Gm-Message-State: AOAM531JWNoeChrpnQO0Ok8pZnKRmTagh/I5dhVLAMPkkVyYIEEpCCIH
        Foi5rfCAs6A6yJg4NaBjmNU=
X-Google-Smtp-Source: ABdhPJyiwXwtgosZ0zLtUDjsD4TYRVYNIASXHrbnAfFjs0gkxFGT5a26JChDp5wHwL0LuN+HWhoK6g==
X-Received: by 2002:a63:7e42:: with SMTP id o2mr23075863pgn.296.1635323203062;
        Wed, 27 Oct 2021 01:26:43 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id t40sm10519507pfg.142.2021.10.27.01.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:26:42 -0700 (PDT)
Date:   Wed, 27 Oct 2021 17:26:38 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] docs: counter: add edge_capture_unit_* attributes
Message-ID: <YXkNPk65hXAgpVv3@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-9-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ek0MJCt6gYWt9LXH"
Content-Disposition: inline
In-Reply-To: <20211017013343.3385923-9-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Ek0MJCt6gYWt9LXH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 16, 2021 at 08:33:43PM -0500, David Lechner wrote:
> This adds documentation for new counter subsystem edge_capture_unit_*
> sysfs attributes.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 37 +++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index 78bb1a501007..6c192c8c2b55 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -59,6 +59,7 @@ What:		/sys/bus/counter/devices/counterX/countY/error_n=
oise_available
>  What:		/sys/bus/counter/devices/counterX/countY/function_available
>  What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
>  What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> +What:		/sys/bus/counter/devices/counterX/edge_capture_unit_prescaler_ava=
ilable
>  What:		/sys/bus/counter/devices/counterX/latch_mode_available
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
>  What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_availa=
ble
> @@ -230,6 +231,10 @@ What:		/sys/bus/counter/devices/counterX/signalY/cab=
le_fault_enable_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_=
component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_componen=
t_id
>  What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_compon=
ent_id
> +What:		/sys/bus/counter/devices/edge_capture_unit_enable_component_id
> +What:		/sys/bus/counter/devices/edge_capture_unit_latched_period_compone=
nt_id
> +What:		/sys/bus/counter/devices/edge_capture_unit_max_period_component_id
> +What:		/sys/bus/counter/devices/edge_capture_unit_prescaler_component_id
>  What:		/sys/bus/counter/devices/latch_mode_component_id
>  What:		/sys/bus/counter/devices/unit_timer_enable_component_id
>  What:		/sys/bus/counter/devices/unit_timer_period_component_id
> @@ -249,6 +254,38 @@ Description:
>  		shorter or equal to configured value are ignored. Value 0 means
>  		filter is disabled.
> =20
> +What:		/sys/bus/counter/devices/edge_capture_unit_enable
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that starts or stops the Edge Capture Unit.
> +		Valid values are boolean.
> +
> +What:		/sys/bus/counter/devices/edge_capture_unit_latched_period
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Latched period of the Edge Capture Unit represented as a string.
> +		The value is latched in based on the trigger selected by the
> +		counterX/latch_mode attribute. Units are nanoseconds.
> +
> +What:		/sys/bus/counter/devices/edge_capture_unit_max_period
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that selects the maximum period that can
> +		be measured by the Edge Capture Unit. Units are nanoseconds.
> +
> +What:		/sys/bus/counter/devices/edge_capture_unit_prescaler
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that selects the how the
> +		counterX/countY/count value is scaled coming in to the Edge
> +		Capture Unit. This acts like a clock divider, e.g. if a value
> +		of 4 is selected, the Edge Capture Unit will measure the period
> +		between every 4 counts.
> +

I'd like to see that naming for this made more generic if possible so
that other drivers can use these extensions in the future. For example,
instead of the "edge_capture_unit_*" prefix, perhaps "latched_count_*"
would be appropriate. Would this be feasible?

William Breathitt Gray

>  What:		/sys/bus/counter/devices/counterX/events_queue_size
>  KernelVersion:	5.16
>  Contact:	linux-iio@vger.kernel.org
> --=20
> 2.25.1
>=20

--Ek0MJCt6gYWt9LXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF5DT4ACgkQhvpINdm7
VJIZtQ/+Mb0bJ6fZ3OKhP4XxbSLj3pMkArvOiIMgHRgycGcYnc/VhAvBTnGZgt6P
K/Zn8pyy/e2Wn4NB+DPefeKjPfXvdNym/+dvUZ6Vj5M9caYR+B8Rgutxc/8Hio75
95IL3T99tfyt7IzwfV5DGnQAw+8NJVYAopWum0V7a2FSMTyHO5JwHVIfj+EN942a
MU5pfHy55gKu9K6pkoSk347O8nyvghXRpB+fJHBvezMjH77M15/u4DYRRslqW+tZ
R/daQrhdzFmP7+hdgwG9XlE/n3qQHCnFvWMLHDY9Ro//61RppB/9/ueCkKYv65xY
FB8doar8X65T1hlNFn5B/ANd2YN/Js0V/h8k4H+1f3xUl1AAeoOuJBzywd3F7ykN
DCjY31Ffqo3fXLFnvaGns5OEQCD3Q9CCVg1Bhs5cuPcSZnJFBbfQvfFY7zM0Zc9G
PC4vD5ZsWzp0+kgReYkTvDYGpovoi6teMeuQc4bjRWkBE1bKiVLQpoHJyXPWau0t
OJV5ACGIIw89KT70VwRlgdIdkSxfagtk2F5V1eDytX9GZCOlGBtLiLqQDEdRuYO+
fR2k48WRd+Hc2dPKl9gzfTHdlzTl4gcRYjl6T2P8fZdd0mrgtleEmf6Vxmt3mGxO
wUYYqS12VWlKwxUMuOr/I9A469pJ0Nydsv8fwMh5jpeKGNCLc78=
=WR06
-----END PGP SIGNATURE-----

--Ek0MJCt6gYWt9LXH--
