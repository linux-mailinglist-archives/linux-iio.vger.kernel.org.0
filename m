Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A23673D10
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jan 2023 16:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjASPGj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Jan 2023 10:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjASPGe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2023 10:06:34 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95F7EFA
        for <linux-iio@vger.kernel.org>; Thu, 19 Jan 2023 07:06:31 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-15f83e0fc63so2778994fac.11
        for <linux-iio@vger.kernel.org>; Thu, 19 Jan 2023 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVjqzLXD5QPwyyUmo7QN3xQRrSsniKZQ8j72Zl2FHQw=;
        b=YiNTNpJPOc3Wmuzb/3Q7pqQvbd2ZzWNfpj1VHR5N6kEfkttYP4/b3o9OJHSC2Zw10c
         qWkVxCuhihmj9mAEBn6X8FAlqN0l1xea8gwUWzIV/fBJrLTzIurLRIXWE8ldLKbTfIzV
         YedwMN7kxJg3rGYKleFEoTZDK4UAkeU4NlE9tDxPLiyQBEOxCR/uth+gnHkZ+F8nwdrI
         nYQab/n7EYjrry107uTxFNbLNsZPGryqq5eoXPeMeq4D2jkDMbNIp+F7LNpZMR3KsbkU
         hhBqNLoBFFRUAJOrl4A1z9VlUkKiF/iCi9YAGxHYeovCRwUTdcYl2CR/G+KnFlXKNJQ3
         X7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVjqzLXD5QPwyyUmo7QN3xQRrSsniKZQ8j72Zl2FHQw=;
        b=pK9SLTFVBI0NBr/HsEUTTlN4szs3odYzeKjRazjqMesC4bzLhKUF6nwV2V/T0rutCE
         s8z+i2/sV5Cec3jKMZc9F3IWGNIqPIWHLE+O4KivnKcO6FC28/bpe67MHc+SqkY1zH1h
         1kHOb3060m7wyAkMSHSju7b6qDJqAdiRzy/bVa0mBkJUYb1GCjMhT9ZB3BcCbb3v/Duq
         q2FmH2WEa/MAwiepqnKrCdbmSjB1pTU7skzMgA3NLmqI/ElOSVvaoOvNZdW8+Dk1I0NA
         ZEq7NVcQZQCo9pK6xrN77SdhUEQxDG3zYB3u0THxVjmChFXmXxhf55cvkflLxxgrzCPm
         u1CA==
X-Gm-Message-State: AFqh2koWrvgUpDbVruPplMwoBKre66TSebRdl6XwiJnEtza96URjCqvK
        omepALYffQ4MyAOPkK0XeaHVFQ==
X-Google-Smtp-Source: AMrXdXucZxz1FDxgj5PVd3AbYAdQyG0hqb56jvZef36HSYU6QkTBEpd/gQuWajjxF8/6y/dyE3gZLg==
X-Received: by 2002:a05:6358:d08a:b0:ed:1bdb:777c with SMTP id jc10-20020a056358d08a00b000ed1bdb777cmr314869rwb.16.1674140790941;
        Thu, 19 Jan 2023 07:06:30 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e124-20020a37b582000000b0070495934152sm23767138qkf.48.2023.01.19.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:06:30 -0800 (PST)
Date:   Thu, 19 Jan 2023 10:06:27 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] drivers: mfd: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y8lcc/Bi82efYsgp@fedora>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-2-okan.sahin@analog.com>
 <Y8eq0GtVZfVdNKYn@smile.fi.intel.com>
 <Y8lTUegNjFZrXh1o@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I2QLmuidwBEKOGja"
Content-Disposition: inline
In-Reply-To: <Y8lTUegNjFZrXh1o@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--I2QLmuidwBEKOGja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2023 at 02:27:29PM +0000, Lee Jones wrote:
> On Wed, 18 Jan 2023, Andy Shevchenko wrote:
>=20
> > On Wed, Jan 18, 2023 at 09:38:08AM +0300, Okan Sahin wrote:
> > > MFD driver for MAX77541/MAX77540 to enable its sub
> > > devices.
> > >=20
> > > The MAX77541 is a multi-function devices. It includes
> > > buck converter and ADC.
> > >=20
> > > The MAX77540 is a high-efficiency buck converter
> > > with two 3A switching phases.
> > >=20
> > > They have same regmap except for ADC part of MAX77541.
> >=20
> > ...
> >=20
> > > +/*
> > > + * Copyright (c) 2022 Analog Devices, Inc.
> >=20
> > Happy New Year!
>=20
> If the code hasn't changed greatly since the Copyright, there is no
> requirement to update the date.

Actually a date isn't necessary at all. In fact, by the Berne Convention
copyright protection exists the moment a work is completed, so you could
even argue a copyright notice is unnecessary and the SPDX line alone is
sufficient. However, I would say there is a practical benefit in a
copyright notice identifying the primary authors to make ownership
clear.

For the curious, this LF blog post gives some reasons about why
copyright notices may be better left simple:
https://www.linuxfoundation.org/blog/blog/copyright-notices-in-open-source-=
software-projects

William Breathitt Gray

--I2QLmuidwBEKOGja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY8lccwAKCRC1SFbKvhIj
K3PUAQCdO9/weT+3alL6hyrXG+ESPtB1UsaqnZ6jvNSPMLYDEgEAgPsVq0EKZ1HR
UXMsXWyhGX8hEq02NozqbFBkbpL29ww=
=nL1A
-----END PGP SIGNATURE-----

--I2QLmuidwBEKOGja--
