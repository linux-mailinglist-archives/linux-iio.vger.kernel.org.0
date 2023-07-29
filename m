Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4BC767E9C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jul 2023 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjG2LVP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Jul 2023 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjG2LVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jul 2023 07:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6C1A5
        for <linux-iio@vger.kernel.org>; Sat, 29 Jul 2023 04:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3371860B92
        for <linux-iio@vger.kernel.org>; Sat, 29 Jul 2023 11:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EF5C433C7;
        Sat, 29 Jul 2023 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690629672;
        bh=Da5qqJ00EwlvAqge1RCcLr/wQtNOocebrT9i5qo8yfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JZ7R701lOTslitnU6OdT1l/LSLMenkwtITPXYYE1nAxnDdsO4TxCK21LT9rsJNbzA
         TN072ACoCxBfv5vYyjnnxvLPk+xdqU5mxAbuiUqqM1f78WSpl216Dy1XiXyKA1iCdE
         QqeIRwc2Ukxrap6cTkWAiJiBjZqiCUL4/xWujANC5bcMg7DrTYAGDrN5dMGW1g0JY4
         MY4hqxAigZAuR0s2rm09d5gIhIhSRZRe7V9atK6HQVuB7Mavmz+eVeGQaY2FMW4Hgc
         3Ch2Lv680PXua1i6AKfI75RArNfKva1s2Rg3jAqals/h7gb+1M71wyypTEdUffQchz
         zDfjtdj3euYdA==
Date:   Sat, 29 Jul 2023 12:21:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>, Yiyuan Guo <yguoaz@gmail.com>,
        <lars@metafoo.de>, <bleung@chromium.org>, <groeck@google.com>,
        <dianders@chromium.org>, <mazziesaccount@gmail.com>,
        <gwendal@chromium.org>, <linux-iio@vger.kernel.org>,
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for
 cros_ec_command
Message-ID: <20230729122115.6c2b2593@jic23-huawei>
In-Reply-To: <20230718103702.0000546e@Huawei.com>
References: <20230630143719.1513906-1-yguoaz@gmail.com>
        <20230716141028.4c57c5c7@jic23-huawei>
        <ZLSw1FxccNOqE52C@google.com>
        <20230718103702.0000546e@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jul 2023 10:37:02 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 17 Jul 2023 11:09:08 +0800
> Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> 
> > On Sun, Jul 16, 2023 at 02:10:28PM +0100, Jonathan Cameron wrote:
> > [...]  
> > > 2) Various people commented on earlier versions, and I'm waiting for them to confirm
> > > they are fine with this version.    
> > 
> > The version addressed all my comments and LGTM.  
> 
> Tag?  I can pick up without, but it's nice to record this
> formally.   Reviewed-by seems appropriate here.

Applied to the fixes-togreg branch of iio.git.

Note the fixes tag had to be replaced with the full version.
No shortening allowed.

Jonathan
