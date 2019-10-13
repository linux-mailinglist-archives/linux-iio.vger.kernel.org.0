Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B381D5561
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 11:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfJMJCn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 05:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfJMJCn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 05:02:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486112064A;
        Sun, 13 Oct 2019 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570957362;
        bh=cvmrXPfNXUCKqFDI0ZAh2mmlgZMhfdiVH0nCpuylLDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKN3rts3NnXpFRFtBiv4SNxCaC2a136teKWrqj3Rs6ANh8wq+dEluyLlyVLdY1kWR
         50Znfgsx6IbMBXxIeu3YP6OzAGmXKkhsOat49kLfM/Vlta+w6cyXGLMUijCs8rG1RK
         iOv+1xXjf2AbyXfGR7sq6VodMqQR2t8tObs1G1q4=
Date:   Sun, 13 Oct 2019 11:01:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PULL v3] First set of iio new device support etc for the 5.5
 cycle
Message-ID: <20191013090123.GA2409479@kroah.com>
References: <20191013091859.25344d8f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013091859.25344d8f@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 09:18:59AM +0100, Jonathan Cameron wrote:
> The following changes since commit b73b93a2af3392b9b7b8ba7e818ee767499f9655:
> 
>   iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34:49 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.5a-take3

Much better, thanks!  Now pulled and pushed out.

greg k-h
