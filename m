Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74CEB676
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2019 18:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfJaRzh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Oct 2019 13:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaRzh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 31 Oct 2019 13:55:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 222D02080F;
        Thu, 31 Oct 2019 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572544535;
        bh=+/HRjUm5dFZy837cEGAIXhDRwghxC/hMVcJjsei/Dx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kndz53msJlEDew00D9nbAwVuSAG8MB56IrrqXGGgO+Tn0L/U2O+v+RZ4Cp36zUX5v
         fx0tqJ3cIcZOP1jiZy4jRkRA+RUr4CRh4i7jW87lxM2Zh0pZ/PQ/Mi9hBVFINHaDum
         AQR9nIfN3LRM0bNTwaI/rbh9MM0OpfqggXcs4vrs=
Date:   Thu, 31 Oct 2019 18:55:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.4 cycle.
Message-ID: <20191031175532.GA1065005@kroah.com>
References: <20191030201651.0f9b5237@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030201651.0f9b5237@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 30, 2019 at 08:16:51PM +0000, Jonathan Cameron wrote:
> The following changes since commit 3f3d31622a2c18b644328965925110dd7638b376:
> 
>   Merge tag 'iio-fixes-for-5.4a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2019-10-10 11:18:37 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.4b

Pulled and pushed out, thanks.

greg k-h
