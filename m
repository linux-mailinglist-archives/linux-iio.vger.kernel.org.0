Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8A7DF086
	for <lists+linux-iio@lfdr.de>; Thu,  2 Nov 2023 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbjKBKtN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Nov 2023 06:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbjKBKtN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Nov 2023 06:49:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF28181
        for <linux-iio@vger.kernel.org>; Thu,  2 Nov 2023 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zcHop8NuQuPzRcwE1qtEp0smISu64VSHzQzb9edrhRg=; b=LawOFogMf+HUsU37euD0aNMwL7
        qVaIMSD2M6hVqLDlWHga3qDhczJiOAolbQHe1OY0+1ccJ1WRJZWMi4FUeHQWCvoiRwUn0UC4H7JFs
        mDU+W+38i9ccxkrq5va6JhPNKPElLzhO4PC0RyGxeOcSfx0RlhtTh1vYE+AvQLYJx0T4fJfJu6P3L
        lnVontSAcSAo0IYcwTxGrCNPWaYxbLqE4BS6mvhhGcot38SjvHvaP5qeqH/iBz0bp5vpTj3uaPhvQ
        pZ9kKkTjqdI83pTB/83xN5667kabgjOPdrMrgmrGY1Sw3hUdgVp7RM51r052gppixCnArrRFxMN6s
        1pMOpXBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyVFo-00413U-MA; Thu, 02 Nov 2023 10:48:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 548E03004AB; Thu,  2 Nov 2023 11:48:48 +0100 (CET)
Date:   Thu, 2 Nov 2023 11:48:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        linux-iio@vger.kernel.org, Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based direct
 mode claiming infrastructure
Message-ID: <20231102104848.GA3818@noisy.programming.kicks-ass.net>
References: <20231022154710.402590-1-jic23@kernel.org>
 <20231022154710.402590-2-jic23@kernel.org>
 <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
 <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
 <20231024151123.GB40044@noisy.programming.kicks-ass.net>
 <20231024152800.GA13938@noisy.programming.kicks-ass.net>
 <20231028175928.09047193@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028175928.09047193@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 28, 2023 at 05:59:28PM +0100, Jonathan Cameron wrote:

> #define scoped_cond_guard_call(_name, _call, args...) \
> +	for (CLASS(_name, scope)(args), \
> +	     *done = NULL; !done; done = (void *)1) \
> +		if (!__guard_ptr(_name)(&scope)) _call; \
> +		else
> 
> Totally untested but hopefully conveys the idea (which is a tiny
> extension of your scoped_cond_guard)

It's a statement not a call, but yeah, I've done something like this,
even made one of my cases simpler too,

Let me got post this stuff so we can get it merged.
