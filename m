Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14AC139D3B
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 00:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAMXX0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 18:23:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43654 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgAMXX0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 18:23:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so10022530oif.10
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 15:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyL/JS9B7rUgj8Iql4HM1FyxI7CsxZnIzSDjO8scpzY=;
        b=tTKPTdROEvidEZ7u5G5Wspf6UY7rGH4FNretnR2l3SJcPeREqV8N0LD8qPcLH9Zu5x
         W/NHP6K+OXldzyKf2rrH5foe97wyrxaP1I2r6VDgxcnjRZKyEWhwllV8uS3B2388pQfF
         b+PV8he3vqhePQ8DvAXtGvYkXeiUNF+s/V/YGySiaWkAvdso7fJj1hP7tq9nkQXUKHqG
         NBuJPXAehw2D/R3cKt+EL4NeJZO69txRg+CiuNr3N2fXAvGeTklYDNwPMBPT5Smmj2r/
         hvpRv+AHGktxt3sh9Pgcks4vgJ3wZ/SOpYlgjahgfZLEWaCm1s0XGBnv3y7LL1R7KGrv
         sKLQ==
X-Gm-Message-State: APjAAAXSK+23nIHYRwTNN69kgl+a6AmnF+CXcyatChmoURNiz+O70NAn
        cIOUzn53m1A8e2LE8Tz9GGoDHO4OjQ==
X-Google-Smtp-Source: APXvYqwZe1mKdy/f7kHh6RQi7G9jJugmV7cCZ1YN3S4uXbiVR3mrNgYFnlyeDpN9T9KGuzaTrCCCcA==
X-Received: by 2002:aca:cd92:: with SMTP id d140mr14208693oig.68.1578957805675;
        Mon, 13 Jan 2020 15:23:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k17sm4064209oic.45.2020.01.13.15.23.23
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:23:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:23 -0600
Date:   Mon, 13 Jan 2020 17:23:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 03/17] dt-bindings: atmel-can: add
 microchip,sam9x60-can
Message-ID: <20200113232323.GA31125@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:17:55 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-can to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/can/atmel-can.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
