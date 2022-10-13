Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9C5FD2A3
	for <lists+linux-iio@lfdr.de>; Thu, 13 Oct 2022 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJMBeL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJMBeI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 21:34:08 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ACE11BD94
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 18:34:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f27so257947qkh.12
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vM1Pq6pizJAQjF6d0WUQMuk01qOUpPCFDdYQ3Ehce8=;
        b=Q6xPY7GHL/VI7cIryPepuHleBoXyhYKfqHP+0RLBPS+dYi3N5bWuqNmXerkiYqttJb
         TJcf5TuL88lhHWKqQuwJ/sXyknbKudYOUP8o98wIJ74T7VD0avn6CfdUKaMfUpo50Xk/
         N7VGAN8Cz+z6CeDiEddWvt5bOYWuMTygxsAOrZ5aDryqTkyiUZYjNNmmeAmHiXAth2+r
         gxBoYlMoAQy7t8DpJZvo9STlbla2q3ASS2DJNfedcOW2+OD1lbcmka0OrnOR3dbB65sQ
         qnnxMmBGLAUeUNAlNQr1KtSi+f5JNtV8X//Jr9uevbBK7VeE1nNwEfjnehOqJXtAU44B
         YF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vM1Pq6pizJAQjF6d0WUQMuk01qOUpPCFDdYQ3Ehce8=;
        b=5Cn0HgAhmrATk8D62HhJ7g3c9das6gEdpMDLkJV6P/QADwf1quOh7Cq/2VOYEMJg/t
         2uxhopphFxisJU79MkZ058KmyY9f2Ehzak23yW8iggcWe4jn6ku4QP2Hv2AKwboPysfv
         SDN1N8qFQtcJLZnT/2oQubO/nG4qmMhORsWN3iUlfG0oDPRyBbJyLCISON+QKoD0YAcI
         HQhqI0y2xcuyZ3vUv/e6fZiwYEMkEuQdhEEyNvXfA3PFvIc9ut8IwT2PqLCkuOqC3zpX
         rhJ0dWsnqaqZ1100YxWwDlBTUZk2LZGTQOwSQj+gnzMmCGX98ICuYXdOhR2HrBqUaGIq
         I6Fw==
X-Gm-Message-State: ACrzQf1IVNswGvOpKGz028hUZwFtMi6f8j/AbdIwis4A0IqTgVJblQQP
        KyIT8J5BlwaSwuPnqAOrDvgBLIhpEQMZVg==
X-Google-Smtp-Source: AMsMyM67fxRbKy5Iqz/XDJ/snoBSe3gb3BinrTx9cGx95Is05iVJ3Iq6kgCkFlziWy1piJYcQ5iamw==
X-Received: by 2002:a05:622a:546:b0:393:7334:65de with SMTP id m6-20020a05622a054600b00393733465demr26217697qtx.504.1665620371659;
        Wed, 12 Oct 2022 17:19:31 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8068b000000b0039853b7b771sm10371672qth.80.2022.10.12.17.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 17:19:30 -0700 (PDT)
Date:   Wed, 12 Oct 2022 20:19:28 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Message-ID: <Y0dZkOAGlVGKup1v@fedora>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
 <Y0DUQTMd2TpFTnZS@fedora>
 <OS0PR01MB5922B6980F38873D494B3937865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y0VsWdrpoAhM2jK3@fedora>
 <OS0PR01MB592280D15AF243C0A5FA93CD86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3/itvaV4N/gk6Vxb"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592280D15AF243C0A5FA93CD86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--3/itvaV4N/gk6Vxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2022 at 03:50:38PM +0000, Biju Das wrote:
> > To support the phase mode selection, implement a Counter device
> > extension for that specific purpose. You can use DEFINE_COUNTER_ENUM()
> > and COUNTER_COMP_DEVICE_ENUM() to create a device extension that will
> > allow users to toggle between "16-bit" and "32-bit" phase modes. If
> > you need help with these macros, just let me know.
>=20
> Yes please, that will be helpful.=20
>=20
> Cheers,
> Biju

It'll look something like this::

    static const char *const rz_mtu3_phase_counting_modes[] =3D {
            "16-bit",
            "32-bit",
    };
   =20
    static int rz_mtu3_phase_counting_mode_get(struct counter_device *count=
er,
                                               u32 *phase_counting_mode);
    static int rz_mtu3_phase_counting_mode_set(struct counter_device *count=
er,
                                               u32 phase_counting_mode);
   =20
    static DEFINE_COUNTER_ENUM(rz_mtu3_phase_counting_mode_enum,
                               rz_mtu3_phase_counting_modes);
   =20
    static struct counter_comp rz_mtu3_device_ext[] =3D {
            COUNTER_COMP_DEVICE_ENUM("phase_counting_mode",
                                     rz_mtu3_phase_counting_mode_get,
                                     rz_mtu3_phase_counting_mode_set,
                                     rz_mtu3_phase_counting_mode_enum),
    };

Using the get/set callbacks, you can get/set the index for the
respective mode of your rz_mtu3_phase_counting_modes array.

In rz_mtu3_cnt_probe() you could set the counter_device ext member to
rz_mtu3_device_ext. This will make the extensions appear in the sysfs
tree for your Counter device. You should also add a new entry in
Documentation/ABI/testing/sysfs-bus-counter to document this new sysfs
file.

William Breathitt Gray

--3/itvaV4N/gk6Vxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY0dZkAAKCRC1SFbKvhIj
K4uhAQDXAEzRAPEwNp+jKPEWWJSkCu8qqQuaCmZCDGbWt6gncQD/ch8PskJWzhpX
tH6RCE5eVgu+jT6nmyWSwBxJOq61YQ8=
=cpQc
-----END PGP SIGNATURE-----

--3/itvaV4N/gk6Vxb--
