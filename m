Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366AE4786D9
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 10:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhLQJO6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 04:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhLQJO6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 04:14:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDAC061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 01:14:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47468B82750
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 09:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D10C36AE5;
        Fri, 17 Dec 2021 09:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639732494;
        bh=2m0UeZt4cc48Zvd4dpr1y9a845BWrKc0VOJhgwAu9Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uATwjuKb3Vw7TLpGuSXHUsEG+jMA3nmjvBm8b2RY+nV5utYmuQ65FYMcC5C6TH3Al
         wvp+QaLNXMIGevFNMR4IZ4aiDBm4qWoJ+KKFp9gAP9JB2SGrMOrWlmuSEMQl1gsvjZ
         JnuqV4hKlLlqtnPyhuldEsVa3XkoYafy25fxCINbh9ypPG7NvbFsig6kRn6Uwo/oas
         KEI99sFHtjcwS3F0HhPZHmX0aAvtaCMiW2tme7KMV0TUj+2qdEf2joDWtwB5qSnmBU
         IH92qt+6pqNCeXZv/UTLvbx0MdrCLw/tGMfzX56HaFaDeBCDJ2FdjyTQYPaJ7/mPiw
         rtmhb88crL72Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1my9KD-00012q-4V; Fri, 17 Dec 2021 10:14:49 +0100
Date:   Fri, 17 Dec 2021 10:14:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/13] iio: lm3533: Use sysfs_emit()
Message-ID: <YbxVCcJgE55hOqPY@hovoldconsulting.com>
References: <20211216185217.1054495-1-lars@metafoo.de>
 <20211216185217.1054495-8-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216185217.1054495-8-lars@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 16, 2021 at 07:52:11PM +0100, Lars-Peter Clausen wrote:
> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> knows about the sysfs buffer specifics and has some built-in checks for
> size and alignment.

I realise that the above is some copy-paste boiler plate, but none of it
is really relevant here when the driver uses the attribute buffer
directly with scnprintf() and a PAGE_SIZE argument.

This should probably be rephrased in terms of consistency and the
documentation now claiming that only sysfs_emit() should be used in
show() functions (e.g. to avoid problems in drivers that would have
failed to follow the previous instructions).

> Use sysfs_emit() to format the custom device attributes of the lm3533
> driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

That said, the change itself is otherwise fine even I'm not sure it's
generally worth the churn to convert all existing show() functions:

Reviewed-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/iio/light/lm3533-als.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index 8a621244dd01..827bc25269e9 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -417,7 +417,7 @@ static ssize_t show_thresh_either_en(struct device *dev,
>  		enable = 0;
>  	}
>  
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", enable);
> +	return sysfs_emit(buf, "%u\n", enable);
>  }
>  
>  static ssize_t store_thresh_either_en(struct device *dev,
> @@ -474,7 +474,7 @@ static ssize_t show_zone(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", zone);
> +	return sysfs_emit(buf, "%u\n", zone);
>  }
>  
>  enum lm3533_als_attribute_type {
> @@ -530,7 +530,7 @@ static ssize_t show_als_attr(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>  
>  static ssize_t store_als_attr(struct device *dev,

Johan
