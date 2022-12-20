Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D82665227B
	for <lists+linux-iio@lfdr.de>; Tue, 20 Dec 2022 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiLTO00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Dec 2022 09:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiLTO0V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2022 09:26:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1925719027
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 06:26:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A36961477
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 14:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC896C433D2;
        Tue, 20 Dec 2022 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671546377;
        bh=tYBxYQPxmjWyfIQV69lN1LLorJx1grvusxR//M+3ORw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Vfdcn9HHGZ3dUyEEFF+O0SKWhdvRPK1RS6C9hHZUd+4gSUoEarG3TbWQBPRIwyw1n
         g5BF8cXyyYMlgoPbNNYQzuvdChY73G8DjjhrnZjWlLstHQ+gqAFu8MN1bYLcC/nhD/
         yi1bJlkWEFGkPv9XiCDjk0Z+FxLzyu61MJQmKye0KRw1SJqRZesmSC47/XIGa+9sQ8
         Uami0DLeUgeI4SQ9aJioxs3wKTWByk56/FsuiBiosI59zzenE6v1ZcTCzYWcAR5nW+
         o+dZikQghcxKwOJH2vMNWr1colUtid94V+C3Hd8B8nv1SrnxXYiTaYY3Z/1tctrc2h
         9SASts4+01BLw==
Date:   Tue, 20 Dec 2022 15:26:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 0/4] IIO: More HID custom sensors
In-Reply-To: <20221215162152.0000693f@Huawei.com>
Message-ID: <nycvar.YFH.7.76.2212201525010.9000@cbobk.fhfr.pm>
References: <20221124233841.3103-1-p.jungkamp@gmx.net> <623f2206647e69199c64064c48eb8bf03afb99da.camel@linux.intel.com> <cc35bdc25daedb32dbb5949f99559485a7f83080.camel@gmx.net> <nycvar.YFH.7.76.2212141819340.9000@cbobk.fhfr.pm>
 <20221215162152.0000693f@Huawei.com>
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

On Thu, 15 Dec 2022, Jonathan Cameron wrote:

> Probably more sensible if you pick it up through hid.git given the 
> balance of changes.
> 
> If you can make an immutable branch even better on the off chance anything else
> comes up that hits few lines changed in the IIO drivers.  I'd only pull that
> into IIO if we needed to though (and I would be surprised if we do!)

This is now in hid.git#for-6.3/hid-sensor and we can branch an immutable 
branch off it if needed (and if there are any hid-sensor patches coming on 
top later).

Thanks,

-- 
Jiri Kosina
SUSE Labs

