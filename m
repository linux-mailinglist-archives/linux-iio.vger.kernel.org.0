Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDE139E53
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 01:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgANAfF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 19:35:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45642 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgANAfF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 19:35:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so10163005oie.12
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 16:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qSm233hBzLTG9G2DIy5d4ytValKHnVbjxr5pAXtlvA=;
        b=Eg3UAY2Gx8z+bICpHQpgpdn3/SeAJsaatI9GRSALjs4OxzPQvP6ExCdO8XBr15YxPE
         Wm5Bw4DiZavj8dQEKUlV2Ryp5PhGu5WVYXip71437yC3WLVlgnsd9KnRPEUt0bhEwtry
         1dqcoBNgD4Vi1+EkNcZjdXFrSDTwxxUArv8nHl3T0lqjBjqxHE/HcmsqKBXMecqzgMqF
         XmYWfRr8Ls4XHV3inMrWqMaqSxI9/lTBs9auD2UHTaykjGhJIprxSOhlVRGLN1/5Dnhe
         TWJTOr2HUvYFPZmuRHKMQvWzT6a8ftwFQYABGd3Ef7M8vWqadtK8G81ixcQEkKKKh5Qs
         38uQ==
X-Gm-Message-State: APjAAAVYoNPVUZPMMhEmLxx8yJQYQi/38ARv0h2CWLSc3xPPSkJUgnU/
        v/Gmmut+472e/yCAd5SMWmJrayTuFQ==
X-Google-Smtp-Source: APXvYqyq3sXHGbWcRsZ6qJn9WjC5G+obFONOgzmTY8C46VpZnsR7eY+hxgy1E5+V84fJEEY9wzMzPw==
X-Received: by 2002:a05:6808:291:: with SMTP id z17mr14372409oic.94.1578962104263;
        Mon, 13 Jan 2020 16:35:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w6sm4037927oih.19.2020.01.13.16.35.03
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:35:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d1
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:21:19 -0600
Date:   Mon, 13 Jan 2020 18:21:19 -0600
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
Subject: Re: [PATCH v2 12/17] dt-bindings: atmel,at91rm9200-rtc: add
 microchip,sam9x60-rtc
Message-ID: <20200114002119.GA18003@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:18:04 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-rtc to DT bindings documentation.
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Hi Alexandre,
> 
> I kept this patch as in v1 (same for patch
> "dt-bindings: atmel-tcb: add microchip,sam9x60-tcb").
> I'm waiting your response to this version and take an action aftewards.
> 
> Thank you,
> Claudiu Beznea
> 
>  Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
