Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332AE3EE67B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 08:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhHQGM6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 02:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhHQGM6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Aug 2021 02:12:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D086660F41;
        Tue, 17 Aug 2021 06:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629180745;
        bh=hTwVpjGmUak1NMjM8ZG/8L0yy9w3IguhLNQ5Da//1P8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5oCMcykDIhmhfDiqIa2ExpFHt1RQPJiCW1KMCjT37jDHPFNNHK8J1aQM58RRYY1A
         pHdAqxIJsU1HZlRwhnQEPL6S5G/7PhJyf9MYiDNExP/sV1khiOogItCqao3KkLWS2x
         dgOCECW/6Io+UV0mqQOjC6Bjvuy0fQ9C7wZ61R5c=
Date:   Tue, 17 Aug 2021 08:12:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     daniel watson <ozzloy@challenge-bot.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:iio:ade7854 surround complex defines in
 parentheses
Message-ID: <YRtTRpioOFBYxcxJ@kroah.com>
References: <20210815023115.13016-1-ozzloy@challenge-bot.com>
 <YRizb/FGfYpGbpJy@kroah.com>
 <20210817043038.GA9492@challenge-bot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817043038.GA9492@challenge-bot.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 16, 2021 at 09:30:38PM -0700, daniel watson wrote:
> 
> If this is a false positive from checkpatch, I can submit it as an
> example to the checkpatch maintainers.  Do you think I should?

checkpatch is a perl script that does pattern matching, it is really
hard for it to determine for things like this specific example, that it
is not needed.

Try finding other valid checkpatch cleanups if you wish to contribute in
this way, there are loads of others under drivers/staging/ that should
be easy to find.

thanks,

greg k-h
