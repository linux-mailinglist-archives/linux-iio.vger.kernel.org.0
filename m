Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD2154C7F6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 13:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347318AbiFOLz7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344964AbiFOLz6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 07:55:58 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF36389
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 04:55:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id v12so2019824qvh.9
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MPOz4vgepz2ltUJZ6fEyvEaVgIdF4j+lXzNxdrCQ1W4=;
        b=Kv1/sBXQy+VkaqfjY5/Yt1paxNw4IwE49hKbnnu4UqH8luwltTGeQ6HRlFn9chHIPH
         kj7417kDRfRvsgSOxPDs6mnjM1s+LpvFCf6b0I3EJnWeL5zJR6MHLHHHuJmb2eKtB2uB
         Xm9qMpVab9KKZ0YFri9hts+IWOMdO/3QigWYfzKTK3FyIW6sjLH1qdmKoIDvpqC7KD4p
         nTZSHDsN3ayn6gMT+eSpMRwyyQBYfpOibtwxf3CsiGIxlO5wMOzAkJ8R6yCXT2hyjJSZ
         JiCfhMrB5Qj9RhuIuIYRwoao0q/ktEUFUXwnoC414xL/DL1s4d8olS2trt41pI1wZ3qo
         59bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPOz4vgepz2ltUJZ6fEyvEaVgIdF4j+lXzNxdrCQ1W4=;
        b=CJ9dyLjAbCPEkPwqQi+hEC32BKKUp8XLjE4ZabvocY/kWG688ZsEfHG8KxFCZx2MS3
         OokDWu84xUxV6MnNhKkoM8+AQ99NdJSGP2MqZYCv0+EWOvLzrKQBNUmtCBqRMuigwcgy
         BnVypE5fN9vLru9CvJAzKgF6XfuaCuccP9s7ITS+nsDASS/Ar/QusOfjEGoXae5SNpUX
         vPxILvBnKxBSVXpwhnxXOvSuxjZpMi75RJjnTYhcomvTUGSTGdOYT7CpZq8fD9l6gWKi
         SDGj61FwedwuTljU00ybxDuwU85c8GC9cQChf0BmS6/yzJZDq/baB7UfEkr/N2dc9TLG
         4FDg==
X-Gm-Message-State: AJIora/4rvrOUkWK4UumSPvieWgsAPAbJJHSad6J6VwimpUZawbNFUfN
        urU400iAwMrJF6EojSqPTLF8PwcEZof88g==
X-Google-Smtp-Source: AGRyM1u5vb133j77m9fDqaCMzeSfdNbNW6c5WeARrgXqYyBlVNo2I0dfX5nGQ9k4RhKIsKc74EZvsg==
X-Received: by 2002:a05:6214:1025:b0:46e:5510:e764 with SMTP id k5-20020a056214102500b0046e5510e764mr7551774qvr.78.1655294156742;
        Wed, 15 Jun 2022 04:55:56 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p22-20020ac84616000000b003051f450049sm9393159qtn.8.2022.06.15.04.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:55:56 -0700 (PDT)
Date:   Wed, 15 Jun 2022 07:55:54 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register
 structures
Message-ID: <YqnIygHDSUbV5yws@fedora>
References: <cover.1654118389.git.william.gray@linaro.org>
 <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
 <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LoQy7Axdwa0I3j9u"
Content-Disposition: inline
In-Reply-To: <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LoQy7Axdwa0I3j9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 11:44:54AM +0200, Andy Shevchenko wrote:
> On Mon, Jun 6, 2022 at 4:27 PM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> >
> > Reduce magic numbers and improve code readability by implementing and
> > utilizing named register data structures.
>=20
> Can we consider using regmap APIs instead?
>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

The regmap API may be more appropriate here. I'll investigate and see if
I can convert this over to it.

William Breathitt Gray

--LoQy7Axdwa0I3j9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqnIygAKCRC1SFbKvhIj
KyVdAP9p1cEf2MxISHsQN2H9PTN6/GHta0g18vZLUlDtVJbEIgEA+fO5VJ4K/vgD
0e0CDHy8qRSYdkBhsczHE5v0eC/Vnw8=
=j35z
-----END PGP SIGNATURE-----

--LoQy7Axdwa0I3j9u--
