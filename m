Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0323E14E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHFSmv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 14:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgHFSmi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:42:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BC5221E2;
        Thu,  6 Aug 2020 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596739358;
        bh=u+1HGN9MykfdvUiljd3ywd/elL+4BMhGex8+hTChb8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CriL3uclknhQ5xQHnbof2S7VM3qtbLGk46mEtdSbiagrMvu7TUxRmWJ8wjCLuaaXO
         6mYWsAVva9o++qxYs7FmOOLirYnQdxrWou4+JRqKUX37lEyd0KDzakrufMEtYratoZ
         PG8/g7OOBx0qYnKqpgU9gyCvUKlXU8zy4cDG5rWY=
Date:   Thu, 6 Aug 2020 19:42:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 15/15] iio: sx9310: Use irq trigger flags from
 firmware
Message-ID: <20200806194233.68d92802@archlinux>
In-Reply-To: <20200803175559.v5.15.I4c344a6793007001bbb3c1c08e96d3acf893b36b@changeid>
References: <20200803235815.778997-1-campello@chromium.org>
        <20200803175559.v5.15.I4c344a6793007001bbb3c1c08e96d3acf893b36b@changeid>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Aug 2020 17:58:15 -0600
Daniel Campello <campello@chromium.org> wrote:

> From: Stephen Boyd <swboyd@chromium.org>
> 
> We shouldn't need to set default irq trigger flags here as the firmware
> should have properly indicated the trigger type, i.e. level low, in the
> DT or ACPI tables.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Series all applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it,

Thanks,

Jonathan

> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
>  - Added irq trigger flags commit to the series.
> 
> Changes in v2: None
> 
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index a68766708fb304..db97b5339d0eff 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -948,7 +948,7 @@ static int sx9310_probe(struct i2c_client *client)
>  		ret = devm_request_threaded_irq(dev, client->irq,
>  						sx9310_irq_handler,
>  						sx9310_irq_thread_handler,
> -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						IRQF_ONESHOT,
>  						"sx9310_event", indio_dev);
>  		if (ret)
>  			return ret;

