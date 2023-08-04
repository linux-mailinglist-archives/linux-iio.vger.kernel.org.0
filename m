Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA777015F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjHDNWp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 09:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjHDNW3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 09:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B359CD
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 06:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CEC761FEC
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5787AC433C7;
        Fri,  4 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691155234;
        bh=BxXjl/Rqwmy14Qx/nGQwOZ1p+lnspXcA/ECSRddKYv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHi+ZrI8tTpctYDwlk/YnIIJIjDIPOs27iNpw2fYXHFVxbch0nvLvukbubdutTWtC
         BHpqkZp/WEiZY+Uth2Kz3kJiTGckilVWXH/ILHV9L1mvY0W3tvKIXvPBhxdryenwv+
         ei4th+rm4ZBSjK30zS1nwD/mkPS3pCZkjGCWh0Fk=
Date:   Fri, 4 Aug 2023 15:20:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for 6.5
Message-ID: <2023080410-vigorous-overhear-14a8@gregkh>
References: <20230801184913.40a1cdde@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801184913.40a1cdde@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 01, 2023 at 06:49:13PM +0100, Jonathan Cameron wrote:
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.5a

Pulled and pushed out, thanks.

greg k-h
