Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB746196C23
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgC2JkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 05:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgC2JkF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Mar 2020 05:40:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D288206DB;
        Sun, 29 Mar 2020 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585474805;
        bh=fZx8d3Yegoa/gkblvUC3Z2gOoaGWoaO7VSLCX/1FrKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wScFJMRoh4MtVrQgJFhJS2DiUS5pFlWgRZQjApYdkCP0vn8zKlIFBRxb+iyXUr1vU
         Zq0Kz/mNSfCmgCW24V/ERC+OUdMT/5ERzhdJdg7ZiJUHV41l81Km0VTzafKJj2tV/M
         Ln77THD0s8mJceG1YXQoCPNEVc8t5Dsr/qJ8iODs=
Date:   Sun, 29 Mar 2020 10:40:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer: drop left-over 'stufftoread' field
Message-ID: <20200329104001.6b62b4ab@archlinux>
In-Reply-To: <20200328163421.69784-1-alexandru.ardelean@analog.com>
References: <20200328163421.69784-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Mar 2020 18:34:21 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This seems like a left-over from a7348347ba8a4 ("staging:iio: Add polling
> of events on the ring access chrdev.").
> 
> Then it was moved into the sca3000 driver around 9dd4694dafbd8 ("iio:
> staging: sca3000: hide stufftoread logic"), and that one seemed to be the
> only user of this.
> 
> Then it eventually was no longer used after 152a6a884ae1
> ("staging:iio:accel:sca3000 move to hybrid hard / soft buffer design.")
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Oops.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  include/linux/iio/buffer_impl.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index a4d2d8061ef6..1e7edf6bed96 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -115,9 +115,6 @@ struct iio_buffer {
>  	 */
>  	struct attribute_group scan_el_group;
>  
> -	/* @stufftoread: Flag to indicate new data. */
> -	bool stufftoread;
> -
>  	/* @attrs: Standard attributes of the buffer. */
>  	const struct attribute **attrs;
>  

