Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22E139D39
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 00:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgAMXXN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 18:23:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45146 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgAMXXN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 18:23:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so10705329otp.12
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 15:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7d1TijNzzm5olBqQ6BOPTTjVLO96fK38vWoVBLQU76w=;
        b=A9lzJluKhqA024O3lpviuE0mXT3X6YbYBpkx0FCKMxJ6FoaAEhSO20aBzSfKvmhBiw
         zVlvXDQwuMRJG/559puaICUypqpxtIzX3t+ZFyaLXerZ/P9wZIgWZV/swT2SaVZ5So9d
         qI1DtmdsKRQ3xiXSYgK5LnjKV23P9gDniEGErntLet5aMkYds02NrEfmrsuKkY10P3kK
         rRzKIcOIYgKSH8SK6QaX+cXiOA0JluGoTckcGKaIiMty5mxW5cMh3CTqaye6TJ18Ml7r
         hGRKgcYBcVP6bHYh75QlXrjMmeFxGVvFCN/5cTnqNyhs9DBprkva6+IDbkHQeTbouHFy
         naAQ==
X-Gm-Message-State: APjAAAUb9/4MofAKWOA5SAAFtj5uc1VT4HqyAPwlbLDWE0czCulFq6A7
        dH7vqAst8uMelSPEjoLnUpyLCHE=
X-Google-Smtp-Source: APXvYqzDYxtm2vNa0oIsSGWDsjTzWIEvj6PvHYhrdu/AtLzHIIEQP81jwzWuBSIzzPzHhmAbgHSYsw==
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr15126616oto.355.1578957792338;
        Mon, 13 Jan 2020 15:23:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p184sm4005028oic.40.2020.01.13.15.23.11
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:23:11 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d0
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:10 -0600
Date:   Mon, 13 Jan 2020 17:23:10 -0600
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
Subject: Re: [PATCH v2 02/17] dt-bindings: at_xdmac: add microchip,sam9x60-dma
Message-ID: <20200113232310.GA30698@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:17:54 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-dma to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
