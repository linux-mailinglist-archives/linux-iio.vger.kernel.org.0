Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D981ACFAA
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 20:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbgDPS3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 14:29:12 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:50718 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgDPS3L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Apr 2020 14:29:11 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49376F1ckbzCQ;
        Thu, 16 Apr 2020 20:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1587061749; bh=COFpUNgzn7XGH7P1CqagDOMu3sS86HjRWoae4TnBbOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQZSFO+qSIZzr/1udITeFbqG8wPB8DCC8Ry3pb5C9a3Lkod1ODUYBD8WYMqE7aZ4j
         qanyj0a0YKgWUW/hFaPI4mX0PXy5cudqZFL51Y1H8BDJ/RYieWKq+e2YhbxBLqLmrz
         BgcjJCaEzkUWCe2w/OqA6sinf/Uefu5RrpLnM7zIxXd/B93K2HX49F28prp03EkcLm
         tZ3pBRyv1nDPKv9uATw6g70bmLZb8piO0N3GncpW3GZAXZ/UA5O3wU+m8X+yC5IibO
         Yxs6cavIYeHDm01lhy0spTkPisLApk5+oQOPSlGGknkFtSCK5pJsENOXWyv3Uf4Tgt
         jKKd1RZZejPcg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 16 Apr 2020 20:29:05 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: ak8974: Provide scaling
Message-ID: <20200416182905.GC372@qmqm.qmqm.pl>
References: <20200416140917.8087-1-linus.walleij@linaro.org>
 <20200416140917.8087-2-linus.walleij@linaro.org>
 <20200416181746.GB372@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416181746.GB372@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 16, 2020 at 08:17:46PM +0200, Micha³ Miros³aw wrote:
> On Thu, Apr 16, 2020 at 04:09:17PM +0200, Linus Walleij wrote:
> > The manual for the HSCDTD008A gives us a scaling for the
> > three axis as +/- 2.4mT per axis.
> > 
> > When I implement this the biggest axis indicates 0.59 Gauss
> > which is a reasonable measurement for the earths magnetic
> > which is in the range of 0.25 to 0.65 Gauss on the surface
> > according to Wikipedia.
> > 
> > Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
> > Cc: Stephan Gerhold <stephan@gerhold.net>
> > Cc: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - Split out the measurement refactoring.
> > ---
> >  drivers/iio/magnetometer/ak8974.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> > index 5361647b9054..effcdd93e650 100644
> > --- a/drivers/iio/magnetometer/ak8974.c
> > +++ b/drivers/iio/magnetometer/ak8974.c
> > @@ -603,6 +603,18 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
> >  		*val = outval;
> >  		ret = IIO_VAL_INT;
> >  		break;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/*
> > +		 * The datasheet for HSCDTF008A, page 3 specifies the
> > +		 * range of the sensor as +/- 2.4 mT per axis, which corresponds
> > +		 * to +/- 2400 uT = +/- 24 Gauss. So 0x7fff is 24 Gauss and
> > +		 * 0xffff is -24 Gauss. To account for the one missing value if
> > +		 * we multiply by 1/S16_MAX, instead multiply with 2/U16_MAX.
> > +		 */
> > +		*val = 24 * 2;
> > +		*val2 = U16_MAX;
> > +		ret = IIO_VAL_FRACTIONAL;
> > +		break;
> 
> Hi,
> 
> The comment seems wrong. DS mentions that the measurement values are
> S16, but limited in range (-k to +k, with k = 2^13 or 2^14). So the
> denominator should be 2^13 or 2^14, and numerator 2.4mT.

Ok, this is what you actually did. :-) The error is in 0xffff in the
comment: it should be 0x8000 (== -0x8000). After applying the limit
in range it would be 0x3fff to -0x4000 (== 0xC000).

I would actually use 2^14 as denominator because that's a "round" number,
the difference is insignificant, and we don't really know which one is
correct. (BTW, the DS mentions 0.15uT/LSB resolution, so it would not be
exact 2.4mT for the max value.)

Best Regards,
Micha³ Miros³aw
