Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4878BD24
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 05:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjH2DJc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 23:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjH2DJZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 23:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0EC1;
        Mon, 28 Aug 2023 20:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E46E63093;
        Tue, 29 Aug 2023 03:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7211CC433C7;
        Tue, 29 Aug 2023 03:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693278562;
        bh=N7jWe3j6XOtjLkaxY7ui5Esh2q5j2JyJskPmlck1d0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQvbgAQ0H8IiVMWMELo4/mGJnYg7DtujfnQPPlgskzP9ZiBLvM4PY5pVAaMevfuwS
         jIrMTNMECfDSVLrDm92yKpUWPk+ecFKUmhkPnH6E911fqu2Y2HM5tNLgIb24BBjyc/
         1PbAiXHZ/0ag7m8qb2YeZUCeFJszZk6ERx3ts2uEAgqXRWc/MLVUFRt+X/vzaKtyQy
         cYDFmHvGNfBs48AX+v/18uSctrPXdhOsjZqMUiLxlh/0flb6BwFx+gyitdiiBTi3nN
         2iONo687DaNlUYrc+89H6gnwgGufIBzZJPXzvvNLvZrzni4FDBS7Z6Zz7Su7oAKH3x
         cuuEOaDXqwcWw==
Date:   Tue, 29 Aug 2023 11:09:18 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, lars@metafoo.de,
        chrome-platform@lists.linux.dev, gwendal@chromium.org,
        linux-iio@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: fix an use-after-free in
 cros_ec_sensors_push_data()
Message-ID: <ZO1hXo7J02w8sv0T@google.com>
References: <20230828094339.1248472-1-tzungbi@kernel.org>
 <20230828115359.054dc13a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828115359.054dc13a@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 28, 2023 at 11:53:59AM +0100, Jonathan Cameron wrote:
> Can we use iio_device_claim_buffer_mode() here?  I believe that has the right handling
> even though I don't think we've used it to protect iio_push_* before.  Normally it's about
> enforcing we stay in the mode if the read out of a channel needs to be handled differently
> in a read_raw() callback.
> 
> if (iio_device_claim_buffer_mode(indio_dev) < 0) {
> 	/* Not in buffer mode so fine to drop out - we got -EBUSY*/
> 	return 0;
> }
> //Otherwise mlock is held - though that's an implementation detail all we care about is we can't exit buffer mode.
> ...
> iio_push_...
> iio_device_release_buffer_mode(indio_dev);
> return 0;

Ack, fix it in v2(https://patchwork.kernel.org/project/linux-iio/patch/20230829030622.1571852-1-tzungbi@kernel.org/).
