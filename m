Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B537D5FDC1B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Oct 2022 16:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJMOJV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Oct 2022 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJMOJU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2022 10:09:20 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA974E182
        for <linux-iio@vger.kernel.org>; Thu, 13 Oct 2022 07:09:20 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1321a1e94b3so2444282fac.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Oct 2022 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UrpocBWYkTC7PfXFYdMnjMZDwWMdGbupQiQC/ayeSR8=;
        b=foAkrtJRaTPssxN2ki6HTIxEo37+mP1UEVmjrRGIue19xGEM7AQeZbvoE0s/p4RaQY
         NERN+pmYWKhH7kIsuxuqzhLT/hFEyZfCnkBc4u9NfgYnNHKwvaj16F5NMgew+Iaiwfao
         9gJf2mxgIF33zB6pmuey1zV+PMKOLVsw+57Cv7RGvMZlvNaGAI1ZjG2xUE8l11WNVs3Q
         XRXJ25yQoPeHX+j21izAr86IdeFBCrLA+w0IL6bE4Ts+KyKxybOFGylZ9nJwgMLWwlln
         CiWqHICmA2bAfW5l8bo/mlwojTqYXL9iIvF8HjK4PeDA33kieVd1eVwId/Eh0wcKv1y1
         ADJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrpocBWYkTC7PfXFYdMnjMZDwWMdGbupQiQC/ayeSR8=;
        b=IMN32opKPJ5tDeVpxq5EdSSGea+7dBS0maXtwUKdLL1ateKmBEyqJRGaV0FtnPVhK+
         fhhU3ghIc0Rz9zT+pL6Ldba+BG/BRPGbbzYY5djl3NdmHaW7llwjwDkDO5hiJlhpjv6L
         VD1BrpX4RBeA/TQCnp5nfJkVaO7QSES1tA9h5JAj1AHF5N9bHqgribR3PpGcZYAEfjGY
         wT/yKMSi1eX6im00jL4PLkKIcLuEFxz+lqjpfPWXmKb/g9Xk2kTReStFKS5bhKD3BYDC
         KqcmrjuavNKl9Zzc4RNiHZXoQgheMM6Jryrx1CJE/xTWpHXP0SrfCjbHmW61rdbzRVNU
         2ZqA==
X-Gm-Message-State: ACrzQf2ztbesD7qr89Mx8hwvALxeJTV8Q0vCPtxdgar5B35831haDpv0
        SGDc8pP4+v/s6d41ybzVEon/6w==
X-Google-Smtp-Source: AMsMyM599AohzqrOP8fG4E4v1ld3sGzIF2kltgBMOKQ0Ba6vq/KSRrCeX+MD8fgB/kAmrUAoehQcBg==
X-Received: by 2002:a05:6871:b06:b0:136:c445:82d0 with SMTP id fq6-20020a0568710b0600b00136c44582d0mr5531125oab.146.1665670159242;
        Thu, 13 Oct 2022 07:09:19 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u127-20020a4a5785000000b0047f72b6988fsm2091450ooa.45.2022.10.13.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 07:09:18 -0700 (PDT)
Date:   Wed, 12 Oct 2022 20:50:38 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: ti-ecap-capture: fix IS_ERR() vs NULL check
Message-ID: <Y0dg3nsRgJHnPbmt@fedora>
References: <Y0bUbZvfDJHBG9C6@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0xEguAtRZ42fF1HY"
Content-Disposition: inline
In-Reply-To: <Y0bUbZvfDJHBG9C6@kili>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0xEguAtRZ42fF1HY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2022 at 05:51:25PM +0300, Dan Carpenter wrote:
> The devm_counter_alloc() function returns NULL on error.  It doesn't
> return error pointers.
>=20
> Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support fo=
r ECAP")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Queued for counter-fixes.

Thank you,

William Breathitt Gray

--0xEguAtRZ42fF1HY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY0dg3gAKCRC1SFbKvhIj
Kw0yAP9G9K47RgJhiv6YlKAXlmvGOn+VhqTYBos/vT7HCFwlxgD/Q11klnu6M4sJ
cgZIrW08boKJd03vabfGZuS2ETk+QQU=
=GqHK
-----END PGP SIGNATURE-----

--0xEguAtRZ42fF1HY--
