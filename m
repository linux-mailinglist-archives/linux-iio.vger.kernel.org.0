Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CFF78ADFD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjH1Ky4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 06:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjH1Kyr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 06:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31931B4;
        Mon, 28 Aug 2023 03:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D25B164546;
        Mon, 28 Aug 2023 10:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42082C433C7;
        Mon, 28 Aug 2023 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693220020;
        bh=8y/hwaWZhfTwXqVb1vUtDbs/7ky9ROf0YKU/PGn71Ik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T5j0eBQntJzwvDlqaqafpNhZ7NtzgrX0MWsTqCHGZrjev7v3zq7XOca3VECjGpfSv
         onpvEcUK3CciDVTzwrC7ZviuyELHkZFVAlY5GmW5VQtTmG9YkxxAwbrHKAhGvZkygW
         5OBr0moVPwgUN55bhKJY2waXq4UoXBZ+oW5+zD+TRBtS6zxVfk0/XIdGPBxE8xMi2z
         NmaT6tY5X8p7Y2ZSAoxI16grs64OHKofyVx48AM9FA5lKG3ZBFw1XeRk72zrkmu+qS
         xB0Peb0W4VbllxMAyei6n9lpodJ8o4xFB12768L1DPD08ryLzPoXmaTH4sJKJSnfPk
         +K6bZw9HxMp6g==
Date:   Mon, 28 Aug 2023 11:53:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, lars@metafoo.de,
        chrome-platform@lists.linux.dev, gwendal@chromium.org,
        linux-iio@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: fix an use-after-free in
 cros_ec_sensors_push_data()
Message-ID: <20230828115359.054dc13a@jic23-huawei>
In-Reply-To: <20230828094339.1248472-1-tzungbi@kernel.org>
References: <20230828094339.1248472-1-tzungbi@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Aug 2023 17:43:39 +0800
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> cros_ec_sensors_push_data() reads some `indio_dev` states (e.g.
> iio_buffer_enabled() and `indio_dev->active_scan_mask`) without holding
> the `mlock`.
> 
> An use-after-free on `indio_dev->active_scan_mask` was observed.  The
> call trace:
> [...]
>  _find_next_bit
>  cros_ec_sensors_push_data
>  cros_ec_sensorhub_event
>  blocking_notifier_call_chain
>  cros_ec_irq_thread
> 
> It was caused by a race condition: one thread just freed
> `active_scan_mask` at [1]; while another thread tried to access the
> memory at [2].
> 
> Fix it by acquiring the `mlock` before accessing the `indio_dev` states.
> 
> [1]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/industrialio-buffer.c#L1189
> [2]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c#L198
> 
> Cc: stable@vger.kernel.org
> Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Hi.

That's an interesting corner case and the comment above the iio_buffer_enabled() call
at least lets us know why this happens. A normal driver cannot call
iio_push_to_buffers_with_timestamp() unless the buffer is enabled
(and hence active_scan_mask is fixed), but here, for convenience the call is made anyway
if we race such that iio_buffer_enabled() is called and correct says the buffer is
enabled, but then immediately after that it is at least briefly disabled.

Now I'm not keen on mlock being touched by a driver because is an internal implementation
detail.

Can we use iio_device_claim_buffer_mode() here?  I believe that has the right handling
even though I don't think we've used it to protect iio_push_* before.  Normally it's about
enforcing we stay in the mode if the read out of a channel needs to be handled differently
in a read_raw() callback.

if (iio_device_claim_buffer_mode(indio_dev) < 0) {
	/* Not in buffer mode so fine to drop out - we got -EBUSY*/
	return 0;
}
//Otherwise mlock is held - though that's an implementation detail all we care about is we can't exit buffer mode.
...
iio_push_...
iio_device_release_buffer_mode(indio_dev);
return 0;

Thanks for the bug report and analysis.

Jonathan



> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index b72d39fc2434..a514d0dbafc7 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -182,17 +182,20 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
>  			      s16 *data,
>  			      s64 timestamp)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	s16 *out;
>  	s64 delta;
>  	unsigned int i;
>  
> +	mutex_lock(&iio_dev_opaque->mlock);
> +
>  	/*
>  	 * Ignore samples if the buffer is not set: it is needed if the ODR is
>  	 * set but the buffer is not enabled yet.
>  	 */
>  	if (!iio_buffer_enabled(indio_dev))
> -		return 0;
> +		goto exit;
>  
>  	out = (s16 *)st->samples;
>  	for_each_set_bit(i,
> @@ -210,6 +213,8 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
>  					   timestamp + delta);
>  
> +exit:
> +	mutex_unlock(&iio_dev_opaque->mlock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);

