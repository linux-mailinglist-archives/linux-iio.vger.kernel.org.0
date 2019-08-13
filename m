Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF598B219
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfHMIOY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 04:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfHMIOX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 04:14:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B07220663;
        Tue, 13 Aug 2019 08:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565684063;
        bh=o3qviPvIhSfmyENqSfo1cBYDeP2tim9oMckM9VeKEjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jt6JtTt9+jEItgvmGGZ7ODVvXkbZslOoH0SCuHBoxSlvv+CyBFaAJEVTVWdFlR1M3
         qMTgAa5wtshSttON8adk1L+2d9Sx3hhLEmJsVduTxfGlSarZq+l9y8eNGNsdyBGR66
         iDkoohZTxrjyKAmPmosyKSDE24q+dXAGFQgxQH3I=
Date:   Tue, 13 Aug 2019 10:14:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of new device support, cleanups and features
 for IIO in the 5.4 cycle.
Message-ID: <20190813081419.GA18284@kroah.com>
References: <20190812210428.1668b6d8@archlinux>
 <20190812205932.GA32616@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812205932.GA32616@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 12, 2019 at 10:59:32PM +0200, Greg KH wrote:
> On Mon, Aug 12, 2019 at 09:04:28PM +0100, Jonathan Cameron wrote:
> > The following changes since commit e59fc52529118aaad9aa666f25530dde6e2180e9:
> > 
> >   staging: rtl8192*: display ESSIDs using %pE (2019-07-25 14:38:52 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4a
> 
> Pulled and pushed out, thanks.

0-day gives me the following warning, did you not see this on your tree?

Can you send me a patch to fix this up?

thanks,

greg k-h

----------------
tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/staging.git  staging-testing
branch HEAD: 6aed51d8912460cab375f7fc4ea834851e107b7a  Merge tag 'iio-for-5.4a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next

Regressions in current branch:

drivers/iio/light/noa1305.c:87:9: warning: this statement may fall through [-Wimplicit-fallthrough=]


