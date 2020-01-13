Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0E6139D7A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 00:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAMXkg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 18:40:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39629 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgAMXkf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 18:40:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so10094653oib.6
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 15:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hWr5fTf0UvM/FdokqnbY78OahK5vgKtckbIjPFsKcM=;
        b=DCr6kCYuCUAFGtcMLL3vR/zuV2l80RuTgQrvFguwavLXhHcCjELGmhDOQIrRrk8oTP
         BLMpLs8OEEUv08GLjeMdiTKaFF14fnWTs2Ww+o1cgOhv4AJgHwxgJmVCiRJ+63HUC2bY
         c1bYCVV5Du9BLgHZOr20dRWqwa/HQFtdJXVAHBC0SBjdagcQOwRVnQB/Biq6m1tMqTbg
         PXOZxh57LMxNPu/v4AwtFuCMKnD4YslZmbUIfwvXrTdw5w39pjic8o0nT3xgiRxAzW6T
         Xy5CPmVETHxpX0uDmln0VvCGl/zb/rejUJs+S+Q6+0tYEAzbYW7jXhK2jr7a7mkzM0mm
         7nPQ==
X-Gm-Message-State: APjAAAWVySDNKrKlV7ANtDQ5VOOdXsfimIQW1A6sgjXkNHIuJdS5I0H5
        +2RDdSuFPFWpokINslrfsG8IJFHsOw==
X-Google-Smtp-Source: APXvYqwdzZMG+jDrcbUj2zBXm+HvfcQVb/Yus89lTekIrCGXzXIEFFekkxr9uUGIddzD0mtBl+tmpQ==
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr15157538oie.126.1578958834779;
        Mon, 13 Jan 2020 15:40:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e20sm4696514otr.32.2020.01.13.15.40.34
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:40:34 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 223f23
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:25:51 -0600
Date:   Mon, 13 Jan 2020 17:25:51 -0600
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
Subject: Re: [PATCH v2 05/17] dt-bindings: atmel-isi: add
 microchip,sam9x60-isi
Message-ID: <20200113232550.GA2344@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:17:57 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-isi to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/atmel-isi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
