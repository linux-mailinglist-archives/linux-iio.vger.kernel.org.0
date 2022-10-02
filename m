Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5187B5F237A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJBOD3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJBOD2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 10:03:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6902536407
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 07:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF24160ECE
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 14:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5A2C433D7;
        Sun,  2 Oct 2022 14:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664719406;
        bh=7ZAYO/qHTcsI0sGjxlJ4rf66NPCFAoz0xEtA0s+vQn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BbFTr1yb3k1unVi/uYj+sWg8HhnucOaiugSPomAgJHZwxICuWc8IwlBGrYIFuAHKl
         CuZm37z5LnAUWcqwWlJZU1W+EwtTOvi0dPP7jLH0caWrX6WuCRX3Medofjy4cE3UIB
         hPH6uoPelhl1ZME60MwVxvp35Bq/RLdgf1aiiupwD5i6nrDmLTg61QIcrkvc3Y4FQk
         RNUqa7JTl+2YBpH/k3XcV3r8ZA2rOwE3ZyLSYFEcu7naxkscdb2vfJeRKHvUBwslTa
         0Rwb1wwj39ZNiFq1y2zCizq8QxW6TVtecR2J0HxVFZI0F69KjNr1NsH7wed3Q6Cplf
         Z+iX/XQem8gEA==
Date:   Sun, 2 Oct 2022 15:03:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] iio: Silence no spi_device_id warnings
Message-ID: <20221002150341.48b071dc@jic23-huawei>
In-Reply-To: <CAHp75VfaWS0H6F0LmnmW9SS0JZNwfXRzFoCTP5FOfzMP_CUNLA@mail.gmail.com>
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
        <CAHp75VfaWS0H6F0LmnmW9SS0JZNwfXRzFoCTP5FOfzMP_CUNLA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 21 Sep 2022 23:41:54 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Sep 21, 2022 at 7:19 PM Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
> >
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > SPI devices use the spi_device_id for module autoloading even on
> > systems using device tree.
> >
> > Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
> > compatible") added a test to check that every SPI driver has a
> > spi_device_id for each DT compatiable string defined by driver
> > and warns if the spi_device_id is missing.
> >
> > This series add spi_device_id entries to silence the warnings, and
> > ensure driver module autoloading works.  
> 
> Nice, but I would like to avoid the unneeded churn in the future and
> right away use a new API for that. I will submit a patch soon that you
> may attach to your series as a prerequisite.
> 

Given Andy's suggestion (which I like, but no one else has replied to!)
isn't moving forwards particularly quickly.... I've applied this series
as it stands.  We will just have to cope with the churn (there will be
a lot beyond these few drivers anyway to fully take advantage of
the utility function Andy has suggested)

Applied to the togreg branch of iio.git as 6.2 material. I'll push out
as testing for now for 0-day to see if it can find any problems. Will be
rebasing that tree on rc1.

Jonathan

