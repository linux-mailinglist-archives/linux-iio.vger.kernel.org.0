Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046BA77A29A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjHLUk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHLUk2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 16:40:28 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE12100
        for <linux-iio@vger.kernel.org>; Sat, 12 Aug 2023 13:40:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso3038701276.3
        for <linux-iio@vger.kernel.org>; Sat, 12 Aug 2023 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691872830; x=1692477630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd5MvNncZ2kNwClMx/zXWF5lNfRwjacKaiYxgN8VXks=;
        b=RYpinmAxS//Bh+jVdiYRpi6azE6mjTL+duw6SpfeEYxugTKwxDvBjHuEgJnuhqqKI3
         YaUKR/XxJWXAuI7abeBkNAPasGQRqXEOCxWUjXw8RQQtpIgOlw0Efimtb76Pg3Yxj353
         r+sY4ATp1QN9wJEJ8vr6bMTHJqFewRdZD8dqx19bSpo6mYJl97xLESUKbQCe7xc/N/iV
         3g8cwmHyXZp4ExOg5Zmsy+OglsMSReNhz402i0gdxq0mYxbTSJE3KZkwhdROqPlIep7o
         mHXtNlscklWXh9JGseImcboz/3hay1kC0DNDzt5FNzVLTr4kMjV1QA/4XYYth2o2U2sy
         3xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691872830; x=1692477630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd5MvNncZ2kNwClMx/zXWF5lNfRwjacKaiYxgN8VXks=;
        b=Aq3lDV+jB/ezmXaTQkJKCbcLx1lRXA3m5/VZHfHUm0Fb2Mjep5pirjY0vrPApgJfTz
         GB6nB/scOlzgIts0gWdDVHC71LlOz4m8B0RsLATN+gJUkybixrAbp8556I/wBLuA0MQ2
         psFy84LGuDs+00WDrYe0ZsbYJ2LBXIj+oQcc0l+WUVMRKZez9AhMcwVwPS/vhjEZuQLN
         7g4Ki6GzeYRxor+dFjLuA05DO+BWH5XO+9OerNSwaZvW/ucR2g3xVS9GOva6vOmB/Nfz
         TKDAwEmt3AVcWyyvCEjUNrSV6Fd8Duc8rpgetn0h2y1jgggb4vDUJ9x3PknAklbGAqkc
         wh/A==
X-Gm-Message-State: AOJu0Yy7Xbpms/RMcAO7uCKE5EHSe7N7Ks0jqzJ1XHMdhzzIMa5+RolF
        yJuIgTUmGL1YcNohX5DILu+RADtc10LW31sLAt2hTA==
X-Google-Smtp-Source: AGHT+IF5cFusxqanXw81oUhW0wSJHOShxqJ3gpQ7O92z9q6bsfmS+eIxcyHZS/dFF0V1h8vMTNYJf/S9Ct75+/iQAFE=
X-Received: by 2002:a25:5091:0:b0:d16:bdcf:943d with SMTP id
 e139-20020a255091000000b00d16bdcf943dmr5774172ybb.6.1691872830701; Sat, 12
 Aug 2023 13:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
 <20230811-iio-spacex-lsm6ds0-v1-1-e953a440170d@linaro.org>
 <ZNYIaagdt7HuRet5@lore-rh-laptop> <CACRpkdYHMyfvAGxgvtB8jgTsOp36Lm4gXzVYcBfXdY7RQK36cQ@mail.gmail.com>
 <ZNdOOuXy7vON/Shb@lore-rh-laptop>
In-Reply-To: <ZNdOOuXy7vON/Shb@lore-rh-laptop>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 22:40:19 +0200
Message-ID: <CACRpkdYUnpb4oo+4pBxhQqbnquDP_+w3ecGoFX18TTC9BSZFwg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 11:17=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:

> > > looking at the ISM330DHCX datasheet, the temperature sensor ODR is ju=
st 52Hz,
> > > while values in 0x0A register are used only for FIFO decimation, they=
 are not
> > > values you can configure the sensor e.g. for read_one_shot().

BTW looked at this and the read_one_shot() call uses
register 0x20/0x21 as appropriate.

> > >
> > > > +                             .odr_avl[0] =3D {  26000, 0x02 },
> > > > +                             .odr_avl[1] =3D {  52000, 0x03 },
> > > > +                             .odr_len =3D 2,
> >
> > I look at page 44, paragraph 9.6 about bits 4-5:
> >
> > ODR_T_BATCH_[1:0]
> > Selects batch data rate (write frequency in FIFO) for temperature data
> > (00: Temperature not batched in FIFO (default);
> > 01: 1.6 Hz;
> > 10: 12.5 Hz;
> > 11: 52 Hz)
>
> AFAIR the batch register is used to sub-sample sensor data before queuein=
g them
> into the FIFO (please check st_lsm6dsx_set_fifo_odr()), but it does not r=
efer
> to the configured sensor ODR.
> Looking at the device application-note [0], the temperature sensor ODR de=
pends
> on the accel/gyro one:
>
> - temperature sensor ODR =3D=3D accel sensor ODR if accel ODR is < 52Hz a=
nd the
>   gyro is in power-down
> - temperature sensor ODR =3D 52Hz if accel ODR > 52Hz or if the gyro is n=
ot in
>   power-down

We handle the TEMP along with the EXT channels in
st_lsm6dsx_set_odr() which actually makes sure to match
the data rate of the accelerometer.

It looks as nobody cared to look into the issue with the
gyroscope though :/ It feels like a whole separate issue,
I expect more channels to be affected by that...

Yours,
Linus Walleij
