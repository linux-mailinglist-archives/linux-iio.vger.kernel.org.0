Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1774F224CF9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgGRQTG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgGRQTG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:19:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 045EE2070E;
        Sat, 18 Jul 2020 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595089145;
        bh=5/QUCAv18TlotvDcbNU1UNonfnJZOuPtW3GBSlb47Ts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mKD8lrz7Eg92MsQXvnXwXBCz+jmbun4z0MhcKkkShu+Sz2GVLVpAt6brLw2hdBOEp
         Jgh7KFA9GuntnVyU0P6BWsIpNxa226EIo7GGcP95G9N19AtzH+ksBECjBFgz9t7jpo
         J+W7kUj76gw4FJKX+9BUSKPH/oQKsCnHtlMI5xJA=
Date:   Sat, 18 Jul 2020 17:19:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Correct kernel-doc inconsistency
Message-ID: <20200718171902.13fd2571@archlinux>
In-Reply-To: <20200715191656.29437-1-colton.w.lewis@protonmail.com>
References: <20200715191656.29437-1-colton.w.lewis@protonmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 19:17:09 +0000
Colton Lewis <colton.w.lewis@protonmail.com> wrote:

> Silence documentation build warning by correcting kernel-doc comment
> for iio_dev struct.
> 
> ./include/linux/iio/iio.h:574: warning: Function parameter or member 'read_buf' not described in 'iio_dev'
> ./include/linux/iio/iio.h:574: warning: Function parameter or member 'read_buf_len' not described in 'iio_dev'
> 
> Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
Hi Colton,

Thanks for the patch, but these elements have moved and now have docs
(very recent!)  See the testing branch of iio.git on git.kernel.org


Jonathan

> ---
>  include/linux/iio/iio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a1be82e74c93..48049b344e6c 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -522,6 +522,8 @@ struct iio_buffer_setup_ops {
>   * @flags:		[INTERN] file ops related flags including busy flag.
>   * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
>   * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
> + * @read_buf:		[INTERN] cached register contents for debugfs reads
> + * @read_buf_len:	[INTERN] length of @read_buf
>   */
>  struct iio_dev {
>  	int				id;

