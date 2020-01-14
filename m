Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D952139E9C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 01:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgANAzE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 19:55:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43289 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgANAzE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 19:55:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so10898663oth.10
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 16:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2uIWxQRw2ac2zDhobeFtImF06Kett0ywn6nB0mPlAo=;
        b=D1dlQaoyKNT9HXyY/9wOZINGt030ZkxkmQIP0ByZgp4E+EBbSu3K3bLIfjSJWl/oze
         CcRDZzXyNfWLkzqo3BCNrY9od4TrGepdI+EypqeezY8eHslswi6sRClwGBaeldTqreOx
         ihkt6VmhT+6Fdp/JPk5yIp1T0FCCF2vUmWEJxEn2ENLiQZogelLmDxioIwo6H/6QjCL5
         4pWZCaWbEzNFlBT0Vnl89L0QOSXVHuE/VGtKaQZqlxlpR9fuCiI5HFu9ZSBznMywtz6o
         WGxptEUtTeN1BMWTBmuYspPkCERJQLZNy2qB1te8oT02pZibb+HlSHpL1S9tYqcynkFV
         6/OA==
X-Gm-Message-State: APjAAAWEBVTnNcjoBsBE6GTzQSHZRHeYilgF53h59PDm/K0u9QuLk9q8
        zdFzrZ4bKUgNGanSDqUOslU1gXW4Fg==
X-Google-Smtp-Source: APXvYqzTpGQM/pH4N6IVEUqSVHHZJQBPFqAH9IBVbJ+HZhgI7w1NqQWsA/T3wfC1ZC022UHmr0Vsyg==
X-Received: by 2002:a9d:708f:: with SMTP id l15mr15937210otj.229.1578963303084;
        Mon, 13 Jan 2020 16:55:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t23sm4106330oic.28.2020.01.13.16.55.01
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:55:02 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221ab2
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:59 -0600
Date:   Mon, 13 Jan 2020 18:16:59 -0600
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
Subject: Re: [PATCH v2 08/17] dt-bindings: atmel-nand: add
 microchip,sam9x60-pmecc
Message-ID: <20200114001659.GA11452@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-9-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-9-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:18:00 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-pmecc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
