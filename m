Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284A35BBF29
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIRRg6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 13:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRRg5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 13:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615B15828
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 10:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827FD61165
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 17:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575E2C433D6;
        Sun, 18 Sep 2022 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663522615;
        bh=u8k8+DODcrcFkut13VHQpCCI0JDipbYtH5HbieLlnUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NO1BTDCGfRHvIpcOYeEAUg45eL8kXePz7/q7EuOcL4xcaeWN7vANLoSv3pJKvfPLV
         tNC9oYRWlQXLQFFBX/DwOE+r3mdgNxCDcFgDAgbwAgduim6k2fWM0opm6D6fYdJb/m
         7GGyvDv1rmihyLHxrVRi67iKJB041qXozb004SlYdfLOXgJ1VM6kOXrD77SGmS45DX
         bn+1yUyYpSNyLauvsGpIgmwCWhQRNvEEQiZCYx3cihljnMdk7qDk/pI5UT4fxtWWiv
         SFBQNf7UzPTaSq1/X8WVc9aj9JoUR74+l3ksmiw+V/bykXtSdAb+c33KUjvPOB3doD
         m9D7Qw/3oLE5A==
Date:   Sun, 18 Sep 2022 18:36:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/6] iio: proximity: sx9360: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Message-ID: <20220918183659.425715b1@jic23-huawei>
In-Reply-To: <20220807185618.1038812-4-jic23@kernel.org>
References: <20220807185618.1038812-1-jic23@kernel.org>
        <20220807185618.1038812-4-jic23@kernel.org>
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

On Sun,  7 Aug 2022 19:56:15 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new macros avoid the need for marking the callbacks __maybe_unused
> whilst ensuring both callbacks and structure may be dropped by the compiler
> if CONFIG_PM_SLEEP is not enabled.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>

Applied.
