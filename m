Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EAF600690
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 08:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJQGGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 02:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJQGGY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 02:06:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB164F189
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 23:06:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b18so12675302ljr.13
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 23:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T6rC1Bs+g6z4yLbUAxwDiGEZVOmHj/xMjWYFW7eK18=;
        b=TjcZ4EFVG1oNwX8YeCS5x5r32gSnFOjZN7JW/UBq4zMxQUhycqoGdQ11sTpYVPliZr
         Ok2Q9ly7fYZceJp1bJG8+sr5fC2H9BPZhZWGDwlllATdmXfMscr/Qt4eH3AYXKzHVlk9
         m2i/FJfpFAgpCWI1ErInTYEO8rwjlqbDU4gR3GCIrR/RIGl3Cu7fXQgQPZZZYZOZEDM6
         DzI1BlMs84vpPJlbr48CesMgs37E4lYxEU3Ij/TXIQHlAragTfqLltAXVtamfQwf5Q7N
         f+OAXzEdYthGtuDYeuA2S7aQr1M/mQfXOlPGxUITU7R4dlKOND7SDlGs7Jnns4MVKYCB
         2RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5T6rC1Bs+g6z4yLbUAxwDiGEZVOmHj/xMjWYFW7eK18=;
        b=HTmelKwAZVC8jCCwiO5SnMqOWWQIdlxSaejLfpD8PE0uCcF5sgGuD777ut41jgCWJ0
         f21idZndzCXB/Z8UZFh50xca+ASEdmeH5Fhl4ZUOpqCWAn0mbPORlVSKu0PqgNsK6Fss
         Br1Gxve5OsmdXqDRA2dQEPsO9v5Rk2+WR19bbmbCtRYsNjLntx6iff8fL8Go+edU7BDH
         +SzbKUTMbOKQ0ouNyAc5A+bbxfA+Drd5pnVMOVxdNOGBBtgf5t5R2PA7xOkVZWxFNnJS
         ubu87QZNx0yKRJjVbRZG0QCDT4T/62jFoJhXvUy4rSfl+jHfwaczcMDo6ABvX/rmbBAw
         uNIg==
X-Gm-Message-State: ACrzQf2DeBrPdzHhUEHqMQSdwjOrPrdbKnU76hGfew+YWIvjmhdMctsB
        9/Nwxi+U9Okz3l7fliGJeRo=
X-Google-Smtp-Source: AMsMyM6VNUQkAzHKlVbyEMuW02SexN0OwrvROSWEvJdOM5abJbARHlGIDo9LP9l641+xq8JqNdPomA==
X-Received: by 2002:a2e:9801:0:b0:25e:45ed:edc5 with SMTP id a1-20020a2e9801000000b0025e45ededc5mr3222581ljj.467.1665986781518;
        Sun, 16 Oct 2022 23:06:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b004a22599c4ddsm1291402lfr.268.2022.10.16.23.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 23:06:20 -0700 (PDT)
Message-ID: <18305a55-d7c6-eced-adaa-f1142532ec60@gmail.com>
Date:   Mon, 17 Oct 2022 09:06:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 11/14] iio: light: noa1305: Use
 devm_regulator_get_enable()
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
 <20221016163409.320197-12-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016163409.320197-12-jic23@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NE7EY0qPisTrDIMaKV6973M0"
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
--------------NE7EY0qPisTrDIMaKV6973M0
Content-Type: multipart/mixed; boundary="------------yTZ0JEIz1PsxVQ6xThun8qPS";
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
Message-ID: <18305a55-d7c6-eced-adaa-f1142532ec60@gmail.com>
Subject: Re: [PATCH 11/14] iio: light: noa1305: Use
 devm_regulator_get_enable()
References: <20221016163409.320197-1-jic23@kernel.org>
 <20221016163409.320197-12-jic23@kernel.org>
In-Reply-To: <20221016163409.320197-12-jic23@kernel.org>

--------------yTZ0JEIz1PsxVQ6xThun8qPS
Content-Type: multipart/mixed; boundary="------------bj3Go10po64BdKI0EKgjtQ10"

--------------bj3Go10po64BdKI0EKgjtQ10
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvMTYvMjIgMTk6MzQsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IEZyb206IEpv
bmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gDQo+IFRo
aXMgZHJpdmVyIG9ubHkgdHVybnMgdGhlIHBvd2VyIG9uIGF0IHByb2JlIGFuZCBvZmYgdmlh
IGEgY3VzdG9tDQo+IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIGNhbGxiYWNrLiBUaGUg
bmV3IGRldm1fcmVndWxhdG9yX2dldF9lbmFibGUoKQ0KPiByZXBsYWNlcyB0aGlzIGJvaWxl
cnBsYXRlIGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxK
b25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IENjOiBNYXJ0eW4gV2VsY2ggPG1hcnR5
bi53ZWxjaEBjb2xsYWJvcmEuY29tPg0KDQpSZXZpZXdlZC1ieTogTWF0dGkgVmFpdHRpbmVu
IDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9paW8v
bGlnaHQvbm9hMTMwNS5jIHwgMjYgKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gDQot
LSANCk1hdHRpIFZhaXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNl
bWljb25kdWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJs
eSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
--------------bj3Go10po64BdKI0EKgjtQ10
Content-Type: application/pgp-keys; name="OpenPGP_0x40497F0C4693EF47.asc"
Content-Disposition: attachment; filename="OpenPGP_0x40497F0C4693EF47.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
bJdDT4nPrGpMQWvFLTScS7sTfKC8lx6/+/w=3D
=3DfJFG
-----END PGP PUBLIC KEY BLOCK-----

--------------bj3Go10po64BdKI0EKgjtQ10--

--------------yTZ0JEIz1PsxVQ6xThun8qPS--

--------------NE7EY0qPisTrDIMaKV6973M0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNM8NwFAwAAAAAACgkQeFA3/03aocXh
4gf/SJWFp9y8IqA5kF7Dqut2oGsK7EnZCAbQfKCazVlv3qJz8k/4GkPY0OLrpjIQooFQcJj3GO5v
V7HOKnKeCW+cLUK+coDqwcvu2+z4hK5+jsA74DWRHAjwyZUKTA/WKZVfGQfYVAoRv3/EGsCHI8zE
s1Qt71wzzNLRiFs7RHQyjl3sZ6O4IY30ZWq6ioaRtlDY4ZyiomXx7Y1hrhNRuRBsm5a4ZnK5kz4p
gn1tjUV8bxIvh2UmZ5lGijHKX+b9BOTHE14z/KK1kh5VRi9CRdGbkWev5JJIhDhdhirkZD9VYxiY
7XzSWEIDVCSuQBHLCyKcjuyz+muEJX4mw23krklenQ==
=r0Kl
-----END PGP SIGNATURE-----

--------------NE7EY0qPisTrDIMaKV6973M0--
