Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECB128A375
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 01:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbgJJW5E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbgJJTWZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:22:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A656223AC;
        Sat, 10 Oct 2020 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602345958;
        bh=6MV7ZxzzlYAjamohlXNfIY2Q+5KrsiR/Ee2zbf25e0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WxLid6YLHjk6I+6yRZA6JLZh4F2BAz8dzYEWwJwMv8zrEOvbhni6NYlwu4QRTmeq1
         zR5wCvvwR+cS6rttLxx2JwgCL3evMLMUmafkqk+Z6WegDDqUjylLtzUNU9KgJosh+e
         karulIf+bMU1WevYZD1GLFNbJ8V8P+oqDy7B/QQg=
Date:   Sat, 10 Oct 2020 17:05:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v4 0/4] iio: adc: at91: misc driver cleanups
Message-ID: <20201010170553.69d4ad02@archlinux>
In-Reply-To: <20200930135048.11530-1-alexandru.ardelean@analog.com>
References: <20200930135048.11530-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Sep 2020 16:50:44 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This whole thing started because the lkp bot haunted me for a while with
> this build warning:
> 
> >> drivers/iio/adc/at91_adc.c:1439:34: warning: unused variable
> >> 'at91_adc_dt_ids' [-Wunused-const-variable]  
>    static const struct of_device_id at91_adc_dt_ids[] = {
>                                     ^
>    1 warning generated.
> 
> The fix may likely be patch 'iio: adc: at91_adc: add Kconfig dependency
> on the OF symbol'; was pointed out by Jonathan.

Series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it and see what we missed.

Thanks,

Jonathan

> 
> Changelog v3 -> v4:
> - https://lore.kernel.org/linux-iio/20200930125216.90424-1-alexandru.ardelean@analog.com/T/#t
> - for patch: 'iio: adc: at91_adc: remove platform data and move defs in driver file'
>    * updated/cleand up commit description
>    * remove redundant pdata erorr message
>    * return error code from at91_adc_probe_dt()
>    * remove 'if (!node)' null check in at91_adc_probe_dt()
> - added 'Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>'
>   for patch: 'iio: adc: at91_adc: add Kconfig dep on the OF symbol and remove of_match_ptr()'
> 
> Changelog v2 -> v3:
> - https://lore.kernel.org/linux-iio/20200930060008.42134-1-alexandru.ardelean@analog.com/T/#t
> - added 'Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>'
>   for patches:
>      iio: adc: at91_adc: use of_device_get_match_data() helper
>      iio: adc: at91_adc: const-ify some driver data
> - fixed description for patch 'iio: adc: at91_adc: add Kconfig dependency on the OF symbol'
> - squash patches:
>      iio: adc: at91_adc: add Kconfig dependency on the OF symbol
>      iio: adc: at91_adc: remove of_match_ptr() usage
> - added patch: 'iio: adc: at91_adc: remove platform data and move defs in driver file'
> 
> Changelog v1 -> v2:
> - https://lore.kernel.org/linux-iio/CA+U=Dspd11N-pXXnnY_5CSzNp50iRr7h16zXTCxo8Fk+v48F7g@mail.gmail.com/T/#m7c0efef4dc623776fe8bafdb5f734b0eaca50f82
> - for patch 'iio: adc: at91_adc: use of_device_get_match_data() helper'
>   changed description; it's just tidy-up patch, not a fix
> - added 2 more patches:
>   - iio: adc: at91_adc: add Kconfig dependency on the OF symbol
>   - iio: adc: at91_adc: remove of_match_ptr() usage
> 
> Alexandru Ardelean (4):
>   iio: adc: at91_adc: use of_device_get_match_data() helper
>   iio: adc: at91_adc: const-ify some driver data
>   iio: adc: at91_adc: add Kconfig dep on the OF symbol and remove
>     of_match_ptr()
>   iio: adc: at91_adc: remove platform data and move defs in driver file
> 
>  drivers/iio/adc/Kconfig                |  2 +-
>  drivers/iio/adc/at91_adc.c             | 73 ++++++++++----------------
>  include/linux/platform_data/at91_adc.h | 49 -----------------
>  3 files changed, 28 insertions(+), 96 deletions(-)
>  delete mode 100644 include/linux/platform_data/at91_adc.h
> 

