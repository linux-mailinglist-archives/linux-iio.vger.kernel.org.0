Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059D15709D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 20:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFZScv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 14:32:51 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35658 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFZScv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jun 2019 14:32:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 45D8E9E6A7E;
        Wed, 26 Jun 2019 19:32:49 +0100 (BST)
Date:   Wed, 26 Jun 2019 19:32:47 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] MAINTAINERS: add ADIS IMU driver library entry
Message-ID: <20190626193247.09006ac4@archlinux>
In-Reply-To: <20190625131328.11883-1-alexandru.ardelean@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jun 2019 16:13:24 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds the ADIS driver library to the MAINTAINERS list, and adds
> myself as the current maintainer of this library.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Hi Alexandru,

Given this only has a tangential relationship to the rest of the patches
I'll pick up now.

More generally this series is complex enough a cover letter would have
been good + 5/5 isn't anywhere that I can find?


Thanks,

Jonathan

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1eb971608ac4..544e23753e96 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -930,6 +930,13 @@ S:	Supported
>  F:	drivers/mux/adgs1408.c
>  F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
>  
> +ANALOG DEVICES INC ADIS DRIVER LIBRARY
> +M:	Alexandru Ardelean <alexandru.ardelean@analog.com>
> +S:	Supported
> +L:	linux-iio@vger.kernel.org
> +F:	include/linux/iio/imu/adis.h
> +F:	drivers/iio/imu/adis.c
> +
>  ANALOG DEVICES INC ADP5061 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-pm@vger.kernel.org

