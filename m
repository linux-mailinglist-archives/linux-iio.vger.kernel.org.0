Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB620C280
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgF0OxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 10:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgF0OxJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 10:53:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C24208B6;
        Sat, 27 Jun 2020 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593269589;
        bh=L9OdzSsuNvSwO2OVpk6/T18wHhjvkFd5+zWtVH21nSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FHTruxQut8DGKpuKE4/Z6oi1cMUXVfngUrVcHZvOkHyZdvURsBSi7txrqI387QLQb
         SJPKslw8F+4pZpXCIZhW4MJPblfrNA3ZLpd1kpRsHbkaikxdSCARm0xdhTx+IafsJf
         zU7MP5bm5VqBGcvrthX03U+bS5UV8r+kLKVDKPvM=
Date:   Sat, 27 Jun 2020 15:53:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: magnetometer: ak8974: Fix runtime PM imbalance
 on error in ak8974_probe()
Message-ID: <20200627155304.54ade781@archlinux>
In-Reply-To: <68225325-ba51-7aab-6fef-6f234f4068d1@web.de>
References: <dd84c12f-277d-27e7-3727-4592e530e4ed@web.de>
        <68225325-ba51-7aab-6fef-6f234f4068d1@web.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Jun 2020 14:34:44 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> https://lkml.org/lkml/2020/6/14/117
> https://lore.kernel.org/patchwork/comment/1452516/
> https://lore.kernel.org/linux-iio/20200614131116.143bcf92@archlinux/
> 
> > There was a lot of fuzz in this one due to other changes to the driver.
> > I 'think' it went it cleanly though.  
> 
> Is it interesting anyhow that you committed a change description
> which contained typos (on 2020-06-14 13:08:47 +0100)?
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/drivers/iio/magnetometer/ak8974.c?h=fixes-togreg&id=0187294d227dfc42889e1da8f8ce1e44fc25f147
> 
> How were the chances that my patch review comments would be taken
> better into account?
> https://lore.kernel.org/linux-iio/dd84c12f-277d-27e7-3727-4592e530e4ed@web.de/
> https://lkml.org/lkml/2020/5/31/152

I'm not sure why, but your reply did not have a reply-to field in the header
as such my email client did not present it alongside the patch. Hence I
missed it when applying.

Agreed it would have been nicer to have fixed those typos.
However, they don't affect comprehensibility of the message so I'm not that
worried about having them in the log.

Jonathan



> 
> Regards,
> Markus

