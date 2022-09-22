Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B235E60FB
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 13:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIVL2p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiIVL2a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 07:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BDEE21FA
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B35A62C70
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 11:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4398AC433C1;
        Thu, 22 Sep 2022 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663846098;
        bh=KBvWPPep5G5xY7h+8ctJilsyO5TXdifslj4+PAoj0v0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OA5MiI6aEFHNuTpsUkLsbi10ztThS+HrZzwwixoVZ99m/X+pLkSi5oCuYleVYgxN1
         qbftAPSpvVvhLgSzzc/A9uvmKMXkC/x0UmzD3Z5AeDjKphw9gpKdMYbTpQ5DPtlbuL
         pVepVHKykPbxIkz0T7M0J3GLULixXX+jPMNMmfyc=
Date:   Thu, 22 Sep 2022 13:28:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 2/2] counter: Realign counter_comp comment block to 80
 characters
Message-ID: <YyxGz77qKgDo/rOu@kroah.com>
References: <cover.1663844776.git.william.gray@linaro.org>
 <8294b04153c33602e9c3dd21ac90c1e99bd0fdaf.1663844776.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8294b04153c33602e9c3dd21ac90c1e99bd0fdaf.1663844776.git.william.gray@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 22, 2022 at 07:20:57AM -0400, William Breathitt Gray wrote:
> The member documentation comment lines for struct counter_comp extend
> past the 80-characters column boundary due to extra identation at the
> start of each section. This patch realigns the comment block within the
> 80-characters boundary by removing these superfluous indents.
> 
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Link: https://lore.kernel.org/r/20220902120839.4260-1-william.gray@linaro.org/
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  include/linux/counter.h | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

This isn't needed for 6.0-final, I'll queue it up in my -next branch for
6.1-rc1.

thanks,

greg k-h
