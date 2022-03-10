Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9497C4D562C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 00:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiCJX6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 18:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbiCJX6F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 18:58:05 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7119F46D
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 15:57:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id u29so6080844qtc.6
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 15:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HOjZdqzwC/7/0iKi3dz81WCoCMObB8PLd9bRBmsUbGk=;
        b=dcpcJP0FyVjLPUcCRt8hJCg66bCWESt/zUMp24oJFB0jzzZVE8wqKbYzF7oDa+2ULy
         MXqhpozQY9k4ujKscPTbsFjM6VF5l0riLtD4Dczh7c+GHEIiJ/oMuPvOTyPSyHhjfjnp
         S2ONQFvnjO17po0uDC+CHL6UmxsdQ18G0HAl8x7Jr2SVz9ULBjwEpprLT3zpqrnZJnBM
         txL7VoQyXdPKPmoKe+Gexiw5/jysty/FemXVvvODMB0am+EGa4afSAyiOpXHSlkpHdMv
         w+MLQUAy9vW58NdOE4TGitf6vOgfwcTM95DUriW3ZxT07u8vzxJf8N4T5wENy7Wz+k2Y
         Y8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HOjZdqzwC/7/0iKi3dz81WCoCMObB8PLd9bRBmsUbGk=;
        b=zNK5YFiH9K8grTPRhzgMsVD+BXMJsBLABvCJOI2Is3attLNya/5YiAaPQDA+sN8Yvr
         C1qnDYxBzWf9JRKimJMg5DHVm05E7UtkSj8kcB8zxYu0njzFUrTWNwBski/ZPAm6TEAr
         PNwWCoLJ8pGxr62Qovn/AVip0titWYRf3tw/JOa+9vOWiJUJeoEbtID2OUvpuCoD50U1
         hemF3jKjrWv8XpylgTsKfkRUJpUtBZKKBOClPzq6p50dtkB97+dR+9epGXgHIgFQdAt9
         H8AZaz1JWf9OhhoQKYeEo24Vflay+uK7U9qiTN/jsXk63g2cAHCJussObWvwn9e3xWEj
         AFEA==
X-Gm-Message-State: AOAM5327rJ//DzDV6R/wxsJXUlUuGwlJtMxDhd5Vzkmz/b9P+LsgRypy
        93z7cDGdZAHaUXp4kuMY9/XezXfulRlVT0eE
X-Google-Smtp-Source: ABdhPJws2sXxxH6B4LryYB7GtOhzRm8utEKn9vSi0F5RxyyFYfUfkWHfQfEXUeApxhO8eaBTIpYkAw==
X-Received: by 2002:ac8:5a89:0:b0:2e1:bc09:8a6b with SMTP id c9-20020ac85a89000000b002e1bc098a6bmr50334qtc.450.1646956622264;
        Thu, 10 Mar 2022 15:57:02 -0800 (PST)
Received: from ishi (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id e14-20020a05622a110e00b002d9d03dfe06sm4286947qty.2.2022.03.10.15.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:57:01 -0800 (PST)
Date:   Thu, 10 Mar 2022 18:56:59 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter updates, cleanups, and features for 5.18
Message-ID: <YiqQS2pAKIfYeUIK@ishi>
References: <YiItE3YONnTILC9Q@ishi>
 <YipxpdPZEK2wpeoc@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lXe/cI3OjUJbnlBW"
Content-Disposition: inline
In-Reply-To: <YipxpdPZEK2wpeoc@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--lXe/cI3OjUJbnlBW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2022 at 10:46:13PM +0100, Greg KH wrote:
> On Fri, Mar 04, 2022 at 10:15:31AM -0500, William Breathitt Gray wrote:
> > The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec=
1ef3:
> >=20
> >   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://gitlab.com/vilhelmgray/counter.git tags/counter-for-5.18a
>=20
> I don't have a gpg key for you, and I really don't trust any
> non-kernel.org git infrastructure at the moment.  Any chance you can get
> a kernel.org account?

Sure, how would I apply for a kernel.org account?

> In the meantime, can you send me these by email?

No problem, I'll send a patch series to you for now.

Thanks,

William Breathitt Gray

>=20
> thanks,
>=20
> greg k-h

--lXe/cI3OjUJbnlBW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEESdocE8T8CMGLP5oTJYqFfHOePQsFAmIqkDsACgkQJYqFfHOe
PQu+ZAf/QHPVOS+4VNlBJo3wa48DK1V7spr7Z8MzOHnhVLEPTpOCdctARU3BD/2v
5SI6SwEZmi4T1EisQZ2B0vfhS4x1gJPflFt2zCBZWMgwg6oOl5J/20cjoMHBuz9Y
ooss2H0RvuY2I9ZbHlD9M+LclTWzntKMpt70IrewmmPZenVhZcdl+l/PgmRGB9cn
Dy1jVxQSYMNKLTPx/2c0ZFXsuQpN4/92QOJMa4McGRQej6RYApmKnuqwJILPvBjV
ayKuZndVnvI9FlvqLUMhogVSBbqIB6PL8mG0czjrpqen7fztUSn3YQZu/EEt8QDy
lrw8D0VZiNXiyXnvC0A/KsYMsuzXug==
=HWWs
-----END PGP SIGNATURE-----

--lXe/cI3OjUJbnlBW--
