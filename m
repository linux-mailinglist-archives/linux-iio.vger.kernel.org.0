Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4211E283E03
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgJESKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 14:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJESKS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 14:10:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B007C0613CE;
        Mon,  5 Oct 2020 11:10:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so7471534pfd.5;
        Mon, 05 Oct 2020 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YoMIv66+/pcP+7tXkGyfiaP3wPkP8AZJOUeLQyrbhCo=;
        b=s1FvaNLzk9ENAUF+dImr5G6uF3ttayAdr3ACaxBA/MFA6jo+FY6tDANTn01a3raqQD
         9Dxru8Cv/VQ9HJfZkv490IkLOJ6zk4WjW2gdMjjjhdIMli3lmGNoaAbkEGAlRSVvmwQr
         A22Oro0X+4/rXIkuQhY0A3e93DBSE2Ah8ihWqV9RiH94dSKJ+454v6WUhX8Qku/2fCB9
         IaoYapNlRFdrGPIPkEkUsp4K4vTB4xNAJiQTFCGNXZ8MBzTqadDJn3b8pZVGKYK5XkxE
         VlRsacm41HnJBo8cXHBiPeH7kiXkkYUa3KaUPA3FcwVcd1QgWybul8C3I51cWAxKKyth
         kmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YoMIv66+/pcP+7tXkGyfiaP3wPkP8AZJOUeLQyrbhCo=;
        b=JKjH0w0r40GrEyehYAg6BsQSXjiEtwFJpO5vX9XHY4rx/1I89b4p/lmW12mG0qG62T
         wTJVSnT+GhIW9E+2sEUsn8aVpIb4fBdJozwLppUTcbTpZJhHcMhKXUndIZt4spGWaRKU
         Nyi5VysLpVa20PQ+qQVxXgqv7gwG45eon2Vh4QL10+lPGDXAad4z+C0Mt4gKj8DatVoj
         R6WJ1OaELHcr6L+/efBS10QeMZ708jujnbIn+4eNTZRqHvQ0osxikJRCoDigoELH27Nk
         jwYssDyqM7Dtd9Yet3QBeTHpqnPP79PeDqsxPVSBNOmRL1ogBH3bdj5v6PnI9nvCppX0
         4f3Q==
X-Gm-Message-State: AOAM530iomReTvihl2+cCcvo/V9UP7sitjMa8LRcZT1WKzELmQtdA5f+
        t43uTEYJOiBNQgZl4FDV7HA=
X-Google-Smtp-Source: ABdhPJyH4fsGnVblPJB5N4pgMwQJmZq67gBl5WqwS0SGCx7kk269VvXfguknhYlG7b9tInkRJJ8m+Q==
X-Received: by 2002:a63:4945:: with SMTP id y5mr679607pgk.181.1601921417989;
        Mon, 05 Oct 2020 11:10:17 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id v5sm550037pfu.151.2020.10.05.11.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 11:10:16 -0700 (PDT)
Date:   Mon, 5 Oct 2020 11:10:14 -0700
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
        kernel@collabora.com, Patrik Fimml <patrikf@chromium.org>
Subject: Re: [PATCH v4 7/7] Input: Add "inhibited" property
Message-ID: <20201005181014.GL1009802@dtor-ws>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-8-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608112211.12125-8-andrzej.p@collabora.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andrzej,

On Mon, Jun 08, 2020 at 01:22:11PM +0200, Andrzej Pietrasiewicz wrote:
> @@ -284,8 +284,11 @@ static int input_get_disposition(struct input_dev *dev,
>  	case EV_KEY:
>  		if (is_event_supported(code, dev->keybit, KEY_MAX)) {
>  
> -			/* auto-repeat bypasses state updates */
> -			if (value == 2) {
> +			/*
> +			 * auto-repeat bypasses state updates but repeat
> +			 * events are ignored if the key is not pressed
> +			 */
> +			if (value == 2 && test_bit(code, dev->key)) {
>  				disposition = INPUT_PASS_TO_HANDLERS;
>  				break;
>  			}

Is this chunk really part of inhibit support? I'd think we cancel
autorepeat timer when we are releasing a key, no?

Thanks.

-- 
Dmitry
