Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677AF25EEEC
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgIFPuF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbgIFPt7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:49:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30CC72075A;
        Sun,  6 Sep 2020 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599407382;
        bh=wdS3ZTORml9hKZ+NuMGGtrabwSVv6Ck1pO7SI0Lhp7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PldGE03MODzJp7gwQrprNvhEWBvFatNkOqGi0AwAVJizE2oXIa5yPJXAiN61U8A71
         qyUvJWrCfY0KIOYFiHVqiBKe5NcuSgYThMJfT3Hh7lE/on2fdHn8PUAyKEESSg3E9W
         pgPaxmOi+iF1RnuBimtM/F9zX/2m6ZKDSkgqiDx0=
Date:   Sun, 6 Sep 2020 17:48:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL v2] IIO: First set of new device support etc for the 5.10
 cycle
Message-ID: <20200906154840.GA371133@kroah.com>
References: <20200906161259.2eabfd7a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906161259.2eabfd7a@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 06, 2020 at 04:12:59PM +0100, Jonathan Cameron wrote:
> The following changes since commit bc752d2f345bf55d71b3422a6a24890ea03168dc:
> 
>   staging: hikey9xx: Kconfig: add regulator dependency (2020-08-18 19:15:47 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10a-take2

That worked, thanks!

greg k-h
