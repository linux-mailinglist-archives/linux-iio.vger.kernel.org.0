Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220DF78427D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Aug 2023 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjHVNy0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Aug 2023 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjHVNyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2023 09:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E618B
        for <linux-iio@vger.kernel.org>; Tue, 22 Aug 2023 06:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C97C16572A
        for <linux-iio@vger.kernel.org>; Tue, 22 Aug 2023 13:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22E3C433C7;
        Tue, 22 Aug 2023 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692712463;
        bh=R+M9TLTNEBKe6+KO/xZMeADmJZrv10bRLpU7i413JxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tu9Bmh+3lYYBYVKAQVKkr72xq+t7c8TBs5ZASGSU3NV+61xwUKReslE2PYspnJUTO
         ZUxHuOKDjLhvl9QzvOX4HBDKQ80WYa3qKf9cSvlpoc/GghXVYD/2O5mI084osY3pS4
         rMGqaB781M8QKOxAoTs1HL6v7obD3UI+e53hvTRg=
Date:   Tue, 22 Aug 2023 15:54:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] First set of Counter updates for the 6.6 cycle
Message-ID: <2023082209-usage-kindly-f202@gregkh>
References: <ZN+cRfEqnKvzTMh3@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN+cRfEqnKvzTMh3@ishi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 18, 2023 at 12:28:53PM -0400, William Breathitt Gray wrote:
> The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:
> 
>   Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.6a

Pulled and pushed out, thanks.

greg k-h
