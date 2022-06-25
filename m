Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14C55AAC6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiFYOHP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiFYOHP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 10:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECB610565;
        Sat, 25 Jun 2022 07:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A636F6143D;
        Sat, 25 Jun 2022 14:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6ACC3411C;
        Sat, 25 Jun 2022 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656166030;
        bh=ncHTq1rfd02zCjxs4wvYc8wFAEzHEskFhpUAiHMntUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NRSscMzBpN9qjaB67VBuCFwkVW+PzE2QjLTN2hB2iJY+js9MlK2caKUMnTNs+VTsc
         hbE+QzndeTLgvWGG7mK4UBQSm6r7j/Gk01SbiRMdXzUOQqZ2V4G5aIHUsSPrsJLVOh
         +4xwZ+xiTeEPv3nTsmcpeksWm69wrbALyc7SPkHq4hl4P98iP4FxzYRfP36RUU2RM/
         F0nvqy8UIM82vQw9R+7VrAkGGZFnrUILJbUNpBka6oDCadseASd1/BF2XGvXwE/U82
         iP0o6MP3ciVYkxhqRuIa7qI3IYTItTnzvbXDLWur4mRrklr/BvDBYwo4R9QuLzW5O0
         jJ01ZK6K4xeMA==
Date:   Sat, 25 Jun 2022 15:16:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 6/8] iio: magnetometer: yas530: Rename functions and
 registers
Message-ID: <20220625151637.600d20a0@jic23-huawei>
In-Reply-To: <d3e074b8-9679-87fe-dc5a-9493f0586aca@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <f1a49262b124cbcdf4a258f65fd54ee389de3a29.1655509425.git.jahau@rocketmail.com>
        <20220618160041.15798dcd@jic23-huawei>
        <d3e074b8-9679-87fe-dc5a-9493f0586aca@rocketmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jun 2022 02:53:58 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> Hi Jonathan,
> 
> On 18.06.22 17:00, Jonathan Cameron wrote:
> >
> > On Sat, 18 Jun 2022 02:13:14 +0200
> > Jakob Hauser <jahau@rocketmail.com> wrote:
> >   
> >> This is a preparation for adding YAS537 variant.
> >>
> >> Rename functions used only by YAS530 & YAS532 from yas5xx to yas530_532.  
> > 
> > We've been bitten in the past by naming choices like this, so please
> > use yas530 only and rely on comments or code that makes it obvious that
> > it applies to the yas532 as well.  
> 
> Hm, ok. It's harder to keep the overview. But I can imagine adding up
> names can get out of control. I'll change it.
> 
> For functions and registers used by all variants, I'd keep yas5xx or
> YAS5XX respectively. I hope that's ok.

I reserve the right to laugh at you if the next variant to come along
fits the wild card but not the registers that have been shared until then :)

Otherwise, I'm fine with keeping the naming for those cases.

Jonathan

> 
> Again I'm not sure on the "Reviewed-by:" tags. Again the patch gets
> modified a lot, therefore I would remove the tags.
> 
> ...
> 
> Kind regards,
> Jakob

