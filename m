Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCEB1CD315
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgEKHmj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 03:42:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34707 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKHmi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 03:42:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id g16so7092435eds.1;
        Mon, 11 May 2020 00:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/gXH+5V1OhGf0lDZmtXQexZA4f2X1Oj6FaM9kDcTW/I=;
        b=ZeZp81hwEkHzXkM14meH3JDyv90Ch65oWXzz64DzX9gOUkncpOVcllBjSqsOnoWNjo
         Nk6Srr5SJ+7gJrD8Vf0q2FLACQlCl7bH6YJufWpssG+dx6juVRIYWi4I1z+PpET1lFnU
         pXp6Q/4Jh/0niE1fgaXjFm8sXfXsRG7PxUi91riLjrHHtq5P8sazeoE+7rphMec2pKTO
         E2aeCNsNEJnK5Jz7oI3oUC3NcBtlKBaFhOhb07wLCeDVUCgeHLXZlXbu5iqC8LLpWQ/J
         ZtT7sMcUgAkUbVmRN9LISrqM+lCk9JKWPRHVXuDpwT+MjFfRNJPy+8nhnc12VZdW40we
         uFVQ==
X-Gm-Message-State: AGi0PuZCW9LGR9hHNFDQlDHwjmz0MR7Sp33CmhgVTe1GVze3F1XWu0Ho
        lLRdAb6EkKEIi+Vs1v/xvy0=
X-Google-Smtp-Source: APiQypKNXJxBqeWKUcQZCLy5hhnnh16d804wT763ceEEJlpi/zqQEfidD1ZPGObtTh2DAv0fOSjHSw==
X-Received: by 2002:a05:6402:1d23:: with SMTP id dh3mr12214214edb.349.1589182956149;
        Mon, 11 May 2020 00:42:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id g20sm1194769ejb.41.2020.05.11.00.42.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 00:42:35 -0700 (PDT)
Date:   Mon, 11 May 2020 09:42:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Bakker <xc-racer2@live.ca>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, kgene@kernel.org,
        cw00.choi@samsung.com, kstewart@linuxfoundation.org,
        mpe@ellerman.id.au, m.szyprowski@samsung.com, swboyd@chromium.org,
        tglx@linutronix.de, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Add scaling support to exynos adc driver
Message-ID: <20200511074232.GA7134@kozik-lap>
References: <BN6PR04MB066058A68D6471E7F6AFCFF7A3A20@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200510112417.1e54d66e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200510112417.1e54d66e@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 10, 2020 at 11:24:17AM +0100, Jonathan Cameron wrote:
> On Fri,  8 May 2020 14:14:00 -0700
> Jonathan Bakker <xc-racer2@live.ca> wrote:
> 
> > Currently the driver only exposes the raw counts.  As we
> > have the regulator voltage and the maximum value (stored in
> > the data mask), we can trivially produce a scaling fraction
> > of voltage / max value.
> > 
> > This assumes that the regulator voltage is in fact the max
> > voltage, which appears to be the case for all mainline dts
> > and cross referenced with the public Exynos4412 and S5PV210
> > datasheets.
> > 
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> 
> Seems reasonable to me. I'd like an exynos Ack though before applying.


It's correct, at least with ARMv7 Exynos datasheets

The few ARMv8 Exynos chips are silent about the voltage levels. The
Exynos 7 DTS board in mainline kernel does not have regulator but it
looks clearly like mistake.

I think they behave the same, so for Exynos:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> thanks,
> 
> Jonathan
> 
> 
