Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA84602A82
	for <lists+linux-iio@lfdr.de>; Tue, 18 Oct 2022 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJRLr2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Oct 2022 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJRLr1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2022 07:47:27 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5CFBBF05
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2022 04:47:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m6so8405266qkm.4
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2022 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bsd5fpiiECl8GkpGndwni0gwXZ9Ol1u7EJ2OjmdejwQ=;
        b=hIuc7OIiVe9rdm5/L9WY7R+JlPSWaZSeEDydFnhRf9FRUgExwzch/y6yOecvKiX8n7
         CAv3C019YCgSODUbQA4cRt1xw5gavlpTegHTJ0FTtJEceJWG8Ep49ZgrD9ZzkTzuTF7Z
         eKGHvjrJPx3bCAvvhHYUVMEG6qIdHGQxxnFLOufYvhk5IItwLtReKYwraq74/jPz8gsT
         7qSIUh/slGV3VNn7c8RzLPUnN/KmoPdfPVcKvdo89IcAb+HL9Eg+lqQ9DBoFM1q1Q1/e
         4JXv77kPZilR7fgPIPDsdcxPTWkZYUMkVx2v6HZ86pVVNkG9NO9jAjAdBrpqqgPODLQg
         KTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsd5fpiiECl8GkpGndwni0gwXZ9Ol1u7EJ2OjmdejwQ=;
        b=ILUgyrxePOsNf2O64BM2LM9fCQ6okDXiaIIWLStyWZwqrtj3kLWNwVlbboc/gEy9dx
         LIZIx4jE64TxvCDpEGvWeGLtHuy6DK6RtEYhWqxe8ZoOAcAl/OTUV/Z6+fOHmZlTTqJU
         2obVF1nC2S+8TVHfvFsXueZLHMw/9Exk+OIdXNZMizDkh3DjeOcWPwoERqO01Cao39eF
         7mfkgOGqJ8z6rdsnIkRJ7aOCkMC9cf1mt5c935O32uBlOblX71XrcnXnfzPSxzr8bLqq
         RkGNbmhJ78R+9ScMAeZhsytPE7LjlFI8YsvaS2qlBjq8cLTkmux9ferYY9e3sobp6pXE
         Wncg==
X-Gm-Message-State: ACrzQf2O86YfukFtuIh1eQ/1/lXYHoAv3PrAYmfUgWUoyS/Ryyrfm3gu
        HHpHZ738RJWM9G/qLFM+eoRMkA==
X-Google-Smtp-Source: AMsMyM45wI+u8adKJ5m31AvK3ziypY3lkj4vAfPsDp6HG5t06mNyedOqgAWBgW77MigzQbjGU61nPA==
X-Received: by 2002:a05:620a:4385:b0:6ee:7b48:202e with SMTP id a5-20020a05620a438500b006ee7b48202emr1505033qkp.306.1666093643651;
        Tue, 18 Oct 2022 04:47:23 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006b9c9b7db8bsm2292195qkb.82.2022.10.18.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 04:47:22 -0700 (PDT)
Date:   Tue, 18 Oct 2022 07:47:20 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: Handling Signal1 in microchip-tcb-capture
Message-ID: <Y06SSCvh0tCtcKZ9@fedora>
References: <Y0q7Gzh95nFdqdYK@fedora>
 <Y00nidri3TRYARiu@kb-xps>
 <Y01QPkE0E+HR7dat@fedora>
 <Y02Lkpu+NCaPo/ZF@kb-xps>
 <Y03P55QWFkDhtqt7@fedora>
 <Y05dbRPh9jNj61y+@kb-xps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iGMyhWSEA3XDf/Z/"
Content-Disposition: inline
In-Reply-To: <Y05dbRPh9jNj61y+@kb-xps>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--iGMyhWSEA3XDf/Z/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2022 at 10:01:49AM +0200, Kamel Bouhara wrote:
> On Mon, Oct 17, 2022 at 05:57:59PM -0400, William Breathitt Gray wrote:
> > It might be nice to expose the channel 1 revolution value as Count1 at
> > some point in the future. However, channel 1 seems unrelated to the
> > current issue we're dicussing so we can avoid it for now.
>=20
> OK do you suggest to read both count values in the same mchp_tc_count_rea=
d() ?

Yes, you can differentiate between the requested Count by checking
count->id. So for id 0 return the channel 0 value, and for id 1 return
the channel 1 value.

> > By the way, I suspect there are race conditions present in
> > mcho_tc_count_function_write() that could be resolved by adding a lock
> > to the mchp_tc_data structure and acquiring it before accessing the
> > device state and registers. It's unrelated to the Signal1 issues so I
> > haven't looked any further into it, but it's something you might want to
> > investigate to make sure you don't get weird behavior from the driver.
> >
>=20
> You mean between function_write() and action_write() ?

Those are the callbacks that stood out immediately. For example, it's
possible that these functions are called concurrently, resulting in a
race where qdec_mode is initially evaluated as true but changes to false
before action_write() completes; or similarly, the regmap operations in
function_write() could be clobbered by if another call is happening at
the same time.

William Breathitt Gray

--iGMyhWSEA3XDf/Z/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY06SSAAKCRC1SFbKvhIj
K3FeAQDrKsnuKzIaclPrjEvb2n3pl5Mu1nCtW5SuMup7sJBZOQD+JxxoZb2rU91K
2+KOyXv5zK2cXwLZ2A86IvoqhNRBpwE=
=vwhC
-----END PGP SIGNATURE-----

--iGMyhWSEA3XDf/Z/--
