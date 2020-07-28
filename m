Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13AF2311CA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbgG1SdO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:33:14 -0400
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:37338 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732457AbgG1SdO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:33:14 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 14:33:14 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id D2EDB1801D006
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 18:24:20 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3DBF1182CF689;
        Tue, 28 Jul 2020 18:24:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3872:3873:4250:4321:4605:5007:6742:7576:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13439:13972:14038:14181:14659:14721:21080:21220:21433:21451:21611:21627:21990:30029:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: copy85_0111d2226f6c
X-Filterd-Recvd-Size: 4570
Received: from XPS-9350 (unknown [172.58.27.230])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 18:24:15 +0000 (UTC)
Message-ID: <855ea08a4c41bc107f88699230309675bd9075b0.camel@perches.com>
Subject: Re: [PATCH 13/15] iio: sx9310: Add newlines to printks
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Date:   Tue, 28 Jul 2020 11:24:07 -0700
In-Reply-To: <CAHp75VdSxkgd-+CBTNUJD+WUdOX3e1x3Ysap=D9+33Yo1Kk+yA@mail.gmail.com>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
         <20200728151258.1222876-1-campello@chromium.org>
         <20200728091057.13.I14600506d0f725bf800c8da4ef89fdb3c3fb45cd@changeid>
         <CAHp75VdSxkgd-+CBTNUJD+WUdOX3e1x3Ysap=D9+33Yo1Kk+yA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2020-07-28 at 21:19 +0300, Andy Shevchenko wrote:
> On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
> > From: Stephen Boyd <swboyd@chromium.org>
> > 
> > Printks in the kernel have newlines at the end. Add them to the few
> 
> Printk()s
> 
> > printks in this driver.
> 
> printk()s

Random kernel pedantry.
This patch should not need to be respun for any of these.

> > Reviewed-by: Daniel Campello <campello@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Daniel Campello <campello@chromium.org>
> 
> It has ordering issues
> Should be
> 
> Fixes:
> SoB: Stephen
> Rb: Douglas
> Rb: Daniel
> SoB: Daniel
> 
> 
> > ---
> > 
> >  drivers/iio/proximity/sx9310.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index 3f981d28ee4056..4553ee83a016a3 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -809,7 +809,7 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
> >         if (ret) {
> >                 if (ret == -ETIMEDOUT)
> >                         dev_err(&data->client->dev,
> > -                               "0x02 << 3l compensation timed out: 0x%02x",
> > +                               "0x02 << 3l compensation timed out: 0x%02x\n",
> 
> Looks like ping-pong style in the series, i.e. you may fix this when
> you introduced this line.
> 
> Check the rest (and not only printk()s) for the similar style and
> avoid the latter.
> 
> >                                 val);
> >                 return ret;
> >         }
> > @@ -855,7 +855,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
> > 
> >         ddata = (uintptr_t)device_get_match_data(dev);
> >         if (ddata != whoami) {
> > -               dev_err(dev, "WHOAMI does not match device data: %u", whoami);
> > +               dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
> >                 return -ENODEV;
> >         }
> > 
> > @@ -867,7 +867,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
> >                 indio_dev->name = "sx9311";
> >                 break;
> >         default:
> > -               dev_err(dev, "unexpected WHOAMI response: %u", whoami);
> > +               dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
> >                 return -ENODEV;
> >         }
> > 
> > @@ -896,7 +896,7 @@ static int sx9310_probe(struct i2c_client *client)
> > 
> >         ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
> >         if (ret) {
> > -               dev_err(dev, "error in reading WHOAMI register: %d", ret);
> > +               dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
> >                 return ret;
> >         }
> > 
> > --
> > 2.28.0.rc0.142.g3c755180ce-goog
> > 
> 
> 

