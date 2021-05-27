Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B61E393381
	for <lists+linux-iio@lfdr.de>; Thu, 27 May 2021 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhE0QTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 May 2021 12:19:08 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:36432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235283AbhE0QTE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 May 2021 12:19:04 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7B4A21812870E;
        Thu, 27 May 2021 16:17:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 840D8268E46;
        Thu, 27 May 2021 16:17:26 +0000 (UTC)
Message-ID: <644a711e4d2639a23bfc50dffa180ad184a4acb1.camel@perches.com>
Subject: Re: [PATCH] iio: si1133: fix format string warnings
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Maxime =?ISO-8859-1?Q?Roussin-B=E9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Thu, 27 May 2021 09:17:24 -0700
In-Reply-To: <20210516103628.2cf899a0@jic23-huawei>
References: <20210514135927.2926482-1-arnd@kernel.org>
         <7afc367b-8103-9d48-1bfe-d505d86553b9@kernel.org>
         <20210516103628.2cf899a0@jic23-huawei>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.39
X-Stat-Signature: qdkk4frfin6s4b3oqc9zzfiayxtbnk1i
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 840D8268E46
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ozl0XL3trtk2YILrXGbz44hU+4X9/M6Q=
X-HE-Tag: 1622132246-824994
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-05-16 at 10:36 +0100, Jonathan Cameron wrote:
> On Fri, 14 May 2021 10:45:02 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> > On 5/14/2021 6:59 AM, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > clang complains about multiple instances of printing an integer
> > > using the %hhx format string:
> > > 
> > > drivers/iio/light/si1133.c:982:4: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
> > >                   part_id, rev_id, mfr_id);
> > >                   ^~~~~~~
> > > 
> > > Print them as a normal integer instead, leaving the "#02"
> > > length modifier.
[]
> > > diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
[]
> > > @@ -978,11 +978,11 @@ static int si1133_validate_ids(struct iio_dev *iio_dev)
> > >   		return err;
> > >   
> > > 
> > >   	dev_info(&iio_dev->dev,
> > > -		 "Device ID part %#02hhx rev %#02hhx mfr %#02hhx\n",
> > > +		 "Device ID part %#02x rev %#02x mfr %#02x\n",
> > >   		 part_id, rev_id, mfr_id);
> > >   	if (part_id != SI1133_PART_ID) {
> > >   		dev_err(&iio_dev->dev,
> > > -			"Part ID mismatch got %#02hhx, expected %#02x\n",
> > > +			"Part ID mismatch got %#02x, expected %#02x\n",

which is almost certainly wrong.
the length specification includes the # which is already 2 bytes.

Likely these should be 0x%02x

> > >   			part_id, SI1133_PART_ID);


