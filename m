Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265251A5E0D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDLKbm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 06:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLKbm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 06:31:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A22206E9;
        Sun, 12 Apr 2020 10:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586687502;
        bh=hxvzPQ7gixVpCyxRSJHicmGU46t6PG5ZcN+dwTU8ORk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u6Xramq7OjfTlYLQkFk/ktCp4AwKS3QCuFk/noujq4J2BzOIo5GomcnaRUJS17Hhk
         gpZaO//FUxHmtvQ4Fbt5nDYtq62jbkPo8j+qDEyShO+lVviCEndkQdrlIUCrKjfBAf
         QQTXcfQWuLeifglX2VIw2adMsyN7qQZTwBfz5G8s=
Date:   Sun, 12 Apr 2020 11:31:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: at91: add atmel tcb capabilities
Message-ID: <20200412113137.1763f084@archlinux>
In-Reply-To: <20200409141401.321222-2-kamel.bouhara@bootlin.com>
References: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
        <20200409141401.321222-2-kamel.bouhara@bootlin.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  9 Apr 2020 16:13:59 +0200
Kamel Bouhara <kamel.bouhara@bootlin.com> wrote:

> Some atmel socs have extra tcb capabilities that allow using a generic
> clock source or enabling a quadrature decoder.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
> Changes from v2:
>  - Fixed first patch not applying on mainline
> 
>  include/soc/at91/atmel_tcb.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> index c3c7200ce151..7e47ace9255c 100644
> --- a/include/soc/at91/atmel_tcb.h
> +++ b/include/soc/at91/atmel_tcb.h
> @@ -39,6 +39,8 @@ struct clk;
>   */
>  struct atmel_tcb_config {
>  	size_t	counter_width;

This structure has existing kernel doc. Please add these new
elements and run ./scripts/kernel-doc over it check for any issues.

> +	bool    has_gclk;
> +	bool    has_qdec;
>  };
> 
>  /**
> --
> 2.25.0
> 

Thanks,

Jonathan
