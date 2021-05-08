Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC10037734C
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhEHRCT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 13:02:19 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:50022 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229552AbhEHRCT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 May 2021 13:02:19 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C92D2837F24A;
        Sat,  8 May 2021 17:01:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 442CA20D758;
        Sat,  8 May 2021 17:01:15 +0000 (UTC)
Message-ID: <1eb0428d352be2498739de71eb65746309c90f4c.camel@perches.com>
Subject: Re: [PATCH] iio: tsl2583: Fix division by a zero lux_val
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Colin King <colin.king@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jon Brenner <jbrenner@taosinc.com>, linux-iio@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 08 May 2021 10:01:14 -0700
In-Reply-To: <20210508171258.2ef71a70@jic23-huawei>
References: <20210507183041.115864-1-colin.king@canonical.com>
         <20210508171258.2ef71a70@jic23-huawei>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.90
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 442CA20D758
X-Stat-Signature: wnkp43btcie7ymskkaw68ca5r135z3t9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+/qTRbq/tfWb64s6ZzCDbmjtWe8vVdDaM=
X-HE-Tag: 1620493275-211571
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2021-05-08 at 17:12 +0100, Jonathan Cameron wrote:
> On Fri,  7 May 2021 19:30:41 +0100 Colin King <colin.king@canonical.com> wrote:
[]
> > The lux_val returned from tsl2583_get_lux can potentially be zero,
> > so check for this to avoid a division by zero and an overflowed
> > gain_trim_val.
[]
> > Fixes: ac4f6eee8fe8 ("staging: iio: TAOS tsl258x: Device driver")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Definitely looks like it could happen so applied to the fixes-togreg branch of
> iio.git and marked for stable.
[]
> > diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
[]
> > @@ -341,6 +341,14 @@ static int tsl2583_als_calibrate(struct iio_dev *indio_dev)
> >  		return lux_val;
> >  	}
> > 
> > +	/* Avoid division by zero of lux_value later on */
> > +	if (lux_val == 0) {
> > +		dev_err(&chip->client->dev,
> > +			"%s: lux_val of 0 will produce out of range trim_value\n",
> > +			__func__);
> > +		return -ENODATA;
> > +	}
> > +
> >  	gain_trim_val = (unsigned int)(((chip->als_settings.als_cal_target)
> >  			* chip->als_settings.als_gain_trim) / lux_val);

Is a multiplication overflow possible here?
There are also unnecessary parentheses.


