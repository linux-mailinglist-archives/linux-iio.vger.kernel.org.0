Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74C1D4FDF
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOOEB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 10:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgEOOEB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 May 2020 10:04:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625DF206B6;
        Fri, 15 May 2020 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589551440;
        bh=sex7JNUla6voVpR/WRcdJuRGMegIfekb0zfkJDcPD0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcJGAWjUaFESCmcaNga6B6tPB3KWGot4IaEoB9XLLtVAvqMj8DzZ3LTqZOdliNllt
         Bi701kctFe7cThLaA4DaDBzk6OCqhNktpENCUPrBjxfFTi4Sj5wkdtBolMwijIFp5k
         7gRPNiXmw7tR1uk1hGR3AfKqwM20Hjkd6Q+NsO/8=
Date:   Fri, 15 May 2020 16:03:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO new device support, features and cleanups
 for the 5.8 cycle.
Message-ID: <20200515140358.GA2184507@kroah.com>
References: <20200512195801.28e6fafe@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512195801.28e6fafe@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 12, 2020 at 07:58:01PM +0100, Jonathan Cameron wrote:
> The following changes since commit bf42304b55f59af5e71c86e46291705023dce62e:
> 
>   staging: vt6656: Use fls instead of for loop in vnt_update_top_rates (2020-04-23 13:39:51 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.8b

Pulled and pushed out,t hanks.

greg k-h
