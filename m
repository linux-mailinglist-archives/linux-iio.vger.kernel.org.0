Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE5B1C7A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 13:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfIMLky (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 07:40:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56152 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbfIMLky (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 07:40:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so2383026wmg.5
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2019 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Gw4Md4epl26SqzUSYC+KgqWFXwjU2XSMxnQbNWAO1Pk=;
        b=XXf5FOpvjpeYiS1U55/ZK9IsNC7qsxC7SebZCjUEGluHMTyUFdz8ozxqF9X1OHaK7x
         fa6Shj2P592gYA/ZgnajQbmLngT+FULCsRuTt76mDEZo3Z/tLmjFsp+k+mKxPwbrf6qK
         Wy3dLt6ayRN/OIHe3IdL9gJSsZkEn95dHp3QkEb8wKh6gCYKavlv/7l/3jdEEIpRLNzz
         p2eLMJ6W8pIiAeXY1x4O7Xa8O1+9c0BJVQT7DXULuwF1iwnF7MOO7E+0AE95iavJsrBh
         tHqXYni6/ZVNZV2gK1p7FE5TQHYsWp68oAWvEEyCMf+ij1V2oLQZ3TlhJ3uqJRnYLMW0
         p8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Gw4Md4epl26SqzUSYC+KgqWFXwjU2XSMxnQbNWAO1Pk=;
        b=dlPb+k0uAHpIIYF+mU40AVt/aFCkoEdCoRgRSpuha6fB7HlCw6RHKQqKyKGBzFWw2A
         3ljHtFkTbVAjt8wRywe83yE3Svl53czVlN5/v0tCbCEfONfoHI7xAjm18RAW+RTGMYHN
         YY1E1qTrasj7ByThdrwgVKlMTFjFBj5ouhhyaABbrNdiUZCcQcql6wbJPNvHKz4EO28b
         wBIWfa8XSz1EHSyRuNY5BkQaiSDFqeiCU9iN4dHiklD+MGEDaSy6lPswtBVFHfP1sPkm
         J6bLwncfhsICOxgdbhH/rsZqUZz6ePdlQGN7MC1UujQiRpV77pKp8J4yR8vvVnDfQ9Ok
         9J2A==
X-Gm-Message-State: APjAAAXbqsXjxj7LGoIKiJx5n2yhUUqFdPBrKXqV6FW1H9p3IMkQMhuJ
        6JF0emj1r4Kd5ZOfxle8QriT7jFC2It1XeP2IuM=
X-Google-Smtp-Source: APXvYqzCpKT+D0Hxd34ZuGMKzfCvBkBK99iPfXPd0INJwQlOsCdztjtNb+o625fFcgytXBzwLsTcwst4ZZfnwCgNquw=
X-Received: by 2002:a1c:a617:: with SMTP id p23mr3049926wme.166.1568374852191;
 Fri, 13 Sep 2019 04:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <20190912144310.7458-5-andrea.merello@gmail.com> <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
 <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com> <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com>
In-Reply-To: <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 13 Sep 2019 13:40:41 +0200
Message-ID: <CAN8YU5PsnZ-zXOEvK_RgJh0drEXsGSidf_CZpTRU+caE6N6NQg@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
To:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno ven 13 set 2019 alle ore 13:30 Couret Charles-Antoine
<charles-antoine.couret@essensium.com> ha scritto:
>
> Hi,
>
> Le 13/09/2019 =C3=A0 10:30, Andrea Merello a =C3=A9crit :
> > Il giorno ven 13 set 2019 alle ore 09:19 Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com> ha scritto:
> >
> >> So, at power-up this chip seems to need 2 dummy reads to discard data.
> >> Which seems to happen in ad7949_spi_init()
> >>
> >> One thing that maybe could be optimized (for the driver), is in `ad794=
9_spi_read_channel()` to use the current-channel &
> >> not do a SPI write to change the channel if it doesn't change.
> >>
> >> Datasheets (in general) are not always obvious about describing chip b=
ehavior for SW (or for writing a driver), but I
> >> would suspect that if you are reading garbage data, it could be that t=
he channel has changed.
> >> This is true for some other ADCs.
> >> And requires testing for this one.
> > Yes, it's exactly what I've seen here. If the channel does not change
> > then the AD is already in acquisition phase on the right channel (I
> > assume it's OK to keep it in such phase indefinitely), then we can
> > just trigger a new conversion (CNV low->high, that is a dummy xfer)
> > and then read the result in following xfer, as the driver already did.
> >
> > I craft a V2 that performs the extra (3rd) spi xfer only if the
> > channel has to change.
>
> This design should be ok. I didn't implement in that way because not
> enough time to optimize the driver before release (I don't have access
> to the chip anymore) and for our workflow it was not relevant (we
> scanned all channels).
>
>
> About your fix to read / write several times before reading the value
> after channel change seems not relevant. Did you try with the current
> implementation? Because when I developed the driver, I have always got
> the expected value for each channel with this design.

Yes, I did. But I experienced the said problems. I don't have idea
about why it worked for you and it didn't for me..

By scanning the channels in circular fashion, with the current
implementation, I would expect to get values off-by-one (i.e. you read
ch ...,0,1,2,3,4,0,1,2,3,4,... and you get value for ch
...,4,0,1,2,3,4,0,1,2,3,...).

>
> Just to be sure we are not adding useless steps.
>
> >> Added Charles-Antoine, since he wrote the driver.
> >> Shoud have added him on the other patches as well, but I just remember=
ed.
> > I tried on my first answer, but apparently mails to his address bounce
> > back with a failure response..
>
> But now it seems ok. Did you put the right email address?

Sorry, my fault. I've done a mistake in copy-and-paste.

>
> Thank you for the copy.
>
> Regards,
>
> Charles-Antoine Couret
>
