Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB1600640
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 07:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJQF1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 01:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJQF1l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 01:27:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E021537D2
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:27:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g7so10984383lfv.5
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:from:references:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1FQfL+kSWvNGqyIYGU9AAJXpPIHF/rLVL+xjRE0fmY=;
        b=EPCiZH/GejX2954waRVgOClvpDruFiC4zvCgwyZt+Dt9CtN9qUJIYbYD0gc5I+MGbu
         xX9kvpcnqDku3f9unPshx5ADT72YF4PS7YIcovVAzNVFPIIkW1WpqREryDiV0TRqe/xn
         DB6Uq72Jk3iDjxOomBgpNvVbdroTIlnKX1dKBLnBjtVPBJa099ZNTDtZG9WtV25YjLxM
         UGcqEfq/sXGyIuY/SE5iqysqsFiOgxDUK4iGidAJJHPVsXbO4Hb1e/FYqQx85yawaay2
         Oey6oEoya8kW/MHD9avuokWC63m6KqvfEnhjXcnW9NvLFmd2cd/43MHadFQAvWFYPQAX
         vQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:from:references:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e1FQfL+kSWvNGqyIYGU9AAJXpPIHF/rLVL+xjRE0fmY=;
        b=kmRJWDRn/upQTvlhj38Bs49DSrBbf9taFSdajcI3KBh81dBV9oW68xj3jPQOYqaK7w
         /46NO0FshTRC4lcGit53RPFwZDSe0DVMlomiuAy9Zq7kMHOIGwCFQrPJIcQzLgrmOfDi
         yadhG8VwrMeTSioExXE4jaunoAEtkc/UfPzAOPnWGGFk0IXHT8WRBfBpF0WrUFie65tg
         NzWj3zQJNTpV4eYyRs6Nhl++eeIT4VNrIZ/BnGAnC+Afk7VXijrtmt1POVKsDfvWEp0T
         9bWcYbFc4cXN9Y+WwV7ADYYApCPz4OFvNTZ1Hd6x7fWZjdIOp9/RJrI+BbBybecGAxRN
         NFSQ==
X-Gm-Message-State: ACrzQf0DwjknN1mDDkAkPvNflxNzy28DLENdMG1DIxVOglZB+4M4Fi4Q
        SnP2kHZGfX2ZOQuYvets1b4=
X-Google-Smtp-Source: AMsMyM71qzWhGJdNBrS4BfBcyxUIIeUjozDzpxfaUYeseuJcGxKTIJ0UQwmAxSlJmRjgJeM/3cLX8g==
X-Received: by 2002:ac2:4f02:0:b0:496:d15:ea89 with SMTP id k2-20020ac24f02000000b004960d15ea89mr3178230lfr.69.1665984450887;
        Sun, 16 Oct 2022 22:27:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e9f54000000b0026bca725cd0sm1347205ljk.39.2022.10.16.22.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 22:27:30 -0700 (PDT)
Message-ID: <2dcc9735-ea2d-a796-5ab4-d1928a346908@gmail.com>
Date:   Mon, 17 Oct 2022 08:27:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20221016163409.320197-1-jic23@kernel.org>
 <20221016163409.320197-3-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 02/14] iio: accel: bma400: Use
 devm_regulator_bulk_get_enable()
In-Reply-To: <20221016163409.320197-3-jic23@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gQUraBEhyD0TAyk6hss7bWi4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gQUraBEhyD0TAyk6hss7bWi4
Content-Type: multipart/mixed; boundary="------------aeL7AayE6ztWOoRcvsC7bgtB";
 protected-headers="v1"
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Jagath Jog J <jagathjog1996@gmail.com>, Sean Nyekjaer <sean@geanix.com>,
 Dmitry Rokosov <DDRokosov@sberdevices.ru>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Gwendal Grignou <gwendal@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 Tomasz Duszynski <tduszyns@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <2dcc9735-ea2d-a796-5ab4-d1928a346908@gmail.com>
Subject: Re: [PATCH 02/14] iio: accel: bma400: Use
 devm_regulator_bulk_get_enable()
References: <20221016163409.320197-1-jic23@kernel.org>
 <20221016163409.320197-3-jic23@kernel.org>
In-Reply-To: <20221016163409.320197-3-jic23@kernel.org>

--------------aeL7AayE6ztWOoRcvsC7bgtB
Content-Type: multipart/mixed; boundary="------------05bfGA8ZEnkQaF8sBD9uYVJW"

--------------05bfGA8ZEnkQaF8sBD9uYVJW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvMTYvMjIgMTk6MzMsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IEZyb206IEpv
bmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gDQo+IFRo
aXMgZHJpdmVyIG9ubHkgdHVybnMgdGhlIHBvd2VyIG9uIGF0IHByb2JlIGFuZCBvZmYgdmlh
IGEgY3VzdG9tDQo+IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIGNhbGxiYWNrLiBUaGUg
bmV3DQo+IGRldm1fcmVndWxhdG9yX2J1bGtfZ2V0X2VuYWJsZSgpIHJlcGxhY2VzIHRoaXMg
Ym9pbGVycGxhdGUgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVy
b24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gQ2M6IEphZ2F0aCBKb2cgSiA8
amFnYXRoam9nMTk5NkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBNYXR0aSBWYWl0dGlu
ZW4gPG1henppZXNhY2NvdW50QGdtYWlsLmNvbT4NCg0KLS0gDQpNYXR0aSBWYWl0dGluZW4N
CkxpbnV4IGtlcm5lbCBkZXZlbG9wZXIgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KT3VsdSBG
aW5sYW5kDQoNCn5+IFdoZW4gdGhpbmdzIGdvIHV0dGVybHkgd3JvbmcgdmltIHVzZXJzIGNh
biBhbHdheXMgdHlwZSA6aGVscCEgfn4NCg0K
--------------05bfGA8ZEnkQaF8sBD9uYVJW
Content-Type: application/pgp-keys; name="OpenPGP_0x40497F0C4693EF47.asc"
Content-Disposition: attachment; filename="OpenPGP_0x40497F0C4693EF47.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
bJdDT4nPrGpMQWvFLTScS7sTfKC8lx6/+/w=3D
=3DfJFG
-----END PGP PUBLIC KEY BLOCK-----

--------------05bfGA8ZEnkQaF8sBD9uYVJW--

--------------aeL7AayE6ztWOoRcvsC7bgtB--

--------------gQUraBEhyD0TAyk6hss7bWi4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNM58EFAwAAAAAACgkQeFA3/03aocWi
bggAroWvUg6tqwCXGqJBzO9tjrQO2hvDaB3OiOpXEHS0B1vP14S/gw1PAto3QYe9JheZOy5YE8uw
jf1NQYpn2TpvmRgoezPbevVT6XabUblHZ5dvJPvdUIusSGqkJj3dUxzvNz/WaHM5KASA5tfif6Hn
J2V7vUGkEwvDiVJUVbQBrPkyixmsG901xJKmCEanVujbkUBAzN3RG4YQ7RmT9g0Pea5I4uhxgn0g
Vd01I4+YGVCMOKudWND+hBBOIiuzPfIwvwH7Qh/lj++IYVI9DZpf3t9dbsEMU4W//LNAJZADD5i3
E5aIWWRWC19t+ppugskMdig+UlhOcApzDEonu395oQ==
=aOes
-----END PGP SIGNATURE-----

--------------gQUraBEhyD0TAyk6hss7bWi4--
