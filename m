Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9303D4E87E7
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiC0Nlv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiC0Nlu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 09:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E940E66;
        Sun, 27 Mar 2022 06:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D481961019;
        Sun, 27 Mar 2022 13:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218D3C340EC;
        Sun, 27 Mar 2022 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648388411;
        bh=5i/rEfC0HB9GBKSSLEUACxI9jlRbRA6ciFFumg8pWD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mkGyJSfxo4wbot8NgY6KtoGBwgSonbdWA/I+AbwpVBOHDHd8yjSUZeugPWhEkmgIi
         hveVOJ6eQNLH1fNdIp6IYAbcYqCJqGDM0I7pAb5M3EOUvOEVhLis5AzSO8mfl3Xvci
         w+kQG+A7mbsuXU8iIl4rPEm1MUGm5AkTFxNMVPunGa1F2CWtIlAfjXlvxOrWQiZAdB
         IjCB7gEi6MlIsHWFszGXNRWMfVmiU6376j0RySs2Ag0LBqn3k8gng5XqTDrYpRVH/e
         QH/vCP/9fnxssWF4KEhX9pxGBB7Y4kka+bAe/Jx9SYVsFGAwaEdZKkRgoI6XeerzPN
         fGUHfb26BcuIQ==
Date:   Sun, 27 Mar 2022 14:47:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Add settings for precharge and internal resistor
Message-ID: <20220327144743.4b29fa57@jic23-huawei>
In-Reply-To: <20220325220827.3719273-1-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Mar 2022 15:08:19 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> For Semtech sensors SX9324 and SX9360, allow confugration of the
> pre-charge resistor (9324/9360) and internal resistor (9324).
> 
> Fix register name spelling mistakes first and set default value properly
> for sx9324 internal resistor register.
> 
> The 9360 changes are independent from the 9324 changes, but they are
> very similar.
> 
> Changes since v2:
> - use -ohms instead of -kohms, as ohms is a defined unit in
>   dt-schema.git dtschema/schemas/property-units.yaml
> 
> Changes sinve v1:
> - Add kOhm Unit, add a new patch to fix invalid register setting.

This version looks good to me, but will leave time for dt review.
We aren't in a rush anyway at the moment so I'll probably not pick
it up until after rc1 is available.

Thanks,

Jonathan

> 
> Gwendal Grignou (8):
>   iio: sx9324: Fix default precharge internal resistance register
>   iio: sx9324: Fix register field spelling
>   dt-bindings: iio: sx9324: Add precharge resistor setting
>   iio: sx9324: Add precharge internal resistance setting
>   dt-bindings: iio: sx9324: Add internal compensation resistor setting
>   iio: sx9324: Add Setting for internal compensation resistor
>   dt-bindings: iio: sx9360: Add precharge resistor setting
>   iio: sx9360: Add pre-charge resistor setting
> 
>  .../iio/proximity/semtech,sx9324.yaml         | 19 ++++++++
>  .../iio/proximity/semtech,sx9360.yaml         |  9 ++++
>  drivers/iio/proximity/sx9324.c                | 44 ++++++++++++++++---
>  drivers/iio/proximity/sx9360.c                | 12 ++++-
>  4 files changed, 78 insertions(+), 6 deletions(-)
> 

