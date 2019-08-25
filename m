Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D987A9C561
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2019 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfHYSJX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Aug 2019 14:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbfHYSJW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 14:09:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02ED206E0;
        Sun, 25 Aug 2019 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566756561;
        bh=hbQkd9m6IseZzFq6Etn1PdspQTSTv6FY/5gFLDiTlMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EEgRQ8vfNcONRYkA+3GtdVpKn3DBiATITm7qKEoVvzKASzMxy2D+7JHGmO3Vv6UXW
         SAByMHTB3/HxY3R64+Igw/ybTKmYRe5QxlBb7JzMjjfDN3v5UYBMEH44jT+QBbJJ6r
         sNlAY+y/gv+Zf/F0laXlq0KVBU9itHVz9uXXY8DE=
Date:   Sun, 25 Aug 2019 19:09:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        ak@it-klinger.de, robh@kernel.org, songqiang1304521@gmail.com,
        tglx@linutronix.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Kconfig: Fix the reference to the RFD77402 ToF sensor
 in the 'help' section
Message-ID: <20190825190916.7ca6e750@archlinux>
In-Reply-To: <20190819044827.5259-1-christophe.jaillet@wanadoo.fr>
References: <20190819044827.5259-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Aug 2019 06:48:27 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> This should be RFD77402, not RFD77420.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure that the Kconfig prefix is correct. I have choosen it because of
> commit 21cf20a84a ("Kconfig: change configuration of srf04 ultrasonic iio sensor")

Applied thanks.  I left the prefix alone, though it's a bit unusual.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 6b5cce6f1a7b..d53601447da4 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -62,7 +62,7 @@ config RFD77402
>  	tristate "RFD77402 ToF sensor"
>  	depends on I2C
>  	help
> -	  Say Y to build a driver for the RFD77420 Time-of-Flight (distance)
> +	  Say Y to build a driver for the RFD77402 Time-of-Flight (distance)
>  	  sensor module with I2C interface.
>  
>  	  To compile this driver as a module, choose M here: the

