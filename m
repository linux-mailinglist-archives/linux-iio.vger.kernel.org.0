Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D787674BDCB
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jul 2023 16:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGHOYj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jul 2023 10:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHOYi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jul 2023 10:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC818191;
        Sat,  8 Jul 2023 07:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 792E560C70;
        Sat,  8 Jul 2023 14:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77ACC433C8;
        Sat,  8 Jul 2023 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688826276;
        bh=cYp2646opo8JbxDix+tOX6h98Qvtgi6MUt4oterJbTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xe+++iJUo0B9ofzQCrwHd9qSNovyhKX/qS1aV8nXCIMxpLqED57KVf10INt39Kzdj
         iL/Z/Q28Dcjz/NhfEBB58NAnZipFZtKHnxe/sCZNIlhZ3vVtqKyivM+9V0Q+s+s3HF
         0ZJ55mSEpnBa2qImt2pSo/pAUNbnwSrxCKHThtQpFfZi9y6uuUu3LW5HHtD+U6DVuk
         28GoZIIA5Fld0BhYk2hNCTOzab1d5iObuqoHbJlZMpzDTTLxVOwit+CJf4ywVIeBYm
         5uAF8xfnITtqD39l3hW09vmOSNYrfNbBabcmPPRyfk/g2kBpnK0smohgLuWo7TnhNq
         MqFPyqfIhDC2g==
Date:   Sat, 8 Jul 2023 15:24:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, alazar@startmail.com, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: fix datarate max
 value and meaning
Message-ID: <20230708152428.58b527e8@jic23-huawei>
In-Reply-To: <5e2f841a-9afe-a057-613b-e5263eb126cb@linaro.org>
References: <20230621160857.3400747-1-m.felsch@pengutronix.de>
        <5e2f841a-9afe-a057-613b-e5263eb126cb@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Mon, 3 Jul 2023 18:18:28 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 21/06/2023 18:08, Marco Felsch wrote:
> > Datarate (dr) is a 3-bit wide register field. Values from 0 to 7 are
> > allowed for all devices but only for the ADS1115 devices a value of 7
> > does make a difference.
> > 
> > While on it fix the description of the datarate for ADS1115 devices as
> > well.
> >   
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied,

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

