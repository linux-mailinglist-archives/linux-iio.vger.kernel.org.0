Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA2139E06
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 01:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgANAUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 19:20:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38685 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgANAUq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 19:20:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id l9so10148494oii.5
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 16:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4zWbyVluCegWLV1bmjQGYNlUCTLZBFCektijqCqk8g=;
        b=idfcCNkzLuRNarGQBKsUCTcZhna6KyVlZZskDjftgGseZobLVrg3ml+KMUdo2/ig2B
         u7QrFpQCms2yboNvwEKbqf6F8dz5qan83PkLxP82vL4/YFh8VMFhaRvajoUqf3M67x1z
         bQwKvgM9vrI/+o2e8CcWQ492M26PZTdAd/xjhB0mOBT5gMMoHs+SPEkpUmdTNP0h+OrI
         0tCiAEwZM3huPy1C03iRFEVhJbMfh8fJVk8bkcwHdOoSP9ygymByAwoXDc+vGihElfhu
         9EqTQMRR86hAWUqUHXcgqNHzal7dS4TTOv36nJbD5K4u2/SlmSliyjepVdsq5fKP1b+1
         /jwg==
X-Gm-Message-State: APjAAAU6iLH9jLmLtJap9d3kEDj3Kf51coahPOH2q/VuqtbnodkVQi94
        c4iCm+h5+Tw9ebJkjM1a7RNOGk6qSg==
X-Google-Smtp-Source: APXvYqyCsLyqpC+U/C2tNnUUTacC52msL5AmLSIsERxFJs0JDoiFtGbyOtW/rw4ctnEewtagpT5fXg==
X-Received: by 2002:aca:5487:: with SMTP id i129mr13840269oib.167.1578961245325;
        Mon, 13 Jan 2020 16:20:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e17sm4739927otq.58.2020.01.13.16.20.43
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:20:44 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d0
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:20:42 -0600
Date:   Mon, 13 Jan 2020 18:20:42 -0600
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
Subject: Re: [PATCH v2 11/17] dt-bindings: atmel-gpbr: add
 microchip,sam9x60-gpbr
Message-ID: <20200114002042.GA17036@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:18:03 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-gpbr to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-gpbr.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
