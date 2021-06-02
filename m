Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1696E397FF7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 06:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhFBEFk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 00:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFBEFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 00:05:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08BC061574
        for <linux-iio@vger.kernel.org>; Tue,  1 Jun 2021 21:03:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k7so890235pjf.5
        for <linux-iio@vger.kernel.org>; Tue, 01 Jun 2021 21:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PpXjeoZHildpQY5eLGLdCHLWnQgU/hgOZ/i37Vc04Ww=;
        b=USHApFEFNA/iAENIYxtBH8HRh0VzqBlb9Fidr6MudXv0SFApvCbrOt80XIfrdmUiTU
         gyi6zDHJbMFWs1Mb6hVJph5yS/H77X/IsoMSt5HCs8yErYyCgQsv9JSCsmiCg+LjJH1p
         8MXgtuHmG6C0tNgNkU/CYAlcHHe3aI5p1QKic8fDZSEBGo3qAjwyQThGihHwQKn5vTUA
         NAT8+JPgrw5hDob61v5k/V03lv6F42rucFVkogsX7USCgLfJqcw/anpNQHGmR+C5NFKw
         xTQNFe4oRXYWv6uvCh3FjD1c/4mF0lBo3aCZ0DAKQHh+Ht3DXPT/Et90T4MHHhkB+8Nf
         73dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PpXjeoZHildpQY5eLGLdCHLWnQgU/hgOZ/i37Vc04Ww=;
        b=icoLLbON+0YgO4l49L+J2GaS36po/uT7EAFf7tdTSES1J+lWAqd/YZF7l+tVrTe03B
         9RGUXm8pMAgrgx01sODhfkTaWCXN8XtppT7vokMpEhuEexyrGLjWETcCix3bnzk37Ja6
         eolRJx0RbuZdaDsPAIN7MYIowpAL+HAiK8OyJh5ZNxmMsRROhLSjckJmzFjfMTLzKUXZ
         N/UpVS+Srwb3JPLiXOqD4XvGU2Gq1FuiwHSVso3LrDjuriOYAlQMb2VtGCdfnovYFYLG
         4XOdi6QilkNtkEnztK+zyLU3Fdjoa6w2WgXfCfqKbqGUinoVwm33BjP4kQAH6B77ttBP
         gdIQ==
X-Gm-Message-State: AOAM5335NCVailh5rxytk/j2I6gdU7FlLGNTtl29baghfNfZgB1wc5hA
        YKTo4LGnwW02C23knBMsHkw=
X-Google-Smtp-Source: ABdhPJz8sQTXXdz9U6fXSPJZ3K63bZ275OGF1ejngyZ5bOcK1tzhXjPZwLkL/ZgenO1+Jm14k1N9lg==
X-Received: by 2002:a17:902:b616:b029:ee:c73b:163d with SMTP id b22-20020a170902b616b02900eec73b163dmr28997944pls.30.1622606636467;
        Tue, 01 Jun 2021 21:03:56 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id c16sm14375499pfd.206.2021.06.01.21.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 21:03:55 -0700 (PDT)
