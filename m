Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D010D253E41
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 08:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgH0G4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 02:56:30 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:39523 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0G4a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 02:56:30 -0400
Received: by mail-ej1-f66.google.com with SMTP id s19so865131eju.6;
        Wed, 26 Aug 2020 23:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwbyRUbmBUd5LezaqOq28rowj6rjIRyxb5Ys14hiAso=;
        b=RhWYq7F/0cMFjVntftigQ8FhEj/MclP9Wx1DVgBVTxw1R3kyE2Ja0kG0eXH2w8z4A9
         gE/vG6Qfx58ZVFXfXjhzKv1f4aNSAjiAp4J7xetTl24f0Z8VaugnN0WRZ5prEQsA4+Qr
         tuvTpFEjY1gWw36UdO5EUOtcLLrxJxGubyCWEa12hQfstDOMFdgW8TtpkPper3QrbJPK
         I2DZgelABNX2Fk0cHb60P90C31BFGK0/06A1LtF6/61tZcx3x2j0XjlyjI1j6penCIM3
         Ufw9WISGgNKiPyo25r99B1v3myR2i3n0TVkbvQcSt8piGzATRezkyl+2WTVWkq2FZRL4
         wSWA==
X-Gm-Message-State: AOAM532kkcnTJk2/bZPQ2UqCclzlmyFZdULYDsWfM+iGuhPYeILtV1e4
        TZaEyhb457SGHfYk/ejYVYY=
X-Google-Smtp-Source: ABdhPJzydtC0jtlVQUUi9eW/Vp16eChWCbvvahesP8bLGrilVYCuiS5FU10hbdKTCDOABk1Eu/6Q0g==
X-Received: by 2002:a17:906:5452:: with SMTP id d18mr20181799ejp.163.1598511387917;
        Wed, 26 Aug 2020 23:56:27 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id i25sm854413edt.1.2020.08.26.23.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 23:56:27 -0700 (PDT)
Date:   Thu, 27 Aug 2020 08:56:25 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, kgene@kernel.org,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH] iio: adc: exynos_adc: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200827065625.GB17964@kozik-lap>
References: <20200826132203.236748-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826132203.236748-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 26, 2020 at 04:22:03PM +0300, Alexandru Ardelean wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock, to protect potential concurrent access to the
> completion callback during a conversion.

I don't know the bigger picture (and no links here for general cleanup)
but I assume it is part of wider work and that mlock is unwanted. In
such case:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

If it is part of some bigger work, please put a link to lore.kernel.org
under separators ---, so everyone can get the context.


Best regards,
Krzysztof

> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
