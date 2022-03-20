Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01464E1BB5
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 13:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbiCTMm5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 08:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiCTMm4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 08:42:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51A198EDA;
        Sun, 20 Mar 2022 05:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 441DAB80E71;
        Sun, 20 Mar 2022 12:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3259C340E9;
        Sun, 20 Mar 2022 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647780090;
        bh=kMK8NQO2KsHasdlsSiGWohw55TeYXIvSplN+LYLLYdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKTR0ZHnya3OihOB7Ck6ct6qw5RhkKnPAxaChKXTeyMScQMflgS81JOaDXx7ItZfF
         PeIJ5jpbmNjJpbAZ+P7Z8T7uuYDXYcYcZTyITUH7UWiiMQtV3nEp/LBgyLvAOeB0Iq
         0QwtwKE8BxB4q+gqox5l42enIz2Ni4MZQSBSQzdf5rvdBsaryoYYk87tJGeep3I0lS
         z+EL31G3+LPazYC0HuXUQioBMpCa5DimhUYgK+X5mAfZOkwZ4VR1vjNaCdJ3rO35uH
         kLlKT29vDYKYQYLEq3IFp50b0pbvxMlqYMKHHZOgF8vczGp7YMcFMb+wuV/i2zX+fp
         JgOk9iazibbBw==
Date:   Sun, 20 Mar 2022 12:48:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] Add settings for precharge and internal resistor
Message-ID: <20220320124854.5ad1f0ff@jic23-huawei>
In-Reply-To: <20220315173042.1325858-1-gwendal@chromium.org>
References: <20220315173042.1325858-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Mar 2022 10:30:35 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> For Semtech sensors SX9324 and SX9360, allow confugration of the
> pre-charge resistor (9324/9360) and internal resistor (9324).
> 
> Fix a register name spelling mistake first.
> The 9360 changes are independant from the 9324 changes, but they are
> very similar.
General comment on a pet hate of mine as someone who scan reads an awful
lot of mailing lists:  Always include the driver prefix for the
cover letter title as well to save a small amount of extra time it takes
people who are not interested in this patch series to skip over it.
So
iio: sx9324/9360: Add settings for precharge and internal resistor.

Also makes it easier to spot the series in patch work which is how I
just noticed the prefix wasn't there :)

Thanks,

Jonathan

> 
> Gwendal Grignou (7):
>   iio: sx9324: Fix register field spelling
>   dt-bindings: iio: sx9324: Add precharge resistor setting
>   iio: sx9324: Add precharge internal resistance setting
>   dt-bindings: iio: sx9324: Add internal compensation resistor setting
>   iio: sx9324: Add Setting for internal compensation resistor
>   dt-bindings: iio: sx9360: Add precharge resistor setting
>   iio: sx9360: Add pre-charge resistor setting
> 
>  .../iio/proximity/semtech,sx9324.yaml         | 20 +++++++++
>  .../iio/proximity/semtech,sx9360.yaml         |  9 ++++
>  drivers/iio/proximity/sx9324.c                | 42 ++++++++++++++++---
>  drivers/iio/proximity/sx9360.c                | 12 +++++-
>  4 files changed, 77 insertions(+), 6 deletions(-)
> 

