Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CFD5B54EC
	for <lists+linux-iio@lfdr.de>; Mon, 12 Sep 2022 09:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiILHBJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Sep 2022 03:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiILHBG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2022 03:01:06 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB667248E1;
        Mon, 12 Sep 2022 00:01:04 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1279948d93dso20942097fac.10;
        Mon, 12 Sep 2022 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=0XqePnbUiZRUs1aoZwR1nk/QBuAoAA0VQaa7BjnVFKc=;
        b=A6Q5Hv6Il8qOaS54NO2Ry9eBN6HQFkccYnhowINrA1kwFRMRRoOR/cddqU3nRmeg7B
         +Xast8Kr3pNn0JRMSjgQwFsCSWZfarok0cmmZawlRICgVvVhcXqztq6YTYmjQZ/4zUaT
         nHeWcfY/PgpWFIy/2ckCt5phDPezDId+hQjOjmcdhIj/RER4kPsQuUUePSHayNRHwwEO
         /un/F1CPqQ6cP5ns92/66M5fpc+tDI55qOdIJNzk2e9XQtq0/eTC130Q0r+sgOIRuU6t
         BO2NiBN4Ngm41/DMS4bdhdONkwpxuVTz2W9v43Y4QtmSR/GxA5prMFof4vWwOceinU3B
         1Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0XqePnbUiZRUs1aoZwR1nk/QBuAoAA0VQaa7BjnVFKc=;
        b=bDAOumjDwM4UDfzQfCsaoKLrbQ7tzExSV5bJQjp9t5+ZRvXdKDeFjVxTa565NzuTT6
         AocOQgp20wotJQFZl2dOXJPbJqR8+OCrI3zKeRyM1ELwpdO5XiaY6y1r5R15gHmfb7Rq
         xsQSG6gXQoEca9CvKZeB4i8YEoEb0StOUVUKmVCvl2pIYUhNOBa8kqWg45VKzHjs7ppe
         YWm0R2/ImJqIN8WHIWttLRVo5tXgBJebYVVKPRy99YVXlyKWy/ot5n/ISyf4qz7GHeOw
         J/ytZMwfbaaq10YEy3P1zhCLthNOnR5ng/jXcXsIFx1+SayyglHlJYWm28gk1fcQyiE3
         eR0A==
X-Gm-Message-State: ACgBeo0VFL78ssT5bifOF2Ahh1roF+fji0nMOpn90VzPkzNFSxasAeuI
        PfOx6ZvL0RpU8gVORlpXfTA=
X-Google-Smtp-Source: AA6agR5Dfm7ftir3Lu6vuv1Hee8MmOKzMhyPyHFYr6COnsiaPhm+rn/kPOZouXsDMgUjf2AQKpCVBA==
X-Received: by 2002:a05:6808:1156:b0:34d:c734:6a79 with SMTP id u22-20020a056808115600b0034dc7346a79mr5937865oiu.161.1662966062857;
        Mon, 12 Sep 2022 00:01:02 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id e5-20020a056808148500b003432bb4322esm3502490oiw.40.2022.09.12.00.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:01:01 -0700 (PDT)
Message-ID: <a8bcba9c64a6d38a82094aa38a4a7da1b2897fdf.camel@gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: ad7923: fix channel readings for some
 variants
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Date:   Mon, 12 Sep 2022 09:02:16 +0200
In-Reply-To: <20220911122644.4d408fe6@jic23-huawei>
References: <20220909151413.1164754-1-nuno.sa@analog.com>
         <20220909151413.1164754-2-nuno.sa@analog.com>
         <20220911122644.4d408fe6@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2022-09-11 at 12:26 +0100, Jonathan Cameron wrote:
> On Fri, 9 Sep 2022 17:14:11 +0200
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > Some of the supported devices have 4 or 2 LSB trailing bits that
> > should
> > not be taken into account. Hence we need to shift these bits out
> > which
> > fits perfectly on the scan type shift property. This change fixes
> > both
> > raw and buffered reads.
>=20
> Hi Nuno,

Hi Jonathan,

>=20
> Seems that all the values of shift are 12 - realbits.
> If that's the case, can we reduce the noise this patch creates by
> just
> updating AD7923_V_CHAN() to set .shift =3D 12 - (bits) ?
>=20

Yes, it should be pretty much the same... As I don't have any strong
feelings I can do as you suggest.

> I guess that's not as flexible if anyone adds support for a device
> with different shifts, but I suspect that may never happen.
>=20

Or a device with realbits > 12. But yeah, I'm also fairly positive we
won't see that happening...

- Nuno S=C3=A1

