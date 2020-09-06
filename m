Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8125EEF9
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 18:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgIFQEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 12:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgIFQED (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 12:04:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53BCD20708;
        Sun,  6 Sep 2020 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599408242;
        bh=gMp1PKMc9TtqfuFVnZiPX8l1hDORfTIrBnhLDlKITsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lZ5b6rea5rS+x8cbq1Z6Dn7c4WtJCXYnKsrXGfgpbkZqpltmMqb1O3vSiGWGeVhp+
         9AjFm9vAUauYGaAF+NC/n9OLojMTXFoZFBXPCQfBIxBDXHppH1rDg1+G4DEoSbQi4G
         i7zPYySd2Wg4RGd9Y2IcCyDSfgX7YpIWoEtTuvks=
Date:   Sun, 6 Sep 2020 17:03:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
Message-ID: <20200906170358.4abf98de@archlinux>
In-Reply-To: <8f7de1d6-0756-8b59-7041-c5ae4773e5f2@metafoo.de>
References: <20200903181926.5606-1-krzk@kernel.org>
        <20200906150640.5ffe7e0f@archlinux>
        <8f7de1d6-0756-8b59-7041-c5ae4773e5f2@metafoo.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Sep 2020 17:57:54 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 9/6/20 4:06 PM, Jonathan Cameron wrote:
> > On Thu,  3 Sep 2020 20:19:25 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >  
> >> Emails to Beniamin Bia bounce with no such address so remove him from
> >> maintainers.  After this removal, many entries for Analog Devices Inc
> >> IIO drivers look exactly the same so consolidate them.
> >>
> >> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> >> Cc: Jonathan Cameron <jic23@kernel.org>
> >> Cc: linux-iio <linux-iio@vger.kernel.org>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>  
> > As I'd assume a more specific binding always overrides a catch all,
> > this has the effect of giving Lars and Michael responsibility
> > for a few things they didn't previously cover.  If the two
> > of them are fine with it, than that's good, but I'd ideally
> > like an Ack from Lars.  
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> I think I left a ticket with ADI when I left to update the maintainers 
> entries and replace me with somebody else, must have gotten lost :)
> 
*laughs*

You are probably stuck with it forever if you don't remove yourself :)

Applied series to the togreg branch of iio.git and pushed out as testing
for the autobuilders to probably completely ignore.

thanks,

Jonathan

