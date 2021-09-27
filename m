Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008D341A016
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbhI0U1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 16:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbhI0U1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 16:27:11 -0400
X-Greylist: delayed 1014 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 13:25:32 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8B3C061575
        for <linux-iio@vger.kernel.org>; Mon, 27 Sep 2021 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fd4s99HunOLubBDe63zAwk3tWqtbOB3gIaOJ3cuwGJM=; b=Qx4AkkHm/pmwCxCTBQzK1mMTVC
        jmgxFlIoCnncf/2Ax6nqjP36ucAgXFMRB+7K5peeCjp5CMFRroZjXZbSAXMqcLSSTOvcfHwZVG4sU
        M86cjTeRzBIOGw6PKL62Yzsi0BlF+ErBGp9Njb6fDTt7DtKPI9klfUZg2hFA55KJPVgo=;
Received: from p200300ccff09a7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:a700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mUwvT-0000CF-2S; Mon, 27 Sep 2021 22:08:35 +0200
Date:   Mon, 27 Sep 2021 22:08:34 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org
Subject: Re: [PATCH] iio: adc: rn5t618-adc: use
 devm_iio_map_array_register() function
Message-ID: <20210927220834.014e6c77@aktux>
In-Reply-To: <20210926162859.3567685-1-aardelean@deviqon.com>
References: <20210926162859.3567685-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Sep 2021 19:28:59 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This driver already hooks a similar unwind callback via
> devm_add_action_or_reset().
> 
> They pretty much do the same thing, so this change converts it to the
> devm_iio_map_array_register().
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/iio/adc/rn5t618-adc.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

yes, looks sane, the patches it depens on are not in linux-next yet.
But it seems that they are accepted, so:

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
