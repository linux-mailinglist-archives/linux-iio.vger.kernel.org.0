Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D32238F6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQKG5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 06:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgGQKG5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jul 2020 06:06:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C746220768;
        Fri, 17 Jul 2020 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594980417;
        bh=hs1UCaLv+a/6ZnHuCHhjVUCU1g3D671OBuyCu1/B8fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHArW6YmDSCH1tgOTyi0/W+6jyhanximdMaG9FBW07hF4MGNhNhvGRIDVu2WVLsFl
         7mewxI/8Inm3iXJ7sQQ65a7wC9a4Dkm9ceB4ywd5ykACowOtiJg7QOf9NHXgGehujd
         rtYWm3p7TeVy6ZG/FFm+zz8qAe732iMmXboYtY+A=
Date:   Fri, 17 Jul 2020 12:06:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V2] First set of new device support, cleanups and features
 for  IIO in the 5.9 cycle.
Message-ID: <20200717100628.GA2553180@kroah.com>
References: <20200717085925.2d965fa8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717085925.2d965fa8@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 17, 2020 at 08:59:25AM +0100, Jonathan Cameron wrote:
> The following changes since commit b791d1bdf9212d944d749a5c7ff6febdba241771:
> 
>   Merge tag 'locking-kcsan-2020-06-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-06-11 18:55:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.9a-take2

Pulled and pushed out, thanks.

greg k-h
