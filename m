Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B602CCF18
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 07:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgLCG0m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 01:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLCG0l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 01:26:41 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC21C061A4E;
        Wed,  2 Dec 2020 22:26:01 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so797202pgb.4;
        Wed, 02 Dec 2020 22:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a5Hleron+HNO6OSGaVm7+jn0hTolWYgraVmhaIHqv7U=;
        b=U+Y6zDIhpIkQd0/XkPnsWOx3ty2znoP8t4ISlhFWptNuMbr5LJSUMsW+RTtd0M4x9K
         zkXL5+4LAq4x//bXrJWzpP34A+rpYm0BEV+gvvB+NvDg8g3Ppup7PuLwiRepugDodQb4
         IeDv1J0rX0QSTAaUbFsT4RMfXp6C/1AdjuAe9+WX4ydwHoVVaNSpjnpDGw8TqKH/qBxj
         SFELS12okZcCLgFwMxLX1CdG+AnoH5VLLr3bNMVPRRk2vl+KM5WV2pKelrDbtRPajdey
         ebvLpD8CW2hjzgstxv63BBMYAENN85quML6Mb//RxXN/Yp/6f77xIF0cuNxsS15D55Ap
         2BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a5Hleron+HNO6OSGaVm7+jn0hTolWYgraVmhaIHqv7U=;
        b=Q6JHKsqa17UP3L7EnspzitZ0iETOyNP96Gsg5XmdMrn8Ak3XYi5oi3rRXEZGjn8jSh
         upDk2zen+5+5cuFojf4iKXG1Lo4Wfk2iXnKoI/6Pmsr3eSO6NcSVLhqbCY4yfKO0DR8I
         JOnBIoZ5pO3xXXwHEMvQ5WXkZe2nwecrcjhR3ZZyuc5Om+f7eSBrAo9YgS2oULjZVIVm
         1FIldu2pp6Augexb6anpLUBzlaZVqUYHmEKJmPfNIvmpk0at+AJgnL/BFCb14ptH7RDl
         PXLavGBOQ87x9qXDjQgQmwpcjeEZywYosRULJvKugi+xWvfwJVuiCwiabH9aDOVmJ8rJ
         K6cw==
X-Gm-Message-State: AOAM533lj6WbLWetQEluhxksV25z0E/2YhN2OpII49OtdguXdyTl48nl
        ZryiAGApu3sSKfK/u5paKeI=
X-Google-Smtp-Source: ABdhPJx+P2i1MS4WKP5k78TX7vozpZ6k242noGJ71q6yL4YO0XpxjV8ai5M/byvI+Lbmw/bWUNXyTQ==
X-Received: by 2002:a65:44c2:: with SMTP id g2mr1824908pgs.256.1606976760622;
        Wed, 02 Dec 2020 22:26:00 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id 6sm495218pfb.22.2020.12.02.22.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:25:59 -0800 (PST)
Date:   Wed, 2 Dec 2020 22:25:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
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
        kernel@collabora.com
Subject: Re: [PATCH v4 1/7] Input: add input_device_enabled()
Message-ID: <X8iE81mbK6NVhd0e@google.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-2-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608112211.12125-2-andrzej.p@collabora.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 08, 2020 at 01:22:05PM +0200, Andrzej Pietrasiewicz wrote:
> A helper function for drivers to decide if the device is used or not.
> A lockdep check is introduced as inspecting ->users should be done under
> input device's mutex.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

Applied, thank you.

-- 
Dmitry
