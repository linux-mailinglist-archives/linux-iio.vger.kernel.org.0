Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A29786F1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfG2IDJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 04:03:09 -0400
Received: from onstation.org ([52.200.56.107]:34798 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfG2IDJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jul 2019 04:03:09 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 184053E910;
        Mon, 29 Jul 2019 08:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564387388;
        bh=joh8VV5EaxT+jOmdPyG+T/41nGKY4pOiEOL5KacGdLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIpV0wf5TCz7WHo4cBMcWd7PErqViXdtOnCyqGIJXWFdWWhDNRg0dUWV+RtpRea2A
         Qur7nPomUq692W6W9Lovyst8a2Kzt4D2lDOoFF8igXmZyhXI933EClSTc8gzyzOAOs
         RZexBOnYHxYrXGxgmWwzZcmjtSOlc2Y8IqzuGtW4=
Date:   Mon, 29 Jul 2019 04:03:07 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2772: Use device-managed API
Message-ID: <20190729080307.GA360@onstation.org>
References: <20190726123058.22915-1-hslester96@gmail.com>
 <20190727125749.63297c28@archlinux>
 <20190728083141.GA14194@onstation.org>
 <CANhBUQ3QiV1mPD6p+AROv6YnK+1CB5voVAHKbmzueUWc7P6vcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhBUQ3QiV1mPD6p+AROv6YnK+1CB5voVAHKbmzueUWc7P6vcQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 29, 2019 at 11:03:00AM +0800, Chuhong Yuan wrote:
> Brian Masney <masneyb@onstation.org> 于2019年7月28日周日 下午4:31写道：
> > devm_add_action() could be used in the probe function to schedule the call
> > to tsl2772_chip_off(). That would eliminate the need for
> > tsl2772_remove(). See tsl2772_disable_regulators_action() for an example in
> > that driver.
> >
> 
> I find that we can use devm_add_action_or_reset() for
> tsl2772_disable_regulators_action() to eliminate the fault handling code.
> 
> I am not sure whether devm_add_action() can be used for
> tsl2772_chip_off() because it returns an integer, not void.
> And the return value is used in several functions.

I would add a wrapper function (tsl2772_chip_off_action?) with the
expected declaration that calls tsl2772_chip_off().

> > Chuhong: Another potential cleanup to shrink the size of this driver is
> > to move it over to the regulator_bulk_() API. I didn't realize that API
> > existed at the time I introduced the regulator support. If you're
> > interested in taking on that cleanup as well, I can test those changes
> > for you if you don't have the hardware.
> >
> > Brian
> >
> 
> Does that mean merging vdd_supply and vddio_supply to an array of
> regulator_bulk_data and utilize regulator_bulk_() API to operate them
> together?

Yes.

> I have an additional question that I find regulator_disable() is used in the
> end of many .remove functions of drivers, which hinders us to use devm
> functions.
> One example is drivers/iio/light/gp2ap020a00f.c.
> Is there any solution to this problem?

There are devm_regulator_*() variants of the regulator API available
that you can use. Lots of other APIs in the kernel have devm variants
to simply drivers.

Brian
