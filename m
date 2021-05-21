Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0738CD00
	for <lists+linux-iio@lfdr.de>; Fri, 21 May 2021 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhEUSOP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 May 2021 14:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236538AbhEUSOO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 May 2021 14:14:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D37F613CB;
        Fri, 21 May 2021 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621620770;
        bh=vIGwajyAPxL+s66jTBB9W7pXd/owXOQpoB9O1Pro7/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oe/XCzQilmBP+RN/nqn9nrxeLcDjvmzKXv4XCnLfafEA78weEIRuMJVOFoksPUluk
         kEw2WD+QGDcxLRpg+z87y4yCiwKY0Q4knDlG+T+2Dbi2Z2OXhhYO/8C027b0fQN+sG
         qPlCyKgP4GDT7anJv/+PEBtAi2gwZIse3sHUag/I=
Date:   Fri, 21 May 2021 20:12:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.13 cycle.
Message-ID: <YKf4IOiTV5cyd++3@kroah.com>
References: <20210521181509.419b9db0@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521181509.419b9db0@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 21, 2021 at 06:15:09PM +0100, Jonathan Cameron wrote:
> The following changes since commit ba9c25d94dea1a57492a606a1f5dde70d2432583:
> 
>   Merge tag 'iio-fixes-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-05-11 15:17:55 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.13b

Pulled and pushed out, thanks.

greg k-h
