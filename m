Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BF955052A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiFRNs7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiFRNsd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 09:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104B41A820
        for <linux-iio@vger.kernel.org>; Sat, 18 Jun 2022 06:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C06360C4F
        for <linux-iio@vger.kernel.org>; Sat, 18 Jun 2022 13:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86EDC3411A;
        Sat, 18 Jun 2022 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655560111;
        bh=BUvZ5ut6SDEHeNuHwXTj9U/+ZlkYd3SK4QKcNC5t0uQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NEzn4exNezZvEDHnVKjxMp/qfazUZmgerrQPEm1CB5TemToywLmeCJusOyrIL1rMO
         PfDnEn3QpnsrQlpqKCIdCqzBAgbnaRPrl+iej7BIb+KOU8bVQDxFFVUYXFdd9yzxtx
         PpmkF5OixbSaU3Ah6L7mpmp+DIqDxNJ9ACyExJsPshXTyGDDcHTzuvJK/v5mhs9WhL
         ISuKTN5/CHGGUYXHWhlOHGdTptmWGQTcavSctjHXm8xJN1xAIyszqTty6MhP7NtN2f
         YkpkLX33xasiwWa+Tuy6iyQJBS02EanqzwKL4awEX/tPAX4IX+MEfnxTA0m0IpDXDK
         LXxZ52IG7+PtA==
Date:   Sat, 18 Jun 2022 14:57:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:light:tsl2563: Replace cancel_delayed_work() with
 cancel_delayed_work_sync().
Message-ID: <20220618145750.3016e018@jic23-huawei>
In-Reply-To: <041b6745-f784-ff3f-9836-3f4397d35d94@I-love.SAKURA.ne.jp>
References: <041b6745-f784-ff3f-9836-3f4397d35d94@I-love.SAKURA.ne.jp>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jun 2022 00:04:00 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Since cancel_delayed_work(&chip->poweroff_work) does not guarantee that
> tsl2563_poweroff_work() is not running, tsl2563_set_power(chip, 0) can be
> called from tsl2563_poweroff_work() after tsl2563_get_power(chip) and
> tsl2563_set_power(chip, 1) are called. Use _sync version in order to make
> sure that tsl2563_poweroff_work() is no longer running.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Makes sense to me.

Applied to the togreg branch of iio.git.

Technically this may be a fix (at very least it removes some undesirable
behaviour) but I'm not proposing that we should backport it to stable.

Thanks,

Jonathan

> ---
>  drivers/iio/light/tsl2563.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index 4d89ac3a5bbc..bbb577459fb9 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -310,7 +310,7 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
>  		goto out;
>  
>  	if (!chip->int_enabled) {
> -		cancel_delayed_work(&chip->poweroff_work);
> +		cancel_delayed_work_sync(&chip->poweroff_work);
>  
>  		if (!tsl2563_get_power(chip)) {
>  			ret = tsl2563_set_power(chip, 1);
> @@ -638,7 +638,7 @@ static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
>  		chip->intr &= ~0x30;
>  		chip->intr |= 0x10;
>  		/* ensure the chip is actually on */
> -		cancel_delayed_work(&chip->poweroff_work);
> +		cancel_delayed_work_sync(&chip->poweroff_work);
>  		if (!tsl2563_get_power(chip)) {
>  			ret = tsl2563_set_power(chip, 1);
>  			if (ret)

