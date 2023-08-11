Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4642F7796EA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 20:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjHKSQi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 14:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjHKSQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 14:16:37 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC230DF
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 11:16:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d682d2d1f0dso166244276.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691777796; x=1692382596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt+F/EP5FQMs1tgLE5TDGHO6m8SZDmx1ojCJ7RwCwy0=;
        b=XQTPBxZgbQCJvzoVTX0kc3YaJI9pbSPDpJzvRPk2UZlKs7sVgi/S1/lJilZGsmgJEj
         hxNyajjBTPULM7S7epsmKuOQR5IBwpqsltmz+IQRkPIQViuljz/TyY3AQMqZ6KpadzPQ
         7MF3tm5HZESBHGPXJ1mJyVNX8VI2Ie67bUDgcwkOYpxWhJ1Wz/h3GPjQcm4iE54sSyts
         hiPjt5wJYEQVpvcoPhVU5QDzCd8xbWieUUZalb2nytTTU4PAI6CzuggVZxzkZd0QrtFO
         f8uqZfe/Ft+xirvQ5yn+hLtgRv9qLZDYEh2uxp9SKZKQcfrZZw3brGhJxfABd7bl6zlm
         d0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691777796; x=1692382596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt+F/EP5FQMs1tgLE5TDGHO6m8SZDmx1ojCJ7RwCwy0=;
        b=gPXioGVfWVW5F7mh7zg8gHtBWkohHiZNFyvlsBcCK0GEDab9ZGH1NHLfxRsEHHRok0
         WEs872Ez1ybVKDFbL+MpXoH/Mr4WKrBLaVaf4xfbcE17EGzy0zvo5cNt/i0s1ypvcler
         hsxNSWNxosJyO8cYPrXErozVmDMR7qGENgC6PoAvsHDQzRL1KyQKe3a6v6d7qfBupgEr
         je4CYGeWNiTozz2LQtVpDarkatfwCpLgGviCk4SPWnct3QueS/YvIAdEvyoFL576yBuE
         58QoaaooGOB2HFsLwARssbJj1wJVDQQ37h65KpMCmvp7B8TbOoWGC9Vs73AfvS8iQwmy
         RT8g==
X-Gm-Message-State: AOJu0YxR0m+zu1H4WE2ZO6bDvjonHg9ph3eCPqHhx8W02wScyxscA6Ff
        1DD6mGfz0Q+oZmCvEGjYO6ZiD2142qAU3CleRJGsFQ==
X-Google-Smtp-Source: AGHT+IHig+y86qd6IkHhevcSlmSXovPNnQW2/MMyW/TZ2oeKyZmekZ4zNfYU0bfUOelDiOuPw2cQ7riVYXhQeLBH43o=
X-Received: by 2002:a25:4252:0:b0:d09:f39b:cecf with SMTP id
 p79-20020a254252000000b00d09f39bcecfmr2478308yba.9.1691777795944; Fri, 11 Aug
 2023 11:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
 <20230811-iio-spacex-lsm6ds0-v1-1-e953a440170d@linaro.org> <ZNYIaagdt7HuRet5@lore-rh-laptop>
In-Reply-To: <ZNYIaagdt7HuRet5@lore-rh-laptop>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 20:16:23 +0200
Message-ID: <CACRpkdYHMyfvAGxgvtB8jgTsOp36Lm4gXzVYcBfXdY7RQK36cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: lsm6dsx: Support temperature channel
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lorenzo!

thanks for the review!

On Fri, Aug 11, 2023 at 12:07=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:

> > +                     [ST_LSM6DSX_ID_TEMP] =3D {
> > +                             .reg =3D {
> > +                                     .addr =3D 0x0A,
> > +                                     .mask =3D GENMASK(5, 4),
> > +                             },
>
> looking at the ISM330DHCX datasheet, the temperature sensor ODR is just 5=
2Hz,
> while values in 0x0A register are used only for FIFO decimation, they are=
 not
> values you can configure the sensor e.g. for read_one_shot().
>
> > +                             .odr_avl[0] =3D {  26000, 0x02 },
> > +                             .odr_avl[1] =3D {  52000, 0x03 },
> > +                             .odr_len =3D 2,

I look at page 44, paragraph 9.6 about bits 4-5:

ODR_T_BATCH_[1:0]
Selects batch data rate (write frequency in FIFO) for temperature data
(00: Temperature not batched in FIFO (default);
01: 1.6 Hz;
10: 12.5 Hz;
11: 52 Hz)

That reads to me that I should actually add the odr for 1.6 and 12.5 Hz
and the above 26 Hz is wrong but the .odr_avl[1] =3D {  52000, 0x03 },
52000 milli-Hz is fine?

Yours,
Linus Walleij
