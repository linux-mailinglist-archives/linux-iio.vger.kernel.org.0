Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F17ACAC8
	for <lists+linux-iio@lfdr.de>; Sun, 24 Sep 2023 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjIXQcY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Sep 2023 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQcX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Sep 2023 12:32:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA65FC
        for <linux-iio@vger.kernel.org>; Sun, 24 Sep 2023 09:32:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E872DC433C7;
        Sun, 24 Sep 2023 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695573137;
        bh=xrgcKcIJ3NKA/H9G4RGIq7yveFU9dVoZ/QCyw2vR8NM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EWD1u8LdQFX6+Ekxyeh2LNnyiCNuiRoSCa9B/vyijd/JMRcnYloywR47OtQpnZuMJ
         5Z5fz2hh0uHMOH6PQsUVEhtscWjIZ1p60npqoEiXtk8w2o1Z8sUhmm23tAZX90ugZp
         IF9K6OuPQrJsV2CykJVzQhrvNv7tarA5ySkxJTNtPpHl+2VTLqnQHbm6Cl5CuJluse
         PII9GQMHVgXPokJMaOOAkgvICez27Nq/24i61mY2ASunvlxFALxE+k5cTby85CIj2Q
         dexohY8E+XbzhgQURfPOnmeGYVCYYoIX07QaOaKSh9N/p4iFYWw9idSXhRXN825Wqu
         6ZvBUAplT0SYA==
Date:   Sun, 24 Sep 2023 17:32:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Conall O'Griofa <conall.ogriofa@amd.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] Xilinx XADC fixes
Message-ID: <20230924173210.13f2bf85@jic23-huawei>
In-Reply-To: <bae646e9-7977-4de3-927b-ffcb7a94ac48@amd.com>
References: <20230915001019.2862964-1-robert.hancock@calian.com>
        <bae646e9-7977-4de3-927b-ffcb7a94ac48@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Sep 2023 08:52:49 +0200
Michal Simek <michal.simek@amd.com> wrote:

> +Conall
> 
> On 9/15/23 02:10, Robert Hancock wrote:
> > Fixes for a couple of issues in the Xilinx XADC driver: one where
> > preconfigured temperature/voltage thresholds were being clobbered and
> > potentially breaking overtemperature shutdown, and another for inaccurate
> > temperature readings on UltraScale family devices.
> > 
> > Changed since v2: Updated to also remove disabling XADC alarm bits.
> > 
> > Robert Hancock (2):
> >    iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature
> >      thresholds
> >    iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale
> > 
> >   drivers/iio/adc/xilinx-xadc-core.c | 39 +++++++++++-------------------
> >   drivers/iio/adc/xilinx-xadc.h      |  2 ++
> >   2 files changed, 16 insertions(+), 25 deletions(-)
> >   
> 
> Conall: Please test and review.

I'm sitting on this one until I hear back.   No huge rush, but if you
can estimate when you'll get to this I know to leave you alone until after
that!

Jonathan

> 
> Thanks,
> Michal

