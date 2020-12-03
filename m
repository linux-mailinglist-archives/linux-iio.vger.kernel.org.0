Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B02CCF20
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 07:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgLCG0w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 01:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLCG0w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 01:26:52 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD9C061A4D;
        Wed,  2 Dec 2020 22:26:11 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t7so616359pfh.7;
        Wed, 02 Dec 2020 22:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PMMryq/f/K4KW/tBzqVTPSeUJtb9pzGWFktSlRDSCWA=;
        b=oXdYHFTJ8vwEnPGWOJoKQDM30cRXcVwx5uzWnVG3TQrdW+uYYF6Yk4N/MpZMBPzcLm
         Jkoavh7SVx9CPmeQGginGPwGkOkUQ0+CbjyxHBAx2+08eOot+8EXZv6kEdK2RniSmaRx
         SAat5cFzXCr8iHy7fu3Ti1B1y6n3ye1V46e0LZ42Okv3XJgCNAtD+aBIN9gj4iwG5KYb
         sO1O5w1Uxh0h6abERgKj8dI9l21Kscxte0L9k0I091lDfJZ27iUvvl1hP8w+DgYCCwmf
         68qs2KZq/caA8VcAORV90sGMv7HybPXKFEV2miY9MqAFxOjfjUIJkC2gTjsFfYV65beX
         6C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PMMryq/f/K4KW/tBzqVTPSeUJtb9pzGWFktSlRDSCWA=;
        b=dnMpn8Rw7srX6lovCQy0LR9mPtfpgooi9cuiA7+GbXU3y3HERS1f8P+k6TRuXcxSKn
         eBsbRC+eKKKsGqzxWJJBl3qvbJSFTWPwUEoeSpRpsacIvicHOwM/BiL1qR/FDwBoeexA
         U3E9cgOGrDgKTq1/tpBUT7gDhoq4GO7G8hToV4ZWIqejef5lwMHhVwi8UjOTUvP0rLvv
         noZJTsKT/Nfvbt5n9XGMlLqRs0q0ySoTLe6X6ta6J/7p2mv41p53HEGOzx6/ou2iYjef
         7a0fV1qVtnhsv1aSTX8kaWUNQbMMo+sbnoLLjirrpYi3CNKPDhl3KAmYOsWydMeaFsOQ
         KqlQ==
X-Gm-Message-State: AOAM530NtlSGA4CWkakjZiCRDs9SBR334Za6H2b8t6Za/0N/MhzrfcwZ
        XW+1ycJZZK+wAekEbIyDJWo=
X-Google-Smtp-Source: ABdhPJyzTeUPZ9CQHUWQEdr+2Ce0lCrtr+dGRn8864LCovKwqGAkby+KWmIsQT/jM0AKGjMpw5P8yw==
X-Received: by 2002:a62:15d8:0:b029:198:30d:b49d with SMTP id 207-20020a6215d80000b0290198030db49dmr1732124pfv.5.1606976771494;
        Wed, 02 Dec 2020 22:26:11 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id q20sm86111pgb.6.2020.12.02.22.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:26:10 -0800 (PST)
Date:   Wed, 2 Dec 2020 22:26:07 -0800
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
Subject: Re: [PATCH v4 2/7] Input: use input_device_enabled()
Message-ID: <X8iE/xVPEWO2HRuB@google.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-3-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608112211.12125-3-andrzej.p@collabora.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 08, 2020 at 01:22:06PM +0200, Andrzej Pietrasiewicz wrote:
> Use the newly added helper in relevant input drivers.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

Applied, thank you.

-- 
Dmitry
