Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2502BC07D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 17:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgKUQTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 11:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgKUQTI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 11:19:08 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AE02145D;
        Sat, 21 Nov 2020 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605975548;
        bh=pkyHmU/dtheiAf5v1Lcf6M71Sc0moWCEOIv7SEI8pcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ydKxR4827Z20adUZd4NTfplVhTb2dPG43tP/wrkzP/jihcP83Qao2UdUuj+WvDKGE
         XYkYbnjFfoYEmGjqnlpA8v+++gHOoYo7KyvppikGELjMnz62Rt8UVIS/Qtu5DSXsd7
         ymyiRNn8oV0mYjHAHYEeXJ30RIf1+XWlXzGne1ag=
Date:   Sat, 21 Nov 2020 16:19:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
Message-ID: <20201121161902.5ede1a23@archlinux>
In-Reply-To: <20201116131141.3985-1-vilhelm.gray@gmail.com>
References: <20201116131141.3985-1-vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Nov 2020 08:11:41 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Purely for the record, Kamel, would you mind giving an
Acked-by for this?

Thanks,

Jonathan

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 913b5eb64e44..18d34536c4bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2095,6 +2095,12 @@ X:	drivers/net/wireless/atmel/
>  N:	at91
>  N:	atmel
>  
> +Microchip Timer Counter Block (TCB) Capture Driver
> +M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/counter/microchip-tcb-capture.c
> +
>  ARM/Microchip Sparx5 SoC support
>  M:	Lars Povlsen <lars.povlsen@microchip.com>
>  M:	Steen Hegelund <Steen.Hegelund@microchip.com>

