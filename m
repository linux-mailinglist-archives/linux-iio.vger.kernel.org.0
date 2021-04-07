Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189173578A0
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 01:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhDGXm6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 19:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDGXm6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 19:42:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4BC061760
        for <linux-iio@vger.kernel.org>; Wed,  7 Apr 2021 16:42:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o18so142667pjs.4
        for <linux-iio@vger.kernel.org>; Wed, 07 Apr 2021 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W5UeUzP9r+VV/GKz4HTtWPSQvJvi4GAn9GYWvQZt0Wg=;
        b=aZ92KpPowfTRI/71c0jDaL2MLdeaYC10bKYkWTmZvS387kELHDfgmp+glTbjh/9nh3
         GzChdIt0HpSf8y0a152PWHMBb5o1mpfxU4p4yW/APoOzazkjSQhYYIuZaES6UX8nfRv7
         8H2KaB4bYmp4CG3jEdPkAHzKAqIzlPfwYlCS+sUKIj23jUoGAwGARjg48f5EOlInWf0n
         xzPxgPNZ8FvctaSgeCqs1D+mDXGG6JAaMGjCttcn6ElTQ9giXBVYWvlH3lpMaBpP0yZC
         A9kp0ZWSrOIJ2d0admFEDO/M5oL/yYQAaeSd/AmfaUM8Y0bV/64bHi6TZJVvzy9k0K66
         kwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5UeUzP9r+VV/GKz4HTtWPSQvJvi4GAn9GYWvQZt0Wg=;
        b=sc0eogaPCO/Tnj3PT64FkoK7zluu/xeb74JfYbKlZEqz8EmR+opwQQj1CZZ1POrFkT
         IpvI0f3+Tpm0kYVLsXnqkX0/mkOWap6FeDNHM9zz6ZLMxNaLiwxeckn0o7y06wivI6Sy
         oqnDV1OJhbqAZ90AcD868/OGxQN2UIW1vyOueWRsu8ZifSWjP/KVpOnXfwEfxAT/LJWI
         A/6F7pA0KfbOSOC7CzJxR9sBzGmsxpkWbjS4bhDXkzll0mw/FarQ54GkyV7nh5lDiZp6
         005WfkWu/7+GsdV18uT96FADfWjD8G/T4JLrAxvz3h/Md6SVPL8zuWEpc9ISM4b+2V54
         sbHg==
X-Gm-Message-State: AOAM530D2FJgUBWbkHcxlrBs6YPgBHGS0NQ2iv79EvHfHN1yAQpADrlU
        Q7mnxPEskYQ6STonNN1gkgzSQpmqO4c=
X-Google-Smtp-Source: ABdhPJyI8ufCodIBch3nxf54DGQ7imRHw5/uDwgp+iRO8hYkhSO2gGMsnbNCThDb4bzqNJS1tD3ezQ==
X-Received: by 2002:a17:902:8306:b029:e6:125c:1a3a with SMTP id bd6-20020a1709028306b02900e6125c1a3amr5322928plb.65.1617838967434;
        Wed, 07 Apr 2021 16:42:47 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 4sm6425221pjl.51.2021.04.07.16.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:42:46 -0700 (PDT)
Date:   Thu, 8 Apr 2021 08:42:42 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH 2/2] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <YG5DcjXAFafqbD5t@shinobu>
References: <20210401153228.2773560-1-jarkko.nikula@linux.intel.com>
 <20210401153228.2773560-2-jarkko.nikula@linux.intel.com>
 <YGbyVHNY/55akU9I@shinobu>
 <778390eb-d27b-c486-0f3d-610e019e69f0@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lyffGT3CQuATrki"
Content-Disposition: inline
In-Reply-To: <778390eb-d27b-c486-0f3d-610e019e69f0@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--6lyffGT3CQuATrki
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 05:25:48PM +0300, Jarkko Nikula wrote:
> On 4/2/21 1:30 PM, William Breathitt Gray wrote:
> > On Thu, Apr 01, 2021 at 06:32:28PM +0300, Jarkko Nikula wrote:
> >> +static const struct counter_device_ext intel_qep_ext[] =3D {
> >> +	INTEL_QEP_COUNTER_EXT_RW(noise),
> >> +	INTEL_QEP_COUNTER_EXT_RW(preset_enable)
> >> +};
> >=20
> > "noise" is a new attribute so you'll need to provide an entry in
> > Documentation/ABI/testing/sysfs-bus-counter explaining it.
> >=20
> Should this noise actually be visible as seconds (ns, =C2=B5s, ms) instea=
d of=20
> plain register value? From the spec "It selects the maximum glitch width=
=20
> to remove in terms of peripheral clock cycles: PCLK_CYCLES =3D MAX_COUNT =
+ 2".
>=20
> I think it should since for a person configuring the system plain=20
> register value is more or less guesswork.
>=20
> Jarkko

If this clock is actually temporal in nature then denominating this
value in a temporal unit such as nanonseconds should be fine as long as
such values have a well-defined behavior for this device. I do recommend
giving this attribute a more fitting name however because it is not
immediately obvious what an attribute called "noise" controls.

William Breathitt Gray

--6lyffGT3CQuATrki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBuQ1MACgkQhvpINdm7
VJJPXA/+JhMHAkmJBudc8ZbJTlENdUL7YAy4eILAVQzsGfc9ARcLOYFM2jvAg4pg
jz/KPedEFZEVcnEKb755kbKyqIYOYZD7laaGiHNt86b5r8ETvlqIdFkce3bdC0/l
IaEe+iOwzjNIRxoctM3oRbfyahk/TBNZpmn6V2G9xX/TfNlNuZF18I/5j3KKHBDb
3pO36X+/48+JvpXtz/0L/7bfynZ8Q7hOB6SlMg2XQ7S/vkgLHg6MNmhcsRcG6i+3
+NhSQRKHGyzGyZVYlKu582jNKZxjs2Jgo6P8fp4ZEsS9iCbw2BuwjRsmZFv7SYnz
XV9dJItqpm6f+tTj5f1Ukc0wzSiK8lHk/wLXD2VCOwiqpt0RI+J6KELYQurEeHRe
62xBNA+gkjuu1+hkiOa5YWmAlqjbie3ufow7rwgm/s4fJ/FQATbcuub3d1ejDeEs
vAjOj96/2/zJ2JJL3Mb3agrDsTDF+CpgNHIl0oUn3V07fK82DlH9N1jnf7gUnvPB
VRhNOWS/Zsg2W/373c1k3GvXa+XuudHPWwLROYqfzKg4sI+aX5RcC8D6GK9/dyhH
ENko6DGxgM/fBjpTVTkVnzzno1pU8U1fPO9PPTOD+139dEUHs+wFVs3thxCgnHvk
evJCrBNCbnYum3ePz0nmOPgSrhMeR8c53RevA5B+KCla1rOeiPw=
=7nwh
-----END PGP SIGNATURE-----

--6lyffGT3CQuATrki--
