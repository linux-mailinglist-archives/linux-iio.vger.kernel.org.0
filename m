Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F077CA1D5
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjJPIkJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 04:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPIkI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 04:40:08 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA8E3
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 01:40:06 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7fb84f6ceso50577097b3.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697445606; x=1698050406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIcV/eoNsTgvVRSx24uewUH2oAnDhtvzsUFfFeqBsMI=;
        b=ecYdBBZDrY+6oM87gO4OVus+ETittYgVAw/vFWbo/gMxbwY/lZtRx1LLitY5M8sags
         HdcrhL6LOp+FY236x4gzUHxvNyUC+VXEviPN48mZwGr78oeeW5p+vDKa0u/Osx0++pGe
         3wSTD13P7BQ0Bw3QRkpQGRXV0DPHAgJdpdhnOgl0dyNk4h4T8ESjK2osuet7o6SyFb9I
         HdbJqw0xb/AHTFgWcozODfCT9/47QT7tf6R9fdz4rTE/RdlpT1GDVn2OUFu+oJw1C+Xi
         C7FZGXosYwRF0B7cVbVJXFqWoEMk5JVEozAySvGbyWL82utRIa+AJjQlENgYlgqpiv2a
         pMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445606; x=1698050406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIcV/eoNsTgvVRSx24uewUH2oAnDhtvzsUFfFeqBsMI=;
        b=GsNfu+/ojTjl3/mI8mr/B8udtT7b4/NsfVJAP6hp65rCaatthIsg9nyc4jtFBZRiTY
         89uWXFBDSqG1X1hqa1obZHXMF1tVN0z3wgcjxJuLQqU7NjVCMXqW43cPeiUTEqw/aFSL
         qeINB7mCx1o+sLk+cwC+dZIejujBTpi8H8YHNcXHtedyNo6lW1c+9gpsFU0qC32QLjyj
         h3tcFcQc9fuPHe7Z/pVU/L7UtLTJmZ0+77GM5SqGDrKXq/dxDZNM+R8l/VUDK1TZaqUO
         JyihcXR/kRcFC5Zg1d2hE19iDB+zukEWCgooc/ElbAMl94bljgqWEmkZg1LlAV+JIvyM
         +3Ig==
X-Gm-Message-State: AOJu0YzVWmI4tumnLyii4Uzsd70WKeyfJhjDaJaHHhblYsRaPzQN1mOO
        itp4IPZAelpASYVbhuVR3P3IB+8BfCB47afKVKYz0w==
X-Google-Smtp-Source: AGHT+IGPJr87eMFmI1i3oRCinwLMFY+me3S3qU7EKniAaWqf0R1cQvmPOQ8X9KHGb5ETNwBiVndq3pGsgbkianQsTjU=
X-Received: by 2002:a81:b40c:0:b0:592:2a17:9d88 with SMTP id
 h12-20020a81b40c000000b005922a179d88mr36930507ywi.47.1697445606104; Mon, 16
 Oct 2023 01:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org> <a0a55276-297b-e2b7-79b3-e4aadd39b400@axentia.se>
In-Reply-To: <a0a55276-297b-e2b7-79b3-e4aadd39b400@axentia.se>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Oct 2023 10:39:54 +0200
Message-ID: <CACRpkdaMj2XFcwqaSiRSA2A41zYsW=AG_Fi7v7AjbuLBByxVaQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: afe: rescale: Accept only offset channels
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 15, 2023 at 12:38=E2=80=AFAM Peter Rosin <peda@axentia.se> wrot=
e:
> 2023-09-02 at 21:46, Linus Walleij wrote:

> >       if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
> > -         iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> > -             dev_info(dev, "using raw+scale source channel\n");
> > +         (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
> > +          iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
> > +             dev_info(dev, "using raw+scale/offset source channel\n");
>
> If the rules really are that when not provided scale is 1 and offset 0
> (reasonable of course) then the above still looks suspect to me. Should
> this part not simply be
>
>         if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW)) {
>                 dev_info(dev, "using raw source channel\n");
>
> in that case?

The patch is based on Jonathan's comment that while we currently
support raw+scale, having just raw+offset provided is a possibility.

The if()-clause above (which I guess you are commenting) is meant
as "take this path if scale or offset or both are provided".

Just raw (with neither offset or rescale) doesn't make sense, since
the AFE rescaler does just offsetting and rescaling, in that case the
user should just use the raw channel. Also it would then take
precedence over a processed channel (which applies rescale and
offset internally) which doesn't make sense to me.

> Or was "raw + processed" some kind of special case that we want to handle
> as processed? If that's the case then we need to have more complex logic.

Processed is on the else-path, which will be tried only when neither
scale nor offset is provided:

>       } else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
>               dev_info(dev, "using processed channel\n");
>               rescale->chan_processed =3D true;

I'm not sure I fully understood the remark, please elaborate if I got it wr=
ong!

Yours,
Linus Walleij
