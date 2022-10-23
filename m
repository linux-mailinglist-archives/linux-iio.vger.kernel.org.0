Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674C560949B
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiJWQHL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJWQHK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 12:07:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A068CC1
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 09:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54B8DB80DB3
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 16:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5ECC433C1;
        Sun, 23 Oct 2022 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666541226;
        bh=6ArfMQ4J5EpVQ7knNnCEzMmKaxJijvnld/Kv9UpbgDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wgmApSe+5aCLTumwEem5skQsjq6Ira563i6W0r8Cey4svSEdpmODGmn/+EaaQ3LXS
         O2dBQj56/ZGgd/29bwu9oBhwhGvwKx6zCKo6YZdNkaiZVlfOie99aEbwlyF+BMrap/
         7talNJ8AHmJ6VEKxcVGtuBRfVSQ5+BeQ3/jM6jtk=
Date:   Sun, 23 Oct 2022 18:06:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 6.1
Message-ID: <Y1VmhTISH3ZzTyKo@kroah.com>
References: <20221023115848.148744b1@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023115848.148744b1@jic23-huawei>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 23, 2022 at 11:58:48AM +0100, Jonathan Cameron wrote:
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
> 
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.1a

Pulled and pushed out, thanks.

greg k-h
