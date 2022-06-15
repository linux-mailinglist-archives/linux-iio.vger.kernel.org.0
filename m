Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1080154D3F6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 23:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbiFOVv4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiFOVvz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 17:51:55 -0400
Received: from sonic313-21.consmr.mail.ir2.yahoo.com (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DD396B0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655329913; bh=OvKII6Uk0re5YY5y2WnJ1yZwdpm0drUoa+3WGs3hoVY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cHj2+rEiusGbH4F84GUO6xM0T/2xZtcVKQT7TFo6FOfaXqV0f4hrmF9jQmMm2TiI2Ghq3v79eiD7ZPSwjAhi737nACaBrD6lKT4Azkji0V0XT2Xww7ErMbUWKa5HDGc4+7PEv4BJlspJR0LgpSY5mZwDvZjXyuj47pc99hfejQkj+BTsdaAGUpwQVJDqXKKCZZUf1P2GwXKT2SPOGSDDV+Mw+NPwfSP6uQdqOofVWRIxmWBxM17+eafstrJylnn1vf22IN1Jr/8V/YejQjQOaf33oid1C4dp/nJ8m4NGGN61mR70D2eQYOhKSRR9gwzR5w13l83i95d/RFa3ZxVcNQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655329913; bh=xiI4JJGK5+gZhXPvwMX3QFIq1Ry5+B4U0XbPWtllEAf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bPqtFzgmu7tj8dtbr9LFyU9MsecyvOM4VzfNtn6GQDhsHVhjSVx+StTneDmKjOqBcIEnao3gxjoVh2XYYC6MBgixOP4AO4rNHQZiY6lCBpUU4wvlh2GWioq25vubRnZAvnCtfTPtHvClEKURxtqEtuoyHZqiCwEDOMTAon28JEYk+m9RVMuhSILsk2BtoRpzixWTMZDgTsj6GTjo2uCLX1qjhWoxubNjZGzJuoUErXmKEnQxzjjSToVHIsjxjZuf2+kmJ13rfzEDF2c8ttI5DKZWIIoZyXPO+NRGBRbHsD42XJQvxMP2L0x9a6idOArgsP2QWu87/C3Pb8BFxWnNmQ==
X-YMail-OSG: zQ4qT1wVM1lz9zY3HXkrrbBwt3PdWS578FjW5WkBqAvAL4e_EbryNqJEI94q9Vu
 AGSRk90MI9qTnL1PiK5yW7guXHCWOXsFlvCMgDC.skg1DnxeUbBpfvtJ_g3AxpMz54XqfzrBfkzG
 7w_d6HJ7Tv.0ePvBcbmBXsFLsWSJUQeKyckax0tHBY9dZPzlTiU05u8kBfWePiX55CqxPWrv0B_I
 z1eiI0odKNh5y1OG2.4SSPh4O7e89b8xdf2kvXxfGhg3Nsrh6HvHk1YZrVsP.Ev28YmlTAmBGXwL
 L1LGqE19N9dpZ8MgtyTZSHnx907vKktOqJ7MDsxgbZEbfOSZvoXd5Swr7kIdxqemfAEV4WpKFK5a
 r9m2Y6OeY.KS.5aGuqSHe.Yxn.Us1ovAo6Hi9ud0_aJr0s0JkD6RhgXfXUiXry_kgLCewey8kmvR
 e5iuO4atO3zZylLXhcuDHS5G7Z.BYa1NQH0XqqmxA6C5ITpAGoBCrHIqhBGAfe62rcGqRzuWXctt
 m4J5j1vvzqP9Pbkfcqpbo6cfBWN_epEix2YRXV_dSRQ8V97Hatwe.cSNTgHiDBJ2z8CPBjRdUwYC
 1LlLHty3cY1oNwq8nUHADaYvrNlR5tSN0mqhnSLSkLsTjekzTLII4x5PBPbfZl8xjE7qBZEH9IWG
 15y3Pphi8a3r112Ht9ao891cEkywGMfV5MuFrEdz5QeoJxA0.GoMrJf_9t4.2i0P_G2p51IEW669
 yZgDLmfkGHA4IIljIseiI4ahiDqeSZFnFxCqWvQ5f7XrAzIaD75lqx0LITf6T9zEG6j2mKm0r0N_
 UX3WRu4JNKkNEZqnjMRe2Hzdu_8eruyhvaXa5hYpqr.NWfZstJC0UhCkYSm7v6Cs7auL1XkALctt
 CEv7Job1ZGlLnxyVPDMoQY6Pa6__Gw.H22D96xQ_ySNxK.XEi2wbUygmGHafgrByNRoQBIxJvlij
 tIxcuoyU7dXGsgfC2sb19XCwpvylkSWS2oVuEC6qlrhMNrGCrsuRFl7Xisi.ZVw_EPVALVZPBgMo
 MMgM0bPj2GwwG5AAlTqCCqMZ_6rlD4_btD6SoR9cbCP8NicMrsQb_F30HzT6to7d3Ri_0GfYnhAi
 uSBkapwoKjX3Sec9qxf7fZRSPC98DemBSZ4V9lvGbVHBEYXotwPidCnA0kV5rX0.ntNHWpR5C_dm
 jov_p4GaNm46az554z0zuIh1X01xmrKgwaH.zUfNZs7VP47FxnQVPSFbz2EpKm9cgxGkmaQZsvPn
 SI.x3t07Ez.YueJIhmR_kw9I5eUUQp6j.TtC4BT0EDdS3A_kPbUmx9I5osIlhlSZjTAA42NkjJTZ
 YYujArJWVBDnp6lemEpAFU5Xsaq1o9pAKrO9Hg_hFKDzovnVRyHYZ4eO72XY8Oe24qgJQEB6326x
 GKW_hglq5fT9qPs06kINDJndfBKmG.pmav1q7lBcyaDcE8ktitJooACECtRnzEmsl5x173C4kUkC
 iTRYVSJjGgGNt1fxTBQnai_qYvE1JlNqrIn63vKAurhIaIwt9t9O7Zm7ltSL1DwRp7KyTiIvrPjL
 jVhGyMwnFKaZeBQkkJTJ.6qGxuB9DZl83K6747Ue4YLS0PtM04H.4oXIC35oSMXJGODDABxZeYym
 hsboq7cmq1jsF.22sqWYaH.DZYjOYycFoiqI2Gw6X_wuRtLnljEJPYvhXtSVKvXXJ4JiNdvpYBUI
 Wiqg0yrVQXTp0Jd32pnuUZr2P9Ua1KUK63dF7mEv2tSZ72XF3jfMoibugUWaQGoDRBRTNPERHFaf
 kExZxx7k8leQk.fpKWQOIAu3Todlsq0zLAzHenvxg8jLC8Fh_hPwRXChMIqFXTlQt6yZmYq0mQg7
 _JJzA05MGYUQIGez7JT83wU.cfX47YvkiBpKzwlCoPIlimFCqhW4PnLKRtRiEqEe1OCLX9mp2ZQK
 AOc7Ft3jwNShMVxmu9umvqq0HGAtmCjydfT2.2LUBtu2UtxBYSWKuATmBATWIW4AhYr6wheJ3etu
 EBccrEJYWyHzDonMRAm1R1kfjC0q0bvPmLgWvwBYixxXLrKrGTFVeZO5JRKNIhkxe15.JakIsgBQ
 QPJCCivEVNUztU8U5CvKOdhy1Smhor_0Z.QKlK9w39as98wgU0f84xF0v0oQ2TNjLgb7Hhttum5s
 u9Xn3DB4OWKQv.M4cr1tkNT2zPjwvvw_3f6Jp3YOb5kH3IFOnpE.mf.o6nb7y9QcDi9fcnheu0Es
 z9eoOPKX2xlB3i5vbsPq3tmpuOJsMd2Bly7nSCq2_WyfwIsBGTPMf4V7opfnVqdYYUHB38qe8RlA
 49nNBSvo-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Wed, 15 Jun 2022 21:51:53 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-bp5rh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fd5a26b29e75a180b9849f9eb58f58f2;
          Wed, 15 Jun 2022 21:51:50 +0000 (UTC)
Message-ID: <1c2405ac-98bf-f094-a015-76a7badab101@rocketmail.com>
Date:   Wed, 15 Jun 2022 23:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 7/7] iio: magnetometer: yas530: Add YAS537 variant
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655081082.git.jahau@rocketmail.com>
 <b6e100de37921c22ebf0698f8e0e99794053303a.1655081082.git.jahau@rocketmail.com>
 <CAHp75VfFwSQ6bk=TMLiyA1j-AsafjGdVFbTTHJJ67C8zeYfz8Q@mail.gmail.com>
 <CAHp75Ve3ydACAQnHR0rgPHEU9kSLYj-t6dU96gxDLPWKfnmP0g@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75Ve3ydACAQnHR0rgPHEU9kSLYj-t6dU96gxDLPWKfnmP0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 13.06.22 17:22, Andy Shevchenko wrote:
