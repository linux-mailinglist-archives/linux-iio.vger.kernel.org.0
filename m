Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D22175FA79
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGXPOH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGXPOG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:14:06 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6992812F
        for <linux-iio@vger.kernel.org>; Mon, 24 Jul 2023 08:14:05 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-440ad406bc8so1074039137.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Jul 2023 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690211644; x=1690816444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4lRIIXoxnH9fOv9qy02QtyQBCC4Ojjyu/sA3w8Qe3g=;
        b=sx4a6I5DnjBZUm5xTFIdZxWFSKGICWEvH7cWJGKW1ISHoZr9CY1KDI+Coru2ysFpcN
         bx4Y6B8kfq7Dkrx4yXnI1+PlmVLQWbuf8V+eDznqxsbvJ4YnCiTYM445RwVDNkhbhjqH
         uvYIw8E4HfI/CpfRTwzg0K8sJ+8qoePBTl9QigVho4GuHAZMT1YX9Po2fwn5sGRKc29y
         8JjuP2ntYSXvlUjfYlpBywBn5cYbNKTUJSQhaQdKSneG1kSH/9uCacu8Lg2YZe+H0jw9
         uMzwWeiNAlJbE3/ghmonFkAw5rB7cuu4I97fADFD4DrVBK56frMWHwKaFYxTvrnpZNIa
         QhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211644; x=1690816444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4lRIIXoxnH9fOv9qy02QtyQBCC4Ojjyu/sA3w8Qe3g=;
        b=IAtpFIpRer/dLUIvfHw5GsnMtfUBsZ5d9xfSREPFyVooqcAdi3E14/hkUyqtVRIq2R
         3UU8Dtd3YG5Oi5fT1U/nPciu9M+0rrGwitx/7hAdlxi2Lzf5WgwT+rt8KlD+u3gTzfeg
         YHPAh/DlFhj9k0s2JYgOfIuZngTZV63z2kW3rSXs46PLIr61SmaY1i+TeSVV3L+6rNgH
         c0FnWsSyUCL7vJuObCgQViodrHLz1mbcUoKhk4gfKNE7W+AnPkZu2tfwTK5YDRZehU4U
         6FGCfWEZQ1YIfW+YSxHmExpTjRIPWJmyu27owutCGA8z0QJWSqM7mWFMStFEJofbTq1o
         wL6w==
X-Gm-Message-State: ABy/qLY7XXKhy/PI7c+PFOGD2ccpwRzKvUc0cSQn82tGXLVGvFQdWaxO
        tMppD/yMGAAUVM0sv549rirMI4tcA0q66FsBY2M=
X-Google-Smtp-Source: APBJJlHd2/WiwhEovY7m/fBFy7oSjGsfh1TVgQuPuWfKNhnaZfeXxJszUgnAw9Bp60eZsHSGxMUIyw==
X-Received: by 2002:a67:e294:0:b0:42c:9d63:47ea with SMTP id g20-20020a67e294000000b0042c9d6347eamr2283428vsf.0.1690211644481;
        Mon, 24 Jul 2023 08:14:04 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id c3-20020a67e003000000b00440aaaf18efsm1521868vsl.19.2023.07.24.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:14:04 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:14:02 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] counter: Declare counter_priv() to be const
Message-ID: <ZL6VOpOcJsgJRKt8@fedora>
References: <20230718162015.3940148-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CaNxl9qSDkjHQNIJ"
Content-Disposition: inline
In-Reply-To: <20230718162015.3940148-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--CaNxl9qSDkjHQNIJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 06:20:15PM +0200, Uwe Kleine-K=F6nig wrote:
> According to the gcc manual functions "whose return value is not
> affected by changes to the observable state of the program and that have
> no observable effects on such state other than to return a value may
> lend themselves to optimizations such as common subexpression
> elimination. Declaring such functions with the 'const' attribute allows
> GCC to avoid emitting some calls in repeated invocations of the function
> with the same argument values."
>=20
> counter_priv() is such a function and so can be marked with the const
> function attribute.
>=20
> The effect for an arm allyesconfig build according to bloat-o-meter (on
> top of v6.5-rc2) is:
>=20
> 	add/remove: 0/1 grow/shrink: 2/14 up/down: 524/-1064 (-540)
> 	Function                                     old     new   delta
> 	rz_mtu3_count_enable_write                   632    1152    +520
> 	stm32_count_enable_write                     372     376      +4
> 	ti_eqep_action_read                          456     452      -4
> 	stm32_lptim_cnt_action_write                 400     392      -8
> 	stm32_lptim_cnt_action_read                  300     288     -12
> 	rz_mtu3_count_write                          296     284     -12
> 	rz_mtu3_count_read                           304     292     -12
> 	rz_mtu3_count_function_read                  212     200     -12
> 	rz_mtu3_count_direction_read                 268     256     -12
> 	rz_mtu3_action_read                          628     616     -12
> 	rz_mtu3_count_function_write                 328     312     -16
> 	ecap_cnt_suspend                             364     340     -24
> 	ecap_cnt_resume                              300     276     -24
> 	rz_mtu3_count_ceiling_write                  596     560     -36
> 	rz_mtu3_count_enable_read                    332     288     -44
> 	rz_mtu3_count_ceiling_read                   384     340     -44
> 	rz_mtu3_initialize_counter                   792       -    -792
> 	Total: Before=3D60715, After=3D60175, chg -0.89%
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Queued for counter-next.

Thanks,

William Breathitt Gray

--CaNxl9qSDkjHQNIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZL6VOgAKCRC1SFbKvhIj
K7SLAP9yHXsnRJKjyHb33mOBUqqfvmlc2/Lcte38ej24HfdwagD/YgbnqtoCU1MD
TVdxJZ2I3wQXmw596vCnTSLpr81Q1w8=
=MDMq
-----END PGP SIGNATURE-----

--CaNxl9qSDkjHQNIJ--
