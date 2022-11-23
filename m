Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE785636920
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 19:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiKWSlJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 13:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiKWSlH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 13:41:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C077C694
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 10:41:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 58A08CE2565
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 18:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B58C433C1;
        Wed, 23 Nov 2022 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669228859;
        bh=e1fHR4NJixf8loYB/zHZN0kjusNkzYdv9fWj+kOJ0/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEl5FX0UcuqO/k42sTzEqa9oYXhxWJ8Kicx4cOJodT2CUtfdZqoVwGDcBE7yEk1Ot
         o1vxnGfDRlafbv7Z6+DyH/o/PfLzAYrsGMEn3usvSfbDcQJcAwe5Gn2i451AtrFlGN
         B6jeaYPsa5PUF4CTPdRhLy3l+Uhq3W9B6LJn+/c8=
Date:   Wed, 23 Nov 2022 19:40:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support, features and
 cleanup for 6.2
Message-ID: <Y35pOOLEW8mtxnxa@kroah.com>
References: <20221116190308.76cfba5a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116190308.76cfba5a@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 16, 2022 at 07:03:08PM +0000, Jonathan Cameron wrote:
> The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:
> 
>   Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.2a

I get the following error when trying to push these out:

Commit: 3acdb4a11517 ("iio: adc: ad_sigma_delta: do not use internal iio_dev lock")
	Fixes tag: Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Deltadevices")
	Has these problem(s):
		- Subject does not match target commit subject
		 Just use
			git log -1 --format='Fixes: %h ("%s")'


linux-next should have also warned of this, right?

Can you fix this up and resend?

thanks,

greg k-h
