Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7214E88F2
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiC0Qqx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiC0Qqx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 12:46:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D34DFE3
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 09:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBEF2B80D64
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 16:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058DDC340EC;
        Sun, 27 Mar 2022 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648399511;
        bh=nClzHPbFRZdnPM1MNvxspI4WblcJBuB/32rh4xAAe5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OUZIpHItFPsmKx2QFgrzHPBAUz9lfBnbMVzIqhC8WdUDu6mhBeUApAcs9Q5BcKBDj
         UNkKQmdfpVYGdLEKvX0TRMsvgAZSSXtoXeWY2YjR7paulv9BH17+Fdf9yi7v+XIjb5
         AY6h3vQADwyGfget9jVUsWCPnE191Ljiz6KQd/3nos7of06VdvkpSMDUjHd513Hplc
         M9jlFKzJYdhXi4yDd3vWVQnzdng5EzIaplsPqcrpd6XWr4lDRFzpoCUp/aMjrQ39MO
         JpAIYswAMQtNLuwdKCxjRCgPdV4yk7cIxN0wg6p1Yjjbfz+JLEvAcSvUxxbAHsxuTX
         rRP5DktfsD1xw==
Date:   Sun, 27 Mar 2022 17:52:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7280a: Fix wrong variable used when setting
 thresholds.
Message-ID: <20220327175244.0c1ef60c@jic23-huawei>
In-Reply-To: <YiLNbIrWUC+LzL/A@marsc.168.1.7>
References: <20220226175604.662422-1-jic23@kernel.org>
        <YiLNbIrWUC+LzL/A@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Mar 2022 23:39:40 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 02/26, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Name of variable change missed in refactoring patch.
> > 
> > Fixes: 112bf4aa4afb ("staging:iio:adc:ad7280a: Switch to standard event control")
> > Reported-by: Colin Ian King <colin.i.king@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>  
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
