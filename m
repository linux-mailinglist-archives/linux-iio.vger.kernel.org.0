Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD52834BA
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 13:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJELO5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 07:14:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:42939 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgJELO4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Oct 2020 07:14:56 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 07:14:55 EDT
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4C4dCB6nDXz6D;
        Mon,  5 Oct 2020 13:09:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601896151; bh=29wYbsPytcZ/IhNwUazul/bDu8+y5OSG3sJTGkf3ZyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NiiFVbnNDhA2ihwlqCEJGp++fMbrcDcboJtUDl2cwQoFIYlpm9rwd9MCNzthDOECP
         5GoVOGOsUxT0L2YHwf1ZbtuFPIKRc367UTSIZVMISHEME+/iDpaCTlxLwYxyRFyV80
         /VY1SBsJOUIb3B0OHN95SST5/+TZvi3adakzDB38q6VSAQvwBMMx+zzgwsvEGNFO/W
         2X7Ny2gcIRdYr5ektFZm968NEkCBpeFi/z2jkRq1dUFQTS7H2DSPdBrFS/3IWmcUdg
         pb2EAJ3PUiJ1vYav7dvB7HG8BssFhzZbS3933jGhDBjV7hFki9Anu6GzCKj9G8uDqs
         KLOl3Pj7WlC5A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 5 Oct 2020 13:09:08 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     dmitry.torokhov@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: exynos: do not rely on 'users' counter in ISR
Message-ID: <20201005110908.GA3243@qmqm.qmqm.pl>
References: <20201005052420.GA3262631@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005052420.GA3262631@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 04, 2020 at 10:24:20PM -0700, dmitry.torokhov@gmail.com wrote:
> The order in which 'users' counter is decremented vs calling drivers'
> close() method is implementation specific, and we should not rely on
> it. Let's introduce driver private flag and use it to signal ISR
> to exit when device is being closed.
> 
> This has a side-effect of fixing issue of accessing inut->users
> outside of input->mutex protection.
> 
> Reported-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 22131a677445..7eb2a5df6e98 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -135,6 +135,8 @@ struct exynos_adc {
>  	u32			value;
>  	unsigned int            version;
>  
> +	bool			ts_enabled;
> +
>  	bool			read_ts;
>  	u32			ts_x;
>  	u32			ts_y;
> @@ -633,7 +635,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
>  	bool pressed;
>  	int ret;
>  
> -	while (info->input->users) {
> +	while (info->ts_enabled) {
>  		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
>  		if (ret == -ETIMEDOUT)
>  			break;
> @@ -712,6 +714,8 @@ static int exynos_adc_ts_open(struct input_dev *dev)
>  {
>  	struct exynos_adc *info = input_get_drvdata(dev);
>  
> +	info->ts_enabled = true;
> +	mb();
>  	enable_irq(info->tsirq);
>  
>  	return 0;
> @@ -721,6 +725,8 @@ static void exynos_adc_ts_close(struct input_dev *dev)
>  {
>  	struct exynos_adc *info = input_get_drvdata(dev);
>  
> +	info->ts_enabled = false;
> +	mb();
>  	disable_irq(info->tsirq);

This should be WRITE_ONCE paired with READ_ONCE in the ISR.

But is the check really needed? I see that this is to break waiting for
a touch release event, so I would assume this shouldn't wait forever
(unless the hardware is buggy) and breaking the loop will desync touch
state (I would guess this would be noticable by next user).

Best Regards,
Micha³ Miros³aw
