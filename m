Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198A6B674B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCLOqR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLOqQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 10:46:16 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9048E0F
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 07:46:15 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y3so6770103qvn.4
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678632374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYG7M7YJgMEZJpIizOnrdds/M5Q1j/tkCQGL+vBZq5Q=;
        b=iEbs3HBcKiZuW/k2TT5XtbFXNphCJm965xQNTo1W4xmh2SC9+azBjmLll8hfgLNVbr
         dqdCw2DIwLmTCXYERZaxr5t+PQrj2KRLyqmvZBxnyi4UYkSan6qySCd+idI/iNRqp6Oy
         iJQEV4UQZnSusqfaFdio4NtJ+xZmIusmk0oZmagYVfrrz95JAI8tecEERYkvk+mqIT6m
         qaPuowD2uTSN0C7SPAdPu/B+kLnA2DKNokYjver2EkXofZX7bEFdGfcWFNX4ohV1jV7n
         tBWcKxkKCRFzMPv6fwdLCQqsJfTpoibvcLCDYqRxZkzsQZZ8f88MYSsjvycf9n8ZRydB
         /g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678632374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYG7M7YJgMEZJpIizOnrdds/M5Q1j/tkCQGL+vBZq5Q=;
        b=7nernq8SxLcz6J8lCvs/YevXsK+BwcPN5iQZoYL+FMnm52OqN/pG07qdgK/51VjQcd
         2HocsugujqeAIbBlSzvOpvKT0oHAJ5NkJBqX9p31R616HLOQQs5I/MQF1nDt4UHiaCG+
         /VBYVkNX33YKfFyNxPL0M3vASwRFXDge+xuzpfCDrPRh9fwpHNXHGQkyP7OeAttxz8hX
         YJHNIF8Le4LU6I15E/pMnQ5TLgRKEa1vqzZxgxwCLWRV5B4IGwcmmD9lJkcmZUjuMy0H
         P7V3/YrBL2UrZXv1B0xiVctGeBAyGrE6Ijci4whOFrBDOXsSO7JM6iqtFwddxZyx13x3
         AXxA==
X-Gm-Message-State: AO0yUKUnZBrDEAOpZPbfuM1OWWvHPpOgeB7ptTRB1gm00cvvtMGmFWNc
        I0jkLGKQR8ldhuocJpN0fHjEriZk/KBBg3KMMfw=
X-Google-Smtp-Source: AK7set+UTCxHE2wDd5YitNCfX7f6jps7DA3iwW2yw3qbtSqVa8qvK1bcqNe+Agsexnr5r/gFd1rQxg==
X-Received: by 2002:a05:6214:130f:b0:56e:b7a1:c9e with SMTP id pn15-20020a056214130f00b0056eb7a10c9emr8591023qvb.15.1678632374054;
        Sun, 12 Mar 2023 07:46:14 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 128-20020a370686000000b007457bc9a047sm540236qkg.50.2023.03.12.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 07:46:13 -0700 (PDT)
Date:   Sun, 12 Mar 2023 10:46:10 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Fix race condition between FLAG and
 CNTR reads
Message-ID: <ZA3lskGRFrrIHN4P@fedora>
References: <20230312135625.125312-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YpzQS5GLLAJ/k7iC"
Content-Disposition: inline
In-Reply-To: <20230312135625.125312-1-william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--YpzQS5GLLAJ/k7iC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 12, 2023 at 09:56:25AM -0400, William Breathitt Gray wrote:
> The Counter (CNTR) register is 24 bits wide, but we can have an
> effective 25-bit count value by setting bit 24 to the XOR of the Borrow
> flag and Carry flag. The flags can be read from the FLAG register, but a
> race condition exists: the Borrow flag and Carry flag are instantaneous
> and could change by the time the count value is read from the CNTR
> register.
>=20
> Since the race condition could result in an incorrect 25-bit count
> value, remove support for 25-bit count values from this driver;
> hard-coded maximum count values are replaced by a LS7267_CNTR_MAX define
> for consistency and clarity.
>=20
> Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface =
support")

This bug was actually present when the 104-quad-8 driver was introduced
to the IIO subsystem back in commit 28e5d3bb0325 ("iio: 104-quad-8: Add
IIO support for the ACCES 104-QUAD-8"), so perhaps the Fixes tag should
reference that commit instead.

William Breathitt Gray

--YpzQS5GLLAJ/k7iC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZA3lsgAKCRC1SFbKvhIj
Kz58AQC+lGsFvHBWt0J5NE51cNzlmNgjndnKvoH6dr3Drfuu7AEA6lrzui912AtA
jGT3ZLYoABFCOXwMzxiIbYHTTwwM+gc=
=MUgB
-----END PGP SIGNATURE-----

--YpzQS5GLLAJ/k7iC--
