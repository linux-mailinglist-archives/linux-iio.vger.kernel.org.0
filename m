Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B474C33CE
	for <lists+linux-iio@lfdr.de>; Thu, 24 Feb 2022 18:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiBXReH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Feb 2022 12:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBXReE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2022 12:34:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D5F24FA34
        for <linux-iio@vger.kernel.org>; Thu, 24 Feb 2022 09:33:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BDFE61C27
        for <linux-iio@vger.kernel.org>; Thu, 24 Feb 2022 17:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4709C340EC;
        Thu, 24 Feb 2022 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645724013;
        bh=Cev1r9hBAVI6M9nknPQtTA8yQ2EasgW0cPDYyo3Bovw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ch4n43tDX8xsiZMVydQaVtldPUJa9Euitsc3oXSFhIUtfhppUZPZoSoPMwMhkvbT+
         SD+/lIelGYb9TKdaBu3xAgYwzyj+I4Rk+kBaBfUYWDCGHCttw96CTAGESiCei8Mf7K
         uXWTnl0iKw4wpMB/y7wOP42+eVYsYkiDzV9dy5Q5j3uGua4rYzd6st0JEBJf4pt/1q
         DIXWxYWkijNXOZ61/Pui1tnclRemj8k9M+kZC8ZiZsnyxJpRSeTdbP1872saD29tiG
         B8r5Mp2t2AR7GzVaYK/8NuV1KHXXXka9h4zj4dbxt9s0S0Y+V77Pc95z5TXtlEO0Oe
         fIyiVZ9KyqNFg==
Date:   Thu, 24 Feb 2022 18:33:26 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] iio: accel: mma8452: remove the reset operation during
 driver probe
Message-ID: <YhfBZv7msnpvDVEs@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1645505151-5789-1-git-send-email-haibo.chen@nxp.com>
 <20220222164331.00002d18@Huawei.com>
 <VI1PR04MB401628231C1D06E318820D26903D9@VI1PR04MB4016.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB401628231C1D06E318820D26903D9@VI1PR04MB4016.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> > Wolfram is there a standard way to work around missing ACK in cases like
> > this?  Would just ignoring the return value be fine or are their i2c masters
> > that will get stuck if they don't get the expected ack?

Did I get this right: the reset procedures terminates the ACK and STOP?
And the client expects a new START condition for communication?

