Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4C283212
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgJEIc2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 04:32:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEIc2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 04:32:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so3074582wrp.10;
        Mon, 05 Oct 2020 01:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zz3WlImvfp2NAnIr/XDX6IouF1AWeXqfFzQhs33xWTM=;
        b=jYWN+oWkTWL5WQM/ctgeeRxUGq7TRrDOgDZuj3FC1OGjO7Y4swXXrPFGsG8i3QGD9p
         uNwZLH7KR+IP4kvIQZUQ2qeQcg//QiKWuhuu5bmq/+ShkpDnYbEfoxvOq2RpaA1366zO
         Lx77C/XDoTkEGF3tnIpTqq23Z7apjUva2w2m+NTwsKY/Kd177fj6uHvAEFWm9nyXFgVu
         g04PTwwinjtICIoMSm/h+jFajjQkeM6KcypSU6oBQ1I7EGunnsYV+wv1IbBT2n1Lj0Kr
         rGPshan82ifsWTwOyc6HpNnBeLGDEMzlmiLsuShu21pZql3Cxd232qeaCJkU1w71SwC+
         4QqA==
X-Gm-Message-State: AOAM531tC1d0NLo8OYQ1fxB1WeJjBhyWGiwSpUbLgbgpLAyT8PjhT1eY
        pHMgsqLjLiCwNPH4+J1fUOI=
X-Google-Smtp-Source: ABdhPJwzu68lk8dlJGQlye261/63dWD7++THnJ4WCF1bjzabn9KCHp1QGnBm4IyViA/cX9hLId3m+A==
X-Received: by 2002:adf:e3ce:: with SMTP id k14mr1947757wrm.230.1601886746154;
        Mon, 05 Oct 2020 01:32:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id p3sm11596934wmm.40.2020.10.05.01.32.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Oct 2020 01:32:24 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:32:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     dmitry.torokhov@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: exynos: do not rely on 'users' counter in ISR
Message-ID: <20201005083222.GA8300@kozik-lap>
References: <20201005052420.GA3262631@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005052420.GA3262631@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 04, 2020 at 10:24:20PM -0700, dmitry.torokhov@gmail.com wrote:
> The order in which 'users' counter is decremented vs calling drivers'
> close() method is implementation specific, and we should not rely on
> it. Let's introduce driver private flag and use it to signal ISR
> to exit when device is being closed.
> 
> This has a side-effect of fixing issue of accessing inut->users
> outside of input->mutex protection.
> 
> Reported-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
