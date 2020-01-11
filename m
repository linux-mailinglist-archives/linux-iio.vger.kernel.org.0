Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE87138116
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 12:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgAKLVt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 06:21:49 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:39680 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbgAKLVt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:21:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 08780FB03;
        Sat, 11 Jan 2020 12:21:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 67J4sqHQTi8k; Sat, 11 Jan 2020 12:21:46 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 938364A3D8; Sat, 11 Jan 2020 12:21:45 +0100 (CET)
Date:   Sat, 11 Jan 2020 12:21:45 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: update sampling rates for
 vcnl4040
Message-ID: <20200111112145.GA6565@bogon.m.sigxcpu.org>
References: <20200108155852.32702-1-tomas@novotny.cz>
 <20200108155852.32702-3-tomas@novotny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108155852.32702-3-tomas@novotny.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
On Wed, Jan 08, 2020 at 04:58:52PM +0100, Tomas Novotny wrote:
> Vishay has published a new version of "Designing the VCNL4200 Into an
> Application" application note in October 2019. The new version specifies
> that there is +-20% of part to part tolerance. Although the application
> note is related to vcnl4200, according to support the vcnl4040's "ASIC
> is quite similar to that one for the VCNL4200".
> 
> So update the sampling rates (and comment), including the correct
> sampling rate for proximity. Both sampling rates are lower. Users
> relying on the blocking behaviour of reading will get proximity
> measurements much earlier.
> 
> Fixes: 5a441aade5b3 ("iio: light: vcnl4000 add support for the VCNL4040 proximity and light sensor")
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> ---
>  drivers/iio/light/vcnl4000.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 98428bf430bd..e5b00a6611ac 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -174,9 +174,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  		data->al_scale = 24000;
>  		break;
>  	case VCNL4040_PROD_ID:
> -		/* Integration time is 80ms, add 10ms. */
> -		data->vcnl4200_al.sampling_rate = ktime_set(0, 100000 * 1000);
> -		data->vcnl4200_ps.sampling_rate = ktime_set(0, 100000 * 1000);
> +		/* Default wait time is 80ms, add 20% tolerance. */
> +		data->vcnl4200_al.sampling_rate = ktime_set(0, 96000 * 1000);
> +		/* Default wait time is 5ms, add 20% tolerance. */
> +		data->vcnl4200_ps.sampling_rate = ktime_set(0, 6000 * 1000);

I'm seeing the 80ms in VCNL4040 Application guide (Revision:
12-Nov-2019) but that one also says 6400us for the proximity so 8000
might be more on the safe side which (which i just tested, it's still
way better than the current 100000).

with that fixed

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

>  		data->al_scale = 120000;
>  		break;
>  	}
> -- 
> 2.16.4
> 
