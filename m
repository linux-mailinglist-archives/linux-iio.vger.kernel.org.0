Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F301393A
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 12:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEDKg4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 May 2019 06:36:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39056 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEDKg4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 May 2019 06:36:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id o39so7522476ota.6;
        Sat, 04 May 2019 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Mah2M/rOQLB9r1W2J9fPI+hW8KuDg9vx6L7LqhtKuY=;
        b=EkCAs1QHWCGHh45tgjFxaOEZw8KQHdFFAUhgv39Tfe/MgruVYnNcHIJ3rAgM+OlMcb
         Flqs8Z8if2rZi9/Vr1HahEjuKJLetOb52qpdUOY68yPaK+lphO4qaI3QD3JVGcCGW0Tn
         offtkXHHfduGN8+OQQyCVIUjjlo44VPeDALlKyylvflLfelI+mjrL9IbjT4QggJRZ49n
         3HHlPEdkmG75kQmduua/r7cLb7nugfDvQeYQlFpA7F0PGFTtz11czqC/otPR2r8hPivh
         vQzLq8qec4erkHvg7czYNOH8NcEdDvW7L3gjnQhF7ZR1+0wHohPpkWE/Uow/fYeep+w1
         2eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Mah2M/rOQLB9r1W2J9fPI+hW8KuDg9vx6L7LqhtKuY=;
        b=EQrh/VgBIR6fQQJhXMZRMLT9VjGSwyLf8Frn5PTbWNIrTwa9Ux7C4fZuzK/beyPyN7
         flNGgoYRQW5/WFcKMA0q1YLLHiTbcm0sfo2aqnVDxbib73xCh/olIOg3H+oWF0xd92lk
         UU+h+ZNoUvI3HNK1sqJdHotkZKiTxwAvS0qtRnu9y278Z/zveJvS9+1iNYB4Vh1fWDnN
         baYfgXKj5e7XiJ523hbGXVw3KKk7v276/gpSSsFSOjZK/RlnhBd5t3OS0+rO3XTFtAXA
         00gzFvGU2eyvG7nMedAdxO6n+qz2mK0N9J0fsBpJZBd3AhZ1hbNjv4JjzeWDOGP1lMm7
         lJmQ==
X-Gm-Message-State: APjAAAUXAHUwQd915ufZ3gu9Dw7aOGVVnMvt6fLtogjRBQORPwlJIe6n
        FipWRo1KZ43cKhpEvHNUIPoAKfcNzP/VzAIaxCQ=
X-Google-Smtp-Source: APXvYqy06Q/js8Zzz5TSbvg5kclOlz9RDFjeC90xMb/53GJiZ5mxvEINp8+cqpfTQjO7fNpd+G4ZsPMndS3J+I8KWgY=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr4055310otm.66.1556966215617;
 Sat, 04 May 2019 03:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556919363.git.melissa.srw@gmail.com> <18725f7ddc3ac42b1c781b1848b05fabd4bd8320.1556919363.git.melissa.srw@gmail.com>
In-Reply-To: <18725f7ddc3ac42b1c781b1848b05fabd4bd8320.1556919363.git.melissa.srw@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 4 May 2019 13:36:43 +0300
Message-ID: <CA+U=DsoYaN_gCc=jcQ9nHHNpC+voPfHCc=RP_ZyQAC497Jx_7A@mail.gmail.com>
Subject: Re: [PATCH 3/4] staging: iio: ad7150: simplify i2c SMBus return treatment
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 4, 2019 at 1:26 AM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> Since i2c_smbus_write_byte_data returns no-positive value, this commit
> making the treatment of its return value less verbose.
>
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7150.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 4ba46fb6ac02..3a4572a9e5ec 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -201,16 +201,12 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
>         ret = i2c_smbus_write_byte_data(chip->client,
>                                         ad7150_addresses[chan][4],
>                                         sens);
> -       if (ret < 0)
> +       if (ret)

For i2c_smbus_write_byte_data(), checking "ret < 0" or non-zero, is the same.
Changing this doesn't have any added value.

>                 return ret;
> -
> -       ret = i2c_smbus_write_byte_data(chip->client,
> +       else
> +               return i2c_smbus_write_byte_data(chip->client,
>                                         ad7150_addresses[chan][5],
>                                         timeout);

The introduction of the "else" branch is a bit noisy.
The code was a bit neater (and readable) before the else branch, and
functionally identical.

Well, when I say neater before, you have to understand, that I (and I
assume that some other people who write drivers) have a slight
fixation for this pattern:

example1:
ret = fn1();

if (ret < 0)  // could also be just "if (ret)"
   return ret;

ret = fn2();
if (ret < 0)  // could also be just "if (ret)"
   return ret;

example1a:
+ret = fn3();
+if (ret < 0)  // could also be just "if (ret)"
+    return ret;


Various higher-level programming languages, will discourage this
pattern in favor of neater patterns.

I personally, have a few arguments in favor of this pattern:
1) it is closer to how the machine code ; so, closer to how a
low-level instruction looks like
2) if (ever) this needs to be patched, the patch could be neat (see
example1a) ; the examle assumes that it's been added via a patch at a
later point in time
3) it keeps indentation level to a minimum ; this also aligns with
kernel-coding guidelines
(https://www.kernel.org/doc/html/v4.10/process/coding-style.html )
    (indentation seems a bit OCD-like when someone points it out at a
review, but it has it's value over time)

> -       if (ret < 0)
> -               return ret;
> -
> -       return 0;
>  }
>
>  static int ad7150_write_event_config(struct iio_dev *indio_dev,
> --
> 2.20.1
>
