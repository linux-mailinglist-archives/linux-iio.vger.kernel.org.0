Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9457E0571
	for <lists+linux-iio@lfdr.de>; Fri,  3 Nov 2023 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjKCPUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Nov 2023 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjKCPUC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Nov 2023 11:20:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD63D47
        for <linux-iio@vger.kernel.org>; Fri,  3 Nov 2023 08:20:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMPT33pJmz6J9qG;
        Fri,  3 Nov 2023 23:15:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 15:19:58 +0000
Date:   Fri, 3 Nov 2023 15:19:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        <linux-iio@vger.kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "Jagath Jog J" <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based
 direct mode claiming infrastructure
Message-ID: <20231103151957.00001f2e@Huawei.com>
In-Reply-To: <20231102104848.GA3818@noisy.programming.kicks-ass.net>
References: <20231022154710.402590-1-jic23@kernel.org>
        <20231022154710.402590-2-jic23@kernel.org>
        <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
        <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
        <20231024151123.GB40044@noisy.programming.kicks-ass.net>
        <20231024152800.GA13938@noisy.programming.kicks-ass.net>
        <20231028175928.09047193@jic23-huawei>
        <20231102104848.GA3818@noisy.programming.kicks-ass.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2 Nov 2023 11:48:48 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Oct 28, 2023 at 05:59:28PM +0100, Jonathan Cameron wrote:
> 
> > #define scoped_cond_guard_call(_name, _call, args...) \
> > +	for (CLASS(_name, scope)(args), \
> > +	     *done = NULL; !done; done = (void *)1) \
> > +		if (!__guard_ptr(_name)(&scope)) _call; \
> > +		else
> > 
> > Totally untested but hopefully conveys the idea (which is a tiny
> > extension of your scoped_cond_guard)  
> 
> It's a statement not a call, but yeah, I've done something like this,
> even made one of my cases simpler too,

Good point.

> 
> Let me got post this stuff so we can get it merged.
> 

Great.  I really like this whole effort, so thanks for working on it
and your feedback here.

Jonathan

