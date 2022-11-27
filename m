Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D316639B24
	for <lists+linux-iio@lfdr.de>; Sun, 27 Nov 2022 14:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiK0NtF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Nov 2022 08:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0NtE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2022 08:49:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047AFCD1
        for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2022 05:49:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD631B80AF9
        for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2022 13:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF200C433C1;
        Sun, 27 Nov 2022 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669556940;
        bh=thRGH5ESxDPvFnIcMinhMidGhH/CO+oyeodVmeHHwh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0VpXm6DEMkU5Uh+y34N8lDeY9fgITu0okwE/Hs8DeYYZKGqQOxKXmzIPfaVOMupN
         h4YTQ6vSFf2KaDZUIiw0bnejJa/vQfjyCMS2jvg/AhtGg7j4hZaKFp/mfGgUyfj/gk
         UkoPAr1RalTFAFrmkTZ6m1cSdHEgBP1DZK0Onb1k=
Date:   Sun, 27 Nov 2022 14:43:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support, cleanups and minor
 fixes for 6.2
Message-ID: <Y4NpfpOrzrG/NbUV@kroah.com>
References: <20221126184758.4dfe4af1@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126184758.4dfe4af1@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 26, 2022 at 06:47:58PM +0000, Jonathan Cameron wrote:
> The following changes since commit 12491d35551df69709777bd7769e1e33641943cc:
> 
>   iio: pressure: bmp280: convert to i2c's .probe_new() (2022-11-23 20:01:38 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.2b

Pulled and pushed out, thanks.

greg k-h
