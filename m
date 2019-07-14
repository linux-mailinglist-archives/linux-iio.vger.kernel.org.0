Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30367EE4
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 13:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfGNLyM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 07:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbfGNLyM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 07:54:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D2220820;
        Sun, 14 Jul 2019 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563105251;
        bh=A8Qa7tjeb/87Qg25rj3ZVCCuyFrcvyQfxBTm3qn2d9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ny++zaBSiHiuhJJ4wFxioqSoqEWey1i4jwzxnItFqC2yWoudurvf7uV5DOXxh4ff9
         prTsdaMXNSS7gNDcaFdFZOzXnCgs0zToRjrvCAKIUcVltbR4ApzNfkPNkUBpSqcc2B
         1J9Q3pFdZC8dPiGD/qWZgIfyAla6KY7FFy/HT7dI=
Date:   Sun, 14 Jul 2019 12:54:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/12] iio: adc: max9611: Fix misuse of GENMASK macro
Message-ID: <20190714125403.0789dc9e@archlinux>
In-Reply-To: <2929234bd4ecec41c0d012edc52416ef80f3e368.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
        <2929234bd4ecec41c0d012edc52416ef80f3e368.1562734889.git.joe@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 Jul 2019 22:04:17 -0700
Joe Perches <joe@perches.com> wrote:

> Arguments are supposed to be ordered high then low.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
Applied to the fixes-togreg branch of iio.git and marked for
stable etc.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max9611.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 917223d5ff5b..0e3c6529fc4c 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -83,7 +83,7 @@
>  #define MAX9611_TEMP_MAX_POS		0x7f80
>  #define MAX9611_TEMP_MAX_NEG		0xff80
>  #define MAX9611_TEMP_MIN_NEG		0xd980
> -#define MAX9611_TEMP_MASK		GENMASK(7, 15)
> +#define MAX9611_TEMP_MASK		GENMASK(15, 7)
>  #define MAX9611_TEMP_SHIFT		0x07
>  #define MAX9611_TEMP_RAW(_r)		((_r) >> MAX9611_TEMP_SHIFT)
>  #define MAX9611_TEMP_SCALE_NUM		1000000

