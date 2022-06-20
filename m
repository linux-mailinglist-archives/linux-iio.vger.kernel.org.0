Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5505511D0
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 09:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiFTHuo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 03:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbiFTHun (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 03:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28461101E9
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 00:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FC861203
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 07:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEB2C3411B;
        Mon, 20 Jun 2022 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655711442;
        bh=sZfzdPP5oox1MFYRQknbZB0DSh6A8yhqJEVEYjpzM2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKkiMtgyqQgZJER/pwpBHxbopGr1YtKZdCXPPucz58LJe+1Mwugn+71aC894ELi/t
         XfCggEgDnzHiZ4AKi8bEuukWoQ+r/OPGzvIMMdRksBsEdFajnYQxu9YRUxBO4war8V
         WpSWJqDiuLyKmxLK9Fjx+XLT4atcVnUn1W85yAQA=
Date:   Mon, 20 Jun 2022 09:50:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 5.19
Message-ID: <YrAmzPQT1ynkQQ0z@kroah.com>
References: <20220619175025.72b3edb4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619175025.72b3edb4@jic23-huawei>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 19, 2022 at 05:50:25PM +0100, Jonathan Cameron wrote:
> The following changes since commit 57ae8a492116910bad2b3497ffe555b3a4b4180f:
> 
>   Merge tag 'driver-core-5.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2022-04-30 10:24:21 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.19a
> 
> for you to fetch changes up to 70171ed6dc53d2f580166d47f5b66cf51a6d0092:
> 
>   iio:proximity:sx9324: Check ret value of device_property_read_u32_array() (2022-06-19 17:22:49 +0100)
> 

Pulled and pushed out, thanks.

greg k-h
