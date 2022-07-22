Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7586F57DBBD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jul 2022 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiGVIH0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jul 2022 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVIH0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jul 2022 04:07:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7F89B576
        for <linux-iio@vger.kernel.org>; Fri, 22 Jul 2022 01:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EB73B8279F
        for <linux-iio@vger.kernel.org>; Fri, 22 Jul 2022 08:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0478C341C6;
        Fri, 22 Jul 2022 08:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658477243;
        bh=nIDVcevli/or6Zv72ZrPjYMa52OflgWMb+dLpXG/w1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jv7+Se1XOV0JJCwiXYNQjqEi00twf0U/T+2gZ1whsZI3JtqAIlYgXrXObsUQlVlZG
         SCf5ADk60tyUAENqHpDo7nyPjeETzVyOZSF36NR/VhdmkzwcYkDVsiMAH2DjX7yIPQ
         U5ehDYedP8duh18EV1EIxZAn/ID3qkXfbN2ykleI=
Date:   Fri, 22 Jul 2022 10:03:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd IIO pull request for 5.20
Message-ID: <YtpZyZhgx+I3E5mp@kroah.com>
References: <20220720150723.262e2084@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720150723.262e2084@jic23-huawei>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 20, 2022 at 03:07:23PM +0100, Jonathan Cameron wrote:
> The following changes since commit e0e1824bf69e9a342eb4854cf10ce2ba4c840e36:
> 
>   Merge tag 'extcon-next-for-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next (2022-07-16 07:24:37 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.20b

Pulled and pushed out, thanks.

greg k-h
