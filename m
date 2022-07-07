Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAF56A62A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiGGOuw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jul 2022 10:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGGOtq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 10:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4746C45073
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 07:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFECA622C9
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 14:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1E5C3411E;
        Thu,  7 Jul 2022 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205375;
        bh=jYLSsBEBRhlPfGKSROk0gdxxBYcoGtCzGE7jtSaImds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HpuG3HiupBgFqFClzTQ337tdW54uGgU4YoMnI0tTlU/mZ9J+NJlA1SXqGE+hDmETA
         LHPSrLQupWYBBadL3qCYdII2N1pU8WazjYvRDlj5tanl8pMS6jip5ZYKqo/3Hv15cd
         vN68Z5EoXqvfXfE2qa2itUjqQmFRxXH2AaZ5Dw688nvIOdjkXgLLGVu/3Nar1djsnk
         OmOfcXImlX4I0MneYGlLI1O5KyNGriRr5RkmneEd5uvUKKqqPGxub2kUz6ygywnhO5
         P5dqmSZKLdLN7+jplOG4dpy0IT9Ptol8OLw8I//fbs/dhEdcUJFHWpwmTU8sMzYBVb
         yvWm59amA9WTQ==
Date:   Thu, 7 Jul 2022 15:59:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <andy.shevchenko@gmail.com>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: add max11410 adc driver
Message-ID: <20220707155918.51726193@jic23-huawei>
In-Reply-To: <20220707082811.167-1-Ibrahim.Tilki@analog.com>
References: <CAHp75Vc93yhKL+6FwfgvrV7QpDvP3OZt2LLZvSQcgO5PkYcaJg@mail.gmail.com>
        <20220707082811.167-1-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Jul 2022 08:28:11 +0000
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> > > +static irqreturn_t max11410_trigger_handler(int irq, void *p)
> > > +{
> > > +       struct iio_poll_func *pf = p;
> > > +       struct iio_dev *indio_dev = pf->indio_dev;
> > > +       struct max11410_state *st = iio_priv(indio_dev);
> > > +       struct {
> > > +               int data;
> > > +               s64 ts __aligned(8);
> > > +       } scan = {0};  
> > 
> > Why do you need an assignment here?
> > Even memcpy() in IRQ context is a burden.  
> 
> Because the buffer gets populated with meaningless data in the absence of assignment due to timestamp alignment.
> I've removed the assignment and addressed your other comments and sent a new series of patches.

I'll look at v2 in more depth, but as this got highlighted...
a) A non fixed size type for a scan element is going to potentially cause
problems.
b) There are holes in that structure, so you can't get away with just assigning
it as the compiler isn't guaranteed to zero out the holes.  An explicit memset()
is needed (as IIRC that is guaranteed to do so).

Jonathan

> 
> Best regards,
> Ibrahim Tilki

