Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974A63B71BD
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jun 2021 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhF2MIM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Jun 2021 08:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbhF2MIM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jun 2021 08:08:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD1DC061760;
        Tue, 29 Jun 2021 05:05:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q192so16994304pfc.7;
        Tue, 29 Jun 2021 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m17uJ8tyJmebRyt5rUaOfyapmzq/d5La3yQTJot+jLU=;
        b=Q4PtFiHk8v/Ty9R7u93juX8WU5Y4PytGsEhUUXJqifnKImzgL1f/5XdIlujf6jU6kb
         a2zBHXm7AJgat7y8RgqbS5azIJYNC72KOzxivjRwyGm6hCNO/3awLwsfGULEVZzD8wgO
         kXUV/a/NxsZRQvqwSFDV3r9O3mQQI8uB+zy7x0SEEshco/X9Ls40gkAeHs+ZbELFd8FW
         5JsyIemmWYYut3G64NJ8Pwe4Hq/QV3ir9PJk+JYVbKshwPWib38NoI/6Rj6afHawjKbQ
         QukPA5L3Q7nVqjsgSYAGcM1R9alKpQdSG76e/n8cQNgRSsz7+kg3tF9UGnF/CnEPdLkg
         HDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m17uJ8tyJmebRyt5rUaOfyapmzq/d5La3yQTJot+jLU=;
        b=A4YCbqLNo0GzH2XD3OU/sRACjYwVtOoh86BNfjcM2xD3dJP5s+XJ+clXLISRB3iFLB
         XcoWDHMO005aFqHXsTaddMDmqdv5hTHlsCiIpdXRLI3d0pWPSAPJiU5P+e4vIRjLpn+U
         +saeN8Ef8rNmlzwgDu0fVLIAuvf+fl8Qcpu3ySu3m3L7F6DeIS9xFC79AyRPPGHewPuY
         YxpiMOMSZGe4ULtEm8ng1UWYDK2lGAPTjtTVIAtVH/h2GIb9ooMnXLrCaxau9W6jxhxi
         pjHj9wFWNwykqv/2IF7ksT/J1fc0r0zJkHi88DgCBK56trJqKsdl9HSnx/gfdCGWhH8s
         4cbw==
X-Gm-Message-State: AOAM532U5/xnNvu+n6lcmM68uq80qsWTTPSI7+SJWOH6L30VhK3yQGZe
        h4YyodNE1kBjEuWuchwdflE=
X-Google-Smtp-Source: ABdhPJzXJdEFvqEb7D2EbReGHhAiNo0pZpEcD7hJJMwonKIWYtWmbHQzBclCIaCqhqe2B1A0dj3+IQ==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr28409882pgl.118.1624968344711;
        Tue, 29 Jun 2021 05:05:44 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id m10sm13250306pff.215.2021.06.29.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:05:44 -0700 (PDT)
Date:   Tue, 29 Jun 2021 21:05:39 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: intel-qep: Remove linux/bitops.h include
Message-ID: <YNsMk4qyfyZ43MfX@shinobu>
References: <20210629111657.2655688-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TCKwjjzXl7hJJ0ql"
Content-Disposition: inline
In-Reply-To: <20210629111657.2655688-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--TCKwjjzXl7hJJ0ql
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2021 at 02:16:57PM +0300, Jarkko Nikula wrote:
> 0-DAY CI Kernel Test Service reported following iwyu warning:
>=20
> drivers/counter/intel-qep.c:11:1: iwyu: warning: superfluous #include <li=
nux/bitops.h>
>=20
> Remove that include since we don't seem to use anything from it.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/intel-qep.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index 8d7ae28fbd67..1a9512e28519 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -8,7 +8,6 @@
>   * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>   * Author: Raymond Tan <raymond.tan@intel.com>
>   */
> -#include <linux/bitops.h>
>  #include <linux/counter.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> --=20
> 2.30.2
>=20

--TCKwjjzXl7hJJ0ql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDbDIoACgkQhvpINdm7
VJItWQ/6A8yH0ylrY1eWdpiUQPfk9G6P7CabrMZXfd0SiCq7jVBc48thIY7fNTIS
+bWnyfnf3vHIgHd/MJuPx/tXXovuh6lCKM5F9wxSU3YulJeOGC8VQRU7+FiEe2gX
b7aqw2rNCWAbfu8szYap1pFFEZUbw762jDSaWrf0JOdZnhOLh1aNzxuZ33v5HO1Z
qMXXP6WU9XKajqRiee4eViJt7JyD36WZUgm7jf8gy1jo+x0H1ispn/vJb6x6/eZh
8DlzKixp0dyz7j+esDPLnC0Fs/RwliYdnLYNe8+oUbyidKVpemuo1bl4yK0NS4xe
JMdSvj9EXRhF7RjHu8amwY1Si2pPtvpjWTU4axsog0pO/ixerPjwwoXoJVZhqxnB
vvt7zVhO6B7gYRXbju+6ffovyB/c33s18tozqe2X33U39iOCez8/16dQaYbIg8Wx
VGqBg+ZRwyHbJNi18isGuP8dsj9arG3jgm29z45DvkRUH2zAtpiKyltR6Bbtycc2
iSKMprAXO3dTWTH48f4qhPND9pCebS5K+8ykR2ssVyOXRI3L7/kzrO6K4j1+1VUK
yIRuiTb6JXKM1mq0ed+ZEJMW/yTA2km8le6fHCgH02hJ4pkzGvT6u3vZJARYlc/I
6dD0lbv7HFjlLEbI9qe+vbef6ykBwVevKgq/SsJ8u/eYK8Qjp18=
=wrYO
-----END PGP SIGNATURE-----

--TCKwjjzXl7hJJ0ql--
