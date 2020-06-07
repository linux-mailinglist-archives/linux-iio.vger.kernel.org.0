Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABBC1F0BF9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgFGOnL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 10:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgFGOnL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 10:43:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8874120663;
        Sun,  7 Jun 2020 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591540990;
        bh=C1MGID1Ql+htrqwUGJ65/TlfhHS1QG30CrqwQIJccCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M0HdunJwW8GnWsphy67cAyd0o7kXBxLRPQjskcQ8C6E+UxI/pjgJUurFfuUeLyj9O
         t3IkpfuzY/1voRdGYzO1OgSluWGGdvUDOzaTc2w8EP83ZMz92NG+0Z8gWgeKKDyivH
         Xvhv68MN18aHdt7+qC4+J7a4WjVqSv97KwoYyirc=
Date:   Sun, 7 Jun 2020 15:43:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 06/25] iio:magnetometer:ak8974: Fix alignment and data
 leak issues
Message-ID: <20200607154306.712d2a3d@archlinux>
In-Reply-To: <CACRpkdYmoS3z_5WhCUMHqUmoTZ0UaxNA5oE4HUbXHH9Whwgeeg@mail.gmail.com>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-7-jic23@kernel.org>
        <CACRpkdYmoS3z_5WhCUMHqUmoTZ0UaxNA5oE4HUbXHH9Whwgeeg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 11:24:40 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, May 25, 2020 at 7:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable structure in the iio_priv() data.
> >
> > This data is allocated with kzalloc so no data can leak appart from
> > previous readings.
> >
> > Fixes: 7c94a8b2ee8cf ("iio: magn: add a driver for AK8974")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>  
> 
> Whoa, good catch! Definitely my mindless coding.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
I've tweaked this slightly fro v2 to add an __aligned(8) to the ts.
This is driven by the need for some cases to be careful on x86_32
where the s64 might be 4 byte aligned and the padding come out wrong.
It doesn't actually matter in this case but I'd rather be explicit.

Have kept the reviewed-by as not a material change on this one.

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

