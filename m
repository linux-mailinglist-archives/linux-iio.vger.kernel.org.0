Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74260AF276
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfIJVE5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 17:04:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56197 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfIJVE4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2019 17:04:56 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i7nJg-0006Rj-RV; Tue, 10 Sep 2019 23:04:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i7nJe-0007Rf-5w; Tue, 10 Sep 2019 23:04:46 +0200
Date:   Tue, 10 Sep 2019 23:04:46 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: bh1750: Resolve compiler warning and make
 code more readable
Message-ID: <20190910210446.6k7nftbfastgpmg5@pengutronix.de>
References: <20190902113132.26658-1-kw@linux.com>
 <20190910203814.31075-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190910203814.31075-1-kw@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 10, 2019 at 10:38:14PM +0200, Krzysztof Wilczynski wrote:
> Separate the declaration from definition of bh1750_chip_info_tbl
> to make the code more readable.  Separating the code will resolve
> the following compiler warning that can be seen when building
> with warnings enabled (W=1):

This commit log isn't completely accurate. Before we had a definition of
a struct that was instantly (i.e. without repeating the type name) used
as type for an array. (And not a declaration and definition of
bh1750_chip_info_tbl.)

So I'd write:

	Don't mix declaring struct bh1750_chip_info and defining
	bh1750_chip_info_tbl[] in a single statement. This is hard to
	read, with warnings enabled gcc warns about the unusual position
	of the keyword static:
	
		drivers/iio/light/bh1750.c:64:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
	
	and with the empty line this looks as if bh1750_chip_info_tbl
	had no explicit type.

If you want add

	Fixes: 3a11fbb037a1 ("iio: light: add support for ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensors")

and add Tomasz Duszynski <tduszyns@gmail.com> to Cc who authored
3a11fbb037a1.

> ---
> Changes in v2:
>   Made definition of bh1750_chip_info_tbl separate from declaration
>   as per the review feedback.  This also makes the code more readable.
>   Updated wording of the subject and the commit message.
> 
>  drivers/iio/light/bh1750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index 28347df78cff..adb5ab9e3439 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -59,9 +59,9 @@ struct bh1750_chip_info {
>  
>  	u16 int_time_low_mask;
>  	u16 int_time_high_mask;
> -}
> +};
>  
> -static const bh1750_chip_info_tbl[] = {
> +static const struct bh1750_chip_info bh1750_chip_info_tbl[] = {
>  	[BH1710] = { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
>  	[BH1721] = { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
>  	[BH1750] = { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },

The patch looks fine. If you adapt the commit log as suggested above
take my

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
