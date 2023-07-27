Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7451F7655F6
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 16:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjG0O26 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jul 2023 10:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjG0O24 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2023 10:28:56 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881602D56
        for <linux-iio@vger.kernel.org>; Thu, 27 Jul 2023 07:28:52 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-486453928a4so403304e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Jul 2023 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690468131; x=1691072931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YC7SY/+bNunb7hgJZCzTcmNXxqMMEhbQF6xRKuKDNpw=;
        b=ZacN3JOxZQux+J+m5sF+n2TETtwlCk755+CC461ARtVyy7JZczhgMj6DBa8h2ynElW
         PQlT37UW89S/5WfB5+RsgomeM1TeErPtq510yhfDzwmiCqwKU2RgUjauvhzV0/KQZn97
         k+X8HNy8mcwu0J7LNa268TYEZN+A7OBDARuZ87T0vnfNj9KqyPso0NPvMADjbgtJChTI
         0NFTIQjSxenk7Dd26U4ny9j3KwXyeRCvboTqkO2VfWRwdw/r5vZEXuf32HDK5BHqxkye
         oYcqhMqHjN+7PCFFZ/P0h6bimfOPI5s7wBVIPIMUIZPcEvPudNG5bKmkbUi/l91ACdUT
         Cjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468131; x=1691072931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC7SY/+bNunb7hgJZCzTcmNXxqMMEhbQF6xRKuKDNpw=;
        b=QEoYJ4v6qVzrEUDQgnex25z6ErMQ1mHk9hu/z9etn4H91YcGG+qYLu8wKqpXPzUG2z
         Sh4zcYeCWvOyWQLDC8uhRko5cpMgcyG7roMqc+mfmW5ocAmz3NIpK3fnk7IgE1c2dgbL
         x8XqFE8/NZtSVy13pcZEPewQVDji4A8Z2jNsQDLhE03mKIxVUTYqbInCeKOsUfnLCVSG
         CSgrNS+g6X8kyi++3TJ83jXrg2lBD1BpSUxaFNSs/VwtbH9F1W3xcuivS6zOoOekb9wf
         6M5A5W/yn+2nHOAiiRJxUbWVSr/fZYnaEOtGz7xDDOjUG9vUZNNOVvNKQz7cyqmVLbwK
         HiDw==
X-Gm-Message-State: ABy/qLZOuUq2R4QxUudQlubK00PKJcvU+njH+piQEWWB+8tSvM363NX7
        o9gvM6wt6Mr5qEJUe9rB5KmE8srT98uiJTmhc7F8ZA==
X-Google-Smtp-Source: APBJJlGlI6fOTKslVHoebjSJJi2OoMt6X2OGoqQHHH4TcWdKra0BlzdXqCTvdkwM+Px4Dr1KGF26pQ==
X-Received: by 2002:a1f:4985:0:b0:47e:8a9:478c with SMTP id w127-20020a1f4985000000b0047e08a9478cmr1291481vka.16.1690468131542;
        Thu, 27 Jul 2023 07:28:51 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id e4-20020ac5c984000000b00483e3d330ccsm231367vkm.22.2023.07.27.07.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:28:50 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:28:48 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] iio: addac: stx104: Add 8254 Counter/Timer
 support
Message-ID: <ZMJ/INNf6/QuPEWo@fedora>
References: <cover.1689878150.git.william.gray@linaro.org>
 <c73869c2b26db05303902f80ca86316b155c4832.1689878150.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ipNoh1Dp7smmM10"
Content-Disposition: inline
In-Reply-To: <c73869c2b26db05303902f80ca86316b155c4832.1689878150.git.william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0ipNoh1Dp7smmM10
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 02:49:44PM -0400, William Breathitt Gray wrote:
> The STX104 features an 8254 Counter/Timer chip providing three
> counter/timers which can be used for frequency measurement, frequency
> output, pulse width modulation, pulse width measurement, event count,
> etc. The STX104 provides a register bank selection to bank select
> between the 8254 Bank and the Indexed Register Array Bank; the Indexed
> Register Array is not utilized by this driver, so the 8254 Bank is
> selected unconditionally.
>=20
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Apologies Jonathan, I forgot to add you to the address list when I sent
this patchset. If you would like me to resend it again to you, just let
me know.

William Breathitt Gray

--0ipNoh1Dp7smmM10
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZMJ/IAAKCRC1SFbKvhIj
K4CjAQDCDv+EPWCIvfvuWN+0W5AQ/F8cDITZTFB1k0Jqy5wFiwD/dWrL1Y38fbUi
7OJU7kfST2YfGdABMarQlTZzviYwigU=
=u6KE
-----END PGP SIGNATURE-----

--0ipNoh1Dp7smmM10--
