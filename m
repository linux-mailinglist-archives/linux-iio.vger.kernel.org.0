Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384BB2C40E6
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 14:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgKYNH6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 08:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKYNH5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 08:07:57 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1F2C0613D4;
        Wed, 25 Nov 2020 05:07:57 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id d5so1520730qtn.0;
        Wed, 25 Nov 2020 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mMhr7if+ZnRG9MhMHI+KNa2LdhxLLABqJa+FncSk4Ss=;
        b=T2xVHBnpNinPB/LWXNXkxkZaoP24VjjodPX8UKsm9aU4/4wtS2oZiNVbe4q2HAc82w
         uIuIz3s3DmRGkSqO8C9p8QmFJ+3qOeB8jzVRoYrab4wNEV8mPfVTcknf3fWoP2Gd1cvy
         6/7Dezb5IR3UGkhu4LcNp+SxlNdl9Xa8qmG9ScF3kkn5HcfpDMScgQO8CuNlGNu2naYA
         B9T0NFIvhaXQGVMtdjdWHJp1Kdm2rdi7bg1iOk8joFKeXKzNzRnIv7nYGL0lzxmZf6Ul
         bpVsDhpULPZGJWHGfELInwZ1AlWdV17bmHYtbKolm0S3edmhrIf5+wDbsB2slnXqHz3N
         XKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMhr7if+ZnRG9MhMHI+KNa2LdhxLLABqJa+FncSk4Ss=;
        b=kNm0adO9KobH+xH54dxF6Ms/b7Rvzxi1ctgRdh+LoWt9tsN1S7mFTStO9tfmL/JJ7h
         /+mpl6qXF7MzZT8waUa3RviBwLuQH/mjizUPbzQvhJhjrr/n32Ni1KWnQ3qHzW/TnOoC
         aX41mjAmkYRSjhlF06r/Zf5UwML8KGfHmCrqPm4cJ0fGWAA4kX0Ap3CrCrTgZ573YNP0
         +axJV3Nfjjg51K9Kr9/WHLE3slrgiRQ7qSoUMdEyHu8PqrpmFEjaOAQHlghbAE8/saYg
         tQVFrmcrx99aUTNoudgLWNPV2yDIqJ6RCgIKFH0mOcHOjZ0/m1zrFo2bflqDRzDiXvGq
         2/BQ==
X-Gm-Message-State: AOAM530d1E/3jksieYsga4fnTaqqjm548ync5fJZBdOaku4w85EUaBRt
        zq/Iy9AspAHVsjGGDqndhjY=
X-Google-Smtp-Source: ABdhPJxJb4TUF0NizrQVHPOB3OFujzxO1AeeC8RmjaIrDGlIDfo14gqg/cJv0Tldd1XkjLq0l7zMfw==
X-Received: by 2002:ac8:71d5:: with SMTP id i21mr3049929qtp.4.1606309676849;
        Wed, 25 Nov 2020 05:07:56 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id c6sm2443740qkg.54.2020.11.25.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 05:07:55 -0800 (PST)
Date:   Wed, 25 Nov 2020 08:07:53 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     david@lechnology.com
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 1/5] counter: Internalize sysfs interface code
Message-ID: <X75XKTy+8cqPyzlH@shinobu>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
 <950660d49af7d12b09bc9d3b1db6f8ff74209c26.1606075915.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="51cx/e7mr9ap1Ofv"
Content-Disposition: inline
In-Reply-To: <950660d49af7d12b09bc9d3b1db6f8ff74209c26.1606075915.git.vilhelm.gray@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--51cx/e7mr9ap1Ofv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2020 at 03:29:52PM -0500, William Breathitt Gray wrote:
> @@ -117,62 +112,95 @@ static int ti_eqep_count_write(struct counter_devic=
e *counter,
>  	return regmap_write(priv->regmap32, QPOSCNT, val);
>  }
> =20
> -static int ti_eqep_function_get(struct counter_device *counter,
> -				struct counter_count *count, size_t *function)
> +static const u8 ti_qep_t2c_functions_map[] =3D {
> +};

Just a heads-up: this ti_qep_t2c_functions_map array is left over from
some code I was testing. It's not used at all -- I simply forgot to
remove it -- so I'll make sure to take it out in the next patchset. I'll
give this v6 patchset some more time for people to review and comment
before I submit the v7 revision.

William Breathitt Gray

--51cx/e7mr9ap1Ofv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl++VykACgkQhvpINdm7
VJKYVA//dqccbhIoBaceJes3TqLXOFW/M8mwfy+XZ+rP/ih/h8l24f0y0gLPWYnH
g9rV4GH9VOeKz17Lkocb5dKgPhBR6ugL7IAWWOSh7SI4BTg9eT8iVQI9AVYAbXD5
vmZHxvt5zhEjO7l2l5fBstZObzpgTv4eJW+cjZle/ZaCdTVXm0/m8kPNzQU1xtgP
sa/6twzxxE8i6PwHBk+aP7MKYSMYp8hjtAZPVtniAAFj0XdRgTIn4GckYmp4zt6E
gdlh9KdSAnf/vcG7zR2OrXk4YMUOE4grLqBkx+KUWsNi7AlvLX+XHBXeVCAgnljx
KIkro97m6rULfD6yHL48aAce/MMu0r4s5tZ5nRa7yL6pE3mY8Ajvi6k9lTu55NYN
CKTLFUf85+GRs/GUZsW0VwGVmwsGT5wawJZiTkPxYFfa+dgMEBMoaCjUEEZrw7cm
bxk2k/ffuIIi/UGQWtXWPUKXyCIaRm05+rNxK6s7OP/EhwCOdbBKvFLc998AwdyY
Vl7+tPLntu7H9j3vuZBr/tPm3PiTCTcIzGa4WfaYhJMDw0WXKYLrXGdQ0SUvnk2k
BnF2ob6wDL/E/x2wFJABYB6OH8biuob2S/LuBdlTNBAOCzMlDTPylFVhjSxSJ8jt
tWyXUjmfq1xws9/39/0J6vW7QBxpgOOuc3vFP4Q3y6mnBSTEJcs=
=388v
-----END PGP SIGNATURE-----

--51cx/e7mr9ap1Ofv--
