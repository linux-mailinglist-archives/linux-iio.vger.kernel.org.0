Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA9A552305
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiFTRu7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 13:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240588AbiFTRu5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 13:50:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B3FDEC6
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 10:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 574C4B81366
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 17:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FEC3411B;
        Mon, 20 Jun 2022 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655747447;
        bh=ijgZg8r2djatDCnEcWJN8/aITbj5ofT1vKW9zQtv8WE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UygkOa/UIYXcluWIy5v3mHayx9Og5Vq1z6XNlsK9VTurMN1FP/LfpCF+vBK37ZMBq
         Uv9hCKSnS9Ecn6UmzYZ8jlDPwdc79UjxiANISVtC2VJn0lcx7RfRFlM3BFaeFZHM+P
         3Bmp0vl4UH0p+t/SOgpR1hNIGD3V1HKG3uOds4oyosKYWThrj85/5jqFr6Y8xWCNQz
         4ej/d0cXcWniF/T5ma4Xt9RZqWj1LO7TehBTZJHt1Jpbd0cFUdH0jsNZPbFp7BQrSd
         Cr94E5tw7hj0rYZjIlkohdxVMJYYhFNoHUDDAHljmdomH4GzVex8DTG+JOY0AkVRw6
         9Wt3Df0Amz0CQ==
Date:   Mon, 20 Jun 2022 18:50:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 02/17] iio: ABI: Fix wrong format of differential
 capacitance channel ABI.
Message-ID: <20220620185041.2107a550@jic23-huawei>
In-Reply-To: <CAHp75VeEzASC+0wR31CsidAxGLG6uQAsb5wYWYgeEVeLrPNZMA@mail.gmail.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220619185839.1363503-3-jic23@kernel.org>
        <CAHp75VeEzASC+0wR31CsidAxGLG6uQAsb5wYWYgeEVeLrPNZMA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jun 2022 00:58:20 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 19, 2022 at 8:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > in_ only occurs once in these attributes.  
> 
> Shouldn't this be a fix independently of the series context?
> If so, adding a Fixes tag?
> 
Good point. Added tag for
0baf29d658c7 ("staging:iio:documentation Add abi docs for capacitance adcs.")

Thanks,

Jonathan

