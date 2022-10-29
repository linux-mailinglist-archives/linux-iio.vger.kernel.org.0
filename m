Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4CA612617
	for <lists+linux-iio@lfdr.de>; Sun, 30 Oct 2022 00:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ2WC4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2WCz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 18:02:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB072C656;
        Sat, 29 Oct 2022 15:02:54 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFC21660231A;
        Sat, 29 Oct 2022 23:02:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667080972;
        bh=34xyCO5Alo2glnzXKm3onPMsgcEoOJdeiM8/2fgcEbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uk+C9Wq4RQZR9ak3Evg9c2Fv7UHDHSK9JFFdLIgwcUblgosBx2Pz3A1RBJTuF0jC1
         fbYHcCiJ4pQfWRKp0scaAVNG06w3Np5QvsY4MIMBnGh+F5CLc3cLjexa84NQAzD/Zm
         mB7Htet0hr95fwHWlV8qnHZGuVjqt1DPoA+mtoWoqomm9Cp6nDH5y89IVcviFk6U+G
         +q5aYcRDnq4NdAeZNo6a3+RqDi9lskkf5YvhqCrO3EW896Iv44u4zsROiRC+Gs249b
         p3MsPpvOn66e5qbF8aStXFwKRnCUkm9NoD0Pd19jLlHs/udrrVJ/F9aklZ3rQa+Zy6
         pG8rzQzWHcdIw==
Received: by mercury (Postfix, from userid 1000)
        id 373041066A63; Sun, 30 Oct 2022 00:02:50 +0200 (CEST)
Date:   Sun, 30 Oct 2022 00:02:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 0/8] Add support for mp2733 battery charger
Message-ID: <20221029220250.pybesx2w4hslkrcp@mercury.elektranox.org>
References: <20221029093000.45451-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnqkut6gjfzafbxh"
Content-Disposition: inline
In-Reply-To: <20221029093000.45451-1-sravanhome@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--tnqkut6gjfzafbxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Oct 29, 2022 at 11:29:52AM +0200, Saravanan Sekar wrote:
> add support for mp2733 Battery charger control driver for
> Monolithic Power System's MP2733 chipset.

I suppose you do not actually want to get this merged concidering
you did not carry over the Acked-by you got in v4? :)

-- Sebastian

--tnqkut6gjfzafbxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNdowYACgkQ2O7X88g7
+ppCuA/9EaUr3RIT3rZlRyeSq64bqT5OX6cD2aCfAz0t6X4UnShTGVeXTHY2ROxX
ChF3GmKE6V7VDbNUyWisgVAXVk0Sxv/qIDHJKLy9H07BGRw61jfYU/LTNrup/1rU
8e6HbmKBbr6s+Bp4G2uTTCS2YmcFtd13CoKu+jr+of67o74eI16iuHpb1+LS7nIC
Qo6nRUf/BbrG6NDRNFLKkrFRSXJ0OupS9ScjB2M0uwSL7ShHHXz98BNt54EsVsvF
LVdAB/jNdpHGpoE3sGeLWACHBbudNRrbFo1FGf/lCC5ck0lHeaF+sz6oe1AkU2So
QWsWnvsngqcZi2I3DqnAjIvrVMQFxUr74/nGylcyqb+5B3J7ugqeO8RmXbKXtD/N
L7EexVF4ijjJ+pA+XEIFfrOzBAveOrqj5FCb0zOcFtKO4NRl9w6mzZi8dTByZ4nm
g8shb2qH/B+uLEEdoyIhAcpO7q2pK4rWG+mdnJZmMz8qwr3W/n/N1mO3I9AOr8q8
p5EYXi1nxFrNU88HSxbP/IwCRaVsrI0+vdzqvZ+KisI2jNDkZN9zhNyz9m9e/+5f
Xdq97NX0qQtyMLK5uTD2cVR3ULhWf0AxyI5p4p4sjx1uyFMADoJ0LGP4tRUwUl2m
7Y2g3HIFCHjrPqnVxvNs52TfHILISS/Ogug/8x6/yoC7KfK+RI4=
=FNRE
-----END PGP SIGNATURE-----

--tnqkut6gjfzafbxh--
