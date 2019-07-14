Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358C567FD2
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfGNPXy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 11:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfGNPXy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 11:23:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC238205F4;
        Sun, 14 Jul 2019 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563117832;
        bh=iEG5GUnMOj2lTxT3cH5J8+wWEV1D3nTI5obA2yehjR0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k9Rjj6lCSoW5bQLkrveeOvVl57G8AMdVPg9gDJtUMiAYl91u39QhDFSE8tDD/eTC9
         fwQxETGNeOedj/fI6/3RyJZK+8VhE/9Clbow/gKQ2INdTI0tx0+kXUuSteXDLOcBDX
         lv0ZSatScisnP7FC/Qb/f14rlG6TmMNfdwR4ZTLg=
Date:   Sun, 14 Jul 2019 16:23:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vivek Unune <npcomplete13@gmail.com>,
        Hannes Schmelzer <hannes.schmelzer@br-automation.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Martijn Braam <martijn@brixit.nl>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~martijnbraam/pmos-upstream@lists.sr.ht,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 3/3] iio: light: stk3310: Add device tree support
Message-ID: <20190714162324.66af1b33@archlinux>
In-Reply-To: <20190703180604.9840-3-luca@z3ntu.xyz>
References: <20190703180604.9840-1-luca@z3ntu.xyz>
        <20190703180604.9840-3-luca@z3ntu.xyz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  3 Jul 2019 20:05:59 +0200
Luca Weiss <luca@z3ntu.xyz> wrote:

> Add device tree support for the stk33xx family of ambient light sensors.
> 
> Tested-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/light/stk3310.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index b955183edfe8..185c24a75ae6 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -679,9 +679,18 @@ static const struct acpi_device_id stk3310_acpi_id[] = {
>  
>  MODULE_DEVICE_TABLE(acpi, stk3310_acpi_id);
>  
> +static const struct of_device_id stk3310_of_match[] = {
> +	{ .compatible = "sensortek,stk3310", },
> +	{ .compatible = "sensortek,stk3311", },
> +	{ .compatible = "sensortek,stk3335", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, stk3310_of_match);
> +
>  static struct i2c_driver stk3310_driver = {
>  	.driver = {
>  		.name = "stk3310",
> +		.of_match_table = stk3310_of_match,
>  		.pm = STK3310_PM_OPS,
>  		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
>  	},

