Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABE5496D88
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 20:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiAVTIP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 14:08:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36752 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiAVTIP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 14:08:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D548B60EAE
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 19:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9162C004E1;
        Sat, 22 Jan 2022 19:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642878494;
        bh=qz/XSsmq6dyVDD1/12oulEBz5kWq530icoJ5F1KDIAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sbc5VZRdmPc5Hp00oV4i2OeueYEhgde4RbDLVfIayC8gvosHwAbFUELSK56awNN29
         f9GgqU9uQXHoV1ZAB6KW0QQwywf87VNxOy3RP8+tNweXlUHpUiOr7UMzxCHJyaP23+
         +a3MKcZ6s/JK+5IkL7zhJjBvCl5qNPNEr+guX+k37AyPQdfodi7HLzs/vRvrFoPGRe
         n8hWG0syJ3fog97UYd/j3Xb/Qzzza1BkXlQFY8buwsKKILm9BSp9Ra5zVutBTxt5J2
         ZXdsBgxlNmsznxLwKPLOvErzsQUMw4brKX+Saum46cfD8NdjLcKSXoyoK3JPehDjI1
         Slo9QvRa3FGTA==
Date:   Sat, 22 Jan 2022 19:14:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, jongpil19.jung@samsung.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: sx9360: enable push iio event
Message-ID: <20220122191403.22364523@jic23-huawei>
In-Reply-To: <CAHp75VcRFRVOPvgGROiNM4wQurTDn+D-DSc0oU1YsrgkkNOF6g@mail.gmail.com>
References: <20220118212504.832429-1-gwendal@chromium.org>
        <20220122172940.125d8033@jic23-huawei>
        <CAHp75VcRFRVOPvgGROiNM4wQurTDn+D-DSc0oU1YsrgkkNOF6g@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 Jan 2022 20:15:57 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Jan 22, 2022 at 7:23 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 18 Jan 2022 13:25:04 -0800
> > Gwendal Grignou <gwendal@chromium.org> wrote:  
> 
> ...
> 
> > > Fixes: f75095753 ("iio:proximity:sx9360: Add sx9360 support")  
> > This is part of the tag block so should appear.  
> 
> 
> > fixes tag should be here.  
> > > Signed-off-by: Jongpil Jung <jongpil19.jung@samsung.com>
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> 
> ...and the submitter's SoB must be last (according to the documentation).
> 
Hi Andy,

If it's a handling chain, rather that about co development etc then
I'd expect it to be in this order to indicate that Gwendal was on the
route to upstream. 

"Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch, but were not involved in its
development. SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author."

Jonathan
