Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7161893F3
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 03:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRCSH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 22:18:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39840 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRCSG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 22:18:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id f17so18159041qtq.6;
        Tue, 17 Mar 2020 19:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gwlzqeZj4d3b961byPyFVrEOJd+bwlw/Cv25SoFLeBI=;
        b=FnkI7Hf4aobxD7Mbzp+6UCkJHwEUJUtmKlGIBVgagNQDs9KazggfL0FMl3zl0RC9Tq
         YsrjkW6M5gRPEUliOWv8C+Dmjjy+DcTgzpnVpx+GTIT/ZPJ+Y874zsTi6EdlzOjNSFWX
         HtuBIsIZU4NM3QSpBQ5j6qnSw54uQnldE1uPhj4eVZ9h80m4K4iDRc20MofkmjCBliNP
         I4WRIO+fL/vdize/oQLvHdG5gx75O4iX73XmI47OqLipFzJ2k6cRtnInPXK/G0tzoFQP
         QqfQv4C7CaiUZcV6lnd9tKhx4vFXlASSNt8WxJzeGx+LR2fpeT4s9fHMoZFgf03ZkecP
         MqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gwlzqeZj4d3b961byPyFVrEOJd+bwlw/Cv25SoFLeBI=;
        b=LodeWK5HRuDZMxhbZZTXwTxLTsYZq1nwhX9rXCGZuhPxeQdQHpcoiK52I5uegdZ1Yo
         5qemeJ2ny9+QT/oYaAKyD+J88KMMhUo+fJ2UyDeuuHj4flJquvH7628ZUePXEf0irMDk
         oTzJxzokBS8f84/4Vq3EELy+24zSOBLp/kibTUaiN9Ks9vU9lWR9WizzDJcIQlX52lPr
         X/soXTtX0Oa6fG/2WtNZ5AC5q4Sxyk7qhhaYNm5ZfTtwq5fWJfJ5MI2ClQBCW+rFHRmH
         PwxRZ2JJzF4981MUdHQtrvdjA1+zL3ymWq5TpUyVfe46yK0oRWEugrd1VnyWFOK5MsF0
         whxA==
X-Gm-Message-State: ANhLgQ1jm5KOiZv7mhWVPcYqXJ8xo+K9a+5oDo035P3uHF8ag/Wj6oNp
        6iaRyLT2iRmWlY5UJr32rI3MDKpO0X2cGA==
X-Google-Smtp-Source: ADFU+vv5HD9xXsH8mTL6DvQT5Pg/4NoEqtBsEYA+KV0Y6AW4tN9pogaXID1SkaBoJevPxnQMrdDL9g==
X-Received: by 2002:ac8:7a96:: with SMTP id x22mr2406587qtr.0.1584497885590;
        Tue, 17 Mar 2020 19:18:05 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id m19sm3232429qkk.1.2020.03.17.19.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 19:18:04 -0700 (PDT)
Date:   Tue, 17 Mar 2020 22:18:02 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] counter: 104-quad-8: Add lock guards -
 differential encoder
Message-ID: <20200318021802.GB45571@icarus>
References: <20200316125006.GA415@syed.domain.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20200316125006.GA415@syed.domain.name>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 06:20:06PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions to 104-quad-8 counter driver
> for differential encoder status code changes. Mutex lock calls used for
> protection.
>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> ---
> Changes in v5:
>  - Change spin lock calls to mutex lock calls.
>  - Modify the title description.

Looks like the Fixes tags were dropped in these last two patches. I
suppose they aren't really necessary though since these features haven't
yet made it out of the IIO tree, so no need to backport these fixes.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5xhNoACgkQhvpINdm7
VJKOqxAA0HEYpYOE9HFYYHkmUWf9sjCh4Op7o6kpfjdbOABgZ8z28RiGFVReqRDH
PUUd+fa5ytttaczn6NKnwUtdR7ExetwqdCBTKQ2ouY/q9N6nl5cR+DNDphTZz4Ig
Nhdr+M5NrUd0OyUE6SUzz0OlIAl2xE8Z7+bVesPWCdRWPrUwWjy/lhQ6zyCzHnpe
gg+C3YwpoEq0we4Hw8fynbmq/D/uMjOEwLAEe7Tqs2trwvp31hK2+BcCiEA9YfO6
4lntatXjEh9QXL5wnr/sVsLNOMttJ00qiFSUnqFmrUXwB7YwisjAlfwmsVgiIlvD
zAuBqvIwQntWnEUa3tCG/HLQXaPji2lSqyiqdhsx4YnN5kjGdPnGfDFwYvlXOp/T
xRMr6ESopn8UzYQ6ch0p2esCX75RCBgutcM/vvxsZUacOAzcnCiKe/TpzIa/X1Pb
i+NCrqa2B40HKPPoSEWQcOKwGXWCUxNj/1NzTjN95aMOdXCtSq+c4Bv9cPH0AGJh
QvJFaI6tLKSzxhsMeNr8fyvChVEvHf6ESgMfaqLYc3XXfoe4ndswIaDxpq/JVdya
EgDFoBdOpwNvTDOk0ZjjWxNKWRvNCSvpH1I6NQEVTK4v3bDIeToUCoOKwwV3Avp0
f42QA4M6jHxJuS2Edf2vKk+sk3ydw0LO1nAUYAJw50WrUAaf/e4=
=z7tb
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
