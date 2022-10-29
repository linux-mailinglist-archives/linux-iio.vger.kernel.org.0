Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C215E6122ED
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJ2Mbk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 08:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2Mbj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 08:31:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FEE43633
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 05:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33C4FB80BFC
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 12:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A9BC433D6;
        Sat, 29 Oct 2022 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667046695;
        bh=NwFs2MCYyBz6FysngsqRaIT3B2tU728tEgYeF3xI4K4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uaAr9rZ3wZ/s4vWoFI1Z3XuC6rg2w/LEfZP0j5ZRSFD3X6/eKTL8+1/pcxv4f7kOS
         zKBSULByOPXefDD4nDRem+duzPAUxEFGV7/YSzzuF+CWT4r0gyCIvpXvxqpRdrm0CL
         DnIR1F6T/yVYbNG5SI4UwkmSLWKwb9AuwxWVXlx1wk8JoADqpJY5o2rWxE3jhcUd4S
         AqaulqZzAMumS7YJrXGUDFyndY8shVmrdA/vY6ur98tG9PI8wpEyCiEjNzlJKP92R3
         FcjetWEUQYwpdyyjSm9hArjvkliQlfSxpu88VO99JdRMCiRqD5Qp04NQiYEljvIepU
         cpXqVSVt/gogQ==
Date:   Sat, 29 Oct 2022 13:43:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phani Movva <Phani.Movva@imgtec.com>,
        Naidu Tellapati <naidu.tellapati@imgtec.com>
Subject: Re: [PATCH 0/5] iio: adc: cc10001: Devm conversion
Message-ID: <20221029134331.52adcda1@jic23-huawei>
In-Reply-To: <20221016170950.387751-1-jic23@kernel.org>
References: <20221016170950.387751-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Oct 2022 18:09:45 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A very simple example of how using devm_ managed calls for everything
> can reduce complexity error handling and removal ordering in a driver.
> 
> Note I don't have one of these to test so if anyone has a chance to do
> so or give these a quick look at that would be much appreciated.
> Note this is a fairly old driver, so relative unlikely original authors
> still have access.
> 
> Cc: Phani Movva <Phani.Movva@imgtec.com>
> Cc: Naidu Tellapati <naidu.tellapati@imgtec.com>

If anyone has time for a quick glance at this it would be much appreciated!

Old maintainer issue of who is the fall back reviewer for the maintainers
own patches to old drivers, where the authors etc have probably long since
moved on.

Jonathan
> 
> Jonathan Cameron (5):
>   iio: adc: cc10001: Add local struct device *dev variable to avoid
>     repitition
>   iio: adc: cc10001: Add devm_add_action_or_reset() to disable
>     regulator.
>   iio: adc: cc10001: Use devm_clk_get_enabled() to avoid boilerplate.
>   iio: adc: cc10001: Use devm_ to call device power down.
>   iio: adc: cc10001: Switch remaining IIO calls in probe to devm_ forms.
> 
>  drivers/iio/adc/cc10001_adc.c | 89 +++++++++++++----------------------
>  1 file changed, 34 insertions(+), 55 deletions(-)
> 

