Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F79432EFD
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhJSHLw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 03:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhJSHLw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 03:11:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94CD060F57;
        Tue, 19 Oct 2021 07:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634627380;
        bh=OLO3QJt3/eogyu78yADOLEChzEXFYjKvvmPElTt0Cdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUBD0tYK2R3mskhPFIW+xbWIl+/fXgyZXXvcksUhWuiG+QHdIBokiqXi3C7UUr1nb
         0GlPu0r7ewyt9buOsEe27f0AeTIi7BnJUEZtkzh/tmUR1jfRKyJkSPxQVpK6i4oHuv
         YHr2tCFTEsRTqK8nBDjuYFo/hz5/65lIgt6e9N0E=
Date:   Tue, 19 Oct 2021 09:09:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PULL V2] 1st set of counter subsystem new features for the 5.16
 cycle.
Message-ID: <YW5vGxQ0eP7KUBlt@kroah.com>
References: <20211018193232.4b896586@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018193232.4b896586@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 18, 2021 at 07:32:32PM +0100, Jonathan Cameron wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/counter-for-5.16a-take2

Much nicer, now pulled and pushed out.

greg k-h
