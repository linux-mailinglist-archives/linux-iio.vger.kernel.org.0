Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB5A1500D2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 04:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBCDx0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 22:53:26 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:53633 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbgBCDx0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 22:53:26 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 489v7R2nwHzC6;
        Mon,  3 Feb 2020 04:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1580702004; bh=/uZxCLT/f5ZoDZCTtm4Ac+CYil95UyDoe4NDvpQ1qDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMKPSFav6FuLXRQGz90QX1B1U1B6wbWvuU1pDwt06j+fDjc7oqKPPREwRv+uuF2Yh
         Y5SNhUQNDBK9shYf7F1adK8Akhe89AJIziUOG/mfvX2zuy6DEaUtC4XoCkIKc29xFg
         sVbd6IMX984+fzPnONm/FcC1KLuRzbjbt4EoWTySNqJXb1N+aLa/mAajuYuVH9vh9V
         G4TvFudNmVZmOBhnH2SVmXXvZ7RPAD/cyLqErXnT7Q+qk7HOAq5xqCrAdAfRpKgRzI
         EXc4Howmq/YZijV/RV0kgawd98EeVw8z66VJ6kpMpVOTRqTAA4ITfHUpji3cgagB0p
         F/eDpgDXlX3bg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 3 Feb 2020 04:53:22 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 4/7] iio: light: add Dyna-Image AL3010 driver
Message-ID: <20200203035321.GA26220@qmqm.qmqm.pl>
References: <20200201180024.328700-1-david@ixit.cz>
 <20200201180024.328700-5-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200201180024.328700-5-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 01, 2020 at 07:00:21PM +0100, David Heidelberg wrote:
> Based on:
> - 3320A in-kernel driver
> - https://www.spinics.net/lists/linux-iio/msg25145.html
> - https://lore.kernel.org/patchwork/patch/684179/

Haha! This is such a simple device, that there is not many ways you can
write a driver quickly. Just look at [1]. ;-)

[1] https://rere.qmqm.pl/git/?p=linux;a=commit;h=f40bf1646c9166f9b8daeb7cf55703be3c5f78b3

[...]
> --- /dev/nulla
> +++ b/drivers/iio/light/al3010.c
[...]
> +#define AL3010_GAIN_SHIFT		4
> +#define AL3010_GAIN_MASK		(BIT(6) | BIT(5) | BIT(4))
> +
> +#define AL3010_GAIN_READ(g) \
> +	(((g) & AL3010_GAIN_MASK) >> AL3010_GAIN_SHIFT)
> +
> +#define AL3010_GAIN_WRITE(g) \
> +	(((g) << AL3010_GAIN_SHIFT) & AL3010_GAIN_MASK)

There are FIELD_GET and FIELD_PREP macros available from
<linux/bitfield.h> that make accessing the registers a lot easier
to code and read.

> +#define AL3010_SCALE_AVAILABLE "1.1872 0.2968 0.0742 0.018"

I have used (albeit with a bug) more precise numbers. This doesn't
matter much, though, since I would expect noise to be much higher
than 0.1% for the measurement.

> +
> +enum al3xxxx_range {
> +	AL3XXX_RANGE_1, /* 77806 lx */
> +	AL3XXX_RANGE_2, /* 19542 lx */
> +	AL3XXX_RANGE_3, /*  4863 lx */
> +	AL3XXX_RANGE_4  /*  1216 lx */
> +};

The enums don't look very useful.

[...]

Tested-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

Best Regards,
Micha³ Miros³aw
