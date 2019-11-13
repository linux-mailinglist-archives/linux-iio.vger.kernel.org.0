Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C345AFAFAF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 12:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfKML1h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 06:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfKML1h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Nov 2019 06:27:37 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B288422459;
        Wed, 13 Nov 2019 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573644457;
        bh=UD1TGBUiL8sT9Pva3BAU4rTt4YkwLnXvLAA0k4IK55s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebI6tcixHTcfV8QoLctvTCZVN9OtZFnbqTKvUbn9/KYWxOotHSdOVUFL4GI8j9RCA
         aaIFf4sF4Atg4mGHZiD985vYgIXrkDSJdg2/GeexFHxOqsqS1Ptc0R1hTAxa4bXOpr
         9mCpC3N0+RJIztMTOqYGQiY79yMVfXfPYA+vVZKU=
Date:   Wed, 13 Nov 2019 19:26:08 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 3rd set of new device support, cleanups etc for IIO in
 the 5.5 cycle.
Message-ID: <20191113112608.GA2265082@kroah.com>
References: <20191111193735.6c0e9472@archlinux>
 <20191111194249.5eb84282@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111194249.5eb84282@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 11, 2019 at 07:42:58PM +0000, Jonathan Cameron wrote:
> Hi Greg,
> 
> Clearly this one is a bit late, but it seemed a shame to hold it given
> Linus has been hinting at this cycle going a week longer than normal.
> 
> There are a few fixes in here, so if you decide its too late or something
> else is wrong I'll pull them back out again for after the merge window.
> None of them are urgent enough to be worth rushing in before the
> merge window opens.

Looks good, I've merged it all now, thanks.

greg k-h
