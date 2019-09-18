Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A67B6681
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfIRO4y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 10:56:54 -0400
Received: from node.akkea.ca ([192.155.83.177]:52120 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731382AbfIRO4y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Sep 2019 10:56:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 142824E200E;
        Wed, 18 Sep 2019 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1568818052; bh=J31pd4dcqN6Q5YFE9iBNAt1xV31UYqUwnYlvnxPItS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=jdD0bh1Q+wW8ZREnOWvXJkMobd+URstwXYbktTo5FPEIpfMQcmXxZiLe6nZ0aW4Wt
         rw/aTWwAtzQXyP3c1NBDkIJ6JDr4vPbKfQJtUmii7DRUAU44e2gfsE2Vq2iUk1qf/Q
         WzgmDNRyNM568WT137Xo/ePjCP9LT+HBGUbOYW4I=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KUq2N-4ii4t3; Wed, 18 Sep 2019 14:47:31 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id C16FF4E2003;
        Wed, 18 Sep 2019 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1568818051; bh=J31pd4dcqN6Q5YFE9iBNAt1xV31UYqUwnYlvnxPItS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=LdfqEv+U6Wmpn/VbNx6esIhSLBY7AiTrDNOayvJDDE1K2ZZzkSreYZ43P8eTuSv3b
         oI2PlOWtesfAl+1PnYvqH5QaqFKB8B1MigWCukTgWzGCDQ2IcCsJO7cr8A3bODQWju
         5uQ+aShWkYOnq35wub+UMOOVUHBZU9fmlh6USB+k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Sep 2019 07:47:31 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        tomas@novotny.cz, linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] iio: light: add missing vcnl4040 of_compatible
In-Reply-To: <20190917145637.22605-2-m.felsch@pengutronix.de>
References: <20190917145637.22605-1-m.felsch@pengutronix.de>
 <20190917145637.22605-2-m.felsch@pengutronix.de>
Message-ID: <a93e2e861ac7f2473a05929f4511bfa0@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2019-09-17 07:56, Marco Felsch wrote:
> Commit 5a441aade5b3 ("iio: light: vcnl4000 add support for the VCNL4040
> proximity and light sensor") added the support for the vcnl4040 but
> forgot to add the of_compatible. Fix this by adding it now.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Angus Ainslie (Purism) angus@akkea.ca

> ---
>  drivers/iio/light/vcnl4000.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/light/vcnl4000.c 
> b/drivers/iio/light/vcnl4000.c
> index f522cb863e8c..16dacea9eadf 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -408,6 +408,10 @@ static const struct of_device_id 
> vcnl_4000_of_match[] = {
>  		.compatible = "vishay,vcnl4020",
>  		.data = (void *)VCNL4010,
>  	},
> +	{
> +		.compatible = "vishay,vcnl4040",
> +		.data = (void *)VCNL4040,
> +	},
>  	{
>  		.compatible = "vishay,vcnl4200",
>  		.data = (void *)VCNL4200,
