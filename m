Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55D230F757
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhBDQMi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 11:12:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237853AbhBDQM0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Feb 2021 11:12:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA8A264F46;
        Thu,  4 Feb 2021 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612455106;
        bh=0GVlIWGypIP5v/Edg0tCNQRp1Q/WaMNm2NSkamTKAoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9wJrHdDv+fJPPgLnxdrsMg0bpEJ38EpUfFtfq6ECHzwF7dJQr9odqArqZ+CnBw3b
         wU75JV47VS6cfCbXqW5MBkJFO1xS42Y0O4NFTb//hjYmR1Yhj+htx6nS4D2pwGKwZw
         gRpb12n7cJAeiuSzySuIyqJRxn2DezEGqft1X/r8=
Date:   Thu, 4 Feb 2021 17:11:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wilfried Wessner <wilfried.wessner@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] Correct bit mask for ADC result according to ADC's
 resolution.
Message-ID: <YBwcv8SkGBmrq+ck@kroah.com>
References: <20210204155430.GA557111@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204155430.GA557111@ubuntu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 04, 2021 at 04:54:30PM +0100, Wilfried Wessner wrote:
> Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>

I know I can't take patches without any changelog text :(

