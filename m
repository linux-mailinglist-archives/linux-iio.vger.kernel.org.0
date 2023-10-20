Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF37D088C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Oct 2023 08:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjJTGgE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Oct 2023 02:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjJTGgD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Oct 2023 02:36:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB3EA3
        for <linux-iio@vger.kernel.org>; Thu, 19 Oct 2023 23:36:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D051C433C8;
        Fri, 20 Oct 2023 06:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697783761;
        bh=jYaQ6rolk8B4PHlixJqVqAs8zS9TJdUkfRmr07xZ8y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5RubXH566qo/HSVHZlGJKlba++iG8NUUm+C3d/+jNyc3HnX2cKueQ0mQ3a3wpnbw
         /+8jX+FDEvIhUn9tt0KxmsLO5AcTup+TM39r3+FVFKEnA+w6rRjyF5OKnU/VhNkTey
         XxPSxNKGX0oPwd9cMKmcgeI/3W73PG1G01JY8m/A=
Date:   Fri, 20 Oct 2023 08:35:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] First set of Counter updates for 6.7
Message-ID: <2023102038-parted-cupid-d880@gregkh>
References: <ZTCRq/9L64kTqiyz@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTCRq/9L64kTqiyz@ishi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 18, 2023 at 10:17:15PM -0400, William Breathitt Gray wrote:
> The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:
> 
>   Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.7a

Pulled and pushed out, thanks.

greg k-h
