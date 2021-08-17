Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C263EE5B6
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 06:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhHQEbT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 00:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhHQEbS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 00:31:18 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA30C061764;
        Mon, 16 Aug 2021 21:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=80wuYmqec+tkN81Ry5/hAJbtjz7ZSJszLbUYJbgNwnc=; b=RMLTzz8heejfvkbtBduZvmdqg
        S9yiMzEJiTPyJW7XTmDP8mzwAl6/i99oxuw5iDkQw5udghxROT+R3DANsuX4z+AtiYFt6YF/7RJc4
        S6rTHDZdRo2xCYMCjxOQsYfmkX9ipcDO2TpadfNQXveV+GQA35NPchXc1VcB0lQ6C9EDQ=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1mFqkI-0004Om-NX; Mon, 16 Aug 2021 21:30:38 -0700
Date:   Mon, 16 Aug 2021 21:30:38 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:iio:ade7854 surround complex defines in
 parentheses
Message-ID: <20210817043038.GA9492@challenge-bot.com>
References: <20210815023115.13016-1-ozzloy@challenge-bot.com>
 <YRizb/FGfYpGbpJy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRizb/FGfYpGbpJy@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


If this is a false positive from checkpatch, I can submit it as an
example to the checkpatch maintainers.  Do you think I should?

On Sun, Aug 15, 2021 at 08:25:51AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Aug 14, 2021 at 07:31:15PM -0700, daniel watson wrote:
> > Error found by checkpatch.pl
> 
> What error?

$ git checkout 36a21d5172 drivers/staging/iio/meter/ade7854.h # before
Updated 1 path from 638ccd1543654

$ ./scripts/checkpatch.pl --terse --types COMPLEX_MACRO \
drivers/staging/iio/meter/ade7854.h
drivers/staging/iio/meter/ade7854.h:142: ERROR: Macros with complex
values should be enclosed in parentheses
drivers/staging/iio/meter/ade7854.h:143: ERROR: Macros with complex
values should be enclosed in parentheses
drivers/staging/iio/meter/ade7854.h:144: ERROR: Macros with complex
values should be enclosed in parentheses
total: 3 errors, 0 warnings, 0 checks, 173 lines checked

$ git checkout 143b51a80978 drivers/staging/iio/meter/ade7854.h # after
Updated 1 path from 21c208a36476a

$ ./scripts/checkpatch.pl --terse --types COMPLEX_MACRO \
drivers/staging/iio/meter/ade7854.h

$


> > Signed-off-by: daniel watson <ozzloy@challenge-bot.com>
> 
> Capitalize your name?

I can remake this patch with my name capitalized if the patch is worth
remaking.  I'll be sure to capitalize in future sign-off lines for
Linux.


> This is not a real change that is needed, just look at the code to
> verify that.

Agreed, this is not a huge change.

I thought small changes were acceptable, if they get rid of errors from
checkpatch.  I got that impression from this video

Write and Submit your first Linux kernel Patch
https://youtu.be/LLBrBBImJt4

At around 15 minutes, you create a patch which removes curly braces
from an if-else.  That seemed comparable to the change in this
patch.  That video was posted over a decade ago, so I would understand
if things are different now.

> 
> thanks,
> 
> greg k-h

You're welcome!  Thank you too, that was a super fast response!  I am
happy to get a direct response from you!

