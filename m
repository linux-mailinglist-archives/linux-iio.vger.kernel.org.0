Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A635CC9E5
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 14:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfJEMWa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 08:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJEMWa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 08:22:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD412133F;
        Sat,  5 Oct 2019 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570278149;
        bh=3btm0i9Jw2jAGC2vk2TzyudcZjIAbZJevaaA7q42kDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ULciMT7q1Ifab+Ce7gpWYG4BY3lC39MOhrnndHW6XgjSHlwUkRM5mQop8v2QAmVFn
         TSAIVu2+gCgvGJx3A8EX9Y8hCkudgmbej6qfj5UinDN2AG8/Z4opgPJfhxugg1OjDK
         GyVe2JN+SZMhxYGeCzID8ui9F4x7MMH6aYDfObO8=
Date:   Sat, 5 Oct 2019 13:22:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add entry for ROHM BH1750 driver
Message-ID: <20191005132225.63019df2@archlinux>
In-Reply-To: <20190916190024.9955-3-tduszyns@gmail.com>
References: <20190916190024.9955-1-tduszyns@gmail.com>
        <20190916190024.9955-3-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 21:00:24 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add myself as a ROHM BH1750 ambient light sensor driver maintainer.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0c03740b9fb..928059c5cd49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13792,6 +13792,12 @@ L:	linux-serial@vger.kernel.org
>  S:	Odd Fixes
>  F:	drivers/tty/serial/rp2.*
>  
> +ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
> +M:	Tomasz Duszynski <tduszyns@gmail.com>
> +S:	Maintained
> +F:	drivers/iio/light/bh1750.c
> +F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
> +
>  ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
>  M:	Marek Vasut <marek.vasut+renesas@gmail.com>
>  L:	linux-kernel@vger.kernel.org

