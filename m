Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB92B5E8D38
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiIXOLZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIXOLY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 10:11:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F1883CF
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 07:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2709060B5E
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 14:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CFCC433D6;
        Sat, 24 Sep 2022 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664028682;
        bh=TgL1FJJuwX5b5wUgEPuZ3QVtNV36nuO/weXLkyJjwk0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kwxEKWH2Rpa0HBypdezG64v+r/JweATicxtB909VthdQlzd0eDC74tJSFtgdsFmEi
         kLVqLrz8PCkkhyjexQTEw+ZaqlRxNyilVCG88TjZQ7SIMPujM0TVHRXdQmyOqoSYRA
         7l6UPYYmXmM2RZjtXD+CMFWCyaEXUkyVpOUidLGQOsLNcsigLFuqfl/alNC9jYurI2
         goCTpKI8m4/3+wZLsR7L7BXeMW4ImXaqLb/inwukzJ6e7AOEJH2Oqq/oCkKHQvNSPg
         LKT7KUCdfuoLXM1EuyIKV+XXja5coAHyj+FlzxyYjyLtoBqaz9m8TnxGIOyh2SPQiW
         6/oRfk4FAZbpA==
Date:   Sat, 24 Sep 2022 15:11:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v5 1/3] iio: adc: add max11410 adc driver
Message-ID: <20220924151130.53afd007@jic23-huawei>
In-Reply-To: <20220920152628.285-2-Ibrahim.Tilki@analog.com>
References: <20220920152628.285-1-Ibrahim.Tilki@analog.com>
        <20220920152628.285-2-Ibrahim.Tilki@analog.com>
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

On Tue, 20 Sep 2022 18:26:26 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> has 3 differential reference and 10 differential channel inputs.
> Inputs and references can be buffered internally. Inputs can also
> be amplified with internal PGA.
> 
> Device has four digital filter modes: FIR50/60, FIR50, FIR60 and SINC4.
> FIR 50Hz and 60Hz rejections can be enabled/disabled separately.
> Digital filter selection affects sampling frequency range so driver
> has to consider the configured filter when configuring sampling frequency.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Given we'll have a v6 to try and resolve the open question on the
binding, I may take another look, but on this look through
the driver looked very good to me, so no comments to address on this
patch or patch 3.

Jonathan


