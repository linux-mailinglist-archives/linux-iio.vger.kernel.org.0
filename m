Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4534256A9
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJGPge (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 11:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhJGPge (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 11:36:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7870761245;
        Thu,  7 Oct 2021 15:34:39 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:38:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] docs: counter: Include counter-chrdev kernel-doc to
 generic-counter.rst
Message-ID: <20211007163843.050e430f@jic23-huawei>
In-Reply-To: <20211005061437.4846-1-vilhelm.gray@gmail.com>
References: <20211005061437.4846-1-vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Oct 2021 15:14:37 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The counter-chrdev.c file exports the counter_push_event() function.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied

Thanks,

J
> ---
>  Documentation/driver-api/generic-counter.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> index ae9d3c2079f1..1b487a331467 100644
> --- a/Documentation/driver-api/generic-counter.rst
> +++ b/Documentation/driver-api/generic-counter.rst
> @@ -237,6 +237,9 @@ for defining a counter device.
>  .. kernel-doc:: drivers/counter/counter-core.c
>     :export:
>  
> +.. kernel-doc:: drivers/counter/counter-chrdev.c
> +   :export:
> +
>  Driver Implementation
>  =====================
>  
> 
> base-commit: 4c2d124b3c9dade959740e0a842868ca4520cf46
> prerequisite-patch-id: afa00fa5e8b34bd71871f41c5542dcfd688d03e0

