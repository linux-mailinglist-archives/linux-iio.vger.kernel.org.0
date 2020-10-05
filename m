Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1708D283006
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 07:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgJEFIM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 01:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgJEFIL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 01:08:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54227C061787;
        Sun,  4 Oct 2020 22:08:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so5234820pgl.9;
        Sun, 04 Oct 2020 22:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4tJLfv4r1zoGxZLPIaDyCtUW4+LVxjwAdNen8IGn/go=;
        b=se1XSVGwrhHdOgI356g94SUutkWKQpBzxrpqpgfPMBUHMoA90lXzkjgZ0/3Tw8I6QB
         Q5UOA4g26ikmyxmGNiEUC3x3ScQap1qGzK2DTuVfPYXwczdynjqThsGFkHlrBI9rFqlc
         eJtIn1vZAKuoQt8JnVE2YXPu5kCEmlLVNfu9mL6gdd81xTRSbC3SFDGt+HTaXqom0oRD
         VF56TE9qgti4LqfLMq65X7Nk26Zkv8FYAddFi5YtGDkyM9W6WRu+Irfo/xmTGqGQxqAP
         yGgN41FtnwCEBSNAjHdSvGZE6TQpIRcr7WiyNXJZ8/cEOc21PP4Qj90lxbFEu1hau11H
         hUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4tJLfv4r1zoGxZLPIaDyCtUW4+LVxjwAdNen8IGn/go=;
        b=dnQYs3vi7sOlYG43HWYrxZAPYyVLkrF5Uw0PEp8px2L2pk/TokLR/yQwFDEHOCQMyl
         rEeghcmYnCx5dKbiEPzZ+8A3UxTjpUQu/VRWk5EbHBG1/VEpq4xhpMOapq3pTF4psDc3
         dZYbPsMr7yfNsl7X2Ca/17UJp6d1ZiuMwkNBI4oRpqSGmJzCNj3GlXuxg/r/eIs+LPeJ
         +cnh8frWt2bS+euGycdwJQV9waDUEzvQB2dHm0QfTEuw6F/LyKKE8yoEPkkTkL0w6qE+
         rqEBMvPdCD/vL+MkeYK3qNmCvg30WUAmxrr4prfsayGLSMq2lCPub8Xs1YxAf6PJa0OY
         5CwA==
X-Gm-Message-State: AOAM533eIPJ9TTvyDDztj+3gCdLPuj9bsUIM3aSZ6YVW4eS6cxJcN0FV
        ovmL8w65+fq9vYXwp9NjEek=
X-Google-Smtp-Source: ABdhPJzbc7KATEHw3tURSc0pA0PlebTOm5ozKxIivLTRAmqi1P5kxW+VgeENvYQMNfQrrxbYDAqGGA==
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr12411601pgj.74.1601874490742;
        Sun, 04 Oct 2020 22:08:10 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id d128sm10874958pfc.8.2020.10.04.22.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 22:08:10 -0700 (PDT)
Date:   Sun, 4 Oct 2020 22:08:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-input@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH v4 3/7] ACPI: button: Access input device's users under
 appropriate mutex
Message-ID: <20201005050807.GI1009802@dtor-ws>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-4-andrzej.p@collabora.com>
 <CAJZ5v0j7e9TzDtEiDXmj3fLAQ7CvFHoe7Q3aYKKas3PEXrsUuw@mail.gmail.com>
 <20200625052318.GE248110@dtor-ws>
 <CAJZ5v0hgQt-amMn8xiF_0kyVZ-9pQxgm5H-VcFpinVQGKnYhwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hgQt-amMn8xiF_0kyVZ-9pQxgm5H-VcFpinVQGKnYhwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 25, 2020 at 12:55:29PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 25, 2020 at 7:23 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 05:00:09PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jun 8, 2020 at 1:22 PM Andrzej Pietrasiewicz
> > > <andrzej.p@collabora.com> wrote:
> > > >
> > > > Inspecting input device's 'users' member should be done under device's
> > > > mutex, so add appropriate invocations.
> > > >
> > > > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > >
> > > This looks like a fix that might be applied independently of the other
> > > patches in the series.
> > >
> > > Do you want me to pick it up?
> >
> > If you pick it we'll have to have a dance with this series. Can I apply
> > instead?
> 
> Yes, please.
> 
> Also feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to it.

Looking at the driver I think the patch and the original use of
input->users is not proper. I'll post another patch addressing this
shortly.

Thanks.

-- 
Dmitry
