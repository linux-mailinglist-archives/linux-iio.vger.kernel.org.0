Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2ED5E60FA
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiIVL2b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiIVL15 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 07:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970AD8E39
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7784B62C28
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 11:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F90C433D6;
        Thu, 22 Sep 2022 11:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663846074;
        bh=7aKHpiR1IWKq8nEAHGSvfW3h3te/COPe33Zr1dZ9nTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2R0rB+2Q+U/vMdQndGsFBLzPaKWhLouLmPemCNh6v55zqZX1vCAWa1uos8rctRMux
         W/lJvTymTxdgkG/nARiNfZN+micQZTyhVXKR7OUPDUYQLCHA0/fScpIARRazrr5gF1
         qPr7t4NrA4oFZRydQpmBBe5SkZNk1kmo4WYOpfps=
Date:   Thu, 22 Sep 2022 13:27:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] counter: 104-quad-8: Fix skipped IRQ lines during
 events configuration
Message-ID: <YyxGuNPUP/febc9E@kroah.com>
References: <cover.1663844776.git.william.gray@linaro.org>
 <179eed11eaf225dbd908993b510df0c8f67b1230.1663844776.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179eed11eaf225dbd908993b510df0c8f67b1230.1663844776.git.william.gray@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 22, 2022 at 07:20:56AM -0400, William Breathitt Gray wrote:
> IRQ trigger configuration is skipped if it has already been set before;
> however, the IRQ line still needs to be OR'd to irq_enabled because
> irq_enabled is reset for every events_configure call. This patch moves
> the irq_enabled OR operation update to before the irq_trigger check so
> that IRQ line enablement is not skipped.
> 
> Fixes: c95cc0d95702 ("counter: 104-quad-8: Fix persistent enabled events bug")
> Link: https://lore.kernel.org/r/20220815122301.2750-1-william.gray@linaro.org/
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

This should have also cc: stable.  I'll add that when I apply it,
thanks.

greg k-h
