Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE719454D5C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 19:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhKQStW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 13:49:22 -0500
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:53172 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232446AbhKQStV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 13:49:21 -0500
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1D727180A6DE5;
        Wed, 17 Nov 2021 18:46:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 11699D0369DC;
        Wed, 17 Nov 2021 18:46:21 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 17 Nov 2021 10:46:20 -0800
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git <git@xilinx.com>,
        Michal Simek <michals@xilinx.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
In-Reply-To: <CAHp75VfJBwCcFwbv6fgvwf=Q1UdFXwgNex-4GqKLcf=ZhuqGjw@mail.gmail.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
 <YZPtW5igA8RBYLWv@smile.fi.intel.com>
 <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
 <CAHp75VdaO4+DxMn2eJx7t0_UFgrHGV2vgzXvRB=qwZi-ZpMaOA@mail.gmail.com>
 <cf7ad8715a02f3a0e4fe0cd8a270585dcf84bb3a.camel@perches.com>
 <CAHp75VfJBwCcFwbv6fgvwf=Q1UdFXwgNex-4GqKLcf=ZhuqGjw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <164612d20b252a28dda74f5058e0aacb@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.40
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 11699D0369DC
X-Stat-Signature: pwqybmz3msuwrzbe7kcqhpz786jiu5g9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Equ3MWUfwHRKCWKBCS6WzzQz1LGmZMIc=
X-HE-Tag: 1637174781-75152
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-11-17 09:08, Andy Shevchenko wrote:
> On Wed, Nov 17, 2021 at 6:05 PM Joe Perches <joe@perches.com> wrote:

>> What do you think checkpatch is supposed to find?

> To me AMS should precede AXI and not the other way around. Agree?

Sure but checkpatch just looks at patches and doesn't inspect the 
patched file, apply the patch then look at the result. The patch itself 
looks fine.
