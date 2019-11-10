Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D68F6ABA
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKJSUN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 13:20:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:34599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfKJSUN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 13:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573409992;
        bh=T62clJ7TWd59U0C/7J6xbgVZifeNADs/HOl/H6t3fUE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a8O39flUaNfJzbuouJ5nnyA3+PRA9eubRd29Zpc7ZunGhvSabXYHCr5NpbU6lb6Tp
         qBJ1R/tO0fZ2JwutADPYA+ALppQ9zygSPTyWG0ISJqKMafoS7TBWE+T6RWJglz8H1p
         F9WrCflMkEX4l8f2RAiFBa/e0AZSr/xG5uWwZz3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.153.135]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b2d-1iXQio3ISb-0082vF; Sun, 10
 Nov 2019 19:19:51 +0100
Date:   Sun, 10 Nov 2019 19:19:35 +0100
From:   Pedro Ortega <portega.kernel@gmx.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7280: Add spaces around math
 operator
Message-ID: <20191110181935.GA3378@ubuntu>
References: <20191109151729.3792-1-portega.kernel@gmx.com>
 <20191110132710.0e9300dc@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110132710.0e9300dc@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:SfKbQloHdW9MEqjlgG/XSX7dq1PBfp9P9YLBpahOovHPUXmK/lV
 P5zYqOlKTJhSQgG4/DE6qyB8buk6EVxiSWShg9bWzl3em2iA0Ga/7oWbXUKrL8RVzv6dCUs
 mutd50Ws4YTNTNCbROp3DuZ2Vbm9dTaZ+LfQJglty5S+6xhp0gR7HrrnSL+XjLrpb4zQYmf
 B+09anY5WhXZS+TnPygZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0DvFw5ZFExk=:8YZbfk4fmRhKscQRQvekoe
 oPML4/7UXvcwvj4dShA/pnjTXlCV2kc7bwXbgFdXjBIQM1ncUwV308iN8p+rJhVMyg30dO52L
 YdGwRm7DDKq/tCXuZFVMe4m/lzDt+ADiJby0oeEwagznyxHjP3iitrkXyr5H8OYilVmA7kBoa
 UOUGehZRC4ZIyOtDhfX5dkFyer+TtokSZxR5lox24e1C7r5wcBgdtiADWvQFgdvgoFJ9ptg56
 lecEI/RnYUyZ+buui3+XyaILHNYhsBKFuSBONvwmRYlp4wx+LuHciHOm6phtqB+9SpISHv0kK
 4t8cC+iNcBft8MCWZ9i+LAx3I/zGFIKS+aP0cxY+Px+hvbayxKqpoXvoD9cAbK+IsZbA6+ThU
 ZBOeFk0djMiIBkedar6dTByYEc4NN+t8XeVKqdr5OC5mO2bFA5MOpKNWBGNBvfwQtL0uNSmOH
 aaQ1307mFSjjXToSGndGIGLXrDOfeLAI0lVMokBLHee0n3XmTVYG9i0KysXV2WdBxhDtf6cAx
 BaK1BHRh6nCvFwkBeW8YEfSw02VWz4HIZChh7ST8uDzfE3qONKHS7gUBXVWYyadmoJ5O904zZ
 SBavzX0UejwwqmKgy9ByYzvCCrm1DVdle+xLrBTWcN0Tpx+/sI71W5Ng3VqL6PXxmkovCA6uw
 Vhzm84BhJ0Gxkdudm0mEkXWMIKANsOtYMSr6pWwmMPEHN8/O+mElpU6TieFG4N3NZ1bKbQNT+
 Xu/FUX7cD7DXVduquA6aVDtIO6oyeHyuewFYfM0nE8HXDHkHJ/UVw1qrhdtPaOPtG0IlFJ2lO
 NSh7qjSiZhtuV1EKR8o4UYfguUQjZUQuLk1QsCPEZzK1OoY0FHVF4lPkdXpVquHiMGI4xJptU
 bOQ7jWNotpecqA6f/OXw/rCzOpbXQmsVjRtUXKs3GT444UsPlKsDhtEgCnzfBcjPKrfW4gOeh
 Wim9HSTporFWzCh7wjxWdPh/iXrjw2bRIsocEQ1PFAOdlPxN5QgyLzW+DzlgtihrMC9Kg3mtQ
 r1ZsLvixayb9lCXhFY49icrhd0WQNGIdL32x2pp9iUn1qECMTBhLI201zsoQDnweg3h+/hBFK
 oCX6izBizBEzzAWax5bIhf0G8c/1wAxwJ/xnbR8Y9V9ru1OJfkGfOgI7dp+DhhdX9g/Q0NpfG
 qmrZECO9/4sl69DHwkcXujxO1nB/Ar9uLwXYotvO79uCxHyF6OOV9AQQmiIQ5JZ3igNDSkCr4
 SAkyA52bwRSZaeCjca9vISI0Kea7xw8pfyD5bdilG1Tdae7qvdHmZOcG0ffw=
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 10, 2019 at 01:27:10PM +0000, Jonathan Cameron wrote:
> On Sat,  9 Nov 2019 16:17:28 +0100
> Pedro Ortega <portega.kernel@gmx.com> wrote:
>
> > Add spaces around the minus math operator to increase readability.
> >
> > Signed-off-by: Pedro Ortega <portega.kernel@gmx.com>
> Hi Pedro,
>
> Afraid not.  Look at what that macro is actually doing.  That's not a ma=
ths
> operator at all.  I'm fairly sure we had a plan to actually hide these
> examples away as we get a few people suggesting this 'fix' ever year.
> Not sure what happened to them though, I'll have to check back.

I'm sorry. Next time I will review the code much more carefully. The macro
IIO_DEVICE_ATTR_NAMED expand the second parameter to a string. So, the hyp=
hen
is not a maths operator.

>
> Sorry about this, but it is a good lesson in making sure you check
> that the suggestion from checkpatch is actually correct.  It's a
> pattern matcher, it can't always know enough to be able to tell what
> is going on.

First lesson learned.
>
> Thanks,
>
> Jonathan

Thanks,

Pedro
>
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/a=
dc/ad7280a.c
> > index 19a5f244dcae..34ca0d09db85 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq,=
 void *private)
> >  }
> >
> >  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > -			     in_voltage-voltage_thresh_low_value,
> > +			     in_voltage - voltage_thresh_low_value,
> >  			     0644,
> >  			     ad7280_read_channel_config,
> >  			     ad7280_write_channel_config,
> >  			     AD7280A_CELL_UNDERVOLTAGE);
> >
> >  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > -			     in_voltage-voltage_thresh_high_value,
> > +			     in_voltage - voltage_thresh_high_value,
> >  			     0644,
> >  			     ad7280_read_channel_config,
> >  			     ad7280_write_channel_config,
> > --
> > 2.17.1
> >
>