>
> Forgot to add that please try to split even more preparatory patches.
> For example, you may convert existing code to stubs / switch-cases /
> etc and in the last patch just add the new case or new function /
> branch.

That's a good idea. I had a closer look. But I can't spot something that
could be beneficial.

The new functions for YAS537 are similar in structure like their
counterparts of YAS530/YAS532. However, in detail they differ too much,
which hinders merging them into each other.

yas537_measure() being different to yas530_532_measure():
 - regmap_write() has an additional bit YAS5XX_MEASURE_CONT
 - regmap_read_poll_timeout() differs in the read location
 - calculating the values t, x, y1 and y2 are different

yas537_get_measure() being different to yas530_532_get_measure():
 - no linearization
 - no temperature compensation
 - different way of calculating x, y, z from x, y1, y2

yas537_get_calibration_data() being different to
yas530.../yas532_get_calibration_data():
 - one regmap_bulk_read() only
 - different way of getting or extracting the calibration data

yas537_power_on()
 - different procedure and registers

The function yas537_dump_calibration() shares a notable part with
yas530_532_dump_calibration() after the changes applied in patchset v2.
Although merging them together would need some "if" or "switch"
statements because YAS537 version 0 needs to be excluded from that
function and YAS537 version 1 would need to be excluded from the first
and last part of that function. I would leave it like it is, it's easier
readable.

Another approach could be to outsource some parts, which are used by all
variants, into separate functions. But again I don't see much beneficial
pars here.

In yas537_measure() and yas530_532_measure() it could be:
 - regmap_bulk_read()

In yas537_get_calibration_data() and
yas530.../yas532_get_calibration_data() it could be:
 - add_device_randomness()

I think that's it. Both are too small for being worth outsourcing into a
separate function.

Kind regards,
Jakob
