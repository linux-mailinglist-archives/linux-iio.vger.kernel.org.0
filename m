Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760A94C3D73
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 05:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiBYEyJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Feb 2022 23:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiBYEyJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2022 23:54:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E86208337
        for <linux-iio@vger.kernel.org>; Thu, 24 Feb 2022 20:53:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ay5so991637plb.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Feb 2022 20:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=xsQ2teubfmSdYnaA0XlJ0OZNOwUUjNt9R8CbXtgJ2mo=;
        b=MedPA85G2Nc2lQJV21uPG8C9mPOeDa/KZqfLR4X0CdnYPW/cRmsLdqnARa5X4h356P
         q4rbmDsZnG+Ih2f5aKSffisN5r+ofTqRAWD1JAAEu3sFNzKX9egAUhCsi4a2WLfuU+Hm
         euz/yCJwPZ25OKJcfR1/YJ5KjJji2pwK9NxfCpuEjpRuDFYMmGP3wOyxQQSbsKLFmTqo
         9TL58maWBhbn3CFpun5p72iPB+nTI351KA/oOENF1+fgyADKOOPfLdN3ji2g28UtI7Pn
         F+aCnxynhtfWAmaRbhtdvJdJSQueqZSNhMNyyMgYF+tPoCk66Gg4pk8rth5k3Es0my6f
         GJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=xsQ2teubfmSdYnaA0XlJ0OZNOwUUjNt9R8CbXtgJ2mo=;
        b=tBsOxMgP5KAe91G9QAYikBRnjkstQnHGEuIaDP7J7HVYCiOMn8dwGBmZLmIviGz+bH
         MXO6OIApdqBhjb4QsjGpSl4w4lhgk86AcsoN10YXTgMqFAzsuRZlyKx82b+ZYIFt7c8W
         2iW8pLoYRxGAwGxBq60a7AQRfKfDwHfNVhMxJ/4voks+VtZ2n3bVDIOjQtLEvkNkNFQm
         dNfWGkWzX2xatlJp5Zl9mwLAbsMwztaPGvwZHpYD4K3J5XcPe64jEBuy/SYfi70LCSe9
         PoSJm2uiNTvDKuEgyIGPIq6npixpR793JI622DsXtAdcW5BntfMSvHlk8DblByQTJFy0
         Xx8A==
X-Gm-Message-State: AOAM531PzWpnu+zzo6Pk8EgnjHIfIG3GMoWFS4hbyg8zQP86XISLLOAJ
        8hQj/UYnAnpzqhAvoeB4Cs/dyffaYLzVIw==
X-Google-Smtp-Source: ABdhPJylriebjEcbadQVpIczV2+Qv9m5eONws0LsULPItv9OrR3zaUyNTKz4/L6i9TzQnYinoJnI3g==
X-Received: by 2002:a17:902:cec3:b0:14f:f2e3:df52 with SMTP id d3-20020a170902cec300b0014ff2e3df52mr5555636plg.64.1645764814311;
        Thu, 24 Feb 2022 20:53:34 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id f18-20020a056a001ad200b004bf321765dfsm1212905pfv.95.2022.02.24.20.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 20:53:33 -0800 (PST)
Date:   Fri, 25 Feb 2022 13:53:30 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of Counter fixes for the 5.17 cycle.
Message-ID: <Yhhgyt1kb3MoXkp5@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fu1yABsjvtfJsss/"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Fu1yABsjvtfJsss/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  https://gitlab.com/vilhelmgray/counter.git tags/counter-fixes-for-5.17a

for you to fetch changes up to 4a14311a3b935b62b33e665a97ecaaf2f078228a:

  counter: Stop using dev_get_drvdata() to get the counter device (2022-02-=
25 13:36:12 +0900)

----------------------------------------------------------------
First set of Counter fixes for the 5.17 cycle.

counter-sysfs:
 - Fix null pointer dereference when handling sysfs attributes

----------------------------------------------------------------
Uwe Kleine-K=C3=B6nig (1):
      counter: Stop using dev_get_drvdata() to get the counter device

 drivers/counter/counter-sysfs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--Fu1yABsjvtfJsss/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmIYYMkACgkQhvpINdm7
VJLpjw//ZjHIOFU7nxMRp5c/nDMz846810/EXprZJBLy5UCeiO1kilNzJnXYQXwf
IGZSs5hk0Vg8o140tI89ZJ187izmi7Xc9+4Nyat2/KtaMeAfmj+56eZ5luwU5M9l
KuGb3mMLdiWN5LwngPNk7bStr4v2SqxgPLFQUBP93iCCqk/2gnvVjFBA8kYNl2Vi
9y+iruaFR92Qy/bS+p08kSahIoW5vkuufOYSP3O3kiHRqqWyiJC6TweWCFuwsmKU
sCBQamAyYF61v3LzFqwqvsXIMVap9i7ECwpbMluuXj1xb6UYlmxu9zIgcNEDGP9Q
nYbQQpnTWPCsYa0Ss/CfqJsum2ZRlgkKiZQmZ7yubaf5GsQ0S9mGQ+4eUcRoetp2
QzOwok9HQrYSu9NEtUcfFVwYh0eFTDm0qWflZMG67wsFPA8cQU0djpRZTlcxq4jq
iy8jgkTmVknurDW+/uuBhvUo442MDoujuDbWoQGELAh7UzNJ5KL2OAQYO4pwapma
euR2is50+qxyys4Lg3/knIhIT4BPGIsDZMzpKEc9nWJsUUa5J8rikSFlGyQLX3ls
rzT8VwGxtyacpiCsfeL4wxnxvn8j05HxvCQrD7x45FH9Mb/AlwozboBOtzVzXIjZ
e3BOagRIKrq/UmuZmT2j/5ZuBCwmOSljyJ2MXreXEz7Jc6N2WZI=
=qWeb
-----END PGP SIGNATURE-----

--Fu1yABsjvtfJsss/--
