Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD42C1EE3
	for <lists+linux-iio@lfdr.de>; Tue, 24 Nov 2020 08:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgKXHaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 02:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730067AbgKXHaQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Nov 2020 02:30:16 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A120E206E5;
        Tue, 24 Nov 2020 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606203016;
        bh=mrNHYTSeb+aiMQc55WUXClcVVGLghEMaTsDkFa3FNKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yI7jI/Hzi8pL/QedgRT+pf4ILWA4lDbSvqA3orfYwrUCYfbAZ8dXPVDgEWLWzM+cg
         95SrMvNJtoagkz4ov8+p0b4ui8gPnUR3hvCkUtdSJbGfYrhXCO0ymwJiSbwDBy2J7Z
         govqKhVvSqUzu+R1IbeuIjR0khbdZBM6dXke4tp0=
Date:   Tue, 24 Nov 2020 08:31:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of new device support, cleanups and yaml
 conversions for the 5.11 cycle.
Message-ID: <X7y2u5mCqX11smpb@kroah.com>
References: <20201123213515.7b772026@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123213515.7b772026@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 23, 2020 at 09:35:15PM +0000, Jonathan Cameron wrote:
> The following changes since commit 41f0666f0f60997dea10e716df728f330525052e:
> 
>   staging: rtl8188eu: Fix long lines (2020-10-09 15:10:47 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.11a

Pulled and pushed out, thanks.

greg k-h
