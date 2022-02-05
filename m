Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0B54AAAA4
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 18:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380758AbiBERgk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 12:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351942AbiBERgk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2022 12:36:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62964C061348
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 09:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 053966115A
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 17:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19596C340E8;
        Sat,  5 Feb 2022 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644082598;
        bh=cAp3SLcW8N47lmDt/9fejTft+sUOi/P37Uv3thR1mR0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L2MzJJShOtaC39slp9D2wiKjZfj2yeVx5bUibdD9jPNcXz+XQ6BHqBy9z0Oh3JAWC
         oXSbbzfaJFwMkH9CU+4NW3sT5VQR25jVUDKduDrrwucoSB7Qv0juDReHlUeMmMydrd
         QYxOZCJiSLr8LP4KpjCddMYBybNlX/pmWNtBTn18ZbcPh/FMsEq49gL/GTVtRw9gdy
         P5B79DsiA1+TzkDwSuIs0Tf591hCaZeIys+CYD/Xya/RfnWFpBA0aLs/KL41HHHRK2
         SDfvAyTu8812KfqSM0NS0AIcG4CgWZGBGWswxtJHyZTWXCjb8sIpfocl/y+8YmsMwR
         njjnrRrXr770g==
Date:   Sat, 5 Feb 2022 17:43:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: CHECK: Macro argument reuse
Message-ID: <20220205174310.26786d5e@jic23-huawei>
In-Reply-To: <BYAPR03MB46478624466527B5263B83FF97279@BYAPR03MB4647.namprd03.prod.outlook.com>
References: <BYAPR03MB46478624466527B5263B83FF97279@BYAPR03MB4647.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Feb 2022 10:48:51 +0000
"Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com> wrote:

> Hi,
> 
> The driver I'm working on has channels which can be configured similarly but with small changes. In order to simplify the code, I used macros with arguments for the parts that are different.
> Unfortunately this leads to warnings during the checkpatch with --strict .
> 
> CHECK: Macro argument reuse 'num' - possible side-effects?
> +#define ADE9078_POWER_FACTOR_CHANNEL(num, name) {		\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_APF, num),	\
> +	.extend_name = name "_factor",				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			             BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = -1						\
> +}
> 
> Is there any way to fix this warning without adding more arguments?
> In this case, can it be ignored?

It's a request to 'CHECK' that it looks right, not a warning or error
because it may well be fine.  In this case, I'd hope it's fine
as long as you are only passing constant values in for num.
So check what it asks you to check and if it's fine ignore the message.

Jonathan
> 
> Regards,
> Ciprian
> 

