Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C57A6A41
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjISRyY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjISRyX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:54:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3911E92
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:54:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c00df105f8so38299911fa.2
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695146055; x=1695750855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2GDtHiVCjwEBvzvKdSGm+xBFC4ysVV478MpVEvPHcFI=;
        b=TzUE58Yz+JL8dei0hZ2O9qtf+KICk4ma5aN4S9iKCT/MW4iSFTtXHETaU1h2fhcS7d
         pLGU05f7wz3aoHYOnNBcZ3fVAtsa8K9LPzIfYwnJMWfL9LzeAupvTCk02QvLD5k8oEaN
         MIp4lwoWcwtIDKgQd12WBq+Q7mAY9pO6Q+aQVvK4HsCspz57nACUZyJHA/+IQRj5n/tb
         ZAsncVZekkRKp2XtwzxOR7XV4mHMF7xW0J1x7tOtSQrHI0KMMghiHl7T3DIE3tA9gA81
         L5xVt8kIfTlPi+stskw6LOJ0WYGzihK1j2o559dy/zU8lcgw31mjXgyMsXSo52OX7cZ1
         4tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146055; x=1695750855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GDtHiVCjwEBvzvKdSGm+xBFC4ysVV478MpVEvPHcFI=;
        b=cm7pFI8TNOj1w/v+VMb2Nxlm7ob/FBcr9TZeYqtq69o5ZtaVCibx4SEGt0DQWS6p1a
         1Fz8uFeWoi7VbkgVnNo/bsBtrt4CwLYWHTG4GT4F8LPfVyrJTEv7R5ucDUbmvu+DNXvG
         zpWDCWHkYcNE5rdNwhK7kgJG4oRQ9jlomWQBYfgRBIV7QwZArtX2VZZDIdtU56JfWK2T
         DBUPE47XV2r1OXsSo7lGs8GLkN5qI+Zva23vgOOCsbKRglzzM9AsLyu0wIG6xXgHF1wu
         cGFZeY+gLYTWHRav3T1iaTiJd5TZXK8wQcPNS3zso+SLC68bcrCBW+8dcDzhEJ+Ir/b2
         APJQ==
X-Gm-Message-State: AOJu0YwTTAOcz85FpSAr3L2ENGwZl1J8b03i/1bEcLO9/e5itHx9t5N9
        t5sMckh/zAwp1a/nyYk1IE4=
X-Google-Smtp-Source: AGHT+IG9oqUUiKb8aWLMroZ7KGcpd7TZn247SdtnN+t8hvksAwji0iv/4NYecqci3tnTxtfHqv8IEQ==
X-Received: by 2002:a2e:90c2:0:b0:2bb:c22a:f28c with SMTP id o2-20020a2e90c2000000b002bbc22af28cmr120829ljg.32.1695146055051;
        Tue, 19 Sep 2023 10:54:15 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id m21-20020a1709060d9500b00992b71d8f19sm8023709eji.133.2023.09.19.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:54:14 -0700 (PDT)
Message-ID: <e45396906300c06ca8f9200843811ad47144dc55.camel@gmail.com>
Subject: Re: [PATCH 08/49] iio: adc: ep93xx: Convert to platform remove
 callback returning void
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Date:   Tue, 19 Sep 2023 19:54:14 +0200
In-Reply-To: <20230919174931.1417681-9-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
         <20230919174931.1417681-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Uwe,

On Tue, 2023-09-19 at 19:48 +0200, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> =C2=A0drivers/iio/adc/ep93xx_adc.c | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

--=20
Alexander Sverdlin.

