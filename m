Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B984E1B08E2
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDTMJd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 08:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgDTMJd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 08:09:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF8D206D6;
        Mon, 20 Apr 2020 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587384573;
        bh=sJtcQ7Xb85hhu0lZmGgz3bVh3RINQmJ5zmFLQboroR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQUlfmuDZY4m02fD++HoHv3OH5UJYUZKcy7g5xF2ktAltelX5FKQyQ6/jSdZJtbhg
         NxkhPrW22wPl9rjCmDhSjghI59mvN+Y7cLJwkxWQo3gOaYlQ8+I/uVO+6t4HWk1x4Z
         JT4xLTPto9cXJVqoNfhL4+naGvA/l1J68Q0+j3Ug=
Date:   Mon, 20 Apr 2020 14:09:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for 5.7
Message-ID: <20200420120914.GA3937360@kroah.com>
References: <20200419182157.5ba79356@archlinux>
 <20200419182601.5bf20f77@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419182601.5bf20f77@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 19, 2020 at 06:26:01PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> Just a quick note to say there is a trivial merge conflict in MAINTAINERS
> due to Linus sorting the file using the parse-maintainers script.
> 
> The resolution is fairly obvious but involves manually dropping
> the line that ends up duplicated if you just grab the hunk from the
> patch in here.
> 
> Note that patch is here as the large number of bounces people are getting
> has lead to requests for me to hurry that one through.

Now merged, the MAINTAINERS thing was easy to sort out, thanks!

greg k-h
