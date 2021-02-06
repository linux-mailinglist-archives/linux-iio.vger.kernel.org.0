Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802F1311D94
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBFOMm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 09:12:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhBFOMm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 09:12:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5047664E9F;
        Sat,  6 Feb 2021 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612620720;
        bh=Ja7BOdjqliUS/ElffWxy/YzEpUQWAGJZ4O8vhc6PXDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXA7Jq6W++rIylzTXRXzNugTGcF8bqvQiuhqDhkldBfOkkgmY3PnrcXrY4QYJt1UG
         fIhP0PS4dMz75YUwulVYg9Bh8qec7ToD9hVBQOpRkIV3Duf7wt41XYIHVuzzoGFZq8
         3m/SwAtjh2r51FCRj8OXq5vmhlA4usRiuGj7kFwA=
Date:   Sat, 6 Feb 2021 15:11:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wilfried Wessner <wilfried.wessner@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] iio: ad7949: fix wrong ADC result due to incorrect bit
 mask
Message-ID: <YB6jrlzKiJo/qa/H@kroah.com>
References: <20210206140320.GA601846@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206140320.GA601846@ubuntu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 06, 2021 at 03:03:20PM +0100, Wilfried Wessner wrote:
> Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>

This needs to go after the changelog text.

> 
> Fixes a wrong bit mask used for the ADC's result, which was caused by an
> improper usage of the GENMASK() macro. The bits higher than ADC's 
> resolution are undefined and if not masked out correctly, a wrong result 
> can be given. The GENMASK() macro indexing is zero based, so the mask has 
> to go from [resolution -1 , 0].

You have trailing whitespace in your text, perhaps get your editor to
show you this?

Also, this is a new version of the patch, it needs to be marked as such
so we know which is the "latest".  The documentation says how to do
that.

thanks,

greg k-h
