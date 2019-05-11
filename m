Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36A1A769
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfEKKIj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 06:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfEKKIj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 06:08:39 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBB3E217D6;
        Sat, 11 May 2019 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557569319;
        bh=SsM1ofarQZfVphiOzN1Muff7BbA5Z1fF8eufyrWWeQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HAXe6MeobDUFP7WvrCs1xsgjUoGOeAmEG9RNlbuH+Ab7ZuTAzxqpPSMxZdkfT5wtQ
         aQsGa/YmucANFbQql6kff84p7mospL8kV8nxz1TrQyR+xpNWlZI8bFaiPCfeDi02Hb
         VoB5x2tTwt28/2zhixssWI4f11DWdWK3ai+hQEbw=
Date:   Sat, 11 May 2019 11:08:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     linux-iio@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] iio: stmpe-adc: Reinit completion struct on begin
 conversion
Message-ID: <20190511110832.24f58e4a@archlinux>
In-Reply-To: <20190507143615.28477-2-dev@pschenker.ch>
References: <20190507143615.28477-1-dev@pschenker.ch>
        <20190507143615.28477-2-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 May 2019 16:36:12 +0200
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> In some cases, the wait_completion got interrupted. This caused the
> error-handling to mutex_unlock the function. The before turned on
> interrupt then got called anyway. In the ISR then completion() was
> called causing wrong adc-values returned in a following adc-readout.
> 
> Reinitialise completion struct to make sure the counter is zero
> when beginning a new adc-conversion.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Hi Philippe, 

To me this looks like a fix that we should consider applying to stable.
However, as it is in the middle of this series I'm not going to take
it via the fast route (during rc's). If people want to backport it
they will have to wait until after the next merge window.
If anyone has an urgent need, then shout in the next week and I'll
pull this version out and we can restructure the set.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/adc/stmpe-adc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index 9ec338ba3440..b3872eb37293 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -65,6 +65,8 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
>  
>  	mutex_lock(&info->lock);
>  
> +	reinit_completion(&info->completion);
> +
>  	info->channel = (u8)chan->channel;
>  
>  	if (info->channel > STMPE_ADC_LAST_NR) {
> @@ -105,6 +107,8 @@ static int stmpe_read_temp(struct stmpe_adc *info,
>  
>  	mutex_lock(&info->lock);
>  
> +	reinit_completion(&info->completion);
> +
>  	info->channel = (u8)chan->channel;
>  
>  	if (info->channel != STMPE_TEMP_CHANNEL) {

