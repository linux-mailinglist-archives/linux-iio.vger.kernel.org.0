Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A446AABCA
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 19:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCDSUY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 13:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDSUX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 13:20:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03888E38B;
        Sat,  4 Mar 2023 10:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC2B1B80861;
        Sat,  4 Mar 2023 18:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8B7C433EF;
        Sat,  4 Mar 2023 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677954020;
        bh=873OsmyQDgKThAzDPboWcieeAtMpaAf6UwiQOQlZSMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p1T4eO0aSSjplp7/CppqHa40MLpizItJnfU300SnA3izW1WpI6l8pvT5lFyAkch3A
         aUKYP419WnSp8NCF3SkcvI0BRwkLg7O/+Gs6/QF0LpkV5GnUZcNIgrZMBQf6Iv92sg
         RfpWB9SGk+80mAMYk5P/RZMBAjnWpwqZQQUIADLr3Zh06yjVgtCsBhvL439t85uhSL
         6sLoJjX+yhlQygL1HJ8VDKXBr94w4B3r0pCYWZMtpebqjGtExrzL7/bZmfF2HExzW0
         IOJkgSgl8IkSO4kXjWFSGhyb6eCMVeCwiBPV3INPgFJCNJCcTWo/+/HcVOKN9JQ95p
         P+lTALTCfYknw==
Date:   Sat, 4 Mar 2023 18:20:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 0/5] Add TI TMP116 Support
Message-ID: <20230304182015.77ccbecc@jic23-huawei>
In-Reply-To: <20230228090518.529811-1-m.felsch@pengutronix.de>
References: <20230228090518.529811-1-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Tue, 28 Feb 2023 10:05:13 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi,
> 
> this small series adds the support for the TI TMP116 temperature sensor
> which is predecessor of the TMP117 but still in production.
> 
Series applied to the togreg branch of iio.git and pushed out as
testing for 0-day to see if it can find anything we missed.

I'll rebase that branch on rc1 once available.

Thanks,

Jonathan


> 
> Marco Felsch (5):
>   dt-bindings: iio: ti,tmp117: fix documentation link
>   iio: temperature: tmp117: improve fallback capabilities
>   dt-bindings: iio: ti,tmp117: add binding for the TMP116
>   iio: temperature: tmp117: add TI TMP116 support
>   iio: temperature: tmp117: cosmetic alignment cleanup
> 
>  .../bindings/iio/temperature/ti,tmp117.yaml   |  8 +-
>  drivers/iio/temperature/tmp117.c              | 80 ++++++++++++++-----
>  2 files changed, 66 insertions(+), 22 deletions(-)
> 

