Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9BB26C7F1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgIPShK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:37:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:41692 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgIPSg7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 14:36:59 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9A70F2E5;
        Wed, 16 Sep 2020 18:36:50 +0000 (UTC)
Date:   Wed, 16 Sep 2020 12:36:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] kernel-doc: add support for ____cacheline_aligned
 attribute
Message-ID: <20200916123649.20d7d999@lwn.net>
In-Reply-To: <20200910185415.653139-1-jic23@kernel.org>
References: <20200910185415.653139-1-jic23@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 19:54:15 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Subroutine dump_struct uses type attributes to check if the struct
> syntax is valid. Then, it removes all attributes before using it for
> output. `____cacheline_aligned` is an attribute that is
> not included in both steps. Add it, since it is used by kernel structs.
> 
> Based on previous patch to add ____cacheline_aligned_in_smp.
> Motivated by patches to reorder this attribute to before the
> variable name.   Whilst we could do that in all cases, that would
> be a massive change and it is more common in the kernel to place
> this particular attribute after the variable name. A quick grep
> suggests approximately 400 instances of which 341 have this
> attribute just before a semicolon and hence after the variable name.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Note I haven't figured out what this is actually doing and hence the
> patch is done by copying the changes made for ____cacheline_aligned_in_smp.
> It seems to work. :)

The little secret is that *nobody* really understands what all the regexes
in kernel-doc do :)  Anyway, it does indeed seem to work; applied, thanks.

jon
