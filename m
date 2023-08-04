Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C644B77015E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHDNW3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 09:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjHDNWR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 09:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9991994
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 06:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDA061F9A
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 13:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAC2C433C8;
        Fri,  4 Aug 2023 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691155167;
        bh=gjIYBAke9LbnkX/xAU0fY+/dz5VHQV/dUDfLEmzRPqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4lKgWF4qSKTEcMPKnqC8XRcjoxiSoydorRfp+OK+Ny18JH6092bmPWNpeM1MDwom
         a/VMwE//BidN5uUZcsn4a+5L3pXkxAXpuxDos1IEfYG2Gfr4wlvBxTadHXPskmkcf7
         ieeQt+geaYLrQybRvUeR7DJxAtAgnm5PlT7ajPJ4=
Date:   Fri, 4 Aug 2023 15:19:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Second set of Counter fixes for 6.5
Message-ID: <2023080417-labrador-itunes-86c3@gregkh>
References: <ZL6NP1yrUuFHAiso@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL6NP1yrUuFHAiso@ishi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 24, 2023 at 10:39:59AM -0400, William Breathitt Gray wrote:
> The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:
> 
>   Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.5b

Pulled and pushed out, thanks.

greg k-h
