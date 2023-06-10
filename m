Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9A72ADCA
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jun 2023 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFJRh5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jun 2023 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFJRh4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jun 2023 13:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36FB358E;
        Sat, 10 Jun 2023 10:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B0C61789;
        Sat, 10 Jun 2023 17:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D868C433EF;
        Sat, 10 Jun 2023 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686418674;
        bh=sDbXjydUZcplomPk5Q6/w1NDK3IqB8vVcujoG66l0qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KTm0Fu+hZnhe/254F+GzfqJjduxSNDiIggUtbFtvKyNmj3lQNh2TOhnLR4pFGSOtc
         lRyNBpElGc0lCpqur71czcShU3SnBWb65i14NRxoAhWfQnW7Ef4EaWjKNuP+IE8kPV
         PBql1LCv8F5ofmdDZDVkwsY7Pm6zsqVi+wc+4JpHm1DQnW19nNmCfpkJd8QZIC+bWh
         45WSn5rW4kZglotdC8RR7O1wHR9zAH5iC1OZfNUbmGOr/rmx/uRlOnGtlMfos9NTLV
         r9E7sO2AVj8y+/I8WZNHkxN9dKuxrKztdcvEba/f/JeqDtqZvB5sNCtrOUA1mCZ8zt
         5z+yzsHqTFXrQ==
Date:   Sat, 10 Jun 2023 18:54:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Spelling
 s/curcuit/circuit/
Message-ID: <20230610185430.228f977f@jic23-huawei>
In-Reply-To: <f5e1ea82-75b7-8164-f82a-5ad6054ccb5e@axentia.se>
References: <a8597e54b55dedc51025fe3073d25ef0d659d0dc.1686045793.git.geert+renesas@glider.be>
        <f5e1ea82-75b7-8164-f82a-5ad6054ccb5e@axentia.se>
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

On Tue, 6 Jun 2023 12:38:35 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> 2023-06-06 at 12:03, Geert Uytterhoeven wrote:
> > Fix a misspelling of "circuit".
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> 
> Acked-by: Peter Rosin <peda@axentia.se>

Applied to the togreg branch of iio.git

Thanks,

Jonathan

> 
> Cheers,
> Peter
> 
> > -  a curcuit.
> > +  a circuit.  

