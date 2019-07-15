Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4769F78
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfGOXTp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 19:19:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40768 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfGOXTp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 19:19:45 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so36899743iom.7
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 16:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDmRR/vRbt+A2ief6crqAJXdmNg5zgD9ViO0y/y+K/4=;
        b=AuDyEey8sj9EZmfHdHR97PiwIe23ssCUNmLyXv8ti3LIChHAWTXegMwBW8LDeZs8dc
         tpii8Z3z1nGfMJaRRPQ7rD761FeRaM5IfzUi6Zzkk7pzptI2lX7WJKdIQbwZmNWiSZ+/
         5ED3TCcE6Ue/VvB+BOtC3qSSrmssXOCCbpQfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDmRR/vRbt+A2ief6crqAJXdmNg5zgD9ViO0y/y+K/4=;
        b=mkKj9mCDSkWRNUkHxT7S04YNTmOmsCVJarroUOlvyf3IsFh9EYnXvqYR95iZg8fGwO
         jW3o6PgwDAFwTo5m5CPAD/QyWJV232/VGgsqx6rvsUZPO7YefvvqFBMHyyDFmKI7aYp/
         PcRvBJnhqvU7IqSJtp+Q6uMQ+tCPcrDFo7HrnrB5V3+S73c+ogWtMEx/z8129JZy4pJ7
         dBBfaDfm29ApWxMtXtzV3CvpFJqf3grhvq60G4nYBLqLLBjgyCgaduUC1vRBikKGRc9V
         OllHCC9Y+b4VvH8tWPHN2UOXDYnCrRDbzvmYJHW+qKhgsFaT5nwfn7Z16BTgsOKD9+Mo
         aTnw==
X-Gm-Message-State: APjAAAX7d4mcsCS9ewGYQ6Y4mat4tu4bXvUvm+lQQitkfbagQr8L4tPk
        Ql5qKpIKkgdEappiH6gaJQEW2Pd4ArJpnyGnxUwH9g==
X-Google-Smtp-Source: APXvYqzzWW01yuCzViFRgMbu8UpxSBrq3RKAQSYrNoa27kuoHHz7A4tvWLqlWhsZkKeSZF0c3LIFPTozkh5f/P2Uiks=
X-Received: by 2002:a6b:8bd1:: with SMTP id n200mr28478471iod.134.1563232784019;
 Mon, 15 Jul 2019 16:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190715191017.98488-1-mka@chromium.org> <20190715195557.GA29926@google.com>
 <20190715200447.GT250418@google.com> <CAPUE2us7HZvSbpCddx4u_5KcdxedNd43-o=MZDiNfcpbzt9aXA@mail.gmail.com>
In-Reply-To: <CAPUE2us7HZvSbpCddx4u_5KcdxedNd43-o=MZDiNfcpbzt9aXA@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 15 Jul 2019 16:19:32 -0700
Message-ID: <CAPUE2uvjnPfBUTDMXoNbcz1TM++F=MaO7cViNs4LsCPN7DX5tA@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Always release lock when
 returning from _read()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Benson Leung <bleung@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Let's use Matthias CL.

On Mon, Jul 15, 2019 at 4:17 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Sorry for the original mistake. I upload a patch at
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1702884.
>
> On Mon, Jul 15, 2019 at 1:04 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Benson,
> >
> > On Mon, Jul 15, 2019 at 12:55:57PM -0700, Benson Leung wrote:
> > > Hi Matthias,
> > >
> > > On Mon, Jul 15, 2019 at 12:10:17PM -0700, Matthias Kaehlcke wrote:
> > > > Before doing any actual work cros_ec_accel_legacy_read() acquires
> > > > a mutex, which is released at the end of the function. However for
> > > > 'calibbias' channels the function returns directly, without releasing
> > > > the lock. The next attempt to acquire the lock blocks forever. Instead
> > > > of an explicit return statement use the common return path, which
> > > > releases the lock.
> > > >
> > > > Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > >  drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > > > index 46bb2e421bb9..27ca4a64dddf 100644
> > > > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > > > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > > > @@ -206,7 +206,8 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
> > > >     case IIO_CHAN_INFO_CALIBBIAS:
> > > >             /* Calibration not supported. */
> > > >             *val = 0;
> > > > -           return IIO_VAL_INT;
> > > > +           ret = IIO_VAL_INT;
> > > > +           break;
> > >
> > > The value of ret is not used below this. It seems to be only used in
> > > case IIO_CHAN_INFO_RAW. In fact, with your change,
> > > there's no return value at all and we just reach the end of
> > > cros_ec_accel_legacy_read.
> > >
> > > >     default:
> > > >             return -EINVAL;
> > > >     }
> > >
> >
> > I messed up. I was over-confident that a FROMLIST patch in our 4.19
> > kernel + this patch applying on upstream means that upstream uses the
> > same code. I should have double-checked that the upstream context is
> > actually the same.
> >
> > Sorry for the noise.
