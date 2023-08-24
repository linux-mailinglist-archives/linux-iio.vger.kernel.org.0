Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F3786A04
	for <lists+linux-iio@lfdr.de>; Thu, 24 Aug 2023 10:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjHXI23 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Aug 2023 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbjHXI2R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Aug 2023 04:28:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBC61724
        for <linux-iio@vger.kernel.org>; Thu, 24 Aug 2023 01:28:13 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d74a012e613so914986276.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Aug 2023 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865692; x=1693470492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbZXlWH/Q8bA4cToPPyHa9lAxPs+6lFe41wEh4sK6+0=;
        b=iKKLOa0OUqZ1LzpDD+ScrT4Th9qCkgBZFRNJS0/RII9YsFohgA0t0kRvQYzymnLb6q
         2uF85DyKkq1nolQ2ETjmW0f8HHfn3yUzTB5Dp5UHWyYFDaH763af5MjF0bVKzLS/469Q
         3DRwrgOFeHZh+4PN7Nt1Nx3veKlqDxWbWPuSZ0t749Tqcke28N681eiHBat1vDsPo2IR
         5P+h5fPfKicAo+217IRJMQGeLr6yWm9wCJKFZeLp2Ppbqx3lIONbgBS/B183WJEgSzw2
         b1Gu7A50vZE6GfRzHob/Trs8847N0cRMv39prMWca7R1SdbAKa3/styl5zVE3bJfgNb1
         bOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865692; x=1693470492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbZXlWH/Q8bA4cToPPyHa9lAxPs+6lFe41wEh4sK6+0=;
        b=lpO7MIMhNRw58alqcoGT96qkJm9ri71Eze3kyPC8TuK1srgpm8Q76TNIDx5bYZCR4r
         7okCpeHGC5IXjWQeIl/kqO8q2YYwgB6+pEQ9Y2OwUJ3jlzfoOQKa9PWMOlGwNxqBTEOe
         JSP8M6cfNLDf2/6KddCoZpjKedX+xeY3osP0WSlRwHOG6tpdjBMnPL83PUcxtctkmVoV
         hNKItU4Fe3WZjUeU5mLNakXVB3lq7lg6riYIOYFWx4jLek3xvJNQMSJMu/MYeZfAhEG/
         PzxPlwPA9k21gtUUc92QEz3Q/YGlKRgcH0N5ajQyXZzfnQAWsaQ6QAu+Co6A6skASJfI
         hu6A==
X-Gm-Message-State: AOJu0Yw/bQpuemVjMPsx53ryMLVk9rdVP6jhmxMuAbayXq4GF5j+m/S/
        4bL2R7ifENnynbWyFluYRB9l0KWZgMSbGvLD5Ii95Q==
X-Google-Smtp-Source: AGHT+IFnYBgOH3uh/7jigYtlvGxAMhdpG1BC4qh447vUsVFSIeY66UJQGPLeMpB8FS952XQurSxGo7Zbf6ByXBF8WwU=
X-Received: by 2002:a05:6902:566:b0:d0f:dc7d:ff19 with SMTP id
 a6-20020a056902056600b00d0fdc7dff19mr14603489ybt.9.1692865692347; Thu, 24 Aug
 2023 01:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZn3MePSohFU7AzVtzdaKW=edsw14Y42xbScXNBVZDOjA@mail.gmail.com>
 <20230824073933.80-1-bavishimithil@gmail.com> <CACRpkdYOpz7gDQsM+tgxj7sjKzv8FtehEsjezD8_bpDk-F_b=A@mail.gmail.com>
In-Reply-To: <CACRpkdYOpz7gDQsM+tgxj7sjKzv8FtehEsjezD8_bpDk-F_b=A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Aug 2023 10:28:01 +0200
Message-ID: <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
To:     Mighty <bavishimithil@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 24, 2023 at 10:24=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> This should definitely be reflected in the scale attribute for the
> raw channel instead,

Actually both IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_OFFSET
as it looks.

I usually use tools/iio/iio_generic_buffer.c to test the result after
applied scale and offset as it takes those into account.

Yours,
Linus Walleij
