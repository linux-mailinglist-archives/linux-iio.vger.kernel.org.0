Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E997FB6680
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfIRO4y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 10:56:54 -0400
Received: from node.akkea.ca ([192.155.83.177]:52114 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbfIRO4x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Sep 2019 10:56:53 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Sep 2019 10:56:53 EDT
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 1668F4E2006;
        Wed, 18 Sep 2019 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1568818017; bh=aDA9/AHzNVD3j08pDbZWiFUas52ZZ6cyubjFG4eOZiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=QMuSzKaMBAFHgP/EjDhke0EjAT/xe4CjByAFKWwQkoto/nc3AstiUFT2eXc2J8vxN
         0nfQa50FOhCyYQ/70pI87wFSiZDc4F3uaJ7q0/twyeCnBix8tFymJwkGngyStSB+oA
         U6aXVM/kfOv19zM4nmh03AwNklgtBSexYzqjcevc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Xjo0-Iayjat; Wed, 18 Sep 2019 14:46:56 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id AAF344E2003;
        Wed, 18 Sep 2019 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1568818016; bh=aDA9/AHzNVD3j08pDbZWiFUas52ZZ6cyubjFG4eOZiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=UAziWB98xfvbPtYiuQjrmshWR8B+mj/ubp+ir4O5D5tfM2UxB1sWFhxUC3WYkWRTF
         Kq0pP91XqHexHmFeZcxJBMFo4rZe34lI+MyrGkgeAWe/yBDgSeP0nKTjossg8zGLa5
         B0enE7BoWuvAGyCPH14LLd5WgKZtj8/yUpMEmEAE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Sep 2019 07:46:56 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        tomas@novotny.cz, linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] iio: light: fix vcnl4000 devicetree hooks
In-Reply-To: <20190917145637.22605-1-m.felsch@pengutronix.de>
References: <20190917145637.22605-1-m.felsch@pengutronix.de>
Message-ID: <2eb045ee57319a3c1981adf90df80325@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2019-09-17 07:56, Marco Felsch wrote:
> Since commit ebd457d55911 ("iio: light: vcnl4000 add devicetree hooks")
> the of_match_table is supported but the data shouldn't be a string.
> Instead it shall be one of 'enum vcnl4000_device_ids'. Also the 
> matching
> logic for the vcnl4020 was wrong. Since the data retrieve mechanism is
> still based on the i2c_device_id no failures did appeared till now.
> 
> Fixes: ebd457d55911 ("iio: light: vcnl4000 add devicetree hooks")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Angus Ainslie (Purism) angus@akkea.ca

> ---
>  drivers/iio/light/vcnl4000.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c 
> b/drivers/iio/light/vcnl4000.c
> index 51421ac32517..f522cb863e8c 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -398,19 +398,19 @@ static int vcnl4000_probe(struct i2c_client 
> *client,
>  static const struct of_device_id vcnl_4000_of_match[] = {
>  	{
>  		.compatible = "vishay,vcnl4000",
> -		.data = "VCNL4000",
> +		.data = (void *)VCNL4000,
>  	},
>  	{
>  		.compatible = "vishay,vcnl4010",
> -		.data = "VCNL4010",
> +		.data = (void *)VCNL4010,
>  	},
>  	{
> -		.compatible = "vishay,vcnl4010",
> -		.data = "VCNL4020",
> +		.compatible = "vishay,vcnl4020",
> +		.data = (void *)VCNL4010,
>  	},
>  	{
>  		.compatible = "vishay,vcnl4200",
> -		.data = "VCNL4200",
> +		.data = (void *)VCNL4200,
>  	},
>  	{},
>  };
