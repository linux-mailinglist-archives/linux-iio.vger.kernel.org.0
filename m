Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756F721C8AC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgGLLD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 07:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGLLD1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 07:03:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC3B20720;
        Sun, 12 Jul 2020 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594551806;
        bh=/QvVk2Eua5TNcZxHlq8SgAfe3GHep6XHGkfvgIEV4r8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YuVihRzA1RArTBGc/Q/C+x+GmQmtm9CO+FkrORiYx1+GlS0bvn9HHfzN0uiyXL0EQ
         LRRHkbhKijpEsYci9hGrvDLej3ZaXW2iagi8WPCXB508BYC5FmnJiSCzJDJQ9D/JCc
         yuLSCsQGvPd+JX369fXrbF3s/A0ZiBw+tE5Q6Voc=
Date:   Sun, 12 Jul 2020 12:03:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: adc: at91-sama5d2_adc: remove myself as
 co-maintainer
Message-ID: <20200712120322.7c0619a6@archlinux>
In-Reply-To: <20200709083316.7290-1-ludovic.desroches@microchip.com>
References: <20200709083316.7290-1-ludovic.desroches@microchip.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 Jul 2020 10:33:16 +0200
Ludovic Desroches <ludovic.desroches@microchip.com> wrote:

> Eugen is, now, more active and up to date on this topic than I. So I let
> him the full maintainance of this driver.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Applied.  Thanks for your work on this in the past!

Jonathan

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c87b94e6b2f6..0134ac72c42c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11361,7 +11361,6 @@ F:	Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>  F:	drivers/pwm/pwm-atmel.c
>  
>  MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
> -M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>  M:	Eugen Hristev <eugen.hristev@microchip.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported

