Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3496F6D3980
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 19:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDBRkz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBRky (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 13:40:54 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519EFCC17
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 10:40:52 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5445009c26bso511622557b3.8
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680457251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJpTsvE1EuL9/USYXCTsI8NfHm4n9LB4JRYujq1u5b8=;
        b=lIOyUIFZXVU085qpGi3Cz3gY+GJ4NrjN6YPjm6oq9gCAThs3IG45H1VZy/xisolQfc
         /QqAJZNvEe3cUufI8ec4AwifJnVvZ8pDglYS1mo23C6tTMmNfSCllM5T0816UtUmM74j
         cnjvM6NZonAR3oyQbksvqoLs1BxXtrS1iA3yX8/G7QO12wfsWjOyj/KWyl613R6RqS+P
         Afwmo0+nQaOh/iPDwMfPJiYhe1dDQxU9UVqcgYxKSUKsUfqwfjSUHzJ7zwm5ywnhLmtR
         6R6sBCxkQ4IHzkxFtGQBjeh6H/CFw6liaiKutHmqw2l5sPvBc1KE2UFDhElGBnfnPZfS
         +YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680457251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJpTsvE1EuL9/USYXCTsI8NfHm4n9LB4JRYujq1u5b8=;
        b=N+e+tjPHyEg0zya3wdT8TJiTm9vuVjnRSceRfc/3+y9k53HfQk74kD8cGhSJwWKvEW
         /1HpA4aD6Hdkv31ohjem5BnQj5n3LY6SapSGj6vJo9uH641uVAIWjt0Nz0f91RuIwC8F
         slrsIjPe5KbV77gq5FeGWdCbrnPghQHTop7jG/eg7+iVlL9SxhuQnjPWIO4qwccC9mbd
         LJMAgudaU169VHaumVZtHeKswGakUy5gb7LsKYa5HtPr+ONOccCoZY+Wv0G7o1nAG1CW
         88Cl5ueDsJrVfh4DJwUAXyxhHs84X/R+ofW9sd6CkoHfGrZSsztIFTAq3kTxAkBCTodq
         Qkyw==
X-Gm-Message-State: AAQBX9cyuTTPMvGR8xX1FfIvzAUtp2zvzg67DG8kVoBE6EZYrKl0qf9a
        mbCevfynU5dTHabxmx8h2VcH8w==
X-Google-Smtp-Source: AKy350Y9pn+fv4dLQtkOD+UCspvVtT89Yf/yzkAotSwBDV23/Hua3fUCMEQ6UFKWB+IuHM+KmJqstQ==
X-Received: by 2002:a0d:d505:0:b0:541:7193:e136 with SMTP id x5-20020a0dd505000000b005417193e136mr31935308ywd.23.1680457251476;
        Sun, 02 Apr 2023 10:40:51 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q65-20020a819944000000b0054601a8399csm2017755ywg.119.2023.04.02.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 10:40:50 -0700 (PDT)
Date:   Sun, 2 Apr 2023 10:51:19 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <ZCmWZyEOnfknvSLg@fedora>
References: <cover.1679867815.git.william.gray@linaro.org>
 <4ebc1b6b609a086846420954b893e914fd395384.1679867815.git.william.gray@linaro.org>
 <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
 <ZCg6bhkxGKmkMloM@fedora>
 <20230402174657.55159879@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yEXAaY2iei/+iClt"
Content-Disposition: inline
In-Reply-To: <20230402174657.55159879@jic23-huawei>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--yEXAaY2iei/+iClt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2023 at 05:46:57PM +0100, Jonathan Cameron wrote:
>=20
> > > > +	.wr_table =3D &aio_ctl_wr_table,
> > > > +	.rd_table =3D &aio_ctl_rd_table,
> > > > +	.volatile_table =3D &aio_ctl_volatile_table,
> > > > +	.cache_type =3D REGCACHE_FLAT,
> > > > +}; =20
> > >=20
> > > Do we need regmap lock? =20
> >=20
> > I think the regmap lock is opt-out, so I don't think we need to set an
> > custom lock callback for the regmaps in this driver.
> >=20
> > Jonathan, do read_raw() and write_raw() require explicit locking?
>=20
> The don't provide their own locking.  Depending on the access pattern the
> underlying bus locking may be sufficient.  If you have read modify write
> cycles though you'll want locking at the appropriate level for that
> which might well be at the level of regmap.
>=20
> Jonathan

If read_raw() can be called concurrently multiple times then we risk
changing the ADC channel while the analog-to-digital conversion is in
progress, thus resulting in an incorrect reported value. Looks like
we'll need an explicit lock for this after all, so I'll create a
precursor patch addressing that.

William Breathitt Gray

--yEXAaY2iei/+iClt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCmWZwAKCRC1SFbKvhIj
KwOXAQCxIk2C5V1TsQ/IO+hSQKNUJQofrl9yPD5Cj7Hqhm8krAD+LwqxOaNPKZ86
T4S/v73bD/2MaFkSBaC1sEQcyfSBqA4=
=jsa1
-----END PGP SIGNATURE-----

--yEXAaY2iei/+iClt--
