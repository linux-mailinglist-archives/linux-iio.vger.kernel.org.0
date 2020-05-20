Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888CD1DB2D1
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETMNo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 08:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETMNn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 May 2020 08:13:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5C3620758;
        Wed, 20 May 2020 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589976823;
        bh=eiU9ulrXo9//FrP90hIhY+NjAvrqcWQpknvLFOmH76Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yZYGkFyv04VHheGle3iylFTms1gPrfCjLo5r5/jHnQ4a4Jyjfzga/2ShzAut47vdw
         pqtQf0GTjRxUhmA72d0NTk7T5j9+v/cmZyKKSPu8+8bJnC4esPrYZNWNqc7td/1+ha
         rMIuivgOWHgczc+3s4+IOpPQ7J6gwZTLZL37/SNA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jbNbR-00Dv6k-BG; Wed, 20 May 2020 13:13:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 May 2020 13:13:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dummy_evgen: Fix use after free on error in
 iio_dummy_evgen_create()
In-Reply-To: <20200520120306.GD172354@mwanda>
References: <20200520120306.GD172354@mwanda>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <000f28ab442759baf6b6251b207aeabb@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dan.carpenter@oracle.com, jic23@kernel.org, bgolaszewski@baylibre.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, kstewart@linuxfoundation.org, allison@lohutok.net, linus.walleij@linaro.org, linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dan,

On 2020-05-20 13:03, Dan Carpenter wrote:
> We need to preserve the "iio_evgen->irq_sim_domain" error code before
> we free "iio_evgen" otherwise it leads to a use after free.
> 
> Fixes: 337cbeb2c13e ("genirq/irq_sim: Simplify the API")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iio/dummy/iio_dummy_evgen.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c
> b/drivers/iio/dummy/iio_dummy_evgen.c
> index 409fe0f7df1c..ee85d596e528 100644
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -45,6 +45,8 @@ static struct iio_dummy_eventgen *iio_evgen;
> 
>  static int iio_dummy_evgen_create(void)
>  {
> +	int ret;
> +
>  	iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
>  	if (!iio_evgen)
>  		return -ENOMEM;
> @@ -52,8 +54,9 @@ static int iio_dummy_evgen_create(void)
>  	iio_evgen->irq_sim_domain = irq_domain_create_sim(NULL,
>  							  IIO_EVENTGEN_NO);
>  	if (IS_ERR(iio_evgen->irq_sim_domain)) {
> +		ret = PTR_ERR(iio_evgen->irq_sim_domain);
>  		kfree(iio_evgen);
> -		return PTR_ERR(iio_evgen->irq_sim_domain);
> +		return ret;
>  	}
> 
>  	mutex_init(&iio_evgen->lock);

Nice catch. I've applied it to irq/irqchip-next, since
the offending patch is queued there.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
