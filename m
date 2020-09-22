Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A86273CC7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIVH44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 03:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIVH44 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Sep 2020 03:56:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1355239A1;
        Tue, 22 Sep 2020 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600761416;
        bh=3eu/w/KKCKdPXKsdMIDN5K5v/i/YwxBkeL2s2fN7gEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsqXyBta5P5vfrFvztQUpbh7GctnBR/YhEkWk+r0KfuCphEPLuTVdyeEuJebwnLKg
         N/wpLrE/+Xq6AJlOggcHLoHXfY4bLz2U/MP/2U2GDpKHkHwV+ABf/0N4tA4FozkCgB
         xOVeetiaQaPACXz9+nj69fltiDkBCpMcn6KFZ+J0=
Date:   Tue, 22 Sep 2020 09:57:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for 5.9
Message-ID: <20200922075717.GA1797611@kroah.com>
References: <20200920190349.2732d4e8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920190349.2732d4e8@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 20, 2020 at 07:03:49PM +0100, Jonathan Cameron wrote:
> The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:
> 
>   Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.9b
> 
> for you to fetch changes up to 888f7cdc893a67d556187b12f40c9e9710ec1c99:
> 
>   iio: adc: qcom-spmi-adc5: fix driver name (2020-09-20 18:26:44 +0100)

{sigh}

Commit: 888f7cdc893a ("iio: adc: qcom-spmi-adc5: fix driver name")
	Fixes tag: Fixes: e13d757279 ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
	Has these problem(s):
	        - SHA1 should be at least 12 digits long
	          Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
	          or later) just making sure it is not set (or set to "auto").

I recommend going and installing the scripts...

thanks,

greg k-h
