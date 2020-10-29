Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B631929F052
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 16:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgJ2Pnq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 11:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgJ2Pnq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 11:43:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0FE207DE;
        Thu, 29 Oct 2020 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603986225;
        bh=o1di1FVImlZ/WX+SlakEAVThYj8EXzI8/Bg5Th32ku8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l4hybExPWaf0ngZ+C35lvfGL68apV2vl5vII4bJRU6NFYB4LTLepBAohgyvCEP31y
         WDOO+veusBuPjFmKem+hXNHKU/IjWFmG+U4PITbZ+8tsgcXEALLlvztYydL48+8+i3
         m9smIHJaPJiyz5Jd3+PAerrmLrhPVZeiBL7S8qYU=
Date:   Thu, 29 Oct 2020 15:43:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 45/56] iio: fix a kernel-doc markup
Message-ID: <20201029154336.1837bd0a@archlinux>
In-Reply-To: <46622c3bdcffb76e79719f0fe5011c2952960b32.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <46622c3bdcffb76e79719f0fe5011c2952960b32.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Oct 2020 18:33:32 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> A function has a different name between their prototype
> and its kernel-doc markup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  include/linux/iio/trigger.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index cad8325903f9..f930c4ccf378 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -97,7 +97,7 @@ static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *trig)
>  }
>  
>  /**
> - * iio_device_set_drvdata() - Set trigger driver data
> + * iio_trigger_set_drvdata() - Set trigger driver data
>   * @trig: IIO trigger structure
>   * @data: Driver specific data
>   *

