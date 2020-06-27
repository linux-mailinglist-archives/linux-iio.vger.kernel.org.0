Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9720C2A4
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgF0PMo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 11:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgF0PMo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 11:12:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F51620FC3;
        Sat, 27 Jun 2020 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593270763;
        bh=C6b0LLCAfmlV8FuDgswjds1M0qKz2uubTGMmipdtiwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nx9ob/1Z3xEmUfyTesUHH/3RtYpfk6whGJMqapC/D4fqNzfZs0LIw9XkFaGEtB+vG
         kOJklqX/q8jA2bOwFc+li4h2wae7WFS42yl2AmWckERgAdf7k6TutqvaAO/CufC9g0
         asIK5LM7kJLjljQUlpdFIZ1nE1qrgM1tfJc9gvyg=
Date:   Sat, 27 Jun 2020 16:12:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <knaack.h@gmx.de>
Subject: Re: [PATCH v3 1/7] iio: core: remove iio_priv_to_dev() helper
Message-ID: <20200627161239.72159cea@archlinux>
In-Reply-To: <20200621123345.2469-2-alexandru.ardelean@analog.com>
References: <20200621123345.2469-1-alexandru.ardelean@analog.com>
        <20200621123345.2469-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jun 2020 15:33:39 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> All users of this helper have been updated to not use it.
> Remove it now, so that we don't need to move it when creating the
> iio_dev_opaque structure.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
(note I discovered I'd not applied the at91-sama5d patch when I said I had
so noticed when doing local tests on this).

Thanks,

Jonathan

> ---
>  include/linux/iio/iio.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 1c1d02107722..10a6d97a8e3e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -703,12 +703,6 @@ static inline void *iio_priv(const struct iio_dev *indio_dev)
>  	return (char *)indio_dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
>  }
>  
> -static inline struct iio_dev *iio_priv_to_dev(void *priv)
> -{
> -	return (struct iio_dev *)((char *)priv -
> -				  ALIGN(sizeof(struct iio_dev), IIO_ALIGN));
> -}
> -
>  void iio_device_free(struct iio_dev *indio_dev);
>  struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
>  struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,

