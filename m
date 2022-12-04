Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0C641E91
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 19:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLDSJT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 13:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLDSJT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 13:09:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B211149
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 10:09:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE3B60EDD
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 18:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C26CC433D6;
        Sun,  4 Dec 2022 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670177357;
        bh=/dCRszoLcj1qV28iCaeHCN5qlhpgpEV5fwBvL77bAec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BPrtsVEWLc0TisZfluE1JKetBhzGy36U4vEGb8lfKdFguyzLLjuMco5vNBJaD8jvE
         /dDo65x6NjLYq+y7Ee2Ecli82q6nCPoiryX4yqQxdLY4y9x66zBoKcutn57f0hPBsp
         Cy9ndKPgQNGmw1LlfbdhccXnSTpit+GFvthDB8lLMmzGOdPU/JFdGSkOkTvsZPKAFF
         XmwHRzl2yXt45LIWhRYhloX17+26bRZ2sDN+iJOm2CFr0GaRtSo+86ASYBI2gKPoM3
         UYyOukIK/fzitSigN72Nl8/ZbMRJScFYqXscrMtNEuFu7I5MvILP6f+Cx8bnmFlMMY
         b1D8TuPZKRmbQ==
Date:   Sun, 4 Dec 2022 18:22:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 14/14] iio: pressure: ms5611: Switch to fully devm_
 managed registration.
Message-ID: <20221204182201.42dcd76a@jic23-huawei>
In-Reply-To: <b6427817-6b44-c3c6-1e6d-4472e3eb066a@gmail.com>
References: <20221016163409.320197-1-jic23@kernel.org>
        <20221016163409.320197-15-jic23@kernel.org>
        <b6427817-6b44-c3c6-1e6d-4472e3eb066a@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Oct 2022 09:30:01 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/16/22 19:34, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > All the remaining calls in probe() have devm_ equivalents so
> > switching to those allows the remove() callbacks to be deleted.
> > No functional change.  
> 
> Right :) So please ignore my last comment in the patch 13/14 :) The one 
> concerning the commit message is still valid though :)
> 
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomasz Duszynski <tduszyns@gmail.com>  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Applied to the togreg branch of iio.git - some fuzz due to crossing
with i2c probe_new() mass conversion and the changes that affected
the previous patch.

If anyone wants to sanity check the result, see the testing branch of iio.git
in a few minutes.

Thanks,

Jonathan

> 
> > ---
> >   drivers/iio/pressure/ms5611.h      |  1 -
> >   drivers/iio/pressure/ms5611_core.c | 17 +++--------------
> >   drivers/iio/pressure/ms5611_i2c.c  |  6 ------
> >   drivers/iio/pressure/ms5611_spi.c  |  6 ------
> >   4 files changed, 3 insertions(+), 27 deletions(-)
> >   
> 

