Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F198E476A50
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 07:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhLPGXR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 01:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhLPGXR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 01:23:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E319C061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 22:23:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so21624394pjb.5
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 22:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVI2NKrHVTvcW6GUaxXsCBRxeYW7KB585ntOpwS+PNM=;
        b=GxD8LhXXRC/P7oGHKB5JdLsUHuNAPTru9hgUMrPdLwOFFBE+qnv6ZblTuPE0zokiZb
         lKqF+vp5acPySCwCNpuPtHG/uPHq9Ay8TCB1j1E/B60ZhEM2QhBBsZuozOq0oN+5Qt+T
         fbrx0zWht1xpZ/BREKGaxsgpncor67c6kvICy0eP5t7l5t1cnoyePDMXyp7fEHQNB0hW
         CGcVHf5UA2iJn0hSVFtapLcdwZzsnlOvRI/5ycqzyfzj8TfdpHgC8dVfb6QWnPpq/FHr
         n2SCehaIFmcsp5N0AaJvQoEUDldEsAMS/KTyhbULxU2wcRixTGS9DfWWunlszq3VF3n0
         tqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVI2NKrHVTvcW6GUaxXsCBRxeYW7KB585ntOpwS+PNM=;
        b=MwzbwzFFQGo9ebfsgLh6ICv7XSWYf+dYRbaD/LFJB+ss1sJ+jNOq8BuRqxA7bRsmuG
         jb3J0wA5uwIJ2aUF8b10834Msth2xZi5s4odpsmZNXHwQyFLqAlzd6qxGH/zdmsy/pEG
         TudV/+2jtb/wm8I7bpHdVLemNmTVOYPFyEIZcLYtZmld0NOLoMvPeHe1vO76bnPHQPyO
         j5+TSfVXQKh/nV4ADCoWG/jg3yBeUjpc3IUiyqcUvjdSiZI0LncB4n1jpN2dyB3MwKh2
         oC0Q5EAQPfKJ7Vm9HE6KhIKOaU69AR8NNPwwsd/TqoVZ0COlFQ17qRnFf2i7VJftDCr5
         jORA==
X-Gm-Message-State: AOAM530GgjUR2fes7jYZ5ya7r+CAHC1x0BUTT4zHnRlELNXFSWfiX2YI
        b3IR78sKD0bfOty+nmQVDzLN2g1KWFDYSDVUf4KXgHCScsw=
X-Google-Smtp-Source: ABdhPJz2am10ME+subur1bmRf1XMOL6C16S+wySTnX3Gq2v4N4aqbjwH9y4NRue0yo/hrr+XPx1D4HCO5Q443smlxdA=
X-Received: by 2002:a17:902:7b88:b0:148:91ab:be83 with SMTP id
 w8-20020a1709027b8800b0014891abbe83mr12653044pll.88.1639635796805; Wed, 15
 Dec 2021 22:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20211215151344.163036-1-miquel.raynal@bootlin.com> <20211215151344.163036-2-miquel.raynal@bootlin.com>
In-Reply-To: <20211215151344.163036-2-miquel.raynal@bootlin.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 16 Dec 2021 08:23:05 +0200
Message-ID: <CA+U=DsrrCQir166YQTk+D9Y1QfHO5rCh42DkCiLSeaB02KYoAQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] iio: core: Fix the kernel doc regarding the
 currentmode iio_dev entry
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> This is an internal variable, which should be accessed in a very
> sporadic way and in no case changed by any device driver.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 324561b7a5e8..06433c2c2968 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -488,7 +488,7 @@ struct iio_buffer_setup_ops {
>  /**
>   * struct iio_dev - industrial I/O device
>   * @modes:             [DRIVER] operating modes supported by device
> - * @currentmode:       [DRIVER] current operating mode
> + * @currentmode:       [INTERN] current operating mode
>   * @dev:               [DRIVER] device structure, should be assigned a parent
>   *                     and owner
>   * @buffer:            [DRIVER] any buffer present
> --
> 2.27.0
>
