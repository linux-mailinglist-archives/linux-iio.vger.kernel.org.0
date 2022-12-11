Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987556493F0
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 12:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLKLhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 06:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiLKLhw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 06:37:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC7BE02;
        Sun, 11 Dec 2022 03:37:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E00EB80975;
        Sun, 11 Dec 2022 11:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB66C433D2;
        Sun, 11 Dec 2022 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670758668;
        bh=MB3W7c91XD6Sbro663PUKZYskWcJMHbqsYaC/wZrcBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=acbE7Oujt+dyIv2BCN39WmWmY6TxrQG+fHyLC72z1bcHaOWReg9WszETr2biqPLs/
         XMB8HB3TclIcsrc8aYURgCeAR4ycnkYb4BDkOuL45kOMvP+YFqXeW7clmT7rkGlcAn
         QIpHmfWFf5moC1YVV/jXJC1G/5YCqDmoNZ2kHjh4A9K+iTdUn1mMfyuy2/m1pFAhY2
         wHNS2+p3ZTtnYvt4Yr+GFjNAZuR6ExbNUb3LOuSIfZHf/Q3PhYegSqwwaC9v1EbHNY
         IGFY56NuoWpAke07Fi2TNQVA09ezZLwD9f1B2+FsGAxhCqbWgaf3S61oOl6qMQ2me8
         XQb8TKhQO6sVA==
Date:   Sun, 11 Dec 2022 11:50:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Add support for mp2733 battery charger
Message-ID: <20221211115042.5ec91c3f@jic23-huawei>
In-Reply-To: <eedcf790-5447-d988-f9cb-9103f34f27ae@gmail.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
        <eedcf790-5447-d988-f9cb-9103f34f27ae@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Tue, 6 Dec 2022 17:05:26 +0100
saravanan sekar <sravanhome@gmail.com> wrote:

> On 23/11/22 18:54, Saravanan Sekar wrote:
> > changes in v6:
> >    - splitted chip id to v6-0003 and support of mp2733 to v6-0004 patch
> >    - fixed commit message English grammar
> > 
> > changes in v5:
> >    - fixed commit message on v5-0002 and v5-0004
> > 
> > changes in v4:
> >    - fixed attributes groups review comments in v3
> >    - added new bug fix patches v4-0007 and v4-0008
> > 
> > changes in v3:
> >    - fixed dt_binding_check error
> >    - fixed spelling usb->USB
> > 
> > changes in v2:
> >    - fixed spelling
> >    - revert back probe to probe_new in mfd driver
> > 
> > add support for mp2733 Battery charger control driver for Monolithic
> > Power System's MP2733 chipset
> > 
> > Saravanan Sekar (7):
> >    mfd: mp2629: fix failed to get iio channel by device name
> >    power: supply: fix wrong interpretation of register value
> >    mfd: mp2629: introduce chip id machanism to distinguish chip
> >    mfd: mp2629: Add support for mps mp2733 battery charger
> >    iio: adc: mp2629: restrict input voltage mask for mp2629
> >    power: supply: Add support for mp2733 battery charger
> >    power: supply: mp2629: Add USB fast charge settings
> > 
> >   .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
> >   drivers/iio/adc/mp2629_adc.c                  |   5 +-
> >   drivers/mfd/mp2629.c                          |   7 +-
> >   drivers/power/supply/mp2629_charger.c         | 229 +++++++++++++++---
> >   include/linux/mfd/mp2629.h                    |   6 +
> >   5 files changed, 226 insertions(+), 37 deletions(-)
> >   
> 
> Hi,
> 
> Can someone give me share the plan for this series?

Given some cross dependencies I think the whole lot should go through
mfd.  Lee?

Thanks,

Jonathan
> 
> Thanks,
> Saravanan

