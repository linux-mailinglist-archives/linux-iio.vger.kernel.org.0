Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6835E395EB4
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhEaOCc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbhEaOAK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 May 2021 10:00:10 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83903C06137F;
        Mon, 31 May 2021 06:36:58 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id u13so1769214qvt.7;
        Mon, 31 May 2021 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=Ubdjxd4xLO/bMSsRXMlc/f+cavJirKnWXXDG8pw3VZg=;
        b=Hn/G0YcYBaopoP+bkODCY7Xc+LDfDY8/JARg/hlRoqIKxv4BtiBd28Aczyk4eRK2qS
         /asrPYto/imLkR9leLWplLsWs2PtcSJKp9iZiLdNWOSY3SKBt0ct6nd8qf1av9cJ5Xgr
         +7fHBneQFs+RCM/G0cxiXzd7P0uvYKVy6mRXBujOeHsDy98FlzrzoHdL3qfLg916a62h
         MaJkQJwHNNFPzZlISWACRxEbOYS0KtoqKdlDn3xUJQvU6L2w82+rCSeIf/yc098lEknv
         wtnr9OXeiE2BpdnSh3SjBf0DlCZ3A+zDgmFgcFR6Rl/y7ULxNPCe20GNrzTRYqwkzFBI
         rVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=Ubdjxd4xLO/bMSsRXMlc/f+cavJirKnWXXDG8pw3VZg=;
        b=cgAXugz5z+fPsQ6WY9Z8Q7dnDk4T+VkthzYqMJe93XIHzuUbGXFX0BpcyUHJk2esDR
         vHGOfT9akqxUshG1V3z3jghXva2SbaUxwGZt8BrNm0MVDC0+2tkW5Ts16XSU2pqj1mj3
         P3pSaMKwMXZMdVs15j7Kvey1135BP4LJzPKaaYKX7TahM9N6Ua0ZSH1e24jNc0eLrpow
         t+HQhI3W18ihJVyuQ9XDJU5orLCxoTLEJHB3YJyuhAWa5ikjaaDZSgsAN+BiFEIXAQC3
         AUVWE7GfKKkx84IAIEfUOWyIa4lHNOrWnzGU/bkai7xpeTswNZ84czjU/c5w8jzouj9R
         DK3w==
X-Gm-Message-State: AOAM532EL+a2CsN87zsfxDMHXleBFvTAc/V+3uBjufcJnv/f0jJPa1Vg
        EiigsipfdS4TuqKlZKiRo8s=
X-Google-Smtp-Source: ABdhPJx0ySdMobnVV3yZlpTYeWj9KuRlzRFeq6H1W/371j4yI7Mk6TcfY4mXd+Od9YaD05m4iUB9EA==
X-Received: by 2002:a05:6214:e4d:: with SMTP id o13mr3533618qvc.19.1622468217437;
        Mon, 31 May 2021 06:36:57 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n81sm3338846qke.16.2021.05.31.06.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 06:36:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 May 2021 09:36:56 -0400
Message-Id: <CBRGZCQWCG6S.676W3VCPMMUH@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 4/9] iio: afe: rescale: add offset support
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-5-liambeguin@gmail.com>
 <0769aaae-8925-d943-e57d-c787d560a8dc@axentia.se>
In-Reply-To: <0769aaae-8925-d943-e57d-c787d560a8dc@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Mon May 31, 2021 at 4:52 AM EDT, Peter Rosin wrote:
> Hi!
>
> Thanks for the patch!
>
> On 2021-05-30 02:59, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > This is a preparatory change required for the addition of temperature
> > sensing front ends.
>
> I think this is too simplistic. I think that if the upstream iio-dev has
> an offset, it should be dealt with (i.e. be rescaled). The rescale
> driver
> cannot ignore such an upstream offset and then throw in some other
> unrelated offset of its own. That would be thoroughly confusing.

I'm not sure I fully understand. The upstream offset should be dealt
with when calling iio_read_channel_processed().  That was my main
motivation behind using the IIO core to get a processed value.

>
> Also, I see no reason of expose an offset channel if there is no offset.

You're right, I'll add conditions to only expose an offset when
required.

Liam

>
> Cheers,
> Peter
>
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index 4d0813b274d1..3bd1f11f21db 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -31,6 +31,7 @@ struct rescale {
> >  	struct iio_chan_spec_ext_info *ext_info;
> >  	s32 numerator;
> >  	s32 denominator;
> > +	s32 offset;
> >  };
> > =20
> >  static int rescale_read_raw(struct iio_dev *indio_dev,
> > @@ -52,6 +53,10 @@ static int rescale_read_raw(struct iio_dev *indio_de=
v,
> >  		*val2 =3D rescale->denominator;
> > =20
> >  		return IIO_VAL_FRACTIONAL;
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		*val =3D rescale->offset;
> > +
> > +		return IIO_VAL_INT;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -119,8 +124,10 @@ static int rescale_configure_channel(struct device=
 *dev,
> >  		return -EINVAL;
> >  	}
> > =20
> > -	chan->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > -		BIT(IIO_CHAN_INFO_SCALE);
> > +	chan->info_mask_separate =3D
> > +		BIT(IIO_CHAN_INFO_RAW) |
> > +		BIT(IIO_CHAN_INFO_SCALE) |
> > +		BIT(IIO_CHAN_INFO_OFFSET);
> > =20
> >  	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
> >  		chan->info_mask_separate_available |=3D BIT(IIO_CHAN_INFO_RAW);
> > @@ -280,6 +287,7 @@ static int rescale_probe(struct platform_device *pd=
ev)
> >  	rescale->cfg =3D of_device_get_match_data(dev);
> >  	rescale->numerator =3D 1;
> >  	rescale->denominator =3D 1;
> > +	rescale->offset =3D 0;
> > =20
> >  	ret =3D rescale->cfg->props(dev, rescale);
> >  	if (ret)
> >=20

