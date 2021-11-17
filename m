Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB15C4550E8
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 00:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbhKQXJ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 18:09:58 -0500
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:54040 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233161AbhKQXJ5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 18:09:57 -0500
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0314418486701;
        Wed, 17 Nov 2021 23:06:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 2C054E00034E;
        Wed, 17 Nov 2021 23:06:49 +0000 (UTC)
Message-ID: <33ca60945b7945ff08ae295a4d683ebe99e41d46.camel@perches.com>
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git <git@xilinx.com>,
        Michal Simek <michals@xilinx.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        heikki.krogerus@linux.intel.com
Date:   Wed, 17 Nov 2021 15:06:54 -0800
In-Reply-To: <YZVX9R/TMvkPwuuF@smile.fi.intel.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
         <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
         <YZPtW5igA8RBYLWv@smile.fi.intel.com>
         <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
         <CAHp75VdaO4+DxMn2eJx7t0_UFgrHGV2vgzXvRB=qwZi-ZpMaOA@mail.gmail.com>
         <cf7ad8715a02f3a0e4fe0cd8a270585dcf84bb3a.camel@perches.com>
         <CAHp75VfJBwCcFwbv6fgvwf=Q1UdFXwgNex-4GqKLcf=ZhuqGjw@mail.gmail.com>
         <164612d20b252a28dda74f5058e0aacb@perches.com>
         <YZVX9R/TMvkPwuuF@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C054E00034E
X-Spam-Status: No, score=-3.40
X-Stat-Signature: 5gonfoxuqwgckts6t7zg5ii6eb4g4ijk
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19+IFv9qylv3KP1O9JLcstv6VxH49IBE28=
X-HE-Tag: 1637190409-49400
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2021-11-17 at 21:28 +0200, Andy Shevchenko wrote:
> On Wed, Nov 17, 2021 at 10:46:20AM -0800, Joe Perches wrote:
> > On 2021-11-17 09:08, Andy Shevchenko wrote:
> > > On Wed, Nov 17, 2021 at 6:05 PM Joe Perches <joe@perches.com> wrote:
> > 
> > > > What do you think checkpatch is supposed to find?
> > 
> > > To me AMS should precede AXI and not the other way around. Agree?
> > 
> > Sure but checkpatch just looks at patches and doesn't inspect the patched
> > file, apply the patch then look at the result. The patch itself looks fine.
> 
> I see, checkpatch simply doesn't have such functionality and maintainers should
> ask people to rung parse-maintainers.pl from time to time…

I asked Linus to do that before every -rc1 and he demurred.

https://lore.kernel.org/lkml/CAHk-=wjq68jF+fcSJYpRT3yS+=oOxaEFtYVmSjKb0RLbo7+JWw@mail.gmail.com/


