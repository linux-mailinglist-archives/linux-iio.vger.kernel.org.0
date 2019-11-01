Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C84AEEC04B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKAJLw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfKAJLw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Nov 2019 05:11:52 -0400
Received: from localhost (unknown [84.241.195.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B96217D9;
        Fri,  1 Nov 2019 09:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572599512;
        bh=rMnCPZ3p5jg/OxDvBv+SJxYYzIhIXR4u6rTS6ipd7Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/qMCqw7RC1IW749SuOr6hUzkSF8oDdNMcNtxftAiThjRi4PsIXEjCB/eCFS1WRK7
         yl4msgtlvcwrU+Y5VHp2RAHFQeTbMMljZncS6UUOoSOvprXEoSTDpANQ55P4Z5pxd1
         5YzKMQWFPjPOb446egXZKh2igoQMNJV4UHZAlJig=
Date:   Fri, 1 Nov 2019 10:11:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO + counter new device support, features etc
 for the 5.5 cycle.
Message-ID: <20191101091144.GA2727629@kroah.com>
References: <20191031204557.1ed83e95@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031204557.1ed83e95@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 31, 2019 at 08:45:57PM +0000, Jonathan Cameron wrote:
> The following changes since commit 88d0facf186c6c652c2203536fecd77089b43a4e:
> 
>   staging: wfx: fix potential vulnerability to spectre (2019-10-14 15:37:19 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.5b

Pulled and pushed out, thanks.

greg k-h
