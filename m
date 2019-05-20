Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E90A2410D
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfETTUe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 15:20:34 -0400
Received: from ms.lwn.net ([45.79.88.28]:35682 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETTUe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 May 2019 15:20:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C87AA6A2;
        Mon, 20 May 2019 19:20:33 +0000 (UTC)
Date:   Mon, 20 May 2019 13:20:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH -next] counter: fix Documentation build error due to
 incorrect source file name
Message-ID: <20190520132032.74912949@lwn.net>
In-Reply-To: <b6475070-f336-1093-ff0f-6bc8d5fda35e@infradead.org>
References: <b6475070-f336-1093-ff0f-6bc8d5fda35e@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 21:29:58 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc build error in Documentation/driver-api/generic-counter.rst
> of incorrect source file name.
> Fixes this warning and error:
> 
> Error: Cannot open file ../drivers/counter/generic-counter.c
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -export ../drivers/counter/generic-counter.c' failed with return code 2
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
> ---
>  Documentation/driver-api/generic-counter.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20190517.orig/Documentation/driver-api/generic-counter.rst
> +++ linux-next-20190517/Documentation/driver-api/generic-counter.rst
> @@ -251,7 +251,7 @@ for defining a counter device.
>  .. kernel-doc:: include/linux/counter.h
>     :internal:
>  
> -.. kernel-doc:: drivers/counter/generic-counter.c
> +.. kernel-doc:: drivers/counter/counter.c
>     :export:
>  
>  Implementation

Applied, thanks.

jon
