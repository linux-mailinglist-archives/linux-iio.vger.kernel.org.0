Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5BFBE93
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 05:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKNEdX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 23:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfKNEdW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Nov 2019 23:33:22 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC3B206D7;
        Thu, 14 Nov 2019 04:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573706002;
        bh=keNAqgUSBMIa/wGMMC9Ddn2w6xKFwebg23FDS0NmBz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjqHjR/5F4OyXNJMOPhf+o6uAzqRn93mHzZaP3dQj0XAk77N7SSTTM4Fk8vwXu/i3
         gmUoZECz8UCcsaMglIwH1FYwr3ZHY0EmNBIMiXeR5mwgYFkVPglSNnJHM9nuOnTD9u
         fHP9eogqOtBoVkADF+eGM5bgbSow9NchOtX6rElk=
Date:   Thu, 14 Nov 2019 10:03:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: buffer-dmaengine: Use dma_request_chan() directly
 for channel request
Message-ID: <20191114043318.GE952516@vkoul-mobl>
References: <20191113092453.30838-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113092453.30838-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13-11-19, 11:24, Peter Ujfalusi wrote:
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
