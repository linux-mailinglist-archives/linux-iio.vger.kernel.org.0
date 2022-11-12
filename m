Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD184626ADF
	for <lists+linux-iio@lfdr.de>; Sat, 12 Nov 2022 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiKLR2w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Nov 2022 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiKLR2v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2022 12:28:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263E1BC8C;
        Sat, 12 Nov 2022 09:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79F59B80AEF;
        Sat, 12 Nov 2022 17:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF05C433C1;
        Sat, 12 Nov 2022 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668274128;
        bh=F485qhHTIh9CmK7hy1NhMzh6HMGWQY7IhAau/1prH8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=snsSgQwL63w7qszuQIr8NuGMAbHR8B3SAESy8OQ6Fj+YNfe+LxAZba4WGJlfeau5U
         eqCFeQhZy53CYLfIprYsIpKglZoPi33jVN5ilueykMqgUnTCWPBJLQoPss6crGjsGl
         wshmQF8EvZo9P7p2X6dTuDgOYP113xZKdq94A7EFYbkhincVkZPsKUq2fyKih7qzmi
         8iPmpzsy0PjoT9SXPBjgQK1rRXwYgSPyBB1X7S85OLWRmTk7CWMtyuOQjeqw2VGfUB
         AFS8UMcSgrxk68MjeIxkfQfJ7oi1p5Dyk/f+TMTkvxRgqzCXCbFwxXVAW6DZGiB7vm
         iioKmf/7pTtEg==
Date:   Sat, 12 Nov 2022 17:41:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 03/10] dt-bindings: iio: adc: rockchip-saradc: Add
 saradc for rv1126
Message-ID: <20221112174101.472abb56@jic23-huawei>
In-Reply-To: <58ee258e-8708-abcc-077b-c6b4a1a4185a@linaro.org>
References: <20221108041400.157052-1-jagan@edgeble.ai>
        <20221108041400.157052-4-jagan@edgeble.ai>
        <58ee258e-8708-abcc-077b-c6b4a1a4185a@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 8 Nov 2022 19:09:45 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 08/11/2022 05:13, Jagan Teki wrote:
> > Add saradc compatible string for rockchip rv1126.
> > 
> > Cc: linux-iio@vger.kernel.org  
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied this patch to the togreg branch of iio.git and pushed
out as testing for 0-day to poke at all the patches I've queued
up today.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

