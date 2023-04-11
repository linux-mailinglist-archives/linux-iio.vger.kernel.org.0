Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A96DD46B
	for <lists+linux-iio@lfdr.de>; Tue, 11 Apr 2023 09:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDKHlH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Apr 2023 03:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDKHlG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2023 03:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A61733
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 00:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 448CE6225C
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 07:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38999C433EF;
        Tue, 11 Apr 2023 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681198864;
        bh=y4ULD30jHTVkZ8fWKjF1aiVKZfG0XQfRwtyn1/xMu2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0KGYRxalRQ3jJrbJPmj/ch7y3hr5O5owYkmH6JzSy8FdI0vTF7zr2zl1CRB4NZ8am
         BjZPCBhuOIc8mcSBXZ6iUC6TO0S6w9YqpJmrMgMX8jgD+8J8BXvkQdLcoOfHYKYoZE
         Nb7uVd9VEnfAR6XlNXdu3uBjFdhjvuPvsBYCDKT0=
Date:   Tue, 11 Apr 2023 09:41:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO fixes for 6.3 set 2
Message-ID: <2023041144-straddle-slaw-dcc7@gregkh>
References: <20230410172500.04c124e2@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410172500.04c124e2@jic23-huawei>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 10, 2023 at 05:25:00PM +0100, Jonathan Cameron wrote:
> The following changes since commit 4bffd2c7a3fc165fc70bc69211b8e6436f41a5c3:
> 
>   Merge tag 'iio-fixes-for-6.3a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2023-03-28 13:30:55 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.3b

Pulled and pushed out.

thanks,

greg k-h
