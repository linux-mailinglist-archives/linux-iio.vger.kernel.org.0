Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC764CECD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 18:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiLNRUS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 12:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbiLNRUN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 12:20:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF0221
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 09:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6D8F61B2D
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 17:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16709C433EF;
        Wed, 14 Dec 2022 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671038411;
        bh=4o8bGLbOgAdRBiaBrM4EOifTtrbZy511lmpU+q7yLDk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bZNWfWGpdhjZeKrae+WLJzY4s2OK3hCtnLjWvrLWSMEdrM5qlzqNpOsXGGpwf8AsM
         o2J2T4n+RqTbEOgwm7M/+bFwq3m5LFap7eyei8r+j01SLPlE4Leg0uivfrEziRSZHt
         WqPTKwI5kRxrCXvimLd57RRp9i3GXdhXqvwqvusUSK5VLIhBxN3CYPx6dTBiPDmmqh
         iCN9cCdGLTQZ3++6Tq15QVZYoHAp8+8i4JXDGCApzrMv0F+Oagek3EmRp8DwM9zY9b
         ErfxosnCPHZldsj/q7lhznKMW/3MBuQC/7ZQ+C27DQ3L4DsTM41Yf7hBpxrEK7jDUb
         Mqw2XkBWTULCw==
Date:   Wed, 14 Dec 2022 18:20:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 0/4] IIO: More HID custom sensors
In-Reply-To: <cc35bdc25daedb32dbb5949f99559485a7f83080.camel@gmx.net>
Message-ID: <nycvar.YFH.7.76.2212141819340.9000@cbobk.fhfr.pm>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>  <623f2206647e69199c64064c48eb8bf03afb99da.camel@linux.intel.com> <cc35bdc25daedb32dbb5949f99559485a7f83080.camel@gmx.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Dec 2022, Philipp Jungkamp wrote:

> Is there something I still need to do for this to be merged in the next
> merge window?
> 
> I don't quite understand what would happen next. I'm curious and hope I
> don't bother in the busy times when approaching a merge window.

Unless Jonathan prefers to take this through iio.git for some reason, I'll 
pick it up into hid.git for 6.3 once 6.2 merge window is over.

Thanks,

-- 
Jiri Kosina
SUSE Labs

