Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA51298CE
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLWQkh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:40:37 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34676 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLWQkg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Dec 2019 11:40:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 149DC9E73DD;
        Mon, 23 Dec 2019 16:40:34 +0000 (GMT)
Date:   Mon, 23 Dec 2019 16:40:32 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: pms7003: fix unmet triggered buffer
 dependency
Message-ID: <20191223164032.78498e6b@archlinux>
In-Reply-To: <20191213213808.124603-1-tduszyns@gmail.com>
References: <20191213213808.124603-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Dec 2019 22:38:08 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> IIO triggered buffer depends on IIO buffer which is missing from Kconfig
> file. This should go unnoticed most of the time because there's a
> chance something else has already enabled buffers. In some rare cases
> though one might experience kbuild warnings about unmet direct
> dependencies and build failures due to missing symbols.
> 
> Fix this by selecting IIO_BUFFER explicitly.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the fixes-togreg branch of iio.git. Marked for stable and
with the addition of a fixes tag.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index fa4586037bb8..0b91de4df8f4 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -65,6 +65,7 @@ config IAQCORE
>  config PMS7003
>  	tristate "Plantower PMS7003 particulate matter sensor"
>  	depends on SERIAL_DEV_BUS
> +	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here to build support for the Plantower PMS7003 particulate

