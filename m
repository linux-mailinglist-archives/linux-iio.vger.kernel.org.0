Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1D46D3CB
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 13:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhLHM6D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 07:58:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49650 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhLHM6C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 07:58:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37E6EB820EB
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 12:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735E9C00446;
        Wed,  8 Dec 2021 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638968069;
        bh=cMZHb5qhu1BSQ5utGiZMhNhTjElBelpC2EamcEhx9VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9zkKUcgh4b6o1/S9ATY05752/3XnVNDaBfyGP/cxvO/UB8wxBjALWp7HG7typqF2
         vnjZ3XC6zKOk58zoDZ4f24QwsEEXJr8hywoBN9CymJB3kwSfLDHys23QnRBDl1+d8Z
         XEZ3AtKwpValWVFveO2g4zPMGQI1Bbnt5Y4lUIyo=
Date:   Wed, 8 Dec 2021 13:53:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for 5.16
Message-ID: <YbCq5UjNn4NOhHj0@kroah.com>
References: <20211208101050.50ef90e8@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208101050.50ef90e8@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 08, 2021 at 10:10:50AM +0000, Jonathan Cameron wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.16b

Pulled and pushed out, thanks.

greg k-h
