Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A322266
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfERIzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 04:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbfERIzs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 04:55:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91DFD206BF;
        Sat, 18 May 2019 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558169748;
        bh=eW30US+1ShrTXtzi6QRLnFCjDmgs7AvKH0a+6LYVU78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qkRdxRCf61Dw+UE7QahGm1+1IgCaOiisoeS+nF+67YaTq//Yc7Teyv656RypU9OlI
         Yt2pMfWn8pJGLm9EEsdcbh9O75Vd+WsacyGIt4txI+jh26+JF1oOX+s8lzGv9DCDeb
         GblPmZ4cKBDJxhs5sXb2u3MoDAIVch9vYwSwrKtw=
Date:   Sat, 18 May 2019 09:55:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio convert to SPDX license tags
Message-ID: <20190518095540.26dc2055@archlinux>
In-Reply-To: <20190512132505.q2j2tpplw3gkl245@flea>
References: <20190512083241.9191-1-tiny.windzz@gmail.com>
        <20190512132505.q2j2tpplw3gkl245@flea>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 May 2019 15:25:05 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Sun, May 12, 2019 at 04:32:41AM -0400, Yangtao Li wrote:
> > Updates license to use SPDX-License-Identifier.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>  
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Maxime
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

