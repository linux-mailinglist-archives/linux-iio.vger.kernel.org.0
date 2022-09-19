Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804795BD177
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiISPw7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiISPw6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D025132B81
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D8C61724
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 15:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33921C433D6;
        Mon, 19 Sep 2022 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663602776;
        bh=d6L6gEfrGBr9oriVCLv9ZdBbit0qeffE+mEx6GTtCUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kDXWgBn0mZLM365aRStYacqUH6LHJlEiXYCrtLLhNEGMWkyuyfZP8G0kdq8DU4//g
         6vf1of8OsGuyjBHdTLFjsMuadIAxRsWvusubIapempoAr7cIAkW6o6MdIPEgsvjxbo
         xVAQ2skt9PGV1FTWqIBFmGxVRvH4aNuO797PIKq71eCNOk6fsrKjBdRt3gjhadZyQj
         m1Iq8NOflVeYC5wV7PpPFZH4WDFAOqefN6tG0nZuEIuB1EO+MZFwO3e0dQvXXW/zCK
         TFSdXuJhWrCYG8a7rp2cAch1Gdqc6W+erQBe587p/2mPEXQfQOCcVo6P4jeKOq145I
         KcvoyrDobFGOw==
Date:   Mon, 19 Sep 2022 16:53:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Wei Yongjun <weiyongjun@huaweicloud.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7124: Silent no spi_device_id warnings
Message-ID: <20220919165300.71e8012f@jic23-huawei>
In-Reply-To: <d7afc35d-e764-609c-003c-5ff664649eb4@huawei.com>
References: <20220919145945.823327-1-weiyongjun@huaweicloud.com>
        <d4fa7502-d5a5-9849-8daf-efc25a22ae81@metafoo.de>
        <d7afc35d-e764-609c-003c-5ff664649eb4@huawei.com>
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

On Mon, 19 Sep 2022 22:50:35 +0800
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> On 2022/9/19 22:46, Lars-Peter Clausen wrote:
> > On 9/19/22 16:59, Wei Yongjun wrote:  
> >> From: Wei Yongjun <weiyongjun1@huawei.com>
Hi Wei Yongjun,

> >>
> >> Add spi_device_id entries to silent following SPI warnings:

silence rather than silent (also in patch titles)

> >>
> >> SPI driver ad7124 has no spi_device_id for adi,ad7124-4
> >> SPI driver ad7124 has no spi_device_id for adi,ad7124-8  
> > What generates those warnings?
> >   
> 
> Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
> compatible") added a test to check that every SPI driver has a
> spi_device_id for each DT compatiable string defined by the driver
> and warns if the spi_device_id is missing.

When sending a series of similar fixes to a given subsystem together
it's helpful to group them into a series, so that comments that
apply series wide can easily be easily found.

A cover letter is also useful to provide a little more information on
what is being fixed.


> 
> Regards,
> Wei Yongjun

