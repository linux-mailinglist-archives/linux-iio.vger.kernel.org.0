Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E3592035
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbiHNOle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiHNOld (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 10:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F202713D07
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 07:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8373B60BC2
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 14:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5858C433D6;
        Sun, 14 Aug 2022 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660488091;
        bh=fjxatODcRUZ9eK5+iGW2XPF+/8rgUq+JR0xv0e3yh/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KjdMwbUvKHV9nb7PTAnI5VfV2YExMLXKq/pAcE4Izgixrl4KDKEwTuO+o3CSNQ7H0
         50C9HsfE3F/JSO11w9wsOrXSPC+5xchGkn68cr0dEc9VtVOmwt6iz0XeMjfkkVvcp2
         QWsw6s3VITuluc3pe9Z2k1yB+XxCRXfyxPVp26FKmBZyOoAVZ7qWtU+uXFj3Q7EzD2
         LKJW7KM7G92jg4s4th1QY8tYu0muPPO+J3NveoSw88TGdmX0c1zSqVYfBWJyM2kzSw
         ZizswMoJpYozwX07Vv7A3Kr2OrbE3g9jIVMC910vtzKM003N9sDV0EvMEPSyGciOa2
         pn2tU7ZOpHwjA==
Date:   Sun, 14 Aug 2022 15:52:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v3 0/2] iio: adc: add max11410 adc driver
Message-ID: <20220814155201.3fcb98b3@jic23-huawei>
In-Reply-To: <20220811134243.111-1-Ibrahim.Tilki@analog.com>
References: <20220811134243.111-1-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 11 Aug 2022 13:42:41 +0000
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> I added filter enable attributes for 50Hz and 60Hz FIR filters.
> Disabling both will set filter to sinc4, allowing higher sampling rates.
> 
> Regards,
> Ibrahim
> 
> Note: No sign-off tag for David as he was unreachable when the initial patch was sent.
> 
> Changelog:
> since v3:
>   - prefix defines with MAX11410_
>   - group vref regulators
>   - use builtin iio_validate_scan_mask_onehot
>   - validate iio trigger
>   - move scan data into state struct
>   - require vrefn regulator in DT if used by any channel
>   - don't require irq for triggered buffer
>   - remove filter sysfs attr and ABI documentation
>   - add in_voltage_filter[0-1]_notch_{center,en} attrs

I'm not seeing a documentation patch for this new ABI.
It's subtly different from the existing entries in
Documentation/ABI/testing/sysfs-bus-iio and the _en part is
new in general for filters.

I'll take a look at the rest of the code, but Docs need to
be in place and reviewed before I can take the driver.

Thanks,

Jonathan



> 
> since v2:
>   - remove bit position shifting, use field_prep instead
>   - reduce the amount of reg writes in max11410_configure_channel
>   - add error checking in max11410_parse_channels
>   - remove some unneeded blank lines and minor style fixes
>   - remove scan data assignment in max11410_trigger_handler
> 
> 
> Ibrahim Tilki (2):
>   iio: adc: add max11410 adc driver
>   dt-bindings: iio: adc: add adi,max11410.yaml
> 
>  .../bindings/iio/adc/adi,max11410.yaml        | 165 +++
>  drivers/iio/adc/Kconfig                       |  13 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/max11410.c                    | 954 ++++++++++++++++++
>  4 files changed, 1133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
>  create mode 100644 drivers/iio/adc/max11410.c
> 

