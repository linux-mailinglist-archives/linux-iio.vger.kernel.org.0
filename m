Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C7261E6
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2019 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfEVKgI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 May 2019 06:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbfEVKgH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 May 2019 06:36:07 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83917217D9;
        Wed, 22 May 2019 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558521366;
        bh=5jCx1AzTyj5isamf00DyysnuPgoISn9moaTLCzGLIgU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tiu1zUjZ0sCJqf2jK3/Ox2nFpczo6F47SaMR0CVvmxLZ57hjF/IXpYGoSXIzo/I9O
         xyASZZjShjoynRdRnd2syE8hrB1FjMtZxTsUwL5i9M1aoPtun+mk0Ti7qGR3qU4Bxr
         FuijziXnFq45kIw23nF2HZ/ONxWHY42+YfsrBAzE=
Date:   Wed, 22 May 2019 12:36:03 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     hongyan.song@intel.com
cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@intel.com,
        hdegoede@redhat.com, even.xu@intel.com
Subject: Re: [PATCH] hid: remove NO_D3 flag for ish not CHV platform
In-Reply-To: <1558082782-29279-1-git-send-email-hongyan.song@intel.com>
Message-ID: <nycvar.YFH.7.76.1905221235140.1962@cbobk.fhfr.pm>
References: <1558082782-29279-1-git-send-email-hongyan.song@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 May 2019, hongyan.song@intel.com wrote:

> From: Song Hongyan <hongyan.song@intel.com>
> 
> NO_D3 flag is set for CHV and the older platforms, the other platform
> suppose can enter D3, if have this NO_D3 flag set it can never enter D3

Could you please provide a little bit more descriptive changelog -- namely 
what observable problem is it fixing.

> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> ---
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index a6e1ee7..de1459b 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -154,7 +154,9 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* mapping IO device memory */
>  	hw->mem_addr = pcim_iomap_table(pdev)[0];
>  	ishtp->pdev = pdev;
> -	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +	/*This NO_D3 flag is only for CHV and older platforms*/

... and while you're updating the changelog, please also stick a space 
before and after the comment mark.

Thanks,

-- 
Jiri Kosina
SUSE Labs

