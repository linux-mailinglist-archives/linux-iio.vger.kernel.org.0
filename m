Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817CC107EE3
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 15:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfKWOhN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 09:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfKWOhM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:37:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7342068F;
        Sat, 23 Nov 2019 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574519832;
        bh=be73bIOVQc3o0JQzcStBmsglN4xPwR3eSFsxrHjP6M4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2s3P//BADv9VVa0T+21SdNeqZzDLKkqpB0ku7lHsqxmI24TRCCPiTDnIh+NUmYwIX
         wm07P2dX1jEcqlXuZmFLo9/CU9aLHAp7BB9+aH0si2EeIWagDdIrNhvcqLl3tYYzI6
         yFzGg+3omUaOVhMM0ASNn4p/vCfCtcdvwoyQ/Amw=
Date:   Sat, 23 Nov 2019 14:37:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add maintainer for ping iio sensors
Message-ID: <20191123143705.6e0e2868@archlinux>
In-Reply-To: <20191118073648.tk4otab6alsiuzt7@arbad>
References: <20191118073648.tk4otab6alsiuzt7@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 08:36:50 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add a maintainer for the new parallax PING))) and LaserPING IIO sensors
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied,

Thanks,

Jonathan

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6c34d04ce95..ad469adffb99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12264,6 +12264,13 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/panasonic-laptop.c
>  
> +PARALLAX PING IIO SENSOR DRIVER
> +M:	Andreas Klinger <ak@it-klinger.de>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> +F:	drivers/iio/proximity/ping.c
> +
>  PARALLEL LCD/KEYPAD PANEL DRIVER
>  M:	Willy Tarreau <willy@haproxy.com>
>  M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

