Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09E22DEF4
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgGZM0L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgGZM0L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:26:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC85F206D8;
        Sun, 26 Jul 2020 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595766371;
        bh=fCDE7fxJVUavVe9TqBxIOmulaM5drOP0NXsSYMv3oi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aM5rxlB0Jx7/3CB0uzqmU0b/o0Yu4nSluZv6s3JgeLvS+jvVMyKXbqrcBDZ14odZO
         EIt9Bm1plvCTlTSAuonHY4lvRm4pu0CGRZBOhuX9P6rWZHkvT93QiGVf8Lv9WVzl9Y
         Suuu/SkSbp6P91ZLm36iksMT1nGt6V+jiQf2Pv8A=
Date:   Sun, 26 Jul 2020 13:26:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v2 1/4] iio: cros_ec: Accept -EOPNOTSUPP as 'not
 supported' error code
Message-ID: <20200726132607.5e260674@archlinux>
In-Reply-To: <20200720202243.180230-2-linux@roeck-us.net>
References: <20200720202243.180230-1-linux@roeck-us.net>
        <20200720202243.180230-2-linux@roeck-us.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jul 2020 13:22:40 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> A follow-up patch will extend the number of errors reported by
> cros_ec_cmd_xfer_status(). Specifically, the function will return
> -EOPNOTSUPP if a command is not supported by the EC. Prepare for it.
> 
> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2: Added patch
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index a66941fdb385..e3aff95493dd 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -73,7 +73,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>  		st->core.param.sensor_offset.flags = 0;
>  
>  		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> -		if (ret == -EPROTO) {
> +		if (ret == -EPROTO || ret == -EOPNOTSUPP) {
>  			/* Reading calibscale is not supported on older EC. */
>  			*val = 1;
>  			*val2 = 0;

