Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A77256F1
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2019 19:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfEURoq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 May 2019 13:44:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfEURoq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 May 2019 13:44:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so2259111pgp.11
        for <linux-iio@vger.kernel.org>; Tue, 21 May 2019 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=606JMBHU1WCSkVE8vEh8jp0Vn08O9hluQpv6YSChqEM=;
        b=bQVhsZXwJoS8kkAVFoHwkcLXby5dBYqyoeVKoiXPqgc7fmXn1bh8ym5oYjKC4HS7Tj
         9oCLmvze7JP4BG602rGkjb0Rp6P9Iw+/OkRoeJliB8fgxIRu1qINoBy3cwhjPL+63Tu/
         OU32v+ugrsYpgf4PkCeaVSWXM3XmJt0AC/wLyUKT6tv6vIUzy8XChksFv5QwqetG3l4l
         1t+jCnm+4R2NtxtdGjmnXXwDLUdqNqe6PXgjXqdvyUEcYZBIfbQBwf766rewrwLIWjl8
         b2dhZIJupbfBiYO3AqNNhhnTt8ST4hsQFVj3FO9ObC778Rd86z74h0x9191+G6uv3xka
         uiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=606JMBHU1WCSkVE8vEh8jp0Vn08O9hluQpv6YSChqEM=;
        b=FrlUT5diSFX2UQ9PruVkuMki+ak9RUR8zGRkwocJNUmk+N3FFp08TKmkpwA51an/UB
         mYBzevi+G/xTn4i+tKvIL4bVfVqqy3sUF1b+JMlP+suLDx1Eq9hMy0R3YXp6yJlpJ3TX
         hF601zrl1+6xZVJC1hsA5qdaHkJijyYKqv03MS5bzt6LRLXsMZnazXJs41LoTptlK5d6
         FUS7ShMkh1d14cMg1xT4BGeCLZDzlz3A7op/sxy+52IxxGRC7pyvVe95JWTwep09RPZX
         4iZJUbQZTjklqQ/f8hA8U/EAdQM0+LwTROaPmZD3VIW030MqoUiEX9L2qocxozjrjWb5
         QxJg==
X-Gm-Message-State: APjAAAWZJ57fH7BLd5T3wZliPD23nULt0QR743siCZFP96IDJqJrA6NI
        Mdb6Caj/fKIhesPEZsZV07aU5Q==
X-Google-Smtp-Source: APXvYqx9jmSTOfoHKfChiJWP6QeuV7uyrYxH5QrdJfyQeoHf+pjwRhSwqdCXVT6bvmqUA2iagFvxog==
X-Received: by 2002:a63:5166:: with SMTP id r38mr12376011pgl.429.1558460684705;
        Tue, 21 May 2019 10:44:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id r77sm29853892pgr.93.2019.05.21.10.44.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 10:44:43 -0700 (PDT)
Date:   Tue, 21 May 2019 10:44:38 -0700
From:   Benson Leung <bleung@google.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190521174438.GA2821@google.com>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
 <20190518063949.GY4319@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190518063949.GY4319@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Sat, May 18, 2019 at 07:39:49AM +0100, Lee Jones wrote:
> On Fri, 17 May 2019, Gwendal Grignou wrote:
>=20
> > Lee,
> >=20
> > I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
> > used on chromebook using a squashed version of these patches.
> > (crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
> > respectively)
> > Please let me know if you have any questions.
>=20
> Is no one else from Chromium going to review?
>=20
> These seem like quite important changes.
>=20

I've gone ahead and acked the whole series. Enric and I are OK with this go=
ing
in for 5.3, and as Gwendal mentioned, he's landed these changes into our
production kernels for Chrome OS as well, so this is what we want to sync o=
n.

Let me know if you have any other concerns.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXOQ5BgAKCRBzbaomhzOw
wt8HAP9uU1klLrzkR34L7NbfgwEDQgELzBnyp0zr6eH8FswIUwEAhSZ8hXpksiuJ
cuKw4zj4F0wocqqx1xPt59u73qeMXgM=
=Zm0H
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
