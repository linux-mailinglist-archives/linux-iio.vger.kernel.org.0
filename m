Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F5138121
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 12:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgAKLdD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 06:33:03 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:40328 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbgAKLdD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:33:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 069E1FB03;
        Sat, 11 Jan 2020 12:33:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OvpMWXnJo0pH; Sat, 11 Jan 2020 12:32:59 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 38C564A3D8; Sat, 11 Jan 2020 12:32:59 +0100 (CET)
Date:   Sat, 11 Jan 2020 12:32:59 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] iio: light: vcnl4000: update sampling rates for
 vcnl4200
Message-ID: <20200111113259.GB6565@bogon.m.sigxcpu.org>
References: <20200108155852.32702-1-tomas@novotny.cz>
 <20200108155852.32702-2-tomas@novotny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108155852.32702-2-tomas@novotny.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
On Wed, Jan 08, 2020 at 04:58:51PM +0100, Tomas Novotny wrote:
> Vishay has published a new version of "Designing the VCNL4200 Into an
> Application" application note in October 2019. The new version specifies
> that there is +-20% of part to part tolerance. This explains the drift
> seen during experiments. The proximity pulse width is also changed from
> 32us to 30us. According to the support, the tolerance also applies to
> ambient light.
> 
> So update the sampling rates. As the reading is blocking, current users
> may notice slightly longer response time.
> 
> Fixes: be38866fbb97 ("iio: vcnl4000: add support for VCNL4200")
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> ---
>  drivers/iio/light/vcnl4000.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index b0e241aaefb4..98428bf430bd 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -167,10 +167,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
>  	switch (id) {
>  	case VCNL4200_PROD_ID:
> -		/* Integration time is 50ms, but the experiments */
> -		/* show 54ms in total. */
> -		data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
> -		data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
> +		/* Default wait time is 50ms, add 20% tolerance. */
> +		data->vcnl4200_al.sampling_rate = ktime_set(0, 60000 * 1000);
> +		/* Default wait time is 4.8ms, add 20% tolerance. */
> +		data->vcnl4200_ps.sampling_rate = ktime_set(0, 5760 * 1000);
>  		data->al_scale = 24000;
>  		break;
>  	case VCNL4040_PROD_ID:

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

> -- 
> 2.16.4
> 
