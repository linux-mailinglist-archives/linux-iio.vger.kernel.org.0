Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25FA50D304
	for <lists+linux-iio@lfdr.de>; Sun, 24 Apr 2022 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiDXQFu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Apr 2022 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiDXQFt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2022 12:05:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10974DDE;
        Sun, 24 Apr 2022 09:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6527B80AB3;
        Sun, 24 Apr 2022 16:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6274DC385A7;
        Sun, 24 Apr 2022 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650816165;
        bh=KJ2aAXuTqumrNW/oYiBr11RoCkH9tnnRFX9BovDO7hI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=szRyjFyga826MuYSzKYOjgCiHGZyMqkHoHIrJp3Uxr9x0w0I6TFs8Yq8QGultW3Zu
         NDNAYq404u6/oRYTtD/bvoCapNfDIU9P/1d3gVgxxrRbJgH4dg/VH/62hUFtTuQSGx
         eS/q7EeRrsO4xopJ4pJagwVYj52p+o5WHIMiKKAskxZGHUz9O4SJyRQq+n9GYUF1Xt
         F2NNRMJqLshexf42WrGRUj9obQ65VtTAaOl2q4WF/lwj5PI4NOgnEB/Hy4axJxI9Dh
         VsyCa0CcqrnscGc2Hp/SttP+yaFBxS5YPTwU90BEMxnVPTEEaPr1soBSv6GfT6eCpW
         8trBdqPPc9Heg==
Date:   Sun, 24 Apr 2022 17:10:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: Document Renesas RZ/V2L ADC
Message-ID: <20220424171052.0872ed89@jic23-huawei>
In-Reply-To: <164bbdf7-e74d-7f30-6657-6c80d2f91a97@linaro.org>
References: <20220423131654.131390-1-biju.das.jz@bp.renesas.com>
        <164bbdf7-e74d-7f30-6657-6c80d2f91a97@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 23 Apr 2022 20:57:26 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 23/04/2022 15:16, Biju Das wrote:
> > Document renesas RZ/V2L ADC bindings. RZ/V2L ADC is identical to RZ/G2L
> > with same number of channels.
> > 
> > While at it remove RZ/G2LC SoC from binding documentation as it does not
> > support ADC.  
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> 
> 
> Best regards,
> Krzysztof

