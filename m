Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3405F5BBF2A
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIRRiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 13:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRRiF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 13:38:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AA615828
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 10:38:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93B1CB80F4B
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 17:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAAFC433D6;
        Sun, 18 Sep 2022 17:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663522682;
        bh=4NB/rTsiACbx2utHild21tXDUiKQuo52kfsxxZ3RwBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rBlgYVdvGgWXYpoAJUqcMViokT8cA5HdjrztznXR6c+jp51a3rKTq9ZKz+7rpQQHx
         IKzg3N28wJghDWaUCJNCsTG3gE+VpJ0OEjZsdsPYSCu+z7T1Is9sG2L9gfbbvSxIsA
         2nvtCcEoO4HINPatemxhQirhxQQf7u/GWkZM9nuyGgEg7WwmvxTw6Xsf81vofYPX0x
         kFqSg/+b2OqxhHuWYYfFBMkDbtnENXKvMtexQW3ycHQaO3xHF2/+OykH9ZsmSsgnKb
         If1w5aDeBGrCurTI5lw7JyL6289HGrFxjEYca2Rya1mQ0R+SNqwFvCMcbBfc9MJ/m9
         fk0Z2sM5zPiLg==
Date:   Sun, 18 Sep 2022 18:38:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/6] iio: proximity: srf04: Use pm_ptr() to remove
 unused struct dev_pm_ops
Message-ID: <20220918183805.183e3eba@jic23-huawei>
In-Reply-To: <20220807185618.1038812-5-jic23@kernel.org>
References: <20220807185618.1038812-1-jic23@kernel.org>
        <20220807185618.1038812-5-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun,  7 Aug 2022 19:56:16 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> If CONFIG_PM is not set, the pm_ptr() will ensure that the struct
> dev_pm_ops and callbacks are removed without the need for __maybe_unused
> markings.
> 
> In this case we can't simply use DEFINE_RUNTIME_DEV_PM_OPS() because
> that would provide suspend and resume functions without the
> checks the driver is doing before calling runtime_pm functions
> (whether the necessary GPIO is provided).  It may be possible to
> clean that up in future by moving the checks into the callbacks.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andreas Klinger <ak@it-klinger.de>
Some consensus reached in the discussion so even though no one
gave a tag I feel comfortable taking this one.
The suggested follow up change needs hardware to boost confidence
that there are no side effects.

Applied.

Jonathan
