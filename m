Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E977015D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 15:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjHDNW1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHDNWN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 09:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B534ED2
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 06:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 369D361FFB
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 13:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F83C433C8;
        Fri,  4 Aug 2023 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691155157;
        bh=bcgrQh4pPH9ExLkn4+5/Ait9kUuYWOx/tpXcWK7cX1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ8jFYiJD6XdllDGFbEPjP2VD5/VH/rYXx4ZxveS7vsPO2QY3MkK7Xrrdopj8sbTs
         TixP5ppBv0u3leSprtices8prtxeNnwNloRKkidVKCz58MF051htiCUlkpT1EdXLhQ
         PqgLvxiYRQ3XZflnUkp6+rVgkaGOm4eBam27UVUw=
Date:   Fri, 4 Aug 2023 15:19:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] First set of Counter fixes for 6.5
Message-ID: <2023080404-sneezing-debatable-07f3@gregkh>
References: <ZJoM8IoK3o7LUylZ@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJoM8IoK3o7LUylZ@ishi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 26, 2023 at 06:10:56PM -0400, William Breathitt Gray wrote:
> The following changes since commit d428487471ba6640ee8bcdabaf830aec08b85400:
> 
>   counter: i8254: Introduce the Intel 8254 interface library module (2023-06-08 10:11:17 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.5a

Sorry for the delay, pulled and pushed out, thanks.

greg k-h
