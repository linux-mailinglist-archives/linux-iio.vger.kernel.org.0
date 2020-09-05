Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC63025EBA9
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgIEXCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 19:02:44 -0400
Received: from onstation.org ([52.200.56.107]:41568 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgIEXCn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 19:02:43 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Sep 2020 19:02:42 EDT
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2BB3A3EA33;
        Sat,  5 Sep 2020 22:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1599346529;
        bh=GIR2HiRFUTveB1N7snRGzhHiGetAZFJ8HK5+25fJ4lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiFzpu1EvY3zA9zrGNjwy1HI1UhWCdH81MF4ZZF3YOclUpKkkRnDdIyaB/uaIWC2M
         xUzjJYS2FN4mgiCfJj6oibjaC3398tBU0DOunAfBPOI8qcFJumV6OU3r+M1pjLzrVO
         HIzGqPb78+Cvuhbyh7g02sVD5PV/QpY4sP1vSRLA=
Date:   Sat, 5 Sep 2020 18:55:28 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/4] staging:iio:light: Move tsl2x7x ABI docs to correct
 location.
Message-ID: <20200905225528.GA44421@onstation.org>
References: <20200905174721.216452-1-jic23@kernel.org>
 <20200905174721.216452-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905174721.216452-3-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 05, 2020 at 06:47:19PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These seem to be up to date but never moved out of staging when the driver
> did. Hence let us move them out now.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Brian Masney <masneyb@onstation.org>

Oops, that was my mistake. Thanks for the cleanup!

Reviewed-by: Brian Masney <masneyb@onstation.org>

Brian


> ---
>  .../ABI/testing/sysfs-bus-iio-light-tsl2772                       | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x b/Documentation/ABI/testing/sysfs-bus-iio-light-tsl2772
> similarity index 100%
> rename from drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x
> rename to Documentation/ABI/testing/sysfs-bus-iio-light-tsl2772
> -- 
> 2.28.0
