Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D626C477179
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 13:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhLPMQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 07:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbhLPMQt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 07:16:49 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E82EC061574
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 04:16:49 -0800 (PST)
Received: from [81.101.6.87] (port=52566 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxpgl-00031Z-8l; Thu, 16 Dec 2021 12:16:47 +0000
Date:   Thu, 16 Dec 2021 12:22:13 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Zach DeCook <zachdecook@librem.one>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: event_monitor: Flush output on event
Message-ID: <20211216122131.12c29551@jic23-huawei>
In-Reply-To: <20211208214806.3225-1-zachdecook@librem.one>
References: <20211208214806.3225-1-zachdecook@librem.one>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  8 Dec 2021 16:48:08 -0500
Zach DeCook <zachdecook@librem.one> wrote:

> By flushing the output, iio_event_monitor can be more useful to programs
> chained along with it.
> 
>   iio_event_monitor stk3310 | awk '/rising/{system("my_unlockscreen.sh")} /falling/{system("my_lockscreen.sh")}'
> 
> Without this flush, the above example would buffer a number of events,
> then after a while run the lock/unlock scripts several times.
> 
> Signed-off-by: Zach DeCook <zachdecook@librem.one>
Seems sensible to me.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day to poke at
it (possibly - no idea what it does with tools patches :)

Jonathan

> ---
>  tools/iio/iio_event_monitor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 0076437f6..b94a16ba5 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -279,6 +279,7 @@ static void print_event(struct iio_event_data *event)
>  		printf(", direction: %s", iio_ev_dir_text[dir]);
>  
>  	printf("\n");
> +	fflush(stdout);
>  }
>  
>  /* Enable or disable events in sysfs if the knob is available */

