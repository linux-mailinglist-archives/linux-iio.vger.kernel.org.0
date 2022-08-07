Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2A58BB0A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiHGNak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiHGNaf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 09:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C74964F3
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 06:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A003460EEB
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 13:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB79C433C1;
        Sun,  7 Aug 2022 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659879033;
        bh=37+GqQKAk9RBEfwMSgZGu/Nl1LkRTs25UqwCtfvn9/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OviwCgoEBMIBHl/gtxvULf/OttbKZItq7aeByvoXhI629oS2PT8CboxSxw+tJy8a6
         E3FmdU7oxxQBdyRjb1KIeDf1qtOMrL2RXcA4V14j4sheIBonV1+Y3S06RvP1xkuuf5
         pNq+ghRiRPI89Ly+i40Txw3wN2QkFZU41dY9bwm8OU0Cm17+pXOhpVE3VJbXtuC1xy
         suzQsEP7q4OEq0dUy/Fd0NlPRJFvdGpHqMFgBqz1INCsZsZ1mFt6Q5jdsZ5IFQhmAy
         Hwt+jN1exVC8S4rtaU+C1ERXiylOZDPgIGY7wt61PZoOYfe2fBDPtbxjg/OZrnC3ny
         6MkabxVUNjeag==
Date:   Sun, 7 Aug 2022 14:40:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 08/17] staging: iio: cdc: ad7746: Break up use of
 chan->address and use FIELD_PREP etc
Message-ID: <20220807144054.14b597f2@jic23-huawei>
In-Reply-To: <CAHp75VfopwTrTQ-QeDs2CbmGy+xoUGeQ2g=ysr5AP3f78VxFLw@mail.gmail.com>
References: <20220626122938.582107-1-jic23@kernel.org>
        <20220626122938.582107-9-jic23@kernel.org>
        <CAHp75VfopwTrTQ-QeDs2CbmGy+xoUGeQ2g=ysr5AP3f78VxFLw@mail.gmail.com>
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

On Tue, 28 Jun 2022 14:15:57 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 26, 2022 at 2:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Instead of encoding several different fields into chan->address use
> > an indirection to a separate per channel structure where the various
> > fields can be expressed in a more readable form.  This also allows
> > the register values to be constructed at runtime using FIELD_PREP()  
> 
> FIELD_PREP().
> 
> (Note period)
> 
> > Drop the now redundant _SHIFT macros.  
> 
> ...
> 
> >  /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
> >  #define AD7746_CAPDAC_DACEN            BIT(7)
> > -#define AD7746_CAPDAC_DACP(x)          ((x) & 0x7F)
> > +#define AD7746_CAPDAC_DACP_MASK                0x7F  
> 
> GENMASK() ?
> 

Both fixed whilst applying the patch.  Thanks!
