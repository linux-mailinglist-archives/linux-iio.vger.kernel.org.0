Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFC1B57E1
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgDWJLH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Apr 2020 05:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgDWJLH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Apr 2020 05:11:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C79214AF;
        Thu, 23 Apr 2020 09:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587633067;
        bh=VoBSCpefrQsm8kwiBJQX97SNTM2y0DldFFlK7/K4OvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQ9lBBDmJdjhSINktR9NlysVjp3MEUeY0Q8mzlLF/W6sFltbbsoZ6XOnF2sh4NBX+
         wQeqvjzwaDP+CLVEGrbDlKJaSXetP+Dn6JudXzMyLaW5uzj4oJB5p77fPy6R5Ik+LB
         XqGNfVpTWAAWOTuiMBVf/+qoF95JrPY5s3RjnLxw=
Date:   Thu, 23 Apr 2020 11:10:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO new device support, cleanups etc for the
 5.8 cycle
Message-ID: <20200423091058.GA3547015@kroah.com>
References: <20200422213145.6b0f8c9d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422213145.6b0f8c9d@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 09:31:45PM +0100, Jonathan Cameron wrote:
> The following changes since commit 825c6f470c62da05195fab57bb6561ccc1bdafcd:
> 
>   staging: mt7621-pci: be sure gpio descriptor is null on fails (2020-03-20 15:10:51 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.8a

Pulled and pushed out, thanks.

greg k-h
