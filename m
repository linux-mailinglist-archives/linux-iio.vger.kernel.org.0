Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12215688F56
	for <lists+linux-iio@lfdr.de>; Fri,  3 Feb 2023 07:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBCGDt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Feb 2023 01:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBCGDs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 01:03:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D97EFFA
        for <linux-iio@vger.kernel.org>; Thu,  2 Feb 2023 22:03:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C2361D71
        for <linux-iio@vger.kernel.org>; Fri,  3 Feb 2023 06:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEE0C433EF;
        Fri,  3 Feb 2023 06:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675404227;
        bh=vQHTvR8Sy65IFM0gaocErkorZl6X8MwPMWdQO8akz/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsYQY86gP+WM9eBIHM03PO64szlhm5T0oH9HVOg6vM8daDBVFBQuU9RgvE+vaEuD5
         mMtxTPWTtop0AuxMXcqfIQB8Z2Wa9hB8CR0jDZi8J/OESyq26ZwQQoZAJDOhF7DlZJ
         RfyrhJYmewK+jn40os51IsSYcCu+tyHONtJ/Ew0U=
Date:   Fri, 3 Feb 2023 07:02:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of new device support etc for 6.3
Message-ID: <Y9yji6EQpsS/YfKA@kroah.com>
References: <20230202175440.5579e52e@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202175440.5579e52e@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 02, 2023 at 05:54:40PM +0000, Jonathan Cameron wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.3a

Pulled and pushed out, thanks.

greg k-h