Date:   Wed, 2 Jun 2021 13:03:51 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v3] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <YLcDJ+ZI1fXRpFRe@shinobu>
References: <20210527135838.3853285-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SwAr9JGH5ZdCyxft"
Content-Disposition: inline
In-Reply-To: <20210527135838.3853285-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--SwAr9JGH5ZdCyxft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 04:58:38PM +0300, Jarkko Nikula wrote:
> Add support for Intel Quadrature Encoder Peripheral found on Intel
> Elkhart Lake platform.
>=20
> Initial implementation was done by Felipe Balbi while he was working at
> Intel with later changes from Raymond Tan and me.
>=20
> Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> v3:
> - Support for Quadrature x4 with swapped inputs and inverted inputs
>   removed. It turned out in review discussion both are board specific
>   features and questionable should they be even exposed to userspace.
>   Both features are postponed to future contribution if such need arises.
>   Patch 1/2 removed becaused of this.
> - Error out if trying to set 1 clock period long spike filter. Previous
>   version silently disabled the filter and also sysfs behavior in that
>   case was inconsistent: write 10 but read returns 0.
> - Line-continuation characters in INTEL_QEP_COUNTER_EXT_RW() aligned the
>   same way than others.
>=20
> v2: https://marc.info/?l=3Dlinux-iio&m=3D162204156231555&w=3D2
> - counter_to_qep() macro -> counter->priv
> - Use sysfs_emit for user space returned values
> - Use kstrbool for boolean values from userspace
> - enable_write() reworked to be more readable
> - Reworked synapse action control and new sysfs attribute "invert"
>   * Action control before was wrong - what HW does is signal inversion.
>     Implemented "invert" sysfs attribute for it and read-only action
>     mode sysfs returning constant "both edges"
> - Renamed sysfs attribe "noise" as "spike_filter_ns" and define
>   programmable spike filter in terms of nanoseconds instead of raw
>   register value
> - Above and "ceiling" sysfs attribe changed as count extensions instead
>   of device extensions
> - Signal IDs rearranged to be zero based in order to prepare for counter
>   character device interface patches in order to ensure same userspace
>   sysfs paths
> - Initializer macros for counter_signal and counter_synapse
>   initialization
> - Grouping intel_qep_counter_ops, intel_qep_signal_ext and enums near to
>   their callback functions and use
> - "invert" and "spike_filter_ns" sysfs attributes documented
> - Other minor changes like local variable and empty line removal, etc
>=20
> v1: https://www.spinics.net/lists/linux-iio/msg59652.html
> ---
>  Documentation/ABI/testing/sysfs-bus-counter |   9 +
>  drivers/counter/Kconfig                     |  10 +
>  drivers/counter/Makefile                    |   1 +
>  drivers/counter/intel-qep.c                 | 546 ++++++++++++++++++++
>  4 files changed, 566 insertions(+)
>  create mode 100644 drivers/counter/intel-qep.c

Hi Jarkko,

I noticed the intel-qep.c file is missing an entry in the MAINTAINERS
file. Would you be able to resubmit this patch with a proper entry added
to MAINTAINERS so that users have the relevant contact info to reach the
maintainers of this driver? You can keep my Signed-off tag on as well so
that we know the code has already been reviewed.

Thanks,

William Breathitt Gray

--SwAr9JGH5ZdCyxft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmC3AxQACgkQhvpINdm7
VJImtQ//YHyxUO3oWdwLbwMzlpOemEldCVAzHKBmpGK/HYzXBM+1Gl/OV6eRD1Cd
OZz/sE+cYl+9x8wUuG6RUfYO/Lcdxz4YwtCuRqc6FicgU33EsPh5l+g2T3KsLM47
2ckueO2a10m1mFMEbgYyS1NPnBBpGVlq7+gwciFZhRXPJujUdefGdYqTUaZoDrOr
Ftc3tKRy1uwkcOXy9Ki3wHh7+XjlMuxp2cLa9Ik6PR1vzfxI5ZYrYwQAdqyd4SCd
fa9o6Xyx9imeGPjVJ2dv9LmWfpch+Me/h9+KyMa/VHBAxZB39rgkM/636+Eb3JT8
nZRrYvWvoT3vBSy2z2A8jyLtBuhcjCTvGR5qAYClNxvVESPhXenrff+aMlQO4pb+
GZgHaBfxbS3JABiCDRHDCKmedHzVU5uG542KkQQpPzpheMOd6n5RIQYS+qEG7lgD
w2B1Gii1GqdyKA5VgtYOUFZy6DtRBn6ArUrJd4fN1A7v/3TmsZXUVL5Ou4ooWJta
rUOJo8Qv4gXv/AFLf2+4RuVZq4VfZLs857AUq6pZNq+45CWmyE2apGSRGSFzaPoO
Lb6IrHhj+2fmW6Uq3B0xjdJg5Wxqs36Vgi+l3CHgG6owNuYHp1nu1nKTlv+nHQgP
pQ5t7G2lHMGDh8Dq9nL2ncCBA/tOxFe7j3HvH7MxSF8AVQirN+Y=
=O/Le
-----END PGP SIGNATURE-----

--SwAr9JGH5ZdCyxft--
