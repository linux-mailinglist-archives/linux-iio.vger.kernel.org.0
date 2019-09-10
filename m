Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED2CAEBAC
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbfIJNgK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 10 Sep 2019 09:36:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732546AbfIJNgK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Sep 2019 09:36:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 31875E1C68541BC25C73;
        Tue, 10 Sep 2019 21:36:05 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 21:36:02 +0800
Date:   Tue, 10 Sep 2019 14:35:50 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Krzysztof Wilczynski <kw@linux.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: bh1750: Move static keyword to the front of
 declaration
Message-ID: <20190910143550.00000e64@huawei.com>
In-Reply-To: <20190908135208.GA29162@rocinante>
References: <20190902113132.26658-1-kw@linux.com>
        <20190908114944.18bb78e3@archlinux>
        <20190908135208.GA29162@rocinante>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Sep 2019 15:52:09 +0200
Krzysztof Wilczynski <kw@linux.com> wrote:

> Hello Jonathan,
> 
> Thank you for feedback.
> 
> [...]
> > > drivers/iio/light/bh1750.c:64:1: warning:
> > >   ‘static’ is not at beginning of declaration [-Wold-style-declaration]  
> [...]
> > This one has me confused.  The warning seems to be false as static
> > is at the beginning of the declaration....
> > 
> > Sure we "could" combine the declaration with the definition as you have
> > done here, but that has nothing much to do with the warning.  
> [...]
> 
> I only moved the "static const" at the front, I haven't changed the
> code as it's already has been a declaration and definition.  There is
> no semicolon there and the original author put a newline to separate
> things which makes it look as if these were separate.
> 
> Simple example based on the existing code:
> 
>   https://godbolt.org/z/hV4HP7
> 
> I hope this helps to illustrate the change in the patch.  I apologise
> if my approach was incorrect.
> 
> As part of the patch I removed the newline in an aim to make it less
> confusing to anyone who will read the code in the future.  Especially,
> since it makes it a bit awkward to read and when using things like
> grep.
> 
> Krzysztof

I get what you are trying to do, the issue is the code is currently:

struct bh1750_chip_info {
	u16 mtreg_min;
	u16 mtreg_max;
	u16 mtreg_default;
	int mtreg_to_usec;
	int mtreg_to_scale;

	/*
	 * For BH1710/BH1721 all possible integration time values won't fit
	 * into one page so displaying is limited to every second one.
	 * Note, that user can still write proper values which were not
	 * listed.
	 */
	int inc;

	u16 int_time_low_mask;
	u16 int_time_high_mask;
}

static const bh1750_chip_info_tbl[] = {
	[BH1710] = { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
	[BH1721] = { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
	[BH1750] = { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },
};

That test is supposed to catch the second block being

const static bh1750_chip_info_tbl[] = {
...

Which it isn't.  So the issue here was never that the static keyword
wasn't at the front of the declaration but that we could save a tiny
bit code by using the pattern

static const struct bh1750_chip_info {
...
} bh1750_chip_info_tbl[] {
	[...] = ...
};

We can do that of course, but that's nothing to do with moving the static
keyword to the front of the declaration which is what the patch claims
to be doing.

Jonathan





