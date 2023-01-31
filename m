Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF668299C
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 10:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjAaJxk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 04:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjAaJxi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 04:53:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58772126CD
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 01:53:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F51CB81AB2
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 09:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DA8C4339B;
        Tue, 31 Jan 2023 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675158808;
        bh=6o3yEPEjHKHA8KsxgRGQ/PrdEVEucPcP5FyrObccm1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmwqWjuD0bNIj4l7yEfJ5zdx9c8DwpthYxyC06yrVq6nUELw07sjMHXppRFBxfwgO
         FxLdRP9ZHc4sa6NaPOCXi53+TmnvSMKLcMMaUPLx9T6iNmns1IOJAcTPycfIfJRVLO
         STITpfIAK8iRFgw73eF6qvrMv3/VoBRJio2Ef100=
Date:   Tue, 31 Jan 2023 10:52:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO fixes for 6.2 - set 1
Message-ID: <Y9jk7Vly2ylRNs6N@kroah.com>
References: <20230123194738.25eb2a1a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123194738.25eb2a1a@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 23, 2023 at 07:47:38PM +0000, Jonathan Cameron wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.2a

Sorry for the delay, now pulled and pushed out.

greg k-h
