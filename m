Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103F54D53DC
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 22:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiCJVrU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 16:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiCJVrT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 16:47:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58531194159
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 13:46:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 169AFB826A7
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 21:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE1C340E8;
        Thu, 10 Mar 2022 21:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646948775;
        bh=fEHLrQ+VErS61Jq3Je/J0aYP13WAW0GOmSDYSXN22rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohbHOR1ZABiQiWPTKaRmEaE60nbXCt9HxM8UrneLF16W0L5GIDl1kCIuayE6UdoYS
         NQLFitc/gfKQKpy0B4QnvLVRLtIlJlrVwdmgWXxBJiQ+BJDqaYVQ64aYyPVObLh6AL
         bj/fVWsqF/tcBB+L8Ek1bD/DRyPq52wM/EjJ8YEU=
Date:   Thu, 10 Mar 2022 22:46:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter updates, cleanups, and features for 5.18
Message-ID: <YipxpdPZEK2wpeoc@kroah.com>
References: <YiItE3YONnTILC9Q@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiItE3YONnTILC9Q@ishi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 04, 2022 at 10:15:31AM -0500, William Breathitt Gray wrote:
> The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:
> 
>   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/vilhelmgray/counter.git tags/counter-for-5.18a

I don't have a gpg key for you, and I really don't trust any
non-kernel.org git infrastructure at the moment.  Any chance you can get
a kernel.org account?

In the meantime, can you send me these by email?

thanks,

greg k-h
