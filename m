Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2F28A8DB
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfHLVBw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 17:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfHLVBw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Aug 2019 17:01:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D3E2085A;
        Mon, 12 Aug 2019 21:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565643711;
        bh=WwNn+UHsJI8/BJPNI+YpHTx/RR4XG70f+D179aVMNZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LljSn5a3t1lY8os98xa4gyXhobiPC2U9zBmTOggKxZHqZ59FkkjCycbixF8EN1eCB
         XpYoloW8toj+HJtEU3wifAOPxNw0A0TxcPhb4bDzqsgVnPjOGpyp0SzpxzZdo/vKGI
         5ILQwQXO4FL9cfncwVctMJDEtICO2tFFFFgngyfk=
Date:   Mon, 12 Aug 2019 22:59:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of new device support, cleanups and features
 for IIO in the 5.4 cycle.
Message-ID: <20190812205932.GA32616@kroah.com>
References: <20190812210428.1668b6d8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812210428.1668b6d8@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 12, 2019 at 09:04:28PM +0100, Jonathan Cameron wrote:
> The following changes since commit e59fc52529118aaad9aa666f25530dde6e2180e9:
> 
>   staging: rtl8192*: display ESSIDs using %pE (2019-07-25 14:38:52 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4a

Pulled and pushed out, thanks.

greg k-h
