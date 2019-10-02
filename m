Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1351CC890A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 14:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfJBMwu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 2 Oct 2019 08:52:50 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56113 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBMwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 08:52:50 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9D9C5240018;
        Wed,  2 Oct 2019 12:52:47 +0000 (UTC)
Date:   Wed, 2 Oct 2019 14:52:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/7] iio: adc: max1027: Prepare the introduction of
 different resolutions
Message-ID: <20191002145246.491e2760@xps13>
In-Reply-To: <20191002123025.21413-5-miquel.raynal@bootlin.com>
References: <20191002123025.21413-1-miquel.raynal@bootlin.com>
        <20191002123025.21413-5-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Wed,  2 Oct 2019
14:30:22 +0200:

> Maxim's max1027/29/31 series returns the measured voltages with a
> resolution of 10 bits. There is a very similar series, max1227/29/31
> which works very similarly but uses a resolution of 12 bits. Prepare
> the support for these chips by turning the 'depth' into a macro
> parameter instead of hardcoding it everywhere. Also reorganize just a
> bit the macros at the top to avoid repeating tens of lines when adding
> support for a new chip.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 81 +++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index f9b473ee6711..fc75764a6fd7 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -78,12 +78,15 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
>  	{ .compatible = "maxim,max1027" },
>  	{ .compatible = "maxim,max1029" },
>  	{ .compatible = "maxim,max1031" },
> +	{ .compatible = "maxim,max1227" },
> +	{ .compatible = "maxim,max1229" },
> +	{ .compatible = "maxim,max1231" },

Just spotted a mistake here: the addition of these three lines, while
harmless, should have come in patch 5/7.

Let me respin the series with this corrected.

Thanks and sorry for the noise,
Miquèl
