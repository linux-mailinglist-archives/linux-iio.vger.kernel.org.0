Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42A5BBF2C
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 19:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIRRmA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 13:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRRl7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 13:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F368120B4
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 10:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B9356163C
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 17:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A02C433D6;
        Sun, 18 Sep 2022 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663522917;
        bh=5cR8leTuidRg+pXYq4omcIKIE5bmdA17myjJqPvQ7fg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f05A0Au13TNsKZBR9Regg0CrYZAceKm2TybNU0g+VTq1IxdgITWmxGuip89nczyKZ
         QVfl/9swH36AB8KgcQsYtq7LSLIJ4ugdokNyYOHsaoW23xYXaqL+eq6bEGQkqB0We7
         JyMkaOavlHVAGdtoFTsBU/aPa8yYm0Qcb3Ub4m6GL9RzLfJ//Q8doYx3jNmmj+Rldt
         pTZ+rgQICmtef4xCmwVLCSpCSeM2F9B1omlC0cKXxconu4GzwE/OZr+bwVxrTHzJ1Q
         6GZpk5IeQRKEFNILKol9uVz2OewVTLu5SH9wXNpkuZ/4rPKQOeLpdRLQANgqFfkQ2F
         7rMdVoN4uQbog==
Date:   Sun, 18 Sep 2022 18:42:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6/6] iio: light: st_uvis25: Use
 EXPORT_NS_SIMPLE_DEV_PM_OPS()
Message-ID: <20220918184200.00b663aa@jic23-huawei>
In-Reply-To: <20220807185618.1038812-7-jic23@kernel.org>
References: <20220807185618.1038812-1-jic23@kernel.org>
        <20220807185618.1038812-7-jic23@kernel.org>
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

On Sun,  7 Aug 2022 19:56:18 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using this new macro removes the need to mark the callbacks
> __maybe_unused.  One slightly complexity in this case is that
> the export will exist if CONFIG_PM is set, but only be used
> if CONFIG_PM_SLEEP is also set. This is harmless.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Applied

